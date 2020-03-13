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
        navigationController?.navigationBar.isHidden = false
    }
        
    @objc private func handleSend() {
        let controller = ContinentsListVC()
        controller.sendMoneyVM = sendMoneyVM
        let cardview = CardViewActivityVC(innerController: controller)
        self.present(cardview, animated: true)
    }
    
    @objc func handleClose() {
        self.dismiss(animated: true)
    }
    
    private func animateContent() {
        let components = [iconImageView, titleLabel, descriptionLabel]
        components.forEach { (component) in
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
    
    //MARK: Setup
    private func setupComponents() {
        
        //navBar
        let barButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = barButton
        
        //Vertical stackView
        view.add(verticalStackView) {
            $0.spacing = view.frame.height / 30
            $0.addArrangedSubview(iconHolder)
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(descriptionLabel)
            $0.addArrangedSubview(bottomView)
            $0.anchor(
                top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                padding: .init(top: view.frame.height / 8, left: 16, bottom: 0, right: 16)
            )
            
            iconHolder.constraintHeight(constant: view.frame.height / 7)
            iconHolder.add(iconImageView) {
                let iconSize = view.frame.width / 3
                $0.centerInSuperview(size: .init(width: iconSize, height: iconSize))
                $0.layer.cornerRadius = iconSize / 2
                $0.clipsToBounds = true
            }
            
            //Uploade button
            bottomView.constraintHeight(constant: view.frame.height / 3)
            bottomView.add(sendButton) {
                $0.centerInSuperview(size:
                    .init(width: view.frame.width / 2, height: view.frame.width * 0.15)
                )
                $0.bindableCompletedTouch.bind { _ in
                    self.handleSend()
                }
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Adicionar novo"
    }
    
   
}


class SendMoneyInitialView: UIVi {

    //MARK: - Components
       
       let verticalStackView = configure(UIStackView()) {
           $0.axis = .vertical
           $0.distribution = .fillProportionally
       }
       
       let iconHolder = UIView()
       let iconImageView = configure(UIImageView()) {
           $0.image = #imageLiteral(resourceName: "secure")
           $0.contentMode = .scaleAspectFit
       }
       
       let titleLabel = configure(UILabel()) {
           $0.text = "Send money"
           $0.textAlignment = .center
           $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       }
       
       let descriptionLabel = configure(UILabel()) {
           $0.text = "Sendwave’s leading security experts and best-of-industry practices ensure your information is always secure."
           $0.textAlignment = .center
           $0.numberOfLines = 0
           $0.adjustsFontSizeToFitWidth = true
           $0.font = UIFont.preferredFont(forTextStyle: .title3)
       }
       
       let bottomView = UIView()
       let sendButton = configure(FormButtonActive(
           status: .enable, backColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1), textColor: .black)
       ) {
           $0.setTitle("START", for: .normal)
           $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       }

       let sendButtonLabel = configure(UILabel()) {
           $0.font = UIFont.preferredFont(forTextStyle: .caption1)
           $0.text = "SEND"
       }
}

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
        return sendMoneyVM?.destinations.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CountryListVC()
        controller.sendMoneyVM = sendMoneyVM
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContinentCell.identifier, for: indexPath) as? ContinentCell else {
            return UITableViewCell()
        }
        sendMoneyVM?.destionation = sendMoneyVM?.destinations[indexPath.row]
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}

class ContinentCell: UITableViewCell {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            setupData()
        }
    }
    
    private func setupData() {
        let flag = URL(string: sendMoneyVM?.destionation?.continentFlag ?? "")
        imageView?.sd_setImage(with: flag)
        textLabel?.text = sendMoneyVM?.destionation?.continent
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String  {
        return String(describing: self)
    }
}

class CountryListVC: TableViewWithSearchVC {
    
    var sendMoneyVM: SendMoneyViewModel? {
        didSet {
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Select the continent"
        tableView.register(ContinentCell.self, forCellReuseIdentifier: ContinentCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendMoneyVM?.destionation?.countrys?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(sendMoneyVM?.destionation?.countrys?[indexPath.row].currency ?? "")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContinentCell.identifier, for: indexPath) as? ContinentCell else {
            return UITableViewCell()
        }
        sendMoneyVM?.destionation = sendMoneyVM?.destinations[indexPath.row]
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}
