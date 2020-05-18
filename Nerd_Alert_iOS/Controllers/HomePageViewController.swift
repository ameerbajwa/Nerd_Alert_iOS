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
    var referenceToHomePageView: homePage?
    var referenceToQuizDetailsView : quizDetails?
    var referenceToQuizResultsView: quizResults?
    
    @IBOutlet weak var quizTableView: UITableView!
    var quizSerivce = QuizService()
    var quizQuestionService = QuizQuestionSerivce()
    var quizResultsService = QuizResultsService()
    var user: User?
    
    var quizzes: [Quiz] = []
    var quiz: Quiz?
    var quizScores: [QuizResults] = []
    var quizScore: QuizResults?
    var table: String = "Quizzes"
    
    var quizAction: String?
    var changingQuizId: Int?
    var changingQuizIteration: Int?
    var nameOfQuiz: String?
    var numberOfQuestions: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home page view controller called")
        
        gettingHomePageView()
        retrievingQuizzes(users_quizzes: usersQuizzesInstance.usersQuizzes)
        quizTableView.dataSource = self
        quizTableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePageToCreateEditQuizSegue" && segue.destination is CreateEditQuizViewController {
            if let vc = segue.destination as? CreateEditQuizViewController {
                vc.user = user
                vc.action = quizAction
                vc.quizId = changingQuizId
            }
        }
        
        if segue.identifier == "homePageToQuizSegue" && segue.destination is QuizViewController {
            if let vc = segue.destination as? QuizViewController {
                if changingQuizId != nil {
                    vc.quiz_id = changingQuizId!
                    vc.quiz_name = nameOfQuiz!
                    vc.user = user
                }
            }
        }
        
        if segue.identifier == "homePageToEditQuizSegue" && segue.destination is CreateEditQuizQuestionsViewController {
            if let vc = segue.destination as? CreateEditQuizQuestionsViewController {
                vc.quiz_id = changingQuizId
                vc.user_id = user?.id
            }
        }
        
        if segue.identifier == "homePageToQuizQuestionResultsSegue" && segue.destination is QuizQuestionResultsViewController {
            if let vc = segue.destination as? QuizQuestionResultsViewController {
                vc.quiz_id = changingQuizId
                vc.user_id = user?.id
                vc.quiz_iteration = changingQuizIteration
            }
        }
    }

}

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if table == "Quizzes" {
            print(quizzes[indexPath.row].description)
            numberOfQuestions = 0
            // display all the quiz details on the top half of the screen
            
            quizQuestionService.retrieveNumberOfQuizQuestions(quizzes[indexPath.row].id, user!.id, onSuccess: { (response) in
                print("retrieveNumberOfQuizQuestions API call successful")
                print(response)
                
                self.numberOfQuestions = response["number of questions in quiz"] as? Int
                
                DispatchQueue.main.async {
                    if let referenceToQuizDetailsView = Bundle.main.loadNibNamed("quizDetails", owner: self, options: nil)?.first as? quizDetails {
                        self.topHalfView.addSubview(referenceToQuizDetailsView)
                        referenceToQuizDetailsView.frame.size.height = self.topHalfView.frame.size.height
                        referenceToQuizDetailsView.frame.size.width = self.topHalfView.frame.size.width
                        referenceToQuizDetailsView.delegate = self
                        referenceToQuizDetailsView.quizDetailsXibInit(quizId: self.quizzes[indexPath.row].id, quiz_name: self.quizzes[indexPath.row].name, created_by: self.quizzes[indexPath.row].createdBy, description: self.quizzes[indexPath.row].description, source: self.quizzes[indexPath.row].source, title_of_source: self.quizzes[indexPath.row].titleOfSource, username: self.user?.username, numberOfQuestions: self.numberOfQuestions!)
                    } else {
                        print("xib file could not load to the topHalfView")
                    }
                }

                
            }, onFailure: { (error) in
                print("retrieveNumberOfQuizQuestions API call unsuccessful")
                print(error)
            })

        } else if table == "Quiz Results" {
            print(quizScores[indexPath.row])
            // display all the quiz details on the top half of the screen
                    
            if let referenceToQuizResultDetailsView = Bundle.main.loadNibNamed("quizResults", owner: self, options: nil)?.first as? quizResults {
                topHalfView.addSubview(referenceToQuizResultDetailsView)
                referenceToQuizResultDetailsView.frame.size.height = topHalfView.frame.size.height
                referenceToQuizResultDetailsView.frame.size.width = topHalfView.frame.size.width
                referenceToQuizResultDetailsView.delegate = self
                referenceToQuizResultDetailsView.quizResultsXibInit(quiz_name: nameOfQuiz!, quiz_result: quizScores[indexPath.row], quiz_results: quizScores, number_of_questions: numberOfQuestions!)
            } else {
                print("xib file could not load to the topHalfView")
            }
        }
    }
}

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if table == "Quizzes" {
            return quizzes.count
        } else if table == "Quiz Results" {
            return quizScores.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        if table == "Quizzes" {
            cell.textLabel?.text = quizzes[indexPath.row].name
        } else if table == "Quiz Results" {
            cell.textLabel?.text = "Quiz Iteration \(quizScores[indexPath.row].quizIteration)"
        }
        return cell
    }
        
}

extension HomePageViewController: homePageDelegate {
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
    
    func createQuiz(action: String) {
        changingQuizId = 0
        quizAction = action
        self.performSegue(withIdentifier: "homePageToCreateEditQuizSegue", sender: nil)
    }
}

extension HomePageViewController: actionsFromQuizDetailsDelegate {
    
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
    
    func goToQuizPage(quiz_id: Int, quiz_name: String) {
        if let referenceToQuizDetailsView = Bundle.main.loadNibNamed("quizDetails", owner: self, options: nil)?.first as? quizDetails {
            referenceToQuizDetailsView.delegate = self
            changingQuizId = quiz_id
            nameOfQuiz = quiz_name
            self.performSegue(withIdentifier: "homePageToQuizSegue", sender: nil)
        } else {
            print("referenceToQuizDetailsView has not been identified as type quizDetails")
        }

    }
    
    func goToAddEditQuizQuestionsPage(quiz_id: Int) {
        
    }
    
    func goToEditQuizPage(quiz_id: Int, action: String) {
        changingQuizId = quiz_id
        quizAction = action
        self.performSegue(withIdentifier: "homePageToCreateEditQuizSegue", sender: nil)
    }
    
    func goToQuizResults(quiz_id: Int, quiz_name: String) {
        
        nameOfQuiz = quiz_name
        quizScores = []
        
        quizResultsService.retrieveQuizResults(user!.id, quiz_id, onSuccess: { (response) in
            print("called retrieveQuizResults API successfully")
            print(response.count)
            
            if response.count == 0 {
                print("user hasn't taken any questions from this quiz")
            } else {
                print("user has taken questions from this quiz")
                
                for i in response.keys {
                    self.quizScore = QuizResults(json: response[i] as! [String : Any])
                    self.quizScores.append(self.quizScore!)
                }

                DispatchQueue.main.async {
                    self.table = "Quiz Results"
                    self.quizTableView.reloadData()
                    if let referenceToQuizResultsView = Bundle.main.loadNibNamed("quizResults", owner: self, options: nil)?.first as? quizResults {
                        print("switching topHalfView of controller to QuizResultsView")
                        self.topHalfView.addSubview(referenceToQuizResultsView)
                        referenceToQuizResultsView.frame.size.height = self.topHalfView.frame.size.height
                        referenceToQuizResultsView.frame.size.width = self.topHalfView.frame.size.width
                        referenceToQuizResultsView.delegate = self
                        referenceToQuizResultsView.quizResultsXibInit(quiz_name: quiz_name, quiz_result: self.quizScores[0], quiz_results: self.quizScores, number_of_questions: self.numberOfQuestions!)
                                    
                    } else {
                        print("could not load xib file")
                    }
                }
            }
            
        }, onFailure: { (error) in
            print("calling retrieveQuizResults API resulted in an error")
            print(error)
        })
        
    }
}

extension HomePageViewController : actionsFromQuizResultsDelegate {
    func viewQuizQuestionResults(quiz_id: Int, quiz_iteration: Int) {
        changingQuizId = quiz_id
        changingQuizIteration = quiz_iteration
        self.performSegue(withIdentifier: "homePageToQuizQuestionResultsSegue", sender: nil)
    }
    
    func goBackToQuizDetails(quiz_id: Int) {
        
        quizQuestionService.retrieveNumberOfQuizQuestions(quiz_id, user!.id, onSuccess: { (response) in
            print("retrieveNumberOfQuizQuestions API call successful")
            print(response)
            
            self.numberOfQuestions = response["number of questions in quiz"] as? Int
            
            DispatchQueue.main.async {
                self.quizSerivce.retreiveQuiz(quiz_id, onSuccess: { (response) in
                    print("retrieveQuiz API call successful")
                    print(response)
                    
                    DispatchQueue.main.async {
                        if let referenceToQuizDetailsView = Bundle.main.loadNibNamed("quizDetails", owner: self, options: nil)?.first as? quizDetails {
                            self.topHalfView.addSubview(referenceToQuizDetailsView)
                            referenceToQuizDetailsView.frame.size.height = self.topHalfView.frame.size.height
                            referenceToQuizDetailsView.frame.size.width = self.topHalfView.frame.size.width
                            referenceToQuizDetailsView.delegate = self
                            referenceToQuizDetailsView.quizDetailsXibInit(quizId: response["quiz_id"] as! Int, quiz_name: response["quiz_name"] as! String, created_by: response["createdBy"] as! String, description: response["quiz_description"] as! String, source: response["source"] as! String, title_of_source: response["title_of_source"] as! String, username: self.user?.username, numberOfQuestions: self.numberOfQuestions!)
                            
                            DispatchQueue.main.async {
                                self.table = "Quizzes"
                                self.quizTableView.reloadData()
                            }
                            
                        } else {
                            print("xib file could not load to the topHalfView")
                        }
                    }
                    
                }, onFailure: { (error) in
                    print("retreiveQuiz API call unsuccessful")
                    print(error)
                })
            }
            
        }, onFailure: { (error) in
            print("ERROR retrieveNumberOfQuizQuestions API call unsucessful")
            print(error)
        })
        
    }
}
