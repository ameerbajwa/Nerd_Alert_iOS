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
    var quizzes: [Quiz] = []
    var quiz: Quiz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievingQuizzes(false)
        quizTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func retrievingQuizzes(_ users_quizzes: Bool) {
        quizSerivce.retrieveQuizzes(user!.id, nil, nil, nil, users_quizzes, onSuccess: { (response) in
            print("From Swift Application: retrieveQuizzes function called")
            print(response.count)
            
            for i in response.keys {
                self.quiz = Quiz(json: response[i] as! [String : Any])
                self.quizzes.append(self.quiz!)
            }
                        
        }, onFailure: { (error) in
            print("From Swift Application: retrieveQuizzes function called and an error occured")
            print(error)
        })
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
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        cell.textLabel?.text = quizzes[indexPath.row].name
        cell.detailTextLabel?.text = "0/10"
        return cell
    }
        
}
