//
//  MarvelViewController+TableView.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import UIKit

private var currentIndex: IndexPath?
extension MarvelViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configureTableView() {
        marvelTableView.dataSource = self
        marvelTableView.delegate = self
        marvelTableView.registerCellNib(cellClass: MarvelTableViewCell.self)
        marvelTableView.estimatedRowHeight = UITableView.automaticDimension
        marvelTableView.rowHeight = UITableView.automaticDimension
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        marvelTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        searchBar.text = ""
        viewModel.fetchData(isRefresh: true)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.marvelTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MarvelTableViewCell = tableView.dequeue(for: indexPath)
        let serie = viewModel.marvel.value[indexPath.row]
        cell.configure(with: serie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.marvel.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? MarvelTableViewCell else { return }
        if let currentIndex = currentIndex, currentIndex != indexPath {
            if let previousCell = tableView.cellForRow(at: currentIndex) as? MarvelTableViewCell {
                previousCell.updateCellUIForContraction()
            }
        }
        currentIndex = indexPath
        cell.toggleCellExpansion()
        UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.bounds.height
        
        if offsetY > contentHeight - scrollViewHeight {
            if searchBar.text?.isEmpty ?? false {
                IndicatorScroll.startAnimating()
                viewModel.fetchData(isRefresh: false)
            }
        }
    }
}

