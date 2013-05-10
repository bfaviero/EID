class MapController < ApplicationController
  require 'builder'
  require 'rest_client'
  respond_to :xml
  def logic
    from = params[:from]
    fromBuilding = Building.where(:mit => from).first
    to = params[:to]
    toBuilding = Building.where(:mit => to).first

    sf = Stop.near(fromBuilding, 1, :order => :distance)
    st = Stop.near(toBuilding, 1, :order => :distance)
    routeshash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil,
      "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    routeslist = [ "saferidebostonall", "saferidebostone",  "saferidebostonw", "saferidecamball", "saferidecambeast",  "saferidecambwest"]
    finalRoutesHash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil,
      "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    bestOption = [9999, 9999, 9999, 9999]
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

    routeshash.each do |key|
      key = key[0]
      puts routeshash
      puts key
      puts routeshash[key]
      puts "ROUTES HASH"
      if routeshash[key] != nil and routeshash[key].length==2
        #origin and destination
        ostop = routeshash[key][0]
        dstop = routeshash[key][1]
        #get wait time until shuttle gets to origin stop
        puts ostop.nid
        puts key
        puts "WAIT RESPONSEEEEE"
        getRequest = 'http://proximobus.appspot.com/agencies/mit/stops/'+ostop.nid+'/predictions/by-route/'+key+".json"
        puts getRequest
        waitResponse = RestClient.get getRequest
        waitResponseJSON = JSON.parse(waitResponse)
        wait = 0
        vid = ""
        if waitResponseJSON["items"].length > 0
          item = waitResponseJSON["items"][0]
          wait = item["seconds"]
          vid = item["vehicle_id"]
          #Get the arrival time at the final destination
          arrival = 0
          puts "ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE"
          arrivalRequest = 'http://proximobus.appspot.com/agencies/mit/stops/'+dstop.nid+'/predictions/by-route/'+key+".json"
          puts arrivalRequest
          arrivalResponse = RestClient.get arrivalRequest
          arrivalResponseJSON = JSON.parse(arrivalResponse)
          puts arrivalResponse

          arrivalResponseJSON["items"].each do |item|
            if item["vehicle_id"]==vid
              if item["seconds"]>wait
                arrival = item["seconds"]
                break
              end
            end
          end
          #
          puts "WE HAVE AN OPTION"
          finalRoutesHash[key] = [wait, arrival, ostop.name, dstop.name]
        else
          puts "GET FAILURE"
        end

      end
    end


    #now put it all together
    finalRoutesHash.each do |key|
      key = key[0]
      if finalRoutesHash[key] != nil
        option = finalRoutesHash[key]
        option << Route.where(:nid => key).first.name
        if option != nil
          if option[1]< bestOption[1]
            bestOption = option
          end
        end
      end
    end
    if bestOption[0]!=9999
      puts "We've found the best route for you!"
      departure = Time.zone.now+bestOption[0]
      arrive = Time.zone.now+bestOption[1]
      response = "The " + bestOption[4] + " leaves from " + bestOption[2] + " at " + departure.strftime("%I:%M") + " and will get you to your destination at " + arrive.strftime("%I:%M") + "." +
        "You should get off at the " + bestOption[3] + " stop.".to_json
      puts response
    else
      response =  "We did not find a route for you".to_json
      puts response
    end




    xml_data
    respond_to do |format|
        format.xml { render :xml => @xml }
        format.json {render :json => response}
    end
  end
  def xml_data
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            " "
          }
        }
        xml.GOTO("destination" => "/13")
      }
      xml.VARIABLES {
        xml.VAR("name" => "Name", "value" => @name)
        xml.VAR("name" => "Greeting", "value" => @greeting)
        xml.VAR("name" => "Gender", "value" => @gender)
        xml.VAR("name" => "Preference", "value" => @preference)
      }
    }
    end
end

=begin
  def logic
    from = params[:from]
    fromBuilding = Building.where(:mit => from).first
    to = params[:to]
    toBuilding = Building.where(:mit => to).first

    sf = Stop.near(fromBuilding, 1, :order => :distance)
    st = Stop.near(toBuilding, 1, :order => :distance)
    routeshash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil,
      "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    routeslist = [ "saferidebostonall", "saferidebostone",  "saferidebostonw", "saferidecamball", "saferidecambeast",  "saferidecambwest"]
    finalRoutesHash = {"saferidebostonall" => nil, "saferidebostone" => nil,  "saferidebostonw" => nil,
      "saferidecamball" => nil, "saferidecambeast" => nil,  "saferidecambwest" => nil}
    bestOption = [9999, 9999, 9999, 9999, ""]
    ##for each route, find the closest stops to origin and destination
    sf.each do |stopfrom|
      stopfrom.routes.each do |stopfromroute|
        routeshash[stopfromroute.nid] ||= [stopfrom]
      end
    end

    st.each do |stopto|
      stopto.routes.each do |stoptoroute|
        if routeshash[stoptoroute.nid] != nil
          routeshash[stoptoroute.nid] << stopto
        end
      end
    end

    routeshash.each do |key|
      key = key[0]
      puts routeshash
      puts key
      puts routeshash[key]
      puts "ROUTES HASH"
      if routeshash[key] != nil
        #origin and destination
        ostop = routeshash[key][0]
        dstop = routeshash[key][1]
        #time to walk to the stop
        puts "CALLING GOOGLE API"
        walkResponse = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => fromBuilding.latitude.to_s+","+fromBuilding.longitude.to_s, :destination => ostop.latitude.to_s+","+ostop.longitude.to_s, :sensor => false, :mode => "walking"}}
        walkResponseJSON = JSON.parse(walkResponse)
        timeToStop = 0
        walkResponseJSON["routes"][0]["legs"].each do |leg|
          timeToStop += leg["duration"]["value"]
        end
        #get wait time until shuttle gets to origin stop
        waitResponse = RestClient.get 'http://proximobus.appspot.com/agencies/mit/stops/'+ostop.nid+'/predictions/by-route/'+key+'.json'
        waitResponseJSON = JSON.parse(waitResponse)
        wait = 0
        vid = ""
        waitResponseJSON["items"].each do |item|
          wait = item["seconds"]
          vid = item["vehicle_id"]
          if wait>timeToStop
            break
          end
        end
        #Get the arrival time at the final destination
        arrival = 0
        arrivalResponse = RestClient.get 'http://proximobus.appspot.com/agencies/mit/stops/'+dstop.nid+'/predictions/by-route/'+key+'.json'
        arrivalResponseJSON = JSON.parse(arrivalResponse)
        puts "ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE ARRIVAL RESPONSE"
        puts arrivalResponse

        arrivalResponseJSON["items"].each do |item|
          if item["vehicle_id"]==vid
            arrival = item["seconds"]
            break
          end
        end
        #Time to walk to destination
        lastWalk = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => dstop.latitude.to_s+","+dstop.longitude.to_s, :destination => toBuilding.latitude.to_s+","+toBuilding.longitude.to_s, :sensor => false, :mode => "walking"}}
        lastWalkJSON = JSON.parse(lastWalk)
        walking = 0
        lastWalkJSON["routes"][0]["legs"].each do |leg|
          walking += leg["duration"]["value"]
        end
        finalRoutesHash[key] = [timeToStop, wait, arrival, lastWalk, ostop.name, dstop.name]
      end
    end


    #now put it all together
    finalRoutesHash.each do |key|
      key = key[0]
      if finalRoutesHash[key] != nil
        option = finalRoutesHash[key]
        option << Route.where(:nid => key).first.name
        if option != nil
          if option[2]+option[3] < bestOption[2] + bestOption[3]
            bestOption = option
          end
        end
      end
    end
    if bestOption[0]!=9999
      puts "We've found the best route for you!"
      departure = Time.now+bestOption[1]
      arrive = Time.now+bestOption[2]+bestOption[3]
      response = "The " + bestOption[6] + " leaves from " + bestOption[4] + " at " + departure.strftime("%I:%M") + " and will get you to your destination at " + arrive.strftime("%I:%M") + "." +
        "You should get off at the " + bestOption[5] + " stop.".to_json
      puts response
    else
      response =  "We did not find a route for you".to_json
      puts response
    end




    xml_data
    respond_to do |format|
        format.xml { render :xml => @xml }
        format.json {render :json => response}
    end
  end
  def xml_data
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            " "
          }
        }
        xml.GOTO("destination" => "/13")
      }
      xml.VARIABLES {
        xml.VAR("name" => "Name", "value" => @name)
        xml.VAR("name" => "Greeting", "value" => @greeting)
        xml.VAR("name" => "Gender", "value" => @gender)
        xml.VAR("name" => "Preference", "value" => @preference)
      }
    }
    end
end


    sf.each do |sfrom|
      st.each do |sto|
        routes = []

        sfrom.routes.each do |route1|
          sto.routes.each do |route2|
            if route1.nid==route2.nid
              puts route1
              routes << route1
            end
          end
        end
        puts routes
        puts "CALLING GOOGLE API"
        response = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => fromBuilding.latitude.to_s+","+fromBuilding.longitude.to_s, :destination => sfrom.latitude.to_s+","+sfrom.longitude.to_s, :sensor => false, :mode => "walking"}}
        response = JSON.parse(response)
        timeToStop = 0 #response["routes"][0]["duration"]["value"]
        response["routes"][0]["legs"].each do |leg|
            timeToStop += leg["duration"]["value"]
          end
        puts "TIMETOSTOP"
        puts timeToStop
        routes.each do |route3|
          response2 = RestClient.get 'http://proximobus.appspot.com/agencies/mit/stops/'+sfrom.nid+'/predictions/by-route/'+route3.nid+'.json'
          response2 = JSON.parse(response2)
          wait = 0
          response2["items"].each do |item|
            wait = item["seconds"]
            vid = item["vehicle_id"]
            if wait>timeToStop
              break
            end
          end


          arrival = 0
          response3 = RestClient.get 'http://proximobus.appspot.com/agencies/mit/stops/'+sto.nid+'/predictions/by-route/'+route3.nid+'.json'
          response3 = JSON.parse(response3)
          response3["items"].each do |item|
            if item["vehicle_id"]==vid
              arrival = item["seconds"]
            end
          end
          puts "CALLING GOOGLE API"
          response4 = RestClient.get 'http://maps.googleapis.com/maps/api/directions/json', {:params => {:origin => sto.latitude.to_s+","+sto.longitude.to_s, :destination => toBuilding.latitude.to_s+","+toBuilding.longitude.to_s, :sensor => false, :mode => "walking"}}
          response4 = JSON.parse(response4)
          walking = 0
          response4["routes"][0]["legs"].each do |leg|
            walking += leg["duration"]["value"]
          end

          allroutes << [sfrom, sto, route3, wait, arrival, walking]
        end
      end
    end

    besttime = 9999999999
    bestroute = []
    allroutes.each do |route|
      if route[4]+route[5]<besttime
        bestroute = route
      end
    end
    puts "We've found the best route for you!"
    departure = Time.now+bestroute[3]
    arrive = Time.now+bestroute[4]+bestroute[5]
    puts "The " + bestroute[2].name + " leaves from " + bestroute[0].name + " at " + departure.strftime("%I:%M") + " and will get you to your destination at " + arrive.strftime("%I:%M") + "."
    #http://maps.googleapis.com/maps/api/distancematrix/json?origins=Boca%20Raton,%20FL&destinations=Cambridge,%20MA&sensor=false&mode=walking
    =end


  def xml_data
    xml = Builder::XmlMarkup.new
    @xml = xml.ANGELXML{
      xml.MESSAGE {
        xml.PLAY {
          xml.PROMPT("type" => "text") {
            " "
          }
        }
        xml.GOTO("destination" => "/13")
      }
      xml.VARIABLES {
        xml.VAR("name" => "Name", "value" => @name)
        xml.VAR("name" => "Greeting", "value" => @greeting)
        xml.VAR("name" => "Gender", "value" => @gender)
        xml.VAR("name" => "Preference", "value" => @preference)
      }
    }
    end
end
=end
