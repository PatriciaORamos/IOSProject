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
    var hCardsArray : [UIImageView] = []
    var pCardsArray : [UIImageView] = []
    
    var numberStay = 2
    var numberHit = 2
    var scorePlayer = 0
    var scoreHome = 0
    var pontsPlayer = 0
    var pontsHome = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (name != nil) {
            pnameLbl.text = name
        }
        
        hptsLbl.text = "0"
        hscrLbl.text = "0"
        pptsLbl.text = "0"
        pscrLbl.text = "0"
        
        hCardsArray = [ hcard1, hcard2, hcard3, hcard4, hcard5, hcard6]
        pCardsArray = [ pcard1, pcard2, pcard3, pcard4, pcard5, pcard6]
 
    }
   
    @IBAction func startBtn(_ sender: UIButton) {
        var number = 0
        while number < 4 {
            let card = Int.random(in: 1...52)
            var cardValue = getValueCard(card:card)
            if( number < 2 ) {
                hCardsArray[number].image = UIImage(named:"card\(card)")
                //determina value card when card A
                if cardValue == 1  {
                    if scoreHome == 10 {
                        cardValue =  11;
                    }
                }
                calcScore(cardValue: cardValue, typePlayer: "H")
                result()
            } else {
                pCardsArray[number-2].image = UIImage(named:"card\(card)")
                
                //determina value card when card A
                if cardValue == 1  {
                    if scorePlayer == 10 {
                        cardValue =  11;
                    }
                }
                calcScore(cardValue: cardValue, typePlayer: "P")
                result()
            }
            number += 1
        }

    }
    
    @IBAction func hitBtn(_ sender: UIButton) {
        if numberHit <= 5 && scorePlayer <= 21{
            let card = Int.random(in: 1...52)
            pCardsArray[numberHit].image = UIImage(named:"card\(card)")
            
            var cardValue = getValueCard(card:card)
            //determina value card when card A
            if cardValue == 1  {
                if scorePlayer == 10 {
                    cardValue =  11;
                }
            }
            calcScore(cardValue: cardValue, typePlayer: "P")
            result()
            numberHit = numberHit + 1
        }
    }
    
    @IBAction func stayBtn(_ sender: UIButton) {
        while numberStay <= 5 && scoreHome <= 21 {
            let card = Int.random(in: 1...52)
            hCardsArray[numberStay].image = UIImage(named:"card\(card)")
            
            var cardValue = getValueCard(card:card)
            //determina value card when card A
            if cardValue == 1  {
                if scoreHome == 10 {
                    cardValue =  11;
                }
            }
            
            calcScore(cardValue: cardValue, typePlayer: "H")
            result()
            numberStay = numberStay + 1
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   
   
    func bust(){
        if scoreHome > 21 {
            let alert = UIAlertController(title: "BUST", message: "YOU WIN...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
        }
        if scorePlayer > 21 {
            let alert = UIAlertController(title: "BUST", message: "YOU LOSE...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func blackjack() {
        if scoreHome == 21 {
            let alert = UIAlertController(title: "BLACKJACK", message: "YOU LOSE...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
        }
        if scorePlayer == 21 {
            let alert = UIAlertController(title: "BLACKJACK", message: "YOU WIN...", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.reset()} ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func result() {
        bust()
        blackjack()
        
        //calcular os pontos
        
    }
    
    func reset() {
        hptsLbl.text = "0"
        hscrLbl.text = "0"
        pptsLbl.text = "0"
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
       
    func calcPtsHome(typePlayer: String) {
        if typePlayer == "H" {
            pontsHome = pontsHome + 50
            hptsLbl.text = "\(pontsHome)"
        } else {
            pontsPlayer = pontsPlayer + 50
            pptsLbl.text = "\(pontsPlayer)"
        }
    }
    
    func calcScore(cardValue: Int, typePlayer: String ) {
        if typePlayer == "H" {
            scoreHome = scoreHome + cardValue
            hscrLbl.text = "\(scoreHome)"
        } else {
            scorePlayer = scorePlayer + cardValue
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
        case 31..<48:
            return 10;
        case 49, 50, 51, 52:
            return 1;
        default: return 0
        }
    }
}
