//
//  MainViewController.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/28/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {

    private var viewModel = MainViewModel()
    private var comicsDetails: [ComicsDetailsItem]?
    
    var topSafeArea: CGFloat = 0
    
    let headerView = CharacterListView()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.bounces = true
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
        } else {
            topSafeArea = topLayoutGuide.length
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComicsViewCell.self, forCellReuseIdentifier: "ComicsViewCell")

        headerView.delegate = viewModel.self
        self.setupViews()
        
        viewModel.comicsDetails.bind {
            self.comicsDetails = $0
            DispatchQueue.main.async {
                self.tableView.reloadSections([1], with: .fade)
            }
        }
        
        
    }
    
    private func setupViews() {
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.white
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.white
        }
        
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat(format: "V:|-20-[v0]|", views: tableView)
        
        
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return headerView
        } else {
            let headerView = CharacterTitleView()
            headerView.title.text = viewModel.selectCharacterName
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 100 : 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : comicsDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsViewCell", for: indexPath) as! ComicsViewCell
        cell.comicsDetailsItem = comicsDetails?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let comicsDetails = comicsDetails else { return }
//        if indexPath.row == comicsDetails.count - 1 {
//            print("Load more data")
//        }
//    }
    
        
}

