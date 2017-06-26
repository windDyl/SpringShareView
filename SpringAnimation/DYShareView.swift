//
//  DYShareView.swift
//  SpringAnimation
//
//  Created by dyLiu on 2017/6/23.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

import UIKit

class DYShareView: UIView, UIGestureRecognizerDelegate {
    
    var columns:Int = 0
    private var rows:Int = 1;
    private let duration:CGFloat = 0.7
    private let delay:CGFloat = 0.08
    
    private let item_width:CGFloat = 60
    private let item_height:CGFloat = 100
    private var item_space:CGFloat = 5.0
    private var item_orignalY:CGFloat = 0.0
    
    private var btnViewArray:NSMutableArray? = []
    
    var clickBtnItemBlock:((_ index:Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(WithFrame: CGRect, titleAndImg:NSArray, columns:Int) {//
        self.init()
        self.alpha = 0.0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.isUserInteractionEnabled = true
        self.frame = WithFrame
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        if titleAndImg.count > 0 {
            let max_columns:Int = Int((WithFrame.size.width - item_space*2.0 * 3.0)/item_width)
            
            self.columns = (columns >= 3 && columns <= max_columns) ? columns : (columns == 0 ? max_columns : 3)
            item_space = (WithFrame.size.width - item_width * CGFloat(self.columns)) / CGFloat(self.columns * 2)
            self.rows = (titleAndImg.count + self.columns - 1) / self.columns
            self.item_orignalY = WithFrame.size.height / 2.0 - item_space - item_height * CGFloat(self.rows / 2)
            for i in 0 ..< titleAndImg.count {//循环创建并赋值
                let dic:NSDictionary = titleAndImg.object(at: i) as! NSDictionary
                let titleStr:String = dic.object(forKey: "title") as! String
                let imgStr:String = dic.object(forKey: "img") as! String
                let orignalX:CGFloat = item_space+((item_space*2.0 + item_width)*CGFloat(i % self.columns))
                let orignalY:CGFloat =  WithFrame.size.height + item_height * CGFloat(i/self.columns)
                let btnView:DYButtonView = DYButtonView(frame: CGRect(x: orignalX, y:orignalY, width: item_width, height: item_height))
                btnView.iconView?.image = UIImage(named: imgStr)
                btnView.titleLabel?.text = titleStr
                btnView.itemBtn?.tag = i
                btnView.itemBtn!.addTarget(self, action: #selector(clickItm(btn:)), for: UIControlEvents.touchUpInside)
                self.addSubview(btnView)
                btnViewArray?.add(btnView)
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func close() {
        self.dissmiss()
    }

    func clickItm(btn:UIButton) {
        self.dissmiss()
        let index:Int = btn.tag
        if (self.clickBtnItemBlock != nil) {
            self.clickBtnItemBlock!(index)
        }
    }
    
    func show() {
        self.alpha = 1.0
        for i in 0 ..< self.btnViewArray!.count {
            let btnView:DYButtonView = self.btnViewArray?.object(at: i) as! DYButtonView
            UIView.animate(withDuration: TimeInterval(self.duration), delay: TimeInterval(delay*CGFloat(i)), usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                let orignalX:CGFloat = self.item_space+((self.item_space*2.0 + self.item_width)*CGFloat(i % self.columns))
                let orignalY:CGFloat =  self.item_orignalY + self.item_height * CGFloat(i/self.columns) + self.item_space
                btnView.frame = CGRect(x: orignalX, y:orignalY, width: self.item_width, height: self.item_height)

            }, completion: { (finish:Bool) in
                
            })
            
        }
    }
    
    func dissmiss() {
        for i in 0 ..< self.btnViewArray!.count {
            let btnView:DYButtonView = self.btnViewArray?.object(at: i) as! DYButtonView
            UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay*CGFloat((self.btnViewArray?.count)! - i - 1)), usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                let orignalX:CGFloat = self.item_space+((self.item_space*2.0 + self.item_width)*CGFloat(i % self.columns))
                let orignalY:CGFloat =  self.frame.size.height + self.item_height * CGFloat(i/self.columns)
                btnView.frame = CGRect(x: orignalX, y:orignalY, width: self.item_width, height: self.item_height)
                
            }, completion: { (finish:Bool) in
                self.alpha = 0.0
            })
            
        }
    }

    //MARK:UIGestureRecognizerDelegate
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: self)
        let rect_height:CGFloat =  (self.item_height + self.item_space) * CGFloat(self.rows) - self.item_space
        let rect:CGRect = CGRect(x: 0, y: self.item_orignalY, width: frame.size.width, height: rect_height)
        return (rect.contains(point) == false)
    }
    
}
