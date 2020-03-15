//
//  CountryListVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM

class CountryListVC: UITableViewController {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Select the country"
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendMoneyVM?.selectedContinent?.countrys?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendMoneyVM?.selectedCountry = sendMoneyVM?.selectedContinent?.countrys?[indexPath.row]
        sendMoneyVM?.bindableCountrySelected.value = true        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        sendMoneyVM?.selectedCountry = sendMoneyVM?.selectedContinent?.countrys?[indexPath.row]
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}
