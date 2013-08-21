b = {'KS': ['Kappa Sig', 'Kappa Sigma'], 'ACO': ['Alpha Chi Omega', 'Achio', 'AXO', 'a chi o', 'alpha chi'], '62': [], 'DKE': ['Delta Kappa Epsilon', 'DEK'], 'W20': ['Stud', 'Student Center'], 'FH': ['Fenway House'], 'W61': [], 'ND': ['Nu Delta', 'Nu Delts'], 'SAE': ['Sigma Alpha Epsilon'], 'ZBT': ['Zeta Beta Tau'], 'TEP': [], 'NS': ['Number Six'], 'SPE': ['Sigma Phi Epsilon', 'SigEp', 'Sig Ep'], 'ADP': ['Alpha Delta Phi', 'ADPhi'], 'PDT': ['Phi Delta Theta', 'Phi Delts', 'Phi Delt', 'PhiDelt', 'PhiDelts'], 'PKT': ['Phi Kappa Theta', 'Phi Kap'], 'P': ['Pika'], 'CP': ['Chi Phi'], 'BTP': ['Beta', 'Beta Theta Pi'], 'W51': [], 'PLP': ['Pi Lambda Phi', 'Pi Lamb', 'PiLamb'], 'TDC': ['Theta Delta Chi'], 'W7': [], 'SH': ['Student House'], 'SN': ['Sigma Nu'], 'W1': ['Maseeh Hall', 'Maseeh', 'Masseeh Hall', 'Masseeh', 'Masee'], 'KAT': ['Theta', 'Kappa Alpha Theta'], 'SC': ['Sigma Chi'], 'WILG': [], 'NW35': [], 'W84': ['Student Center', 'Stud'], 'AEP': ['AEPi', 'Alpha Epsilon Pi'], 'DTD': ['Delts', 'Delta Tau Delta'], 'DU': ['Delta Upsilon'], 'PKS': [], 'PP': [], 'TX': [], 'SK': ['Sigma Kappa', 'Sig Kap'], 'NW61': [], 'TC': [], 'E2': [], 'PBE': [], 'NW30': [], 'ET': [], 'ZP': [], 'Kendall': [], 'PSK': [], 'W71': [], 'W70': [], 'NW10': [], 'AP': [], '32': [], 'W79': [], 'LCA': []}
for key in b.keys():
    inp = 'hi'
    while (inp!=''):
        print key
        print b[key]
        inp = raw_input("Enter another name for this: ")
        if inp!='':
            b[key].append(inp)
