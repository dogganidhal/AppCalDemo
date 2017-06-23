//
//  AddFoodEventCell.swift
//  AppCalDemo
//
//  Created by Nidhal on 19.06.17.
//  Copyright © 2017 Strasbourg University. All rights reserved.
//

import UIKit

// This protocol allows the cells to send the input we get from the subViews.

@objc public protocol AddFoodEventCellDelegate: NSObjectProtocol {
    
    // Tells the delegate that the cell has some data to be saved.
    @objc optional func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?)
    
}

// This class is a subclass of UITableViewCell, which allows to display differnt pieces of views on the accessoryView and sends their data to th delegate.

@objc open class AddFoodEventCell: UITableViewCell, UITextFieldDelegate {
    
    // Different pieces of views used in the TableView.
    public enum AddFoodEventCellIdentifier {
        case textField
        case `switch`
        case segment
        case disclosureIndicator
        case none
    }

    // AddFoodEventCellDelegate property
    open weak var delegate: AddFoodEventCellDelegate?
    // This property tells which piece of view the cell should display.
    open var identifier: AddFoodEventCellIdentifier = .none {
        didSet {
            // Reload whenever the identifier changes.
            reloadCell()
        }
    }
    // The input we get from subViews.
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
    // Sets a placeholder on the textField.
    open var placeholderForTextField: String? {
        willSet {
            textField?.placeholder = newValue
        }
    }
    // Sets some text on the textField.
    open var textForTextField: String? {
        willSet {
            textField?.text = newValue
        }
    }
    // Sets the textColor of the textField.
    open var textColorForTextField: UIColor? {
        willSet {
            textField?.textColor = newValue
        }
    }
    // Sets the value of the switch.
    open var valueForSwitch: Bool? {
        willSet {
            self.switch?.isOn = newValue ?? false
        }
    }
    // Sets the tint color of the segment.
    open var segmentTintColor: UIColor? {
        willSet {
            segment?.tintColor = newValue
        }
    }
    // Sets the text on the currentValue Label.
    open var currentValueString: String? {
        willSet {
            currentValueLabel?.text = newValue
            setNeedsLayout()
        }
    }
    // Sets the image of the imageView.
    open var currentImage: UIImage? {
        willSet {
            rightImageView?.image = newValue
        }
    }
    // Sets the value of the segment.
    open var valueForSegment: Int16? {
        willSet {
            guard newValue != nil else { return }
            segment?.selectedSegmentIndex = Int(newValue!)
        }
    }
    // Potential accessoryViews.
    private var textField: UITextField?
    private var currentValueLabel: UILabel?
    private var `switch`: UISwitch?
    private var segment: UISegmentedControl?
    private var rightImageView: UIImageView?
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        // Setup the subviews using autolayout.
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
    
    // Reloads the cell when the identifier has changed.
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
    
    // Sets the input property on the views.
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
    
    // MARK:- Setting a particular type of cell.
    
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
    
    // MARK:- AddFoodEventCellDelegate method.
    
    // In this method the cell sends it's input to the delegate.
    @objc private func addFoodEventCell(_ addFoodEventCell: AddFoodEventCell, shouldSaveData input: Any?) {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(addFoodEventCell(_:shouldSaveData:))) {
            delegate.addFoodEventCell!(self, shouldSaveData: input)
        }
    }

    // MARK:- UITextFieldDelegate method.
    
    // Asks the cell to send the input when the textField is out of focus.
    public func textFieldDidEndEditing(_ textField: UITextField) {
        addFoodEventCell(self, shouldSaveData: input)
    }
    
}
