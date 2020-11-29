//
//  ViewController.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 15/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setCustomNavigation(title: Utils.localizedString(forKey: Keys.home))
    }
    
    @IBAction func btnTopStoriesTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as? StoryViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

