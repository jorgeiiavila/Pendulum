//
//  QuestionTableViewController.swift
//  Pendulum
//
//  Created by Francisco Castro on 10/14/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    var questionType: Int = Int.random(in: 0...2)
    var question: Question!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func refreshQuestion(_ sender: UIBarButtonItem) {
        self.questionType = Int.random(in: 0...2)
        self.tableView.isUserInteractionEnabled = true
        self.generateQuestion()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.generateQuestion()
        
        //question section
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "QuestionTVCell") as! QuestionTableViewCell
            cell.questionLabel.text = self.question.question
            return cell
        } else {
            //answers section
            let cell = UITableViewCell()
            cell.textLabel?.text = self.question.answers[indexPath.row].answer
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        }
        
        if question.answers[indexPath.row].isCorrect {
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.backgroundColor = .green
        } else {
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.backgroundColor = .red
            var index = 0
            for answer in question.answers{
                if answer.isCorrect{
                    break
                }
                index += 1
            }
            let correctCell = self.tableView.cellForRow(at: IndexPath(row: index, section: 1))
            correctCell?.backgroundColor = .green
        }
        
        self.tableView.isUserInteractionEnabled = false
        
    }
    
    func generateQuestion(){
         let pendulum = Pendulum(longitude: Float.random(in: 1...50), gravity: Float.random(in: 1...50))
        
        switch self.questionType {
        case 0:
            
            let question = Question(question: "Encuentra el periodo dado l = " + String(format: "%.2f", pendulum.longitude) + " y g = " + String(format: "%.2f", pendulum.gravity), answers: self.generateAnswers(pendulum: pendulum))
            self.question = question
            
            break
            
        case 1:
            let question = Question(question: "Encuentra la longitud dado p = " + String(format: "%.2f", pendulum.getPeriod()) + " y g =" + String(format: "%.2f", pendulum.gravity), answers: self.generateAnswers(pendulum: pendulum))
            self.question = question
            
            break
            
        default:
            let question = Question(question: "Encuentra la gravedad dado l = " + String(format: "%.2f", pendulum.longitude) + " y T = " + String(format: "%.2f", pendulum.getPeriod()), answers: self.generateAnswers(pendulum: pendulum))
            self.question = question
            
            break

        }
    }
    
    func generateAnswers(pendulum: Pendulum) -> [Answer]{
        var answer: [Answer] = []
        switch self.questionType {
        case 0:
            let period = pendulum.getPeriod()
            
            answer.append(Answer(answer: String(format: "%.2f", period), isCorrect: true))
            answer.append(Answer(answer: String(format: "%.2f", period + 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", period - 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", period + 10), isCorrect: false))
            break
            
        case 1:
            let longitude = pendulum.getLongitude(period: pendulum.getPeriod())
            
            answer.append(Answer(answer: String(format: "%.2f", longitude), isCorrect: true))
            answer.append(Answer(answer: String(format: "%.2f", longitude + 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", longitude - 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", longitude + 10), isCorrect: false))
            break
            
        case 2:
            let gravity = pendulum.getGravity(period: pendulum.getPeriod())
            
            answer.append(Answer(answer: String(format: "%.2f", gravity), isCorrect: true))
            answer.append(Answer(answer: String(format: "%.2f", gravity + 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", gravity - 5), isCorrect: false))
            answer.append(Answer(answer: String(format: "%.2f", gravity + 10), isCorrect: false))
            break
        default:
            break
        }
        answer.shuffle()
        return answer
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
