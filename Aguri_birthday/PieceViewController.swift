//
//  PieceViewController.swift
//  Aguri_birthday
//
//  Created by 荒川陸 on 2016/11/20.
//  Copyright © 2016年 Riku Arakawa. All rights reserved.
//

import UIKit

class PieceViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var pieceImageView: UIImageView!
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.correctAnswerIndexArray.append(index-1)
        pieceImageView.image = UIImage(named: "piece\(index!).png")
        backgroundImageView.image = UIImage(named: "background.png")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animation = CABasicAnimation(keyPath: "trandform")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: 2*M_PI)
        animation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        animation.duration = 5
        animation.repeatCount = Float.infinity
        backgroundImageView.layer.add(animation, forKey: nil)
    }
    
    @IBAction func didTapTopButton() {
        performSegue(withIdentifier: "toTop", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
