//
//  ViewController.swift
//  QuizApp
//
//  Created by Shivakumar Harijan on 14/07/24.
//

import UIKit

class ViewController: UIViewController {
    var list = QuestionBank()
    var anserToQuestion: Bool = false
    var questionNumber: Int = 0
    var totalNumberofQuestions: Int = 0
    var yourScore: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarWidthContrain: NSLayoutConstraint!
    @IBOutlet weak var celebrationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        totalNumberofQuestions = list.qList.count
        changeQuestion(questionNum: questionNumber)
        updateQuestionUI(questionNumIndex: questionNumber)
    }
    
    private func setupUI() {
        // Setup buttons
        [trueButton, falseButton].forEach { button in
            button?.layer.cornerRadius = 25
            button?.layer.shadowColor = UIColor.black.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 4)
            button?.layer.shadowRadius = 5
            button?.layer.shadowOpacity = 0.3
        }
        
        // Setup progress bar
        progressBarView.layer.cornerRadius = progressBarView.frame.height / 2
        
        celebrationLabel.alpha = 0
    }
    
    @IBAction func preseedOnAnswerButton(_ sender: UIButton) {
        // Animate button press
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                sender.transform = .identity
            }
        }
        if questionNumber < totalNumberofQuestions {
            switch sender.tag {
            case 1:
                self.anserToQuestion = true
            case 2:
                self.anserToQuestion = false
            default:
                print("Wrong Button Tapped")
            }
            
            checkAnswer(answeredSelected: anserToQuestion)
        } else {
            showCompletionAlert()
        }
    }
    
    func checkAnswer(answeredSelected: Bool) {
        if (answeredSelected == list.qList[questionNumber].answer) {
            showCelebration()
            nextQuestion()
        } else {
            showWrongAnswerAnimation()
        }
    }
    
    private func showCelebration() {
        celebrationLabel.text = "🎉"
        celebrationLabel.alpha = 1
        
        // Celebration animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.celebrationLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                self.celebrationLabel.alpha = 0
                self.celebrationLabel.transform = .identity
            })
        }
    }
    
    private func showWrongAnswerAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        questionLabel.layer.add(animation, forKey: "shake")
    }
    
    func nextQuestion() {
        print(questionNumber)
        self.questionNumber = questionNumber + 1
        if questionNumber < totalNumberofQuestions {
            UIView.transition(with: questionLabel,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: { [weak self] in
                self?.changeQuestion(questionNum: self?.questionNumber ?? 0)
                self?.updateQuestionUI(questionNumIndex: self?.questionNumber ?? 0)
            })
        } else {
            updateQuestionUI(questionNumIndex: questionNumber)
            showCompletionAlert()
        }
    }
    
    private func showCompletionAlert() {
        
        let alertMessage = UIAlertController(title: "Well Done! 🎉",
                                           message: "You completed all the questions with a score of \(yourScore)!",
                                           preferredStyle: .alert)
        
        alertMessage.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
            self?.startOver()
        }))
        alertMessage.addAction(UIAlertAction(title: "Back", style: .destructive, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
        
        present(alertMessage, animated: true)
    }
    
    func changeQuestion(questionNum: Int) {
        questionLabel.text = list.qList[questionNum].questionText
    }
    
    func updateQuestionUI(questionNumIndex: Int) {
        currentQuestionLabel.text = String(questionNumIndex + 1)
        if questionNumIndex == 0 {
            playerScore.text = "0"
        } else {
            yourScore = yourScore + 10
            playerScore.text = String(yourScore)
        }
        
        let progressPercentage = CGFloat(questionNumIndex) / CGFloat(totalNumberofQuestions)
        let progressBarWidth = view.frame.size.width * progressPercentage
        
        UIView.animate(withDuration: 0.3) {
            self.progressBarWidthContrain.constant = progressBarWidth
            self.view.layoutIfNeeded()
        }
    }
    
    func startOver() {
        questionNumber = 0
        yourScore = 0
        UIView.transition(with: questionLabel,
                        duration: 0.3,
                        options: .transitionCrossDissolve,
                        animations: { [weak self] in
            self?.changeQuestion(questionNum: 0)
            self?.updateQuestionUI(questionNumIndex: 0)
        })
    }
}

