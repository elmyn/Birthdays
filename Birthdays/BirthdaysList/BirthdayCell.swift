//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by dasdom on 30.08.15.
//  Copyright © 2015 dasdom. All rights reserved.
//

import UIKit

class BirthdayCell: UITableViewCell {
    
    //MARK: - vars
    var patternWidthConstraint: NSLayoutConstraint?
    
    lazy var patternView:UIView = {
        var tmpPatternView = UIView()
        tmpPatternView.translatesAutoresizingMaskIntoConstraints = false
        tmpPatternView.clipsToBounds = true
        tmpPatternView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBackgroundPattern")!)
        return tmpPatternView
    }()
    
    lazy var nameLabel:UILabel = {
        var tmpNameLabel = UILabel()
        tmpNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpNameLabel.font = .systemFontOfSize(30)
        return tmpNameLabel
    }()
    
    lazy var patternNameLabel:UILabel = {
        var tmpPatternNameLabel = UILabel()
        tmpPatternNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpPatternNameLabel.font = self.nameLabel.font
        tmpPatternNameLabel.textColor = .whiteColor()
        return tmpPatternNameLabel
    }()
    
    lazy var birthdayLabel:UILabel = {
        var tmpBirthdayLabel = UILabel()
        tmpBirthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        return tmpBirthdayLabel
    }()
    
    //MARK: - inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - autolayout

extension BirthdayCell {
    func setupAutolayout(){
        addSubview(nameLabel)
        addSubview(birthdayLabel)
        addSubview(patternView)
        addSubview(patternNameLabel)
        
        let views = ["pattern": patternView, "name": nameLabel, "birthday": birthdayLabel]
        
        
        var layoutConstraints = [NSLayoutConstraint]()
        
        
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|[pattern]", options: [], metrics: nil, views: views)
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[pattern]|", options: [], metrics: nil, views: views)
        patternWidthConstraint = patternView.widthAnchor.constraintEqualToConstant(0)
        layoutConstraints.append(patternWidthConstraint!)
        layoutConstraints.append(nameLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        layoutConstraints.append(nameLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
        
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("[birthday]-|", options: [], metrics: nil, views: views)
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[birthday]|", options: [], metrics: nil, views: views)
        
        layoutConstraints.append(patternNameLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor))
        layoutConstraints.append(patternNameLabel.centerYAnchor.constraintEqualToAnchor(nameLabel.centerYAnchor))
        
        NSLayoutConstraint.activateConstraints(layoutConstraints)
    }
}


//MARK: - update methods
extension BirthdayCell {
    func updateWithItem<T>(item: T, progress: Float) {
        if item is Birthday {
            let birthday = item as! Birthday
            nameLabel.text = birthday.firstName
            patternNameLabel.text = birthday.firstName
            birthdayLabel.text = "\(birthday.birthday.day) \(birthday.birthday.month)"
            
            patternWidthConstraint?.constant = CGFloat(progress)*frame.size.width
        }
    }
}
