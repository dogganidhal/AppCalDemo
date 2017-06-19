//
//  AddFoodEventCell.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

class AddFoodEventCell: UITableViewCell {
    
    public enum AddFoodEventCellIdentifier {
        case textField
        case `switch`
        case segment
        case disclosureIndicator
        case none
    }

    open var identifier: AddFoodEventCellIdentifier = .none {
        didSet {
            reloadCell()
        }
    }
    open var input: Any? {
        get {
            switch identifier {
            case .textField:
                return textField?.text
            case .switch:
                return `switch`?.isOn
            case .segment:
                return segment?.selectedSegmentIndex
            default:
                return nil
            }
        } set {}
    }
    open var placeholderForTextField: String? {
        willSet {
            textField?.placeholder = newValue
        }
    }
    open var textColorForTextField: UIColor? {
        willSet {
            textField?.textColor = newValue
        }
    }
    open var segmentTintColor: UIColor? {
        willSet {
            segment?.tintColor = newValue
        }
    }
    open var currentValueString: String? {
        willSet {
            currentValueLabel?.text = newValue
            setNeedsLayout()
        }
    }
    open var currentImage: UIImage? {
        willSet {
            rightImageView?.image = newValue
        }
    }
    
    private var textField: UITextField?
    private var currentValueLabel: UILabel?
    private var `switch`: UISwitch?
    private var segment: UISegmentedControl?
    private var rightImageView: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard identifier == .disclosureIndicator else { return }
        var disclosureIndicator: UIView?
        for subview in subviews {
            if subview is UIButton {
                disclosureIndicator = subview
            }
        }
        if currentValueString != nil {
            addSubview(currentValueLabel!)
            currentValueLabel?.font = FontBook.regularFont(ofSize: 16)
            currentValueLabel?.textColor = .lightGray
            currentValueLabel?.sizeToFit()
            currentValueLabel?.translatesAutoresizingMaskIntoConstraints = false
            currentValueLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            currentValueLabel?.trailingAnchor.constraint(equalTo: disclosureIndicator!.leadingAnchor, constant: -8).isActive = true
        } else if currentImage != nil {
            addSubview(rightImageView!)
            rightImageView?.translatesAutoresizingMaskIntoConstraints = false
            rightImageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            rightImageView?.trailingAnchor.constraint(equalTo: disclosureIndicator!.leadingAnchor, constant: -8).isActive = true
            rightImageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
            rightImageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    internal func reloadCell() {
        switch identifier {
        case .textField:
            setToTextFieldCell()
        case .switch:
            setToSwitchCell()
        case .disclosureIndicator:
            setToDisclosureIndicatorCell()
        case .segment:
            setToSegment()
        default:
            setToNormalCell()
        }
    }
    
    private func setToTextFieldCell() {
        self.accessoryView = nil
        self.accessoryType = .none
        self.textField = UITextField(frame: CGRect(x: 16, y: 0, width: frame.width - 32, height: frame.height))
        self.textField?.font = FontBook.regularFont(ofSize: 16)
        self.switch = nil
        self.segment = nil
        self.rightImageView = nil
        self.currentValueLabel = nil
        self.addSubview(textField!)
    }
    
    private func setToSwitchCell() {
        self.switch = UISwitch()
        self.addSubview(`switch`!)
        self.accessoryView = self.switch
        self.accessoryType = .none
        self.textField = nil
        self.rightImageView = nil
        self.currentValueLabel = nil
        self.segment = nil
    }
    
    private func setToSegment() {
        self.segment = UISegmentedControl(items: ["BF", "Lunch", "Dinner"])
        self.segment?.selectedSegmentIndex = 0
        self.switch = nil
        self.textField = nil
        self.currentValueLabel = nil
        self.rightImageView = nil
        self.addSubview(segment!)
        self.accessoryView = segment
        self.accessoryType = .none
    }
    
    private func setToDisclosureIndicatorCell() {
        self.accessoryView = nil
        self.accessoryType = .disclosureIndicator
        self.currentValueLabel = UILabel()
        self.rightImageView = UIImageView(image: currentImage ?? UIImage())
        self.switch = nil
        self.textField = nil
        self.segment = nil
    }
    
    private func setToNormalCell() {
        self.accessoryView = nil
        self.accessoryType = .none
        self.switch = nil
        self.textField = nil
        self.segment = nil
        self.currentValueLabel = nil
        self.rightImageView = nil
    }

}
