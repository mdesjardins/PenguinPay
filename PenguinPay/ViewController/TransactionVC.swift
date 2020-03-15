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
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let transactionView = transactionTextFieldCell?.transactionAmountView
        transactionView?.transactionTextField.isBindableText.bind { text in
            self.sendMoneyVM?.transactionAmount = text
        }
    }
    

    private func setupView() {
        //Setup View
        navigationItem.title = "Transaction"
        view.backgroundColor = .tertiarySystemBackground
        //Setup Table
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        
        buildCells()
    }
    
    private func selectDestine() {
        let controller = ContinentsListVC()
        controller.sendMoneyVM = sendMoneyVM
        let card = CardViewActivityVC(innerController: controller)
        SendMoneyVC.navController?.present(card, animated: true)
    }
    
    private func buildCells() {
        transactionHeaderCell = TransactionCell(typeOfCell: .transactionHeaderCell)
        transactionTextFieldCell = TransactionCell(typeOfCell: .transactionReceiveCell)
        transactionAmountCell = TransactionCell(typeOfCell: .transactionAmountCell)
        
        cells.append(transactionHeaderCell)
        cells.append(transactionTextFieldCell)
        cells.append(transactionAmountCell)
        
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        tableView.tableFooterView = footerView
        tableView.reloadData()
    }
    
    @objc private func handleClick() {
//        sendMoneyVM?.bindableSendTransaction.value = true
    }
   

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            return 160
        case 2:
            return 160
        default:
            return 80
        }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cells[indexPath.row] else { return UITableViewCell() }
        cell.sendMoneyVM = sendMoneyVM
        return cell
    }
        
    var transactionHeaderCell: TransactionCell?
    var transactionTextFieldCell: TransactionCell?
    var transactionAmountCell: TransactionCell?
}


class TransactionRecipientVC: TableWithSearchVC {
    
    var sendMoneyVM: SendMoneyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
    }
    
    
}
