//
//  SingleTableViewCell.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

class SingleTableViewCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let textDetails = "Buy %@\nSell %@"
    }

    // MARK: - State Declaration
    struct State {
        let currency: String
        let rateChange: Double
        let buyRate: Double
        let sellRatte: Double
    }

    // MARK: - Properties
    static var identifier = String(describing: SingleTableViewCell.self)

    var state: State = .init(currency: "", rateChange: 0, buyRate: 0, sellRatte: 0) {
        didSet { reloadState() }
    }

    // MARK: - Initialization Methods
    required init?(coder: NSCoder) {
        super.init(style: .value1, reuseIdentifier: SingleTableViewCell.identifier)
        setupCellStyle()
    }

    // MARK: - Private Methods
    private func reloadState() {
        detailTextLabel?.text = .init(format: Constants.textDetails, state.buyRate.roundedString, state.sellRatte.roundedString)
        reloadTextLabelText()
    }

    private func reloadTextLabelText() {
        let rateChangeSign = state.rateChange > 0 ? "+" : ""
        let rateChangeString = rateChangeSign + (state.rateChange * 100).roundedString + "%"

        let text = NSMutableAttributedString(string: state.currency + " " + rateChangeString)
        text.addAttributes([.foregroundColor: state.rateChange > 0 ? UIColor.systemGreen : .systemRed],
                           range: text.mutableString.range(of: rateChangeString))
        textLabel?.attributedText = text
    }

    private func setupCellStyle() {
        backgroundColor = .systemGray6
        detailTextLabel?.numberOfLines = 2
    }
}

private extension Double {
    var roundedString: String {
        return String(format: "%.2f", self)
    }
}
