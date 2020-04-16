//
//  HomePageViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/12/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var quizTableView: UITableView!
    var quizSerivce = QuizService()
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        QuizService.retrieveQuizzes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizTableView.dataSource = self
        
        if let u = user {
            print("User Information who just logged in")
            print(u)
        } else {
            print("User is not defined from log in page")
        }

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

}

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        cell.textLabel?.text = "quiz"
        cell.detailTextLabel?.text = "0/10"
        return cell
    }
    
    
}
