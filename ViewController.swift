//
//  ViewController.swift
//  Project_2
//
//  Created by 박수연 on 10/8/24.
//

import UIKit
import Combine
import MBProgressHUD


class ViewController: UIViewController, UIAnimatable {
    
    private enum Mode {
        case onboarding
        case search
    }

    @IBOutlet weak var tableView: UITableView!
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    //이벤트나 데이터를 발생시키는 객체입니다. Publisher는 값이 변경되거나
    //새로운 데이터가 들어올 때 Subscriber(구독자)에게 해당 데이터를 제공합니다.
    @Published private var searchQuery = String()
    @Published private var mode: Mode = .onboarding
   
    
    private lazy var searchController: UISearchController = {
        
        var sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.searchBar.placeholder = "search"
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
        
    }()
    
    private var searchResults: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeForm()
        setUptableView()
        setupNavigationBar()
        tableView.register(UINib(nibName: "FirstTVCell", bundle: nil), forCellReuseIdentifier: "First")
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    
    func setupNavigationBar(){
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
    }
    
    private func setUptableView(){
        tableView.tableFooterView = UIView()
    }

    
    private func observeForm(){
        
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
        //Debounce는 Combine 프레임워크에서 제공하는 연산자 중 하나로, 입력된 값 중에서 일정 시간 동안 변경이 없을 때에만 값을 방출합니다.
            .sink { [unowned self] (searchQuery) in
                print(searchQuery)
                
               showLoadingAnimation()
                self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
                hideLoadingAnimation()
                    
                    switch completion {
                    case .failure(let error):
                        print(" ERROR \(error.localizedDescription)")
                    case.finished: break
                    }
                } receiveValue: { (searchResults) in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                }.store(in: &self.subscribers)
                
            }.store(in: &subscribers)
        
        
        $mode.sink { [unowned self] (mode) in
            
            switch mode {
            case .onboarding:
                self.tableView.backgroundView = SearchPlaceholderView()
           
            case .search:
                self.tableView.backgroundColor = nil
              
            }
        }.store(in: &subscribers)
    
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "First", for: indexPath) as! FirstTVCell
        
        if let searchResults  = self.searchResults {
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(with: searchResult)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
                detailVC.title = "Detail"
                // 네비게이션 컨트롤러가 있을 때 push
                navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating {
   
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else  { return
        }
        self.searchQuery = searchQuery
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
    
}
