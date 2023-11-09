//
//  ViewController.swift
//  Homework 17
//
//  Created by salome on 08.11.23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    
    private let randomNumStackView: UIStackView = {
        let randomNumStackView = UIStackView()
        randomNumStackView.axis = .horizontal
        randomNumStackView.alignment = .center
        randomNumStackView.distribution = .fillEqually
        randomNumStackView.spacing = 10
        randomNumStackView.translatesAutoresizingMaskIntoConstraints = false
        randomNumStackView.backgroundColor = .darkGray
        return randomNumStackView
    }()
    
    private let randomNumberOneLabel: UILabel = {
        let randomNumberOneLabel = UILabel()
        randomNumberOneLabel.translatesAutoresizingMaskIntoConstraints = false
        randomNumberOneLabel.backgroundColor = .white
        randomNumberOneLabel.textColor = .black
        randomNumberOneLabel.textAlignment = .center
        return randomNumberOneLabel
    }()
    
    private let randomNumberTwoLabel: UILabel = {
        let randomNumberTwoLabel = UILabel()
        randomNumberTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        randomNumberTwoLabel.backgroundColor = .white
        randomNumberTwoLabel.textColor = .black
        randomNumberTwoLabel.textAlignment = .center
        return randomNumberTwoLabel
    }()
    
    
    private let CalculateFactorialButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    
    
    private let factorialOneLabel: UILabel = {
        let factorialOneLabel = UILabel()
        factorialOneLabel.translatesAutoresizingMaskIntoConstraints = false
        factorialOneLabel.backgroundColor = .white
        factorialOneLabel.textColor = .black
        factorialOneLabel.text = "factorial One"
        return factorialOneLabel
    }()
    
    private let factorialTwoLabel: UILabel = {
        let factorialTwoLabel = UILabel()
        factorialTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        factorialTwoLabel.backgroundColor = .white
        factorialTwoLabel.textColor = .black
        factorialTwoLabel.text = "factorial Two"
        
        return factorialTwoLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        addView()
        addConstraints()
        updateRandomNumberOne()
        updateRandomNumberTwo()
        addButtonAction()
    }
    
    func addView() {
        view.addSubview(mainStackView)
        mainStackView.addSubview(randomNumStackView)
        randomNumStackView.addArrangedSubview(randomNumberOneLabel)
        randomNumStackView.addArrangedSubview(randomNumberTwoLabel)
        mainStackView.addArrangedSubview(CalculateFactorialButton)
        mainStackView.addArrangedSubview(factorialOneLabel)
        mainStackView.addArrangedSubview(factorialTwoLabel)
        
        
    }
    
    func addConstraints() {
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        randomNumStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        randomNumStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -50).isActive = true
        randomNumStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        randomNumStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        CalculateFactorialButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        CalculateFactorialButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        CalculateFactorialButton.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        CalculateFactorialButton.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 200).isActive = true
        
        factorialOneLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        factorialOneLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        factorialOneLabel.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        factorialOneLabel.topAnchor.constraint(equalTo: CalculateFactorialButton.topAnchor, constant: 50).isActive = true
        
        factorialTwoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        factorialTwoLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        factorialTwoLabel.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        factorialTwoLabel.topAnchor.constraint(equalTo: factorialOneLabel.topAnchor, constant: 50).isActive = true
        factorialTwoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500).isActive = true
        
        
        
        
    }
    
    func addButtonAction() {
        CalculateFactorialButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    func generateRandomNumber() -> (Int) {
        let lowerNum = 20
        let upperNum = 50
        return Int.random(in: lowerNum ... upperNum)
    }
    func updateRandomNumberOne() {
        let randomNum = generateRandomNumber()
        randomNumberOneLabel.text = String(randomNum)
        
    }
    func updateRandomNumberTwo() {
        let randomNum = generateRandomNumber()
        randomNumberTwoLabel.text = String(randomNum)
        
    }
    
    
    
  
    @objc func buttonAction() {
        let numberOne = Int(randomNumberOneLabel.text!) ?? 0
        let numberTwo = Int(randomNumberTwoLabel.text!) ?? 0

        DispatchQueue.global().async {
            self.calculateFactorial(num: numberOne) { result in
                DispatchQueue.main.async {
                    self.factorialOneLabel.text = result
                }
            }
        }

        DispatchQueue.global().async {
            self.calculateFactorial(num: numberTwo) { result in
                DispatchQueue.main.async {
                    self.factorialTwoLabel.text = result
                }
            }
        }
    }

    func calculateFactorial(num: Int, completion: @escaping (String) -> Void) {
        var result = [1]

        for i in 2...num {
            var carry = 0

            for j in 0..<result.count {
                let product = result[j] * i + carry
                result[j] = product % 10
                carry = product / 10
            }

            while carry > 0 {
                result.append(carry % 10)
                carry /= 10
            }
        }

        let factorialString = result.map { String($0) }.reversed().joined()
        completion(factorialString)
    }
}
            
            
        
