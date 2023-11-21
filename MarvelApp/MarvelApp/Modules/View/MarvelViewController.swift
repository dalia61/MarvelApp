//
//  MarvelViewController.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import UIKit

class MarvelViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    @IBOutlet weak var marvelTableView: UITableView!
    @IBOutlet weak var IndicatorTableView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel: MarvelViewModel!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
        viewModel.fetchData(isRefresh: false)
    }

    private func setupNavigationBar() {
        title = "Marvel"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func searchBar(_ searchBar: UISearchBar, 
                   textDidChange searchText: String) {
        viewModel.fetchData(title: searchText)
    }

    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        viewModel.fetchData(title: searchBar.text ?? "")
    }

    func bindViewModel() {
        viewModel.isLoadingData.observe(on: self) { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.IndicatorTableView.startAnimating()
                } else {
                    self?.IndicatorTableView.stopAnimating()
                }
            }
        }
        
        viewModel.marvel.observe(on: self) { [weak self] marvelSeries in
            guard let self = self else { return }
            self.reloadTableView()
            refreshControl.endRefreshing()
        }
    }

}