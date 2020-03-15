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
    
    var sendMoneyVM: SendMoneyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        componentsSubscriptions()
    }
    
    @objc private func handleStart() {
        let controller = ContinentsListVC()
        controller.sendMoneyVM = sendMoneyVM
        cardView = CardViewActivityVC(innerController: controller)
        guard let card = cardView else { return }
        self.present(card, animated: true)
    }
    
    @objc func handleClose() {
        self.dismiss(animated: true)
    }
        
    //MARK: - Subscriptions
    private func componentsSubscriptions() {
        
        //Start button
        sendMoneyInitialView?.sendButton.bindableCompletedTouch.bind { _ in
            self.handleStart()
        }
        
        //Country selected, change the UI
        sendMoneyVM?.bindableCountrySelected.bind { _ in
            self.cardView?.dismiss(animated: true, completion: {
                self.transactionVC = TransactionVC()
                self.transactionVC?.sendMoneyVM = self.sendMoneyVM                
                self.view.add(self.transactionVC?.view ?? UIView()) {
                    $0.alpha = 0
                    $0.transform = .init(translationX: 0, y: -10)
                    $0.fillSuperview(padding:
                        .init(top: 50, left: 0, bottom: 0, right: 0)
                    )
                }
                self.transitionFrom(from: self.sendMoneyInitialView, to: self.transactionVC?.view)
            })
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
        navigationItem.title = "Adicionar novo"
    }
    
    //MARK: Custom Views
    private var cardView: CardViewActivityVC?
    private var sendMoneyInitialView: SendMoneyInitialView?
    private var transactionVC: TransactionVC?
}




extension Notification.Name {
     static let didReceiveData = Notification.Name("didReceiveData")
}
