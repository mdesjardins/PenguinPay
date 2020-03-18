//
//  NewRecipientVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 15/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CardViewSPM

class NewRecipientVC: UITableViewController {
    
    var sendMoneyVM: SendMoneyViewModel?
    private var cells = [NewRecipientCell?]()
    private var cardView: CardViewActivityVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem = doneButton
        buildCells()
        setupDelegates()
        subscriptions()
    }
    
    @objc private func handleDone() {
        navigationController?.popViewController(animated: true)
    }
        
    
    private func subscriptions() {
        
        //Selecte country
        sendMoneyVM?.bindableCountrySelected.bind{ _ in
            self.cardView?.dismiss(animated: true, completion: {
                self.sendMoneyVM?.recipientPhone?.removeAll()
                self.sendMoneyVM?.transactionAmount?.removeAll()
                self.sendMoneyVM?.formattedBinaryDestineAmount?.removeAll()
                self.sendMoneyVM?.formattedLocaleTransactionAmount?.removeAll()
                self.tableView.reloadData()
            })
        }
        
        //Check phone validity
        sendMoneyVM?.isBindablePhoneValid.bind{ isValid in
            if isValid ?? false {
                self.cells[2]?.newRecipientPhoneView.phoneTextField.showErrorMessage(status: .hide)
            } else {
                self.cells[2]?.newRecipientPhoneView.phoneTextField.showErrorMessage(status: .show)
            }
        }
        
        //Check name validity
        sendMoneyVM?.bindableNameValid.bind(observer: { (isValid) in
            if isValid ?? false {
                self.cells[1]?.newRecipientNameView.nameTextField.showErrorMessage(status: .hide)
            } else {
                self.cells[1]?.newRecipientNameView.nameTextField.showErrorMessage(status: .show)
            }
        })
    }
    
    private func setupDelegates() {
        cells.forEach { (cell) in
            cell?.viewOfType(type: CustomDefaultTextField.self, process: {
                $0.delegate = self
            })
        }
    }
    
    private func selectDestine() {
        let controller = ContinentsListVC()
        controller.sendMoneyVM = sendMoneyVM
        let card = CardViewActivityVC(innerController: controller)
        cardView = card
        SendMoneyVC.navController?.present(card, animated: true)
    }
    
    private func buildCells() {
        cells.append(NewRecipientCell(typeOfCell: .newRecipientCoyntryCell))
        cells.append(NewRecipientCell(typeOfCell: .newRecipientNameCell))
        cells.append(NewRecipientCell(typeOfCell: .newRecipientPhoneCell))
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            selectDestine()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 180
        default:
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cells[indexPath.row] else { return UITableViewCell() }
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
}


//MARK: - TextField Functions

extension NewRecipientVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case cells[1]?.newRecipientNameView.nameTextField:
            sendMoneyVM?.recipientName = cells[0]?.newRecipientNameView.formatName(string, textField, range: range)
        case cells[2]?.newRecipientPhoneView.phoneTextField:
            sendMoneyVM?.recipientPhone = cells[2]?.newRecipientPhoneView.formatPhone(string, textField)
        default:
            break
        }
        return false
    }
}
