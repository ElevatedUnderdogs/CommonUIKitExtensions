////
////  UITableView+State.swift
////  akin
////
////  Created by Scott Lydon on 9/16/19.
////  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
////
///
///
///
import UIKit

public extension UITableView {

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    func indices(inSection section: Int) -> [IndexPath] {
        let rowcount = numberOfRows(inSection: section)
        guard rowcount > 0 else { return [] }
        return (0..<rowcount).map { IndexPath(row: $0, section: section)}
    }
}

//
//import UIKit
//
//protocol ExactlyEqual {
//    static func === (lhs: Self, rhs: Self) -> Bool
//}
//
//extension UITableView {
//
//    enum State: Equatable, Hashable, ExactlyEqual {
//        case loading
//        case disconnected
//    //    case hasResults(UITableView.Model)
//    //    case noResults(UITableView.BackgroundView.ViewModel)
//
//        func hash(into hasher: inout Hasher) {
//            switch self {
//            case .loading:
//                hasher.combine("loading")
//            case .hasResults(_):
//                hasher.combine("hasResults")
//            case .noResults(_):
//                hasher.combine("noResults")
//            case .disconnected:
//                hasher.combine("disconnected")
//            }
//        }
//
//        var isLoading: Bool {
//            return self == State.loading
//        }
//
//        var hasResults: Bool {
//            if case .hasResults(_) = self {
//                return true
//            }
//            return false
//        }
//
//        var noResults: Bool {
//            if case .noResults(_) = self {
//                return true
//            }
//            return false
//        }
//
//        var model: UITableView.Model? {
//            if case .hasResults(let model) = self {
//                return model
//            }
//            return nil
//        }
//
//        var dataSourceDelegate: UITableView.DataSourceDelegate? {
//            if case .hasResults(let model) = self {
//                return model.dateSourceDelegate
//            }
//            return nil
//        }
//
//        var prefetch: UITableViewDataSourcePrefetching? {
//            if case .hasResults(let model) = self {
//                return model.prefetch
//            }
//            return nil
//        }
//
//        var backgroundModel: UITableView.BackgroundView.ViewModel? {
//            if case .noResults(let model) = self {
//                return model
//            }
//            return nil
//        }
//
//
//        static func == (lhs: State, rhs: State) -> Bool {
//            switch (lhs, rhs) {
//            case (.loading, .loading): return true
//            case (.disconnected, .disconnected): return true
//            case ( .hasResults(_), .hasResults(_)): return true
//            case ( .noResults(_), .noResults(_)): return true
//            default: return false
//            }
//        }
//
//        static func === (lhs: UITableView.State, rhs: UITableView.State) -> Bool {
//            switch (lhs, rhs) {
//            case (.loading, .loading): return true
//            case (.disconnected, .disconnected): return true
//            case ( .hasResults(let resultslhs), .hasResults(let resultsrhs)):
//                return resultslhs == resultsrhs
//            case ( .noResults(_), .noResults(_)): return true
//            default: return false
//            }
//        }
//
/////        *Design notes*
/////        Would it be better to put this in a computed style property?
/////        pros - you can change a property on this view model and it would reflect in the style.
/////        - you can access values more readily at the surface instead of digging to see if it has the value, fewer layers. But it would add a layer because enums cannot have stored properties...net the same layers. But an enum keeps the safety because it ensures you don't accidentally use information you should not be using.  For example, you should not be using a datasource when there are no items in it, you should use a background view
/////
/////        cons - it would encourage people to use the view model for its state instead of initiating a new one
//        init(
//            isLoading: Bool,
//            isConnectedToTheInternet: Bool,
//            relevantRequirements: [Requirement],
//            requirementsDataSource: RequirementsDataSource,
//            itemsCount: Int,
//            tableViewModel: UITableView.Model,
//            noResultsBackground: UITableView.BackgroundView.ViewModel
//            ) {
//            guard relevantRequirements.isEmpty else {
//                requirementsDataSource.requirements = relevantRequirements
//                let tableViewModel = UITableView.Model(
//                    dateSourceDelegate: requirementsDataSource
//                )
//                self = .hasResults(tableViewModel)
//                return
//            }
//            self.init(
//                isLoading: isLoading,
//                isConnectedToTheInternet: isConnectedToTheInternet,
//                itemsCount: itemsCount,
//                tableViewModel: tableViewModel,
//                noResultsBackground: noResultsBackground
//            )
//        }
//
//        init(
//            isLoading: Bool,
//            isConnectedToTheInternet: Bool,
//            itemsCount: Int,
//            tableViewModel: UITableView.Model,
//            noResultsBackground: UITableView.BackgroundView.ViewModel
//            ) {
//            if itemsCount == 0 {
//                guard isConnectedToTheInternet else {
//                    self = .disconnected
//                    return
//                }
//                if isLoading {
//                    self = .loading
//                } else {
//                    self = .noResults(noResultsBackground)
//                }
//            } else {
//                self = .hasResults(tableViewModel)
//            }
//        }
//    }
//}
