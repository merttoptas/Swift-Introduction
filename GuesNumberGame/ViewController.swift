//
//  ViewController.swift
//  GuesNumberGame
//
//  Created by Mert Toptaş on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var etNumberGuess: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var etGuess: UITextField!
    
    @IBOutlet weak var ivSucces: UIImageView!
    
    @IBOutlet weak var ivStatus: UIImageView!
    
    @IBOutlet weak var btnTryAgain: UIButton!
    
    @IBOutlet weak var ivStarsOne: UIImageView!
    
    @IBOutlet weak var ivStartsTwo: UIImageView!
    
    @IBOutlet weak var ivStarsThree: UIImageView!
    
    @IBOutlet weak var ivStartFour: UIImageView!
    
    @IBOutlet weak var ivStarsFive: UIImageView!
    
    @IBOutlet weak var tvResult: UILabel!
    
    var stars : [UIImageView] = [UIImageView]()
    
    let maxAttemptsNumber : Int = 5 //max deneme
    var attempNumber : Int = -1 //deneme sayısı
    var targetNumber : Int = -1 //hedef sayısı
    var gameStatus : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stars = [ivStarsOne, ivStartsTwo, ivStarsThree, ivStartFour, ivStarsFive]
        ivSucces.isHidden = true
        ivStatus.isHidden = true
        btnTryAgain.isEnabled = false
        etNumberGuess.isSecureTextEntry = true
        btnTryAgain.layer.cornerRadius = 10
        btnTryAgain.clipsToBounds = true
        btnSave.layer.cornerRadius = 10
        btnSave.clipsToBounds = true
        
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        ivSucces.isHidden = false
        
        if let guess = Int(etNumberGuess.text!){
            targetNumber = guess
            btnTryAgain.isEnabled = true
            etNumberGuess.isEnabled = false
            btnSave.isEnabled = false
            ivSucces.image = UIImage(named: "onay")
        } else {
            ivSucces.image = UIImage(named: "hata")
        }
       }
    
    @IBAction func btnTryAgainClicked(_ sender: Any) {
        if gameStatus  == true || attempNumber > maxAttemptsNumber {
            return
        }
        
        if let inputNumber = Int(etGuess.text!) {
            attempNumber += 1
            stars[attempNumber].image = UIImage(named: "beyazYildiz")
            
            ivStatus.isHidden = false
            if inputNumber > targetNumber {
                inputForStatus(image: "asagi", color: UIColor.red)
            
            } else if inputNumber < targetNumber {
                inputForStatus(image: "yukari", color: UIColor.red)
            } else {
                inputForStatus(image: "tamam", color: UIColor.green)
                btnSave.isEnabled = true
                tvResult.text = "Doğru Tahmin!"
                etNumberGuess.isSecureTextEntry = false
                gameStatus = true
                shownAlertController(title: "Başarılı", message: "Doğru Tahmin Ettiniz", actionTitle: "Tamam")
                return
            }
        } else {
            ivStatus.image = UIImage(named: "hata")
        }
        
        if attempNumber+1  == maxAttemptsNumber {
            btnTryAgain.isEnabled = false
            ivStatus.image = UIImage(named: "hata")
            tvResult.text = "Tekrar Deneyin! \(targetNumber) Girilmişti"
            etNumberGuess.isSecureTextEntry = false
            gameStatus = true
            
            shownAlertController(title: "Başarısız", message: "Doğru Tahmin Edemediniz", actionTitle: "Tamam")
            
            return
            
        }
    }
    
    func shownAlertController(title: String, message: String, actionTitle: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction =  UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    
    }
    
    func inputForStatus(image: String, color: UIColor){
        ivStatus.image = UIImage(named: image)
        etGuess.backgroundColor = color
    }
}
