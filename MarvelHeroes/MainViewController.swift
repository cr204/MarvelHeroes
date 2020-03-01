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
    
    var topSafeArea: CGFloat = 0
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.bounces = false
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
        
        viewModel.fetchCharactersData { (characters) in
            self.characters = characters
            DispatchQueue.main.async {
                self.setupViews()
            }
        }
        
    }
    
    
    
    
    private func setupViews() {
        
        print("TopSafeArea: \(topSafeArea)")
        
        view.addSubview(tableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat(format: "V:|-\(topSafeArea)-[v0]|", views: tableView)
        
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CharacterListView()
        headerView.characters = self.characters ?? [CharacterItem]()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}
