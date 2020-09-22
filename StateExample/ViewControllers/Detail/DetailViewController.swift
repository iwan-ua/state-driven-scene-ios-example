//
//  DetailViewController.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

final class DetailViewController: BaseViewController {
    // MARK: - Constants
    private enum Constants {
        static let title = "Details of %@"
        static let textCreatedOn = "Updated on %@"
        static let textDescription = "Buy for %@ %@\nSell for %@ %@"
        static let buyButtonTitle = "Buy"
    }

    // MARK: - State Declaration
    struct State {
        let created: Date
        let currencyFrom: String
        let currencyTo: String
        let buyRate: Double
        let sellRate: Double
        let buyAction: () -> Void

        static let empty = State(created: Date(), currencyFrom: "", currencyTo: "", buyRate: 0, sellRate: 0, buyAction: {})
    }

    // MARK: - Outlets
    @IBOutlet private var createdLabel: UILabel!
    @IBOutlet private var currencyLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var buyButton: UIButton!

    // MARK: - Properties
    var state: State = .empty {
        didSet { reloadState() }
    }

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }

    override func reloadState() {
        guard isViewLoaded else { return }
        createdLabel.text = .init(format: Constants.textCreatedOn, dateFormatter.string(from: state.created))
        currencyLabel.text = state.currencyTo
        buyButton.setTitle(Constants.buyButtonTitle, for: .normal)
        descriptionLabel.text = .init(format: Constants.textDescription,
                                      state.buyRate.roundedString,
                                      state.currencyFrom,
                                      state.sellRate.roundedString,
                                      state.currencyFrom)
        title = .init(format: Constants.title, state.currencyTo)
    }

    // MARK: - Private Methods
    private func setupImageView() {
        imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        imageView.backgroundColor = .systemTeal
    }

    @IBAction private func didTapBuy(_ sender: Any) {
        state.buyAction()
    }
}

private extension Double {
    var roundedString: String {
        return String(format: "%.2f", self)
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
/// SwiftUI Preview code is to demonstrate, that our UIViewController is a standalone entity that can be easily configured to display any state.
/// As such, it can be used for previews or snapshots, or replaced with SwiftUI code when the business requirements allow.
import SwiftUI

extension DetailViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DetailViewController {
        return self
    }

    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}
}

struct DetailViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            testView()
                .environment(\.colorScheme, ColorScheme.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))

            testView()
                .environment(\.colorScheme, ColorScheme.dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
    }

    static func testView() -> DetailViewController {
        let view = DetailViewController()
        view.state = .init(created: Date(), currencyFrom: "USD", currencyTo: "EUR", buyRate: 1.15, sellRate: 1.14, buyAction: {})
        return view
    }
}
#endif
