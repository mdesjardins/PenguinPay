//
//  TransactionVC.swift
//  PenguinPay
//
//  Created by Juliano Goncalves Alvarenga on 14/03/20.
//  Copyright © 2020 Ciclic. All rights reserved.
//

import UIKit
import CustomClassSPM

class TransactionVC: UITableViewController  {
    
    var sendMoneyVM: SendMoneyViewModel? { didSet { tableView.reloadData() }}
    private var cells = [TransactionCell?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        navigationItem.title = "Transaction"
        view.backgroundColor = .tertiarySystemBackground
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)        
        buildCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let transactionView = transactionTextFieldCell?.transactionAmountView
//        transactionView?.transactionTextField.isBindableText.bind { text in
//            self.sendMoneyVM?.transactionAmount = text
//        }
    }

    private func buildCells() {
        transactionHeaderCell = TransactionCell(typeOfCell: .transactionHeaderCell)
        transactionTextFieldCell = TransactionCell(typeOfCell: .transactionReceiveCell)
        
        cells.append(transactionHeaderCell)
        cells.append(transactionTextFieldCell)
        buildTableFooter()
        tableView.reloadData()
    }
    
    @objc private func handleClick() {
//        sendMoneyVM?.bindableSendTransaction.value = true
    }
    
    
    private func buildTableFooter() {
        let footerView = Footerview(frame: view.frame)
        tableView.tableFooterView = footerView
    }
   

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            return 160
        default:
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    let clickBbutton = configure(UIButton()) {
        $0.setTitle("Click me", for: .normal)
    }
}

class Footerview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        add(sendMoneyButton) {
            $0.centerInSuperview(size:
                .init(width: frame.width - 32, height: frame.width * 0.15)
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let sendMoneyButton = configure(
    FormButtonActive(status: .enable, backColor: #colorLiteral(red: 0.9960784314, green: 0.6549019608, blue: 0.1568627451, alpha: 1), textColor: .white)) {
        $0.setTitle("SEND MONEY", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
