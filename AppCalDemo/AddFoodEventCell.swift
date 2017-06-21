//
//  AddFoodEventCell.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

@objc public protocol AddFoodEventCellDelegate: NSObjectProtocol {
    
    @objc optional func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?)
    
}

@objc open class AddFoodEventCell: UITableViewCell, UITextFieldDelegate {
    
    public enum AddFoodEventCellIdentifier {
        case textField
        case `switch`
        case segment
        case disclosureIndicator
        case none
    }

    open weak var delegate: AddFoodEventCellDelegate?
    
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
        } set {
            setInput()
        }
    }
    open var placeholderForTextField: String? {
        willSet {
            textField?.placeholder = newValue
        }
    }
    open var textForTextField: String? {
        willSet {
            textField?.text = newValue
        }
    }
    open var textColorForTextField: UIColor? {
        willSet {
            textField?.textColor = newValue
        }
    }
    open var valueForSwitch: Bool? {
        willSet {
            self.switch?.isOn = newValue ?? false
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
    open var valueForSegment: Int16? {
        willSet {
            guard newValue != nil else { return }
            segment?.selectedSegmentIndex = Int(newValue!)
        }
    }
    private var textField: UITextField?
    private var currentValueLabel: UILabel?
    private var `switch`: UISwitch?
    private var segment: UISegmentedControl?
    private var rightImageView: UIImageView?
    
    override open func layoutSubviews() {
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
    
    private func setInput() {
        switch identifier {
        case .disclosureIndicator:
            if input is UIImage {
                rightImageView?.image = input as? UIImage
            } else {
                currentValueLabel?.text = input as? String
            }
        case .segment:
            segment?.selectedSegmentIndex = input as! Int
        case .switch:
            `switch`?.isOn = input as! Bool
        case .textField:
            textField?.text = input as? String
        default:
            break
        }
    }
    
    private func setToTextFieldCell() {
        self.accessoryView = nil
        self.accessoryType = .none
        self.textField = UITextField(frame: CGRect(x: 16, y: 0, width: frame.width - 32, height: frame.height))
        self.textField?.font = FontBook.regularFont(ofSize: 16)
        self.textField?.delegate = self
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
    
    @objc private func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(addFoodEventCell(_:shouldSaveData:))) {
            delegate.addFoodEventCell!(self, shouldSaveData: input)
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        addFoodEventCell(self, shouldSaveData: input)
    }
    
}
