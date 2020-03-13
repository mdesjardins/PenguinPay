//
//  HomeVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM
import UIViewExtensionsSPM

class HomeVC: UIViewController {
    
    private let sendMoneyVM = SendMoneyViewModel()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        navigationItem.title = "PinguinPay"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.add(sendMoneyButton) {
            $0.centerInSuperview(size: .init(width: view.frame.width - 32, height: view.frame.width * 0.15))
            $0.bindableCompletedTouch.bind { _ in
                self.handleSendMoney()
            }
        }
    }
    
    private func handleSendMoney() {
        sendMoneyButton.animateButtonActivity(hasActivity: true)
        sendMoneyVM.getCurrencies(onSuccess: { [weak self] in
            DispatchQueue.main.async {                
                self?.sendMoneyButton.animateButtonActivity(hasActivity: false)
                let controller = SendMoneyVC()
                controller.sendMoneyVM = self?.sendMoneyVM
                let navController = UINavigationController(rootViewController: controller)
                self?.present(navController, animated: true)
            }
        }) { [weak self] (err) in
            self?.sendMoneyButton.animateButtonActivity(hasActivity: false)
            self?.showCenterAlert(title: "", msg: err)
        }
    }
    
    //MARK: components
    let sendMoneyButton = configure(
    FormButtonActive(status: .enable, backColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1), textColor: .white)) {
        $0.setTitle("SEND MONEY", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
