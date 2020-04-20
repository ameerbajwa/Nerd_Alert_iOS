//
//  HomePageViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/12/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var topHalfView: UIView!
    var referenceToQuizDetailsView : quizDetails?
    
    @IBOutlet weak var quizTableView: UITableView!
    var quizSerivce = QuizService()
    var user: User?
    var quizzes: [Quiz] = []
    var quiz: Quiz?
    
    var users_quizzes: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let referenceToHomePageView = Bundle.main.loadNibNamed("homePage", owner: self, options: nil)?.first as? homePage {
            topHalfView.addSubview(referenceToHomePageView)
            referenceToHomePageView.frame.size.height = topHalfView.frame.size.height
            referenceToHomePageView.frame.size.width = topHalfView.frame.size.width
            referenceToHomePageView.homePageXibInit(username: user!.username)
        } else {
            print("could not load xib file")
        }
        
        retrievingQuizzes(users_quizzes)
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
        users_quizzes = !users_quizzes
        retrievingQuizzes(users_quizzes)
        
        // teriary operator
//        quizButtonLabel.titleLabel?.text = users_quizzes ? "View Quizzes" : "View My Quizzes"
        
//        if users_quizzes == true {
//            quizButtonLabel.titleLabel?.text = "View Quizzes"
//        } else {
//            quizButtonLabel.titleLabel?.text = "View My Quizzes"
//        }
        
    }
    
    @IBAction func createQuizButtonPressed(_ sender: UIButton) {
        // use only if user is also a creator
    }

}

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(quizzes[indexPath.row].description)
        // display all the quiz details on the top half of the screen
        
        if let referenceToQuizDetailsView = Bundle.main.loadNibNamed("quizDetails", owner: self, options: nil)?.first as? quizDetails {
            topHalfView.addSubview(referenceToQuizDetailsView)
            referenceToQuizDetailsView.frame.size.height = topHalfView.frame.size.height
            referenceToQuizDetailsView.frame.size.width = topHalfView.frame.size.width
            referenceToQuizDetailsView.quizDetailsXibInit(quiz_name: quizzes[indexPath.row].name, created_by: quizzes[indexPath.row].createdBy, description: quizzes[indexPath.row].description, source: quizzes[indexPath.row].source, title_of_source: quizzes[indexPath.row].titleOfSource, score: "0")
        } else {
            print("xib file could not load to the topHalfView")
        }
        
        
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
