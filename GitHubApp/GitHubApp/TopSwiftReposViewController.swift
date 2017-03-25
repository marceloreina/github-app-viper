//
//  TopSwiftReposViewController.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

enum TopSwiftReposState {
    case initializing
    case loadingRepos
    case loadingMoreRepos
    case noContent
    case presentingRepos
}

class TopSwiftReposViewController: UIViewController {

    //MARK: Class properties
    var presenter: TopSwiftReposPresentation!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    weak var refreshControl: UIRefreshControl!
    
    var topSwiftRepoList: [RepoDisplayData]?
    
    // uses disSet to call methods on state changes
    var currentState: TopSwiftReposState = .initializing {
        didSet  {
            switch currentState {
            case .initializing:
                setupInitializingState()
            case .loadingMoreRepos:
                setupLoadingMoreReposState()
            case .loadingRepos:
                setupLoadingReposState()
            case .noContent:
                setupNoContentState()
            case .presentingRepos:
                setupPresentingReposState()
            }
        }
    }
    
    //MARK: View controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currentState = .initializing
    }
    
    //MARK: View controller states setup functions
    private func setupInitializingState() {
        title = "Swift Repos"
        
        //setup navigation bar
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(colorLiteralRed: 27/255.0, green: 31/255.0, blue: 35/255.0, alpha: 1)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 188/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1)]
        
        //setup tableview
        tableView.dataSource = self
        tableView.delegate = self
        
        //hide no data view
        noDataView.isHidden = true
        
        //create refresh control
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(TopSwiftReposViewController.refreshAction(sender:)), for: .valueChanged)
        tableView.addSubview(refresh)
        
        currentState = .loadingRepos
    }
    
    private func setupLoadingReposState() {
        if let refresh = refreshControl {
            refresh.beginRefreshing()
        }
        presenter.viewDidLoad()
    }
    
    private func setupLoadingMoreReposState() {
        if let reposList = topSwiftRepoList {
            let indexOfLastItem = reposList.count
            let indexPath = IndexPath(row: indexOfLastItem, section: 0)
            tableView.insertRows(at: [indexPath], with: .none)
            presenter.loadMoreRepos()
        }
    }
    
    private func setupNoContentState() {
        noDataView.isHidden = false
    }
    
    private func setupPresentingReposState() {
        if let refresh = refreshControl {
            refresh.endRefreshing()
        }
        noDataView.isHidden = true
        tableView.reloadData()
    }
    
    @objc private func refreshAction(sender: UIRefreshControl) {
        presenter.reloadReposList()
        refreshControl = sender
    }
}

extension TopSwiftReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        switch currentState {
        case  .loadingMoreRepos:
            if let list = topSwiftRepoList {
                numberOfRows =  list.count + 1
            }
        default:
            if let list = topSwiftRepoList {
                numberOfRows =  list.count
            }
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = nil
        
        if currentState == .loadingMoreRepos {
            if topSwiftRepoList!.count == indexPath.row {
                cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableViewCell") as? LoadMoreTableViewCell
                if let laodingCell = cell as? LoadMoreTableViewCell {
                    laodingCell.setupCell(message: "loading more repos")
                }
            }
        }
        
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as? RepoTableViewCell
            if let repoCell = cell as? RepoTableViewCell {
                let repoData = topSwiftRepoList![indexPath.row]
                repoCell.setupCell(data: repoData)
            }
        }

        return cell!
    }
}

extension TopSwiftReposViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.repoSelected(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return currentCellHeightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return currentCellHeightForRow(at: indexPath)
    }
    
    private func currentCellHeightForRow(at indexPath: IndexPath) -> CGFloat {
        var cellHeight = RepoTableViewCell.cellHeight
        if currentState == .loadingMoreRepos {
            if indexPath.row == topSwiftRepoList?.count {
                cellHeight = LoadMoreTableViewCell.cellHeight
            }
        }
        return cellHeight
    }
}

extension TopSwiftReposViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + scrollViewHeight >= scrollContentSizeHeight
        {
            if currentState != .loadingRepos && currentState != .loadingMoreRepos {
                currentState = .loadingMoreRepos
            }
        }
    }
}

extension TopSwiftReposViewController: TopSwiftReposView {
    func showRepos(repos: [RepoDisplayData]) {
        topSwiftRepoList = repos
        currentState = .presentingRepos
    }
    
    func showNoContent() {
        currentState = .noContent
    }    
}
