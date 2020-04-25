//
//  HomePageViewController.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 4/12/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, goToQuizPageDelegate {
    
    @IBOutlet weak var topHalfView: UIView!
    var referenceToHomePageView: homePage?
    var referenceToQuizDetailsView : quizDetails?
    
    @IBOutlet weak var quizTableView: UITableView!
    var quizSerivce = QuizService()
    var user: User?
    var quizzes: [Quiz] = []
    var quiz: Quiz?
    
    var changingQuizId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home page view controller called")
        
        gettingHomePageView()
        retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
        quizTableView.dataSource = self
        quizTableView.delegate = self
        
    }
    
    func goToQuizPage(quiz_id: Int) {
        changingQuizId = quiz_id
        self.performSegue(withIdentifier: "homePageToQuizSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePageToQuizSegue" && segue.destination is QuizViewController {
            if let vc = segue.destination as? QuizViewController {
                if changingQuizId != nil {
                    vc.quiz_id = changingQuizId!
                    vc.user = user
//                    vc.user_id = user?.id
                }
            }
        }
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
            referenceToQuizDetailsView.delegate = self
            referenceToQuizDetailsView.quizDetailsXibInit(quizId: quizzes[indexPath.row].id, quiz_name: quizzes[indexPath.row].name, created_by: quizzes[indexPath.row].createdBy, description: quizzes[indexPath.row].description, source: quizzes[indexPath.row].source, title_of_source: quizzes[indexPath.row].titleOfSource, username: user?.username)
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

extension HomePageViewController: retrieveQuizzesDelegate {
    func retrievingQuizzes(users_quizzes: Bool) {
        print("retrieving quizzes from database")
        self.quizzes = []
        quizSerivce.retrieveQuizzes(user!.id, nil, nil, nil, users_quizzes, onSuccess: { (response) in
            print("From Swift Application: retrieveQuizzes function called")
            print(response.count)
            
            for i in response.keys {
                self.quiz = Quiz(json: response[i] as! [String : Any])
                self.quizzes.append(self.quiz!)
            }
            
            DispatchQueue.main.async {
                self.quizTableView.reloadData()
            }
                        
        }, onFailure: { (error) in
            print("From Swift Application: retrieveQuizzes function called and an error occured")
            print(error)
        })
    }
}

extension HomePageViewController: homePageViewDelegate {
    func gettingHomePageView() {
        if let referenceToHomePageView = Bundle.main.loadNibNamed("homePage", owner: self, options: nil)?.first as? homePage {
            topHalfView.addSubview(referenceToHomePageView)
            referenceToHomePageView.frame.size.height = topHalfView.frame.size.height
            referenceToHomePageView.frame.size.width = topHalfView.frame.size.width
            referenceToHomePageView.delegate = self
            referenceToHomePageView.homePageXibInit(username: user!.username)
                        
        } else {
            print("could not load xib file")
        }
    }
}
