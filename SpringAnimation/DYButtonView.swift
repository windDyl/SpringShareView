//
//  DYButtonView.swift
//  SpringAnimation
//
//  Created by dyLiu on 2017/6/23.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

import UIKit

class DYButtonView: UIView {

    var iconView:UIImageView?
    var titleLabel:UILabel?
    var itemBtn:UIButton?

    private let width:CGFloat = 60
    private let height:CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.iconView = UIImageView(frame: CGRect(x: (frame.size.width - width)/2.0, y: 0, width: width, height: height))
        self.iconView?.layer.cornerRadius = width / 2.0
        self.iconView?.layer.masksToBounds = true
        self.iconView?.isUserInteractionEnabled = true
        self.addSubview(self.iconView!)
        
        self.titleLabel = UILabel(frame: CGRect(x: self.iconView?.frame.origin.x ?? 0, y: height, width: width, height: frame.size.height-height))
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(self.titleLabel!)
        
        self.itemBtn = UIButton(type: UIButtonType.custom)
        self.itemBtn?.frame = CGRect(x: self.iconView?.frame.origin.x ?? 0, y: 0, width: width, height: frame.size.height)
        self.itemBtn?.backgroundColor = UIColor.clear
        self.addSubview(self.itemBtn!)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
