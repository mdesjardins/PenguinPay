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
    
    private func doTransition(for view: UIView) {
        view.subviews.vi
        view.subviews.forEach { (component) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                component.alpha = 0
                component.transform = CGAffineTransform(translationX: 0, y: -10)
            }) { (_) in
                //                self.iconImageView.sd_setImage(with: URL(string: item?.icon ?? ""))
                //                self.titleLabel.text = item?.name
                //                self.descriptionLabel.text = item?.info
                component.transform = CGAffineTransform(translationX: 0, y: 10)
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                    component.alpha = 1
                    component.transform = .identity
                })
            }
        }
    }
    
    //MARK: - Subscriptions
    private func componentsSubscriptions() {
        
        //Start button
        sendMoneyInitialView.sendButton.bindableCompletedTouch.bind { _ in
            self.handleStart()
        }
        
        //Country selected, change the UI
        sendMoneyVM?.bindableCountrySelected.bind { _ in
            self.cardView?.dismiss(animated: true, completion: {
                self.doTransition(for: self.sendMoneyInitialView)
            })
        }
    }
    
    //MARK: Setup
    private func setupComponents() {
        
        //navBar
        let barButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = barButton
        
        sendMoneyInitialView = SendMoneyInitialView(frame: view.frame)
        view.add(sendMoneyInitialView) {
            $0.fillSuperview()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Adicionar novo"
    }
    
    
    //MARK: Custom Views
    var cardView: CardViewActivityVC?
    var sendMoneyInitialView = SendMoneyInitialView()
    let newView = configure(UIView()) {
        $0.backgroundColor = .red
    }
}
