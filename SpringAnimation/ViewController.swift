//
//  ViewController.swift
//  SpringAnimation
//
//  Created by dyLiu on 2017/6/23.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shareView:DYShareView?
    
    @IBOutlet weak var click: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.shareView = DYShareView(WithFrame: self.view.bounds, titleAndImg: [["title": "QQ", "img":"QQ"], ["title": "QQ空间", "img":"QQZone"], ["title": "微信", "img":"WeiChat"], ["title": "朋友圈", "img":"WeiChatline"], ["title": "微博", "img":"WeiBo"]], columns: 0)//columns 为0  自适应计算，
        self.view.addSubview(self.shareView!)
        self.shareView?.clickBtnItemBlock = { (index:Int) in
            debugPrint("click index: \(index)")
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        self.click.isSelected = !self.click.isSelected
        self.shareView?.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

