//
//  QuestionViewController.swift
//  Aguri_birthday
//
//  Created by 荒川陸 on 2016/11/20.
//  Copyright © 2016年 Riku Arakawa. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet var questionImageView: UIImageView!
    @IBOutlet var answerTextField: UITextField!
    var answer: String!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named:"question\(index!).jpeg")
        questionImageView.image = image
        answerTextField.placeholder = "答えを入力してね"
        answerTextField.delegate = self
    }
    
    @IBAction func didTapAnswerButton() {
        if let userAns = answerTextField.text {
            if answer == userAns {
                let alert = UIAlertController(title:"Congrats!", message: "正解です！", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler:{
                    UIAlertAction -> Void in
                    let pieceViewController = PieceViewController.instantiate()
                    pieceViewController.index = self.index
                    self.present(pieceViewController, animated: true, completion: nil)
                    
                }))
                self.present(alert, animated: true, completion:nil)
            } else {
                let alert = UIAlertController(title:"Oh,no...", message: "はずれです！", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title:"Ooops", message: "回答を入力してください", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
        }
    }
    
    @IBAction func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension QuestionViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        answerTextField.resignFirstResponder()
        return true
    }
}

extension QuestionViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        
        return String(describing: self)
    }
}
