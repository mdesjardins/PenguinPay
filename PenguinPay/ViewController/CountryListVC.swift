//
//  CountryListVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM

class CountryListVC: TableWithSearchVC {
    
    private var isSearching = false    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    var filteredCountrys: [Country]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Select the country"
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCountrys?.count ?? 0
        } else {
            return sendMoneyVM?.selectedContinent?.countrys?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isSearching {
            sendMoneyVM?.selectedCountry = filteredCountrys?[indexPath.row]
        } else {
            sendMoneyVM?.selectedCountry = sendMoneyVM?.selectedContinent?.countrys?[indexPath.row]
        }
        sendMoneyVM?.bindableCountrySelected.value = true        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        if isSearching {
            sendMoneyVM?.selectedCountry = filteredCountrys?[indexPath.row]
        } else {
            sendMoneyVM?.selectedCountry = sendMoneyVM?.selectedContinent?.countrys?[indexPath.row]
        }
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}

extension CountryListVC {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          navigationController?.navigationBar.prefersLargeTitles = false
      }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if sendMoneyVM?.selectedContinent?.countrys?.isEmpty ?? false { return }
        searchText.isEmpty ? (isSearching = false) : (isSearching = true)
        
       
        let countrys = sendMoneyVM?.selectedContinent?.countrys?.filter({ $0.countryName?.localizedCaseInsensitiveContains(searchText) ?? false})        
        filteredCountrys = countrys ?? []
        
        guard let isEmptySearch = filteredCountrys?.isEmpty else { return }
        shouldShowEmptySearchLabel(isEmptySearch && isSearching)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.navigationBar.prefersLargeTitles = true
        isSearching = false
        shouldShowEmptySearchLabel(isSearching)
        tableView.reloadData()
    }
}

