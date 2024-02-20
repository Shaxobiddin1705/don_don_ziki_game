//
//  ViewController.swift
//  don_don_ziki_game
//
//  Created by Shaxobiddin on 19/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var randomImage: UIImageView?
    @IBOutlet var imageLabel: UILabel?
    @IBOutlet var rulesButton: UIButton!
    private var randomValue: DonDonZikiElement?
    private var selectedValue: DonDonZikiElement?
    let elements: Array<DonDonZikiElement> = [
        DonDonZikiElement(name: DonDonZiki.paper, image: UIImage(named: "icon-paper")),
        DonDonZikiElement(name: DonDonZiki.rock, image: UIImage(named: "icon-rock")),
        DonDonZikiElement(name: DonDonZiki.scissors, image: UIImage(named: "icon-scissors")),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel?.text = ""
    }
    
    func setUp() {
        randomValue = elements.randomElement()
        randomImage?.image = randomValue?.image
        switch randomValue?.name {
        case .paper:
            imageLabel?.text = "Paper"
        case .rock:
            imageLabel?.text = "Rock"
        case .scissors:
            imageLabel?.text = "Scissors"
        case .none:
            imageLabel?.text = "None"
        }
        
        let result = check()
        switch result {
            case .equal: showAlert(message: "YOU ARE EQUAL")
            case .won: showAlert(message: "YOU ARE WON")
            case .fail: showAlert(message: "YOU ARE FAIL")
        }
    }

    @IBAction func rockButtonPressed(_ sender: UIButton) {
        selectedValue = DonDonZikiElement(name: DonDonZiki.rock, image: UIImage(named: "icon-rock"))
        setUp()
    }
    
    @IBAction func paperButtonPressed(_ sender: UIButton) {
        selectedValue = DonDonZikiElement(name: DonDonZiki.paper, image: UIImage(named: "icon-paper"))
        setUp()
    }
    
    @IBAction func scissorsButtonPressed(_ sender: UIButton) {
        selectedValue = DonDonZikiElement(name: DonDonZiki.scissors, image: UIImage(named: "icon-scissors"))
        setUp()
    }
    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        let rule = UIAlertController(title: "Don Don Ziki", message: "Rules", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        rule.addAction(action)
        
        present(rule, animated: true)
    }
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: "DON DON ZIKI", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive) {(value) in
            self.randomValue = nil
            self.randomImage?.image = nil
            self.imageLabel?.text = nil
        }
        alertController.addAction(action)
        sleep(1)
        present(alertController, animated: true)
    }
    
    func check() -> CheckingResult {
        if selectedValue?.name == randomValue?.name {
            return CheckingResult.equal
        }
        else if selectedValue?.name == DonDonZiki.paper && randomValue?.name == DonDonZiki.rock {
            return CheckingResult.won;
        }
        else if selectedValue?.name == DonDonZiki.rock && randomValue?.name == DonDonZiki.scissors {
            return CheckingResult.won;
        }
        else if selectedValue?.name == DonDonZiki.scissors && randomValue?.name == DonDonZiki.paper {
            return CheckingResult.won;
        }
        return CheckingResult.fail
    }
}

enum DonDonZiki: Equatable {
    case paper
    case rock
    case scissors
}

enum CheckingResult {
    case won, fail, equal
}

struct DonDonZikiElement: Equatable{
    let name: DonDonZiki
    var image: UIImage?
}
