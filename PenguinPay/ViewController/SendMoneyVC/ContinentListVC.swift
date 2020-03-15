//
//  ContinentListVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit

//MARK: - Continent List
class ContinentsListVC: UITableViewController {
    
    var sendMoneyVM: SendMoneyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Select the continent"
        tableView.register(ContinentCell.self, forCellReuseIdentifier: ContinentCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendMoneyVM?.continents.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CountryListVC()
        sendMoneyVM?.selectedContinent = sendMoneyVM?.continents[indexPath.row]
        controller.sendMoneyVM = sendMoneyVM
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContinentCell.identifier, for: indexPath) as? ContinentCell else {
            return UITableViewCell()
        }
        sendMoneyVM?.selectedContinent = sendMoneyVM?.continents[indexPath.row]
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}
