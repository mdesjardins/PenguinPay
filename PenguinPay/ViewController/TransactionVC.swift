//
//  TransactionVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CardViewSPM
import CustomClassSPM

class TransactionVC: UITableViewController  {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { tableView.reloadData() }}
    private var cells = [TransactionCell?]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad() 
        setupView()
        setupSubscriptions()
    }
    
    //MARK: - setup functions
    private func setupView() {
        initialSetup()
        buildCells()
    }
    
    private func initialSetup() {
        //Setup View
        sendMoneyVM?.selectedCountry = sendMoneyVM?.selectedContinent?.countrys?[0]
        navigationItem.title = "Transaction"
        view.backgroundColor = .tertiarySystemBackground
        //Setup Table
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
    }
    
    private func buildCells() {
        cells.append(TransactionCell(typeOfCell: .transactionHeaderCell))
        cells.append(TransactionCell(typeOfCell: .transactionReceiveCell))
        cells.append(TransactionCell(typeOfCell: .transactionAmountCell))
        buildFooter()
        tableView.reloadData()
        setupDelegates()
    }
    
    private func buildFooter() {
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        tableView.tableFooterView = footerView
    }
    
    private func setupDelegates() {
        cells[2]?.transactionSenderView.transactionTextField.delegate = self
    }
    
    //MARK: - subscriptions
    private func setupSubscriptions() {
        //UpdateCountry
        sendMoneyVM?.bindableUpdateCountryFlag.bind(observer: { (url) in
            self.cells[0]?.transactionHeaderView.countryFlag.sd_setImage(with: url)
        })
        
        //Name Recipient
        sendMoneyVM?.bindableUpdateName.bind(observer: { (name) in
            self.cells[0]?.transactionHeaderView.recipientName.text = name
        })
        
        //Phone Recipient
        sendMoneyVM?.bindableUpdatePhone.bind(observer: { (phone) in
            self.cells[0]?.transactionHeaderView.recipientPhone.text = phone            
        })                
        
        //Receive update for Locale
        sendMoneyVM?.bindableUpdateDestineLocale.bind { amount in
            self.cells[1]?.transactionReceiveView.receiveAmount.text = amount
        }
        
        //Receive update for binary
        sendMoneyVM?.bindableUpdateDestinaBinary.bind { amount in
            self.cells[1]?.transactionReceiveView.receiveAmount.text = amount
        }
        
        //Warning Exchange
        sendMoneyVM?.bindableAmountWarning.bind(observer: { (msg) in
            self.cells[1]?.transactionReceiveView.exchangeRateLabel.text = msg
        })
    }
    
    @objc private func handleClick() {
        //        sendMoneyVM?.bindableSendTransaction.value = true
    }
    
    private func pushToNewRecipientVC() {
        let controller = NewRecipientVC()
        controller.sendMoneyVM = self.sendMoneyVM
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: - TableView function
extension TransactionVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            return 180
        case 2:
            return 200
        default:
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            pushToNewRecipientVC()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cells[indexPath.row] else { return UITableViewCell() }
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}

//MARK: TextField functions

extension TransactionVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case cells[2]?.transactionSenderView.transactionTextField:            
            let _ = cells[2]?.transactionSenderView.formatCurrency(limiting: 9,string, textField, range: range, completion: { amount in
                sendMoneyVM?.transactionAmount = amount
            })
        default:
            break
        }
        return false
    }
}
