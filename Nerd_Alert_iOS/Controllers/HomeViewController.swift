//
//  HomeViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/5/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var quizTableView: UITableView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quizTableView.delegate = self
        quizTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        print(user!.id)
        print(user!.username)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        // returns number of quizzes user can take, or number of users' quizzes they can edit
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        cell.textLabel?.text = "Quiz"
        return cell
    }
    
    
}
