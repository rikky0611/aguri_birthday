//
//  StoryboardInstantiable.swift
//  Aguri_birthday
//
//  Created by ShinokiRyosei on 2016/11/24.
//  Copyright © 2016年 Riku Arakawa. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    
    static var storyboardName: String { get }
}

extension StoryboardInstantiable {
    
    static func instantiate() -> Self {
        
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        if let viewcontroller = storyboard.instantiateInitialViewController() as? Self {
            
            return viewcontroller
        }
        
        assert(false, "生成したいViewControllerと同じ名前のStorybaordが見つからないか、Initial ViewControllerに設定されていない可能性があります。")
    }
}
