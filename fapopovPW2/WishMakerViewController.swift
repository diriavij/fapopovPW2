//
//  ViewController.swift
//  fapopovPW2
//
//  Created by Фома Попов on 22.10.2024.
//

import UIKit

// MARK: - WishMaker ViewController
class WishMakerViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    private let modeSwitcher: UIButton = UIButton(type: .system)
    private var currentMode = 1
    private let stack = UIStackView()
    private let hexField = UITextField()
    private let hexText = UILabel()
    private let randomButton: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    
    // MARK: - Constants
    
    private enum Const {
        static let hexColorLength: Int = 6
        static let basicHex: String = "FFFFFF"
        static let digitsHex: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        
        static let descriptionText: String = "Make your wish, \nThis app will help it come true! \n First of all, you need to change the \nbackground color"
        static let fieldText: String = "Enter HEX value (without #):"
        static let switchText: String = "Switch Mode"
        static let randomText: String = "RANDOM COLOR"
        static let titleText: String = "WishMaker"
        static let addWishText: String = "MY WISHES"
        
        static let titleWeight: CGFloat = 5
        static let titleSize: CGFloat = 32
        static let subtitleSize: CGFloat = 24
        static let longSubtitleSize: CGFloat = 18
        
        static let alphaValue: CGFloat = 1
        static let basicHelper: CGFloat = 0.0
        
        static let firstColor: UIColor = UIColor(red: 0.15, green: 0.55, blue: 0.33, alpha: 1)
        static let buttonBackgroundColor: UIColor = .white
        static let buttonTextColor: UIColor = .black
        static let linesQuantity: Int = 0
        
        static let cornerRadius: CGFloat = 10
        static let slidersCornerRadius: CGFloat = 20
        static let slidersMin: Double = 0
        static let slidersMax: Double = 1
        static let redTitle: String = "Red"
        static let greenTitle: String = "Green"
        static let blueTitle: String = "Blue"
        
        static let firstMode: Int = 1
        static let secondMode: Int = 2
        static let thirdMode: Int = 3
        
        static let hexTextLeftOffset: Double = 20
        static let hexTextBottomOffset: Double = 300
        
        static let hexFieldLeftOffset: Double = 100
        static let hexFieldBottomOffset: Double = 250
        
        static let titleViewTopOffset: Double = 30
        static let titleViewLeftOffset: Double = 20
        
        static let descriptionViewTopOffset: Double = 20
        static let descriptionViewLeftOffset: Double = 20
        
        static let modeSwitcherBottomOffset: Double = 350
        static let modeSwitcherLeftOffset: Double = 60
        
        static let randomButtonBottomOffset: Double = 250
        static let randomButtonLeftOffset: Double = 60
        
        static let slidersStackBottomOffset: Double = 10
        static let slidersStackLeftOffset: Double = 20
        
        static let addWishButtonSide: Double = 20
        static let addWishButtonHeight: Double = 40
        static let addWishButtonBottom: Double = 40
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        view.backgroundColor = Const.firstColor
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureSliders()
        configureButtons()
        configureTextField()
    }
    
    private func configureTextField() {
        self.hexField.addTarget(self, action: #selector(hexValueWasEntered), for: .editingChanged)
        hexText.text = Const.fieldText
        hexText.textAlignment = NSTextAlignment.center
        hexText.textColor = Const.buttonTextColor
        hexText.font = UIFont.systemFont(ofSize: Const.longSubtitleSize, weight: UIFont.Weight(Const.titleWeight))
        hexText.backgroundColor = Const.buttonBackgroundColor
        hexText.layer.cornerRadius = Const.cornerRadius
        
        view.addSubview(hexText)
        hexText.pinCenterX(to: view.centerXAnchor)
        hexText.pinLeft(to: view.leadingAnchor, Const.hexTextLeftOffset)
        hexText.pinBottom(to: view.bottomAnchor, Const.hexTextBottomOffset)
        hexText.isHidden = true
        
        hexField.textAlignment = NSTextAlignment.center
        hexField.textColor = Const.buttonTextColor
        hexField.font = UIFont.systemFont(ofSize: Const.subtitleSize, weight: UIFont.Weight(Const.titleWeight))
        hexField.backgroundColor = Const.buttonBackgroundColor
        hexField.layer.cornerRadius = Const.cornerRadius
        
        view.addSubview(hexField)
        hexField.pinCenterX(to: view.centerXAnchor)
        hexField.pinLeft(to: view.leadingAnchor, Const.hexFieldLeftOffset)
        hexField.pinBottom(to: view.bottomAnchor, Const.hexFieldBottomOffset)
        hexField.isHidden = true
        hexField.isEnabled = false
    }

    private func configureTitle() {
        titleView.text = Const.titleText
        titleView.textAlignment = NSTextAlignment.center
        titleView.textColor = Const.firstColor.getOpposite()
        titleView.font = UIFont.systemFont(ofSize: Const.titleSize, weight: UIFont.Weight(Const.titleWeight))
        
        view.addSubview(titleView)
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinLeft(to: view.leadingAnchor, Const.titleViewLeftOffset)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.titleViewTopOffset)
    }
    
    private func configureDescription() {
        descriptionView.numberOfLines = Const.linesQuantity
        descriptionView.text = Const.descriptionText
        descriptionView.textAlignment = NSTextAlignment.center
        descriptionView.textColor = Const.firstColor.getOpposite()
        descriptionView.font = UIFont.systemFont(ofSize: Const.subtitleSize)
        
        view.addSubview(descriptionView)
        descriptionView.pinCenterX(to: view.centerXAnchor)
        descriptionView.pinLeft(to: view.leadingAnchor, Const.descriptionViewLeftOffset)
        descriptionView.pinTop(to: titleView.bottomAnchor, Const.descriptionViewTopOffset)
    }
    
    private func configureButtons() {
        modeSwitcher.setTitle(Const.switchText, for: .normal)
        modeSwitcher.titleLabel?.textAlignment = NSTextAlignment.center
        modeSwitcher.setTitleColor(Const.buttonTextColor, for: .normal)
        modeSwitcher.titleLabel?.font = UIFont.systemFont(ofSize: Const.subtitleSize, weight: UIFont.Weight(Const.titleWeight))
        modeSwitcher.backgroundColor = Const.buttonBackgroundColor
        modeSwitcher.layer.cornerRadius = Const.cornerRadius
        
        view.addSubview(modeSwitcher)
        self.modeSwitcher.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        modeSwitcher.pinCenterX(to: view.centerXAnchor)
        modeSwitcher.pinLeft(to: view.leadingAnchor, Const.modeSwitcherLeftOffset)
        modeSwitcher.pinBottom(to: view.bottomAnchor, Const.modeSwitcherBottomOffset)
        
        randomButton.setTitle(Const.randomText, for: .normal)
        randomButton.titleLabel?.textAlignment = NSTextAlignment.center
        randomButton.setTitleColor(Const.buttonTextColor, for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: Const.subtitleSize, weight: UIFont.Weight(Const.titleWeight))
        randomButton.backgroundColor = Const.buttonBackgroundColor
        randomButton.layer.cornerRadius = Const.cornerRadius
        
        view.addSubview(randomButton)
        self.randomButton.addTarget(self, action: #selector(randomButtonWasPressed), for: .touchUpInside)
        randomButton.pinCenterX(to: view.centerXAnchor)
        randomButton.pinLeft(to: view.leadingAnchor, Const.randomButtonLeftOffset)
        randomButton.pinBottom(to: view.bottomAnchor, Const.randomButtonBottomOffset)
        randomButton.isHidden = true
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Const.addWishButtonHeight)
        addWishButton.pinBottom(to: view.bottomAnchor, Const.addWishButtonBottom)
        addWishButton.pinHorizontal(to: view, Const.addWishButtonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Const.addWishText, for: .normal)
        
        addWishButton.layer.cornerRadius = Const.cornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureSliders() {
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Const.slidersCornerRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Const.redTitle, min: Const.slidersMin, max: Const.slidersMax)
        let sliderBlue = CustomSlider(title: Const.blueTitle, min: Const.slidersMin, max: Const.slidersMax)
        let sliderGreen = CustomSlider(title: Const.greenTitle, min: Const.slidersMin, max: Const.slidersMax)

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        stack.pinCenterX(to: view.centerXAnchor)
        stack.pinLeft(to: view.leadingAnchor, Const.slidersStackLeftOffset)
        stack.pinBottom(to: addWishButton.topAnchor, Const.slidersStackBottomOffset)
        
        var red: CGFloat = Const.basicHelper
        var green: CGFloat = Const.basicHelper
        var blue: CGFloat = Const.basicHelper
        var alpha: CGFloat = Const.basicHelper
        Const.firstColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        sliderRed.slider.value = Float(red)
        sliderGreen.slider.value = Float(green)
        sliderBlue.slider.value = Float(blue)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Const.alphaValue)
            self?.titleView.textColor = self?.view.backgroundColor?.getOpposite()
            self?.descriptionView.textColor = self?.view.backgroundColor?.getOpposite()
        }
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Const.alphaValue)
            self?.titleView.textColor = self?.view.backgroundColor?.getOpposite()
            self?.descriptionView.textColor = self?.view.backgroundColor?.getOpposite()
        }
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Const.alphaValue)
            self?.titleView.textColor = self?.view.backgroundColor?.getOpposite()
            self?.descriptionView.textColor = self?.view.backgroundColor?.getOpposite()
        }
    }
    
    // MARK: - Interactions Processing Methods
    
    @objc private func buttonWasPressed() {
        if currentMode == Const.firstMode {
            currentMode = Const.secondMode
            stack.isHidden = true
            hexField.isHidden = false
            hexField.isEnabled = true
            hexText.isHidden = false
        } else if currentMode == Const.secondMode {
            currentMode = Const.thirdMode
            hexField.isHidden = true
            hexField.isEnabled = false
            hexText.isHidden = true
            randomButton.isHidden = false
        } else if currentMode == Const.thirdMode {
            currentMode = Const.firstMode
            stack.isHidden = false
            randomButton.isHidden = true
        }
    }
    
    @objc
    private func addWishButtonPressed() {
        // this will be done later!
    }
    
    @objc private func hexValueWasEntered() {
        if hexField.text?.count == Const.hexColorLength {
            let newColor = UIColor.convertToRGBInit(hexField.text ?? Const.basicHex)
            view.backgroundColor = newColor
            titleView.textColor = newColor.getOpposite()
            descriptionView.textColor = newColor.getOpposite()
        } else if hexField.text!.count > Const.hexColorLength {
            hexField.text = String(hexField.text!.prefix(Const.hexColorLength))
        }
    }
    
    @objc private func randomButtonWasPressed() {
        var hexColor: String = "#"
        for _ in 0...(Const.hexColorLength - 1) {
            let index: Int = .random(in: 0...(Const.digitsHex.count - 1))
            hexColor += Const.digitsHex[index]
        }
        let newColor: UIColor = UIColor.convertToRGBInit(hexColor)
        view.backgroundColor = newColor
        titleView.textColor = newColor.getOpposite()
        descriptionView.textColor = newColor.getOpposite()
    }

}

