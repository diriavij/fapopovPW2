//
//  WishEventCreationView.swift
//  fapopovPW2
//
//  Created by Фома Попов on 03.12.2024.
//

import UIKit

// MARK: - WishEventCreationView
class WishEventCreationView: UIViewController {
    
    // MARK: - UI Elements
    
    private let windowTitle: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private let titleField: UITextField = UITextField()
    private let descriptionLabel: UILabel = UILabel()
    private let descriptionField: UITextField = UITextField()
    private let startDateLabel: UILabel = UILabel()
    private let startDateField: UIDatePicker = UIDatePicker()
    private let endDateLabel: UILabel = UILabel()
    private let endDateField: UIDatePicker = UIDatePicker()
    private let submitButton: UIButton = UIButton(type: .system)
    
    private var onSubmit: ((WishEventModel) -> Void)?
    
    
    // MARK: - Constants
    
    private enum Const {
        static let cornerRadius: CGFloat = 10
        static let fieldsBackgroundColor: UIColor = .white
        static let fieldsTextColor: UIColor = .black
        static let fieldsHorizontalOffset: Double = 60
        static let fieldsHieght: Double = 40
        
        static let mainTitle = "Add New Event"
        static let mainTitleFont: UIFont = .systemFont(ofSize: 32, weight: UIFont.Weight(3))
        static let mainTitleTop: Double = 20
        
        static let titleFont: UIFont = .systemFont(ofSize: 24, weight: UIFont.Weight(2))
        static let titleLeft: Double = 30
        static let titleSpacing: Double = 20
        
        static let titleText = "Title:"
        static let descriptionText = "Description:"
        static let startDateLabelText = "Start Date:"
        static let endDateLabelText = "End Date:"
        
        static let titlePlaceholder = "Title"
        static let descriptionPlaceholder = "Description"
        
        static let pickerMode: UIDatePicker.Mode = .date
        
        static let bigSpacing: Double = 50
        static let buttonHorizontalOffset: Double = 200
        static let buttonLabel = "ADD EVENT"
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.currentColor
        configureUI()
    }
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        configureMainTitle()
        configureTitle()
        configureDescription()
        configureStartDate()
        configureEndDate()
        configureButton()
    }
    
    private func configureMainTitle() {
        view.addSubview(windowTitle)
        windowTitle.text = Const.mainTitle
        windowTitle.font = Const.mainTitleFont
        windowTitle.textColor = WishMakerViewController.currentColor.getOpposite()
        
        windowTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.mainTitleTop)
        windowTitle.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureTitle() {
        view.addSubview(titleLabel)
        titleLabel.text = Const.titleText
        titleLabel.font = Const.titleFont
        titleLabel.textColor = WishMakerViewController.currentColor.getOpposite()
        titleLabel.pinTop(to: windowTitle.bottomAnchor, Const.titleSpacing)
        titleLabel.pinLeft(to: view, Const.titleLeft)
        
        view.addSubview(titleField)
        titleField.placeholder = Const.titlePlaceholder
        titleField.layer.cornerRadius = Const.cornerRadius
        titleField.backgroundColor = Const.fieldsBackgroundColor
        titleField.textColor = Const.fieldsTextColor
        titleField.pinCenterX(to: view)
        titleField.pinTop(to: titleLabel.bottomAnchor, Const.titleSpacing)
        titleField.setWidth(view.frame.width - Const.fieldsHorizontalOffset)
        titleField.setHeight(Const.fieldsHieght)
    }
    
    private func configureDescription() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = Const.descriptionText
        descriptionLabel.font = Const.titleFont
        descriptionLabel.textColor = WishMakerViewController.currentColor.getOpposite()
        descriptionLabel.pinTop(to: titleField.bottomAnchor, Const.titleSpacing)
        descriptionLabel.pinLeft(to: view, Const.titleLeft)
        
        view.addSubview(descriptionField)
        descriptionField.placeholder = Const.descriptionPlaceholder
        descriptionField.layer.cornerRadius = Const.cornerRadius
        descriptionField.backgroundColor = Const.fieldsBackgroundColor
        descriptionField.textColor = Const.fieldsTextColor
        descriptionField.pinCenterX(to: view)
        descriptionField.pinTop(to: descriptionLabel.bottomAnchor, Const.titleSpacing)
        descriptionField.setWidth(view.frame.width - Const.fieldsHorizontalOffset)
        descriptionField.setHeight(Const.fieldsHieght)
    }
    
    private func configureStartDate() {
        view.addSubview(startDateLabel)
        startDateLabel.text = Const.startDateLabelText
        startDateLabel.font = Const.titleFont
        startDateLabel.textColor = WishMakerViewController.currentColor.getOpposite()
        startDateLabel.pinTop(to: descriptionField.bottomAnchor, Const.titleSpacing)
        startDateLabel.pinLeft(to: view, Const.titleLeft)
        
        view.addSubview(startDateField)
        startDateField.datePickerMode = Const.pickerMode
        startDateField.layer.masksToBounds = true
        startDateField.backgroundColor = Const.fieldsBackgroundColor
        startDateField.layer.cornerRadius = Const.cornerRadius
        startDateField.pinCenterX(to: view)
        startDateField.pinTop(to: startDateLabel.bottomAnchor, Const.titleSpacing)
    }
    
    private func configureEndDate() {
        view.addSubview(endDateLabel)
        endDateLabel.text = Const.endDateLabelText
        endDateLabel.font = Const.titleFont
        endDateLabel.textColor = WishMakerViewController.currentColor.getOpposite()
        endDateLabel.pinTop(to: startDateField.bottomAnchor, Const.titleSpacing)
        endDateLabel.pinLeft(to: view, Const.titleLeft)
        
        view.addSubview(endDateField)
        endDateField.datePickerMode = Const.pickerMode
        endDateField.layer.masksToBounds = true
        endDateField.backgroundColor = Const.fieldsBackgroundColor
        endDateField.layer.cornerRadius = Const.cornerRadius
        endDateField.pinCenterX(to: view)
        endDateField.pinTop(to: endDateLabel.bottomAnchor, Const.titleSpacing)
    }
    
    private func configureButton() {
        view.addSubview(submitButton)
        submitButton.setHeight(Const.fieldsHieght)
        submitButton.pinCenterX(to: view)
        submitButton.pinTop(to: endDateField.bottomAnchor, Const.bigSpacing)
        submitButton.setWidth(view.frame.width - Const.buttonHorizontalOffset)
        submitButton.backgroundColor = Const.fieldsBackgroundColor
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.setTitle(Const.buttonLabel, for: .normal)
        submitButton.titleLabel?.font = Const.titleFont
        submitButton.layer.cornerRadius = Const.cornerRadius
        submitButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
    }
    
    // MARK: - Adding Delegate
    
    internal func addDelegate(_ delegate: @escaping ((WishEventModel) -> Void)) {
        onSubmit = delegate
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonWasPressed() {
        let newEvent = WishEventModel(
            title: titleField.text ?? "",
            description: descriptionField.text ?? "",
            startDate: startDateField.date,
            endDate: endDateField.date
        )
        onSubmit?(newEvent)
        dismiss(animated: true)
    }
}
