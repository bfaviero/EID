class MapController < ApplicationController
  require 'builder'
  require 'rest_client'
  respond_to :xml
  def textUser
    number = params[:callerid]
    response = params[:response]
    text(number, response)
    textxml
    respond_to do |format|
        format.xml { render :xml => @xml }
    end
  end



  def textxml
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            ""
          }
        }
        xml.GOTO("destination" => "/7")
      }
    }
    end



  def receive
    body = params["Body"]
    number = params["From"]
    a = exchange.latest.times
    bldg =  /([A-Z]+\d*)|([A-Z]+)|(\d+)/
    matchBldg = body.scan bldg
    if matchBldg.length == 2
      from = Building.where(:mit => matchBldg[0][0]).first
      to = Building.where(:mit => matchBldg[1][0]).first
      if from and to
        logic(number, from, to)
      else
        if from
          text(number, "Sorry, we don't have '"+to+"' in our system.")
        else
          text(number, "Sorry, we don't have '"+from+"' in our system.")
        end
      end
    else
      text(number, "Sorry, I didn't understand that. You can type in the two building names you want to go to in capital letters" +
        " with a space in between.")
    end
  end
  def getParams
    number = params[:callerid]
    from = params[:currentlocation]
    to = params[:destinationwanted]
    logic(number, from, to)
  end
  def logic(number, from, to)
    fromBuilding = Building.where(:mit => from).first
    toBuilding = Building.where(:mit => to).first

    sf = Stop.near(fromBuilding, 1, :order => :distance)
    st = Stop.near(toBuilding, 1, :order => :distance)
    routeshash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil, "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    finalRoutesHash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil, "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    bestOption = [9999, 9999, "Somewhere", "Somewhere else", "", 9999, 9999]
    ##for each route, find the closest stops to origin and destination
    sf.each do |stopfrom|
      stopfrom.routes.each do |stopfromroute|
        routeshash[stopfromroute.nid] ||= [stopfrom]
      end
    end
    st.each do |stopto|
      stopto.routes.each do |stoptoroute|
        if routeshash[stoptoroute.nid] != nil and routeshash[stoptoroute.nid].length==1
          routeshash[stoptoroute.nid] << stopto
        end
      end
    end

    routeshash.each do |key, value|
      if value != nil and value.length==2
          #origin and destination
          ostop = value[0]
          dstop = value[1]
          #time to walk to the stop
          timeToStop = TimeToStop(fromBuilding, ostop)

          #get wait time until shuttle gets to origin stop
          getRequest = 'http://proximobus.appspot.com/agencies/mit/stops/'+ostop.nid+'/predictions/by-route/'+key+".json"
          waitResponse = RestClient.get getRequest
          waitResponseJSON = JSON.parse(waitResponse)
          wait = 0
          vid = ""

          if waitResponseJSON["items"].length > 0
            waitResponseJSON["items"].each do |item|
              wait = item["seconds"]
              vid = item["vehicle_id"]
              if wait>timeToStop
                break
              end
            end
            arrival = ArrivalTimeVehicle(vid, dstop.nid, key, wait)
            lastWalk = WalkingTime(dstop, toBuilding)

            finalRoutesHash[key] = [wait, arrival, ostop.name, dstop.name, "", timeToStop, lastWalk]
          end
      end
    end
    puts "FINAL ROUTES HASH"
    puts finalRoutesHash
    #now put it all together
    finalRoutesHash.each do |key|
      key = key[0]
      if finalRoutesHash[key] != nil
        option = finalRoutesHash[key]
        option[4] = Route.where(:nid => key).first.name
        if option != nil
          if option[1]+option[6]< bestOption[1]
            bestOption = option
          end
        end
      end
    end
    puts finalRoutesHash
    puts "FINAL ROUTES HASHHHHHHHHHHHHHH"
    if bestOption[0]!=9999
      puts "WE'RE FOUND THE BEST ROUTE FOR YOU"
      departure = Time.zone.now+bestOption[0]
      arrive = Time.zone.now+bestOption[1]
      response = "The " + bestOption[4] + " leaves from " + bestOption[2] + " at " + departure.strftime("%I:%M") + " and will get you to your destination at " + arrive.strftime("%I:%M") + "." +
        "You should get off at the " + bestOption[3] + " stop.".to_json
      puts "RESPONSE"
      puts response
      xml_data(bestOption, response)
    else
      response =  "We did not find a route for you".to_json
      puts "RESPONSE"
      puts response
      xml_data2(response)
    end



    puts @xml
    respond_to do |format|
        format.xml { render :xml => @xml }
        format.json {render :json => response}
    end
  end

  def xml_data(bestOption, response)
    departure = Time.zone.now+bestOption[0]
    arrive = Time.zone.now+bestOption[1]
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            ""
          }
        }
        xml.GOTO("destination" => "/6")
      }
      xml.VARIABLES {
        xml.VAR("name" => "departuretime", "value" => departure.strftime("%I:%M"))
        xml.VAR("name" => "departure", "value" => bestOption[2])
        xml.VAR("name" => "arrival", "value" => bestOption[3])
        xml.VAR("name" => "arrivaltime", "value" => arrive.strftime("%I:%M"))
        xml.VAR("name" => "response", "value" => response)

      }
    }
    end
    def xml_data2(response)
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            ""
          }
        }
        xml.GOTO("destination" => "/1")
      }
    }
    end


    def TimeToStop(origin, destination)
      begin
        walkResponse = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => origin.latitude.to_s+","+origin.longitude.to_s, :destination => destination.latitude.to_s+","+destination.longitude.to_s, :sensor => false, :mode => "walking"}}
        walkResponseJSON = JSON.parse(walkResponse)
      rescue
        puts  "TIME TO STOP FAILED"
        retry
      end
        timeToStop = 0
        if walkResponseJSON["status"]!="OK"
          walkResponseJSON["routes"][0]["legs"].each do |leg|
            timeToStop += leg["duration"]["value"]
          end
        end
        return timeToStop
    end

    def WalkingTime(from, to)
      begin
        lastWalk = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => from.latitude.to_s+","+from.longitude.to_s, :destination => to.latitude.to_s+","+to.longitude.to_s, :sensor => false, :mode => "walking"}}
        lastWalkJSON = JSON.parse(lastWalk)
      rescue
        puts  "WALKING TIME FAILED"
        retry
      end
      walking = 0
      if lastWalkJSON["status"]!="OK"
        lastWalkJSON["routes"][0]["legs"].each do |leg|
          walking += leg["duration"]["value"]
        end
      end
      return walking
    end

    def ArrivalTimeVehicle(vehicle, stop, route, wait)
      #Get the arrival time at the final destination
      arrival = 0
      arrivalRequest = 'http://proximobus.appspot.com/agencies/mit/stops/'+stop+'/predictions/by-route/'+route+".json"
      begin
        arrivalResponse = RestClient.get arrivalRequest
        arrivalResponseJSON = JSON.parse(arrivalResponse)
      rescue
        puts  "ARRIVAL TIME FAILED"
        retry
      end
      raise
      arrivalResponseJSON["items"].each do |item|
        if item["vehicle_id"]==vehicle
          if item["seconds"]>wait
            arrival = item["seconds"]
            break
          end
        end
      end
      return arrival
    end
    def text(number, response)
      twilio_sid = "AC04688af1bb3a335d3a01229ae63faaa5"
      twilio_token = "6d0a0bfea26a14afc13e651d4c415110"
      twilio_phone_number = "9543562027"

      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number,
        :body => response
      )
    end
end

