//
//  GameViewController.swift
//  IOSProject
//
//  Created by w0451169 on 2022-03-21.
//

import UIKit

class GameViewController: UIViewController {
     

    @IBOutlet weak var pnameLbl: UILabel!
    @IBOutlet weak var hptsLbl: UILabel!
    @IBOutlet weak var hscrLbl: UILabel!
    @IBOutlet weak var pptsLbl: UILabel!
    @IBOutlet weak var pscrLbl: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var hitBtn: UIButton!
    @IBOutlet weak var stayBtn: UIButton!
        
    @IBOutlet weak var hcard1: UIImageView!
    @IBOutlet weak var hcard2: UIImageView!
    @IBOutlet weak var hcard3: UIImageView!
    @IBOutlet weak var hcard4: UIImageView!
    @IBOutlet weak var hcard5: UIImageView!
    @IBOutlet weak var hcard6: UIImageView!
    
    @IBOutlet weak var pcard1: UIImageView!
    @IBOutlet weak var pcard2: UIImageView!
    @IBOutlet weak var pcard3: UIImageView!
    @IBOutlet weak var pcard4: UIImageView!
    @IBOutlet weak var pcard5: UIImageView!
    @IBOutlet weak var pcard6: UIImageView!
    
    var name: String?
    var pontos: String?
    var hCardsArray : [UIImageView] = []
    var pCardsArray : [UIImageView] = []
    
    var numberStay = 2
    var numberHit = 2
    var scorePlayer = 0
    var scoreHome = 0
    var pontsPlayer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if name != nil {
            pnameLbl.text = name
        }
        if pontos != nil {
            pptsLbl.text = pontos
            let ptos = Int(pontos!) ?? 0
            pontsPlayer = ptos
        } else {
            hscrLbl.text = "0"
        }
               
        pscrLbl.text = "0"
        
        hCardsArray = [ hcard1, hcard2, hcard3, hcard4, hcard5, hcard6]
        pCardsArray = [ pcard1, pcard2, pcard3, pcard4, pcard5, pcard6]
    }
    
    @IBAction func creditBtn(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "CreditViewController") as! CreditViewController       
        controller.pname = pnameLbl.text
        controller.ppts = pptsLbl.text
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion:nil)
    }
    
   /*
        When the start button is pressed, randomize entries in card array, and the 2 house cards are shown (based on the 1st 2 entries in the array) and the first 2 player cards are shown.
     */
    @IBAction func startBtn(_ sender: UIButton) {
        startBtn.isHidden = true
        hitBtn.isHidden = false
        stayBtn.isHidden = false
        var number = 0
        while number < 4 {
            let card = Int.random(in: 1...52)
            let cardValue = getValueCard(card:card)

            if( number < 2 ) {
                hCardsArray[number].image = UIImage(named:"card\(card)")
                calcScore(cardValue: cardValue, typePlayer: "H")
            } else {
                pCardsArray[number-2].image = UIImage(named:"card\(card)")
                calcScore(cardValue: cardValue, typePlayer: "P")
            }
            number += 1
            bust()
        }
    }
    
    /*
        Each time the player presses the "hit" button, a new card is shown (next value from the array) and the player total is adjusted the score is checked for "bust"
     */
    @IBAction func hitBtn(_ sender: UIButton) {
        if scorePlayer > 0 && numberHit <= 5 && scorePlayer <= 21{
            let card = Int.random(in: 1...52)
            pCardsArray[numberHit].image = UIImage(named:"card\(card)")
            let cardValue = getValueCard(card:card)
            calcScore(cardValue: cardValue, typePlayer: "P")
            numberHit = numberHit + 1
            bust()
        }
    }
    
    /*
        When the "stay" button is pressed, the "house" starts drawing cards from the array from where the player left off. After each card is shown, the house score is adjusted and checked. Card are continually drawn until the house score is equal or greater to the player score.
     */
    @IBAction func stayBtn(_ sender: UIButton) {
        while  scorePlayer > 0 && numberStay <= 5 && scoreHome < scorePlayer  {
            let card = Int.random(in: 1...52)
            hCardsArray[numberStay].image = UIImage(named:"card\(card)")
            let cardValue = getValueCard(card:card)
            calcScore(cardValue: cardValue, typePlayer: "H")
            numberStay = numberStay + 1
            bust()
        }
        scoreHomeVsScorePlayer()
    }
    
  
    func bust(){
        if scoreHome > 21 {
            let alert = UIAlertController(title: "YOU WIN", message: "Congrats, home BUST...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
            //If the house score is > 21, the house busts and the player is awarded 50pts.
            pontsPlayer = pontsPlayer + 50
        }
        if scorePlayer > 21 {
            let alert = UIAlertController(title: "YOU LOSE", message: "Try again, you BUST..", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
            
            //If the player busts or the house score is >= player score (without busting), 50pts is deducted from the player score.
            pontsPlayer = pontsPlayer - 50
        }
        
        if scoreHome == 21 {
            let alert = UIAlertController(title: "YOU LOSE", message: "Try again, Home BLACKJACK...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
            pontsPlayer = pontsPlayer - 50
        }
        
        if scorePlayer == 21 {
            let alert = UIAlertController(title: "YOU WIN - BLACKJACK", message: "Congratulation...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
            pontsPlayer = pontsPlayer + 50
        }
        pptsLbl.text = "\(pontsPlayer)"
    }

    
    func scoreHomeVsScorePlayer(){
        if ( scoreHome < 21 && scoreHome >= scorePlayer ) {
            let alert = UIAlertController(title: "YOU LOSE", message: "Try again, home has score >= you ...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
            //If the player busts or the house score is >= player score (without busting), 50pts is deducted from the player score.
            pontsPlayer = pontsPlayer - 50
            pptsLbl.text = "\(pontsPlayer)"
        }
    }
    
    /*
        An alert is shown announcing the winner, the screen is reset when the dismiss button is pressed, and the start button appears on the screen
     
        Keep track of the score until the player closes the app
     */
    func reset() {
        startBtn.isHidden = false
        hitBtn.isHidden = true
        stayBtn.isHidden = true
        
        hscrLbl.text = "0"
        pscrLbl.text = "0"

        numberStay = 2
        numberHit = 2
        scorePlayer = 0
        scoreHome = 0
        
        var count = 0
        for hcard in hCardsArray {
            if count <= 1 {
                hcard.image = UIImage(named:"cardback-red")
            } else {
                hcard.image = UIImage(named:"")
            }
            count = count + 1
        }
        
        var countH = 0
        for hcard in pCardsArray {
            if countH <= 1 {
                hcard.image = UIImage(named:"cardback-red")
            } else {
                hcard.image = UIImage(named:"")
            }
            countH = countH + 1
        }
    }
       
    func calcScore(cardValue: Int, typePlayer: String ) {
        var value = cardValue
        if typePlayer == "H" {
            if value == 1 {
                if ( scoreHome <= 10)  {
                    value = 11
                }
            }
            scoreHome = scoreHome + value
            hscrLbl.text = "\(scoreHome)"
        } else {
            if value == 1 {
                if ( scorePlayer <= 10)  { 
                    value = 11
                }
            }
            scorePlayer = scorePlayer + value
            pscrLbl.text = "\(scorePlayer)"
        }
    }
    
    func getValueCard(card: Int)-> Int{
        switch (card) {
        case 1, 2, 3, 4:
            return 2;
        case 5, 6, 7, 8:
            return 3;
        case 9, 10, 11, 12:
            return 4;
        case 13, 14, 15, 16:
            return 5;
        case 17, 18, 19, 20:
            return 6;
        case 21, 22, 23, 24:
            return 7;
        case 25, 26, 27, 28:
            return 8;
        case 29, 30, 31, 32:
            return 9;
        case 31..<49:
            return 10;
        case 49, 50, 51, 52:
            return 1;
        default: return 0
        }
    }
}
