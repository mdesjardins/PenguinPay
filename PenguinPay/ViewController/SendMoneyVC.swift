//
//  SendMoneyVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 13/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import SwiftUI
import SDWebImage
import CustomClassSPM
import UIViewExtensionsSPM

//MARK: Uploade VC
class SendMoneyVC: UIViewController {
        
    static var navController: UINavigationController?
    var sendMoneyVM = SendMoneyViewModel()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        componentsSubscriptions()
        SendMoneyVC.navController = self.navigationController
    }
    
    //MARK: - Subscriptions
    private func componentsSubscriptions() {        
        //Start button
        sendMoneyInitialView?.sendButton.bindableCompletedTouch.bind { _ in
            self.handleStart()
        }
    }
    
    //MARK: - Networking
    private func handleStart() {
        sendMoneyInitialView?.sendButton.animateButtonActivity(hasActivity: true)
        sendMoneyVM.getCurrencies(onSuccess: { [weak self] in
            DispatchQueue.main.async {
                self?.sendMoneyInitialView?.sendButton.animateButtonActivity(hasActivity: false)
                self?.pushToTransaction()
            }
        }) { [weak self] (err) in
            self?.sendMoneyInitialView?.sendButton.animateButtonActivity(hasActivity: false)
            self?.showCenterAlert(title: "", msg: err)
        }
    }
    
    private func pushToTransaction() {
        let controller = TransactionVC()
        controller.sendMoneyVM = self.sendMoneyVM
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Setup
    private func setupComponents() {
        //Initial View
        sendMoneyInitialView = SendMoneyInitialView(frame: view.frame)
        view.add(sendMoneyInitialView ?? UIView()) {
            $0.fillSuperview(padding:
                .init(top: returningSafetyArea().top + 16, left: 0, bottom: 0, right: 0)
            )
        }
    }
    
    private func setupView() {        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Pinguin Pay"
    }
    
    //MARK: Custom View
    private var sendMoneyInitialView: SendMoneyInitialView?
}
