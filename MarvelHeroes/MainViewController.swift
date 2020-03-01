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
    private var characters: [CharacterItem]?
    private var selectedCharId: Int = 0
    
    var topSafeArea: CGFloat = 0
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.bounces = false
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
        
        viewModel.fetchCharactersData { (characters) in
            self.characters = characters
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat(format: "V:|-\(topSafeArea)-[v0]|", views: tableView)
    }
    
    
}

extension MainViewController: UITableViewDataSource, CharacterListViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CharacterListView()
        headerView.delegate = self
        headerView.characters = self.characters ?? [CharacterItem]()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?[selectedCharId].comics.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsViewCell", for: indexPath) as! ComicsViewCell
        cell.titleLabel.text = characters?[selectedCharId].comics.items[indexPath.row].name ?? ""
        cell.descLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        cell.initViews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    // MARK: Other methods
    func characterSelected(id: Int) {
        print("characterSelected: \(id)")
        selectedCharId = id
        //self.tableView.reloadSections([0], with: .fade)
    }
    
}

