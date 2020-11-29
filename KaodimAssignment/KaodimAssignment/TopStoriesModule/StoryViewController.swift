//
//  StoryViewController.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var labelNoData: UILabel!
    @IBOutlet weak var tableViewStories: UITableView!
    
    var viewModel: StoriesViewModel?
    var arrStoriesListData: [StoriesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelNoData.isHidden = true
        showProgressIndicator(view: self.view)
        setupViewModel()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableViewStories.separatorStyle = .none
        tableViewStories.delegate = self
        tableViewStories.dataSource = self
        tableViewStories.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Utils.localizedString(forKey:Keys.story)
    }
    
    fileprivate func setupViewModel() {
        viewModel = StoriesViewModel()
        viewModel?.delegate = self
        viewModel?.getStories(count: 25)
    }
    
    fileprivate func checkDataAvailable() {
        if arrStoriesListData.count > 0 {
            labelNoData.isHidden = true
            tableViewStories.isHidden = false
        }
        else {
            labelNoData.isHidden = false
            tableViewStories.isHidden = true
        }
    }
}

//MARK: Table view Stories delegates and datasource
extension StoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStoriesListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Keys.storyCell) as? StoryCell
        
        if (nil == cell) {
            let nib:Array = Bundle.main.loadNibNamed(Keys.storyCell, owner: self, options: nil)!
            cell = nib[0] as? StoryCell
        }
        
        cell?.populateData(model: arrStoriesListData[indexPath.row], no: indexPath.row + 1)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 80
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryDetailsViewController()
        vc.details = arrStoriesListData[indexPath.row]
        self.navigationController?.show(vc, sender: nil)
    }
}

//MARK:- Story list delegates
extension StoryViewController: StoryListProtocol {
    func success(listData: [StoriesModel]) {
        self.arrStoriesListData = listData
        checkDataAvailable()
        hideProgressIndicator(view: self.view)
        DispatchQueue.main.async {
            self.tableViewStories.reloadData()
        }
    }
    
    func failure(error: String) {
        checkDataAvailable()
        hideProgressIndicator(view: self.view)
        Utils.showAlert(AlertTitle: error, AlertMessage: "", controller: self)
    }
}
