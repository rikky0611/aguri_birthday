//
//  ViewController.swift
//  Aguri-Birthday
//
//  Created by RikuArakawa on 2016/11/18.
//  Copyright © 2016年 RikuArakawa. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
    @IBOutlet var finalMessageLabel: UILabel!
    
    var answerArray: [String]!
    var buttonArray: [UIButton]!
    var answer: String!
    var index: Int!
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        finalMessageLabel.isHidden = true
        
        buttonArray = []
        buttonArray.append(button1)
        buttonArray.append(button2)
        buttonArray.append(button3)
        buttonArray.append(button4)
        buttonArray.append(button5)
        buttonArray.append(button6)
        buttonArray.append(button7)
        buttonArray.append(button8)
        buttonArray.append(button9)
        
        for button in buttonArray {
            button.addTarget(self, action: #selector(ViewController.tapped(_:)), for: .touchUpInside)
            button.isEnabled = false
            button.setImage(UIImage(named: "lock.png"), for: .normal)
            button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        }
        update()
        initializeAnswerArray()
        setUpFirebase()
        
        buttonArray[0].isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //全部集めたとき
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.correctAnswerIndexArray.count == 9 {
            let alert = UIAlertController(title:"Congrats!", message: "トモルマ氏のカードを全てみつけたようですね、お見事です。\nあとは順番にビルの消灯されたフロアを辿ってみてください。ゴールはあと少しです。", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler:{
                UIAlertAction -> Void in
                self.finalMessageLabel.isHidden = false
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func tapped(_ sender: UIButton) {
        let tag = sender.tag
        answer = answerArray[tag-1]
        index = tag
        performSegue(withIdentifier: "toQuestion", sender: self)
        let questionViewController = QuestionViewController.instantiate()
        questionViewController.answer = self.answer
        questionViewController.index = self.index
        print(self.answer, self.index)
        self.present(questionViewController, animated: true, completion: nil)
    }
}


//MARK: 通信系

extension ViewController {
    func setUpFirebase() {
        let ref = rootRef.child("test")
        //ここでsleepが必要?
        sleep(1)
        print("参照ポイント\(ref)")
        ref.observe(.value) { (snap: FIRDataSnapshot) in
            print("受信")
            let dic: Dictionary<String, Bool> = [
                "1":(snap.childSnapshot(forPath: "1").value as? Bool)!,
                "2":(snap.childSnapshot(forPath: "2").value as? Bool)!,
                "3":(snap.childSnapshot(forPath: "3").value as? Bool)!,
                "4":(snap.childSnapshot(forPath: "4").value as? Bool)!,
                "5":(snap.childSnapshot(forPath: "5").value as? Bool)!,
                "6":(snap.childSnapshot(forPath: "6").value as? Bool)!,
                "7":(snap.childSnapshot(forPath: "7").value as? Bool)!,
                "8":(snap.childSnapshot(forPath: "8").value as? Bool)!,
                "9":(snap.childSnapshot(forPath: "9").value as? Bool)!,
            ]
            print(dic)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.unlockedQuestionIndexArray.removeAll()
            for (k,v) in dic {
                if v {
                    appDelegate.unlockedQuestionIndexArray.append(Int(k)!-1)
                }
            }
            self.update()
        }
    }
    
    fileprivate func update() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if let unlockedQuestionIndexArray = appDelegate.unlockedQuestionIndexArray {
            for i in (0..<9) {
                if unlockedQuestionIndexArray.index(of: i) != nil {
                    //unlockArrayにiが入っていたら
                    if appDelegate.correctAnswerIndexArray.index(of: i) == nil {
                        //その問題がまだ正解でなかったら
                        buttonArray[i].isEnabled = true
                        buttonArray[i].setImage(UIImage(named: "unlock.png"), for: .normal)
                    } else {
                        let image = UIImage(named: "piece\(i+1).png")!
                        buttonArray[i].isEnabled = true
                        buttonArray[i].setImage(image, for: .normal)
                    }
                } else {
                    //unlockArrayに入っていない。すなわちまだlockされているとき。
                    buttonArray[i].isEnabled = false
                    buttonArray[i].setImage(UIImage(named: "lock.png"), for: .normal)
                }
            }
        }
    }
}


//MARK: 問題系

extension ViewController {
    func initializeAnswerArray() {
        answerArray = ["28",
                    "AIと世界",
                    "ちょこまか",
                    "3",
                    "と",
                    "事前登録等一切不要",
                    "手紙",
                    "ずかん",
                    "127,700"]
    }
}


extension ViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        
        return String(describing: self)
    }
}
