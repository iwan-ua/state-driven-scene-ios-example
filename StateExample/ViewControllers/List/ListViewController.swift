//
//  ListViewController.swift
//  State Example
//
//  Created by Iwan Protchenko on 19.08.2020.
//  Copyright © 2020 Wirex. All rights reserved.
//

import UIKit

final class ListViewController: BaseViewController {
    // MARK: - Constants
    private enum Constants {
        static let title = "Mock USD Exchange Rates"
    }

    // MARK: - State Declaration
    struct Item {
        let state: SingleTableViewCell.State
        let action: () -> Void
    }

    struct State {
        let items: [Item]

        static let empty = State(items: [])
    }

    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Properties
    var state: State = .empty {
        didSet { reloadState() }
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTitle()
    }

    override func reloadState() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }

    // MARK: - Private Methods
    private func setupTableView() {
        tableView.register(.init(nibName: SingleTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: SingleTableViewCell.identifier)
    }

    private func setupTitle() {
        title = Constants.title
    }
}

// MARK: - TableView DataSource & Delegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleTableViewCell.identifier) as! SingleTableViewCell
        cell.state = state.items[indexPath.row].state
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        state.items[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
/// SwiftUI Preview code is to demonstrate, that our UIViewController is a standalone entity that can be easily configured to display any state.
/// As such, it can be used for previews or snapshots, or replaced with SwiftUI code when the business requirements allow.
import SwiftUI

extension ListViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ListViewController {
        return self
    }

    func updateUIViewController(_ uiViewController: ListViewController, context: Context) { }
}

struct ListViewControllerPreviews: PreviewProvider {
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

    static func testView() -> ListViewController {
        let view = ListViewController()
        view.state = .init(items: [.init(state: .init(currency: "EUR", rateChange: 0.1, buyRate: 1.12, sellRatte: 1.11), action: {}),
                                   .init(state: .init(currency: "GBP", rateChange: -0.1, buyRate: 1.3, sellRatte: 1.30), action: {})])
        return view
    }
}
#endif
