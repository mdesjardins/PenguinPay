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
import CardViewSPM
import CustomClassSPM
import UIViewExtensionsSPM

//MARK: Uploade VC
class SendMoneyVC: UIViewController {
        
    static var navController: UINavigationController?
    var sendMoneyVM: SendMoneyViewModel?
    
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
        
    @objc func handleClose() {
        self.dismiss(animated: true)
    }
        
    //MARK: - Subscriptions
    private func componentsSubscriptions() {
        
        //Start button
        sendMoneyInitialView?.sendButton.bindableCompletedTouch.bind { _ in
            let controller = TransactionVC()
            controller.sendMoneyVM = self.sendMoneyVM
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }        
    
    //MARK: Setup
    private func setupComponents() {        
        //navBar
        let barButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = barButton
        
        //Initial View
        sendMoneyInitialView = SendMoneyInitialView(frame: view.frame)
        view.add(sendMoneyInitialView ?? UIView()) {
            $0.fillSuperview()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Pinguin Pay"
    }
    
    //MARK: Custom Views
    private var cardView: CardViewActivityVC?
    private var sendMoneyInitialView: SendMoneyInitialView?
    private var transactionVC: TransactionVC?
}




extension Notification.Name {
     static let didReceiveData = Notification.Name("didReceiveData")
}
