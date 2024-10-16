//
//  DetailViewController.swift
//  Project_2
//
//  Created by 박수연 on 10/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false // Auto Layout을 사용하기 위해 false로 설정
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailFirstTVCell", bundle: nil), forCellReuseIdentifier: "detailFirst")
        tableView.register(UINib(nibName: "DetailSecondTVCell", bundle: nil), forCellReuseIdentifier: "detailSecond")
        tableView.register(UINib(nibName: "DetailThreeTVCell", bundle: nil), forCellReuseIdentifier: "detailThree")
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupTableViewConstraints()
      
    }
    
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailFirst", for: indexPath) as! DetailFirstTVCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSecond", for: indexPath) as! DetailSecondTVCell
            
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailThree", for: indexPath) as! DetailThreeTVCell
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0 :
            return 200
        case 1:
            return 300
        case 2:
            return 300
        default:
            return 0
        }
    }
    
}
