//
//  DashboardViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 7/12/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = user?.username {
            self.navigationController?.title = "\(username)"
        } else {
            self.navigationController?.title = ""
        }
        
        settingUpToolBar()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func settingUpToolBar() {
        self.navigationController?.isToolbarHidden = false
        let myQuizResults = UIBarButtonItem(image: UIImage(named: "myQuizResultsFilled-50"), style: .done, target: self, action: #selector(toolbarItemClicked(sender:)))
        let myQuizStats = UIBarButtonItem(image: UIImage(named: "myQuizStats-50"), style: .done, target: self, action: #selector(toolbarItemClicked(sender:)))
        let searchTool = UIBarButtonItem(image: UIImage(named: "search-50"), style: .done, target: self, action: #selector(toolbarItemClicked(sender:)))
        let settings = UIBarButtonItem(image: UIImage(named: "settings-50"), style: .done, target: self, action: #selector(toolbarItemClicked(sender:)))
        
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        self.toolbarItems = [myQuizResults, flexibleSpace, myQuizStats, flexibleSpace, searchTool, flexibleSpace, settings]
    }
    
    @objc func toolbarItemClicked(sender: UIBarButtonItem) {
        switch sender.image {
        case UIImage(named: "myQuizResultsFilled-50"):
            print("my quiz results")
        case UIImage(named: "myQuizStats-50"):
            print("my quiz stats")
        case UIImage(named: "search-50"):
            print("search")
        case UIImage(named: "settings-50"):
            print("settings")
        default:
            print("nothing")
        }
    }

}
