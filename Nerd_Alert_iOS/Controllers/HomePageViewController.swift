//
//  HomePageViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/12/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var nerdAlertTitle: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var quizButtonLabel: UIButton!
    @IBOutlet weak var createQuizButtonLabel: UIButton!
    @IBOutlet weak var topHalfView: UIView!
    
    @IBOutlet weak var quizTableView: UITableView!
    var quizSerivce = QuizService()
    var user: User?
    var quizzes: [Quiz] = []
    var quiz: Quiz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = user?.username
        
        retrievingQuizzes(false)
        quizTableView.dataSource = self
        quizTableView.delegate = self
        
        // if user.creator == false {
        //    quizButtonLabel.isHidden = true
        //    createQuizButtonLabel.isHidden = true
        // }
        
    }
    
    func retrievingQuizzes(_ users_quizzes: Bool) {
        self.quizzes = []
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
    
    @IBAction func quizButtonPressed(_ sender: UIButton) {
        retrievingQuizzes(true)
//        quizButtonLabel.titleLabel?.text =
    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
        // use only if user is also a creator
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

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(quizzes[indexPath.row].description)
        // display all the quiz details on the top half of the screen
        
        nerdAlertTitle.isHidden = true
        usernameLabel.isHidden = true
        quizButtonLabel.isHidden = true
        createQuizButtonLabel.isHidden = true
        
        let quizDetailsView = quizDetails.self
        self.topHalfView.addSubview(quizDetailsView.init(coder: <#NSCoder#>) ?? <#default value#>)
    }
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
