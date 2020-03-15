//
//  TableWithSearchVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import UIViewExtensionsSPM

class TableWithSearchVC: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
        
    let emptySearchLabel = configure(UILabel()) {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.text = "Search not found"
        $0.textAlignment = .center
    }
    
    let searchConttoller = configure(UISearchController(searchResultsController: nil)) {
        $0.searchBar.placeholder = "Buscar"
        $0.obscuresBackgroundDuringPresentation = false
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchConttoller
        searchConttoller.delegate = self
        searchConttoller.searchBar.delegate = self
        
        view.addSubview(emptySearchLabel)
        emptySearchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptySearchLabel.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 64, left: 0, bottom: 0, right: 0))
        emptySearchLabel.transform = CGAffineTransform.init(scaleX: 0, y: 0)
    }
    
    public func shouldShowEmptySearchLabel(_ shouldShow: Bool) {
        if shouldShow {
            UIView.animate(withDuration: 0.3) {
                self.emptySearchLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.emptySearchLabel.transform = CGAffineTransform.init(scaleX: 0, y: 0)
            }
        }
    }
}
