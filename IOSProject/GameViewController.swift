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
            let value = getValueCard(card:card)
            if( number < 2 ) {
                hCardsArray[number].image = UIImage(named:"card\(card)")
                scoreHome = scoreHome + value
            } else {
                pCardsArray[number-2].image = UIImage(named:"card\(card)")
                scorePlayer = scorePlayer + value
            }
            number += 1
           
        }
        hscrLbl.text = "\(scoreHome)"
        pscrLbl.text = "\(scorePlayer)"
    }
    
    @IBAction func hitBtn(_ sender: UIButton) {
        if numberHit <= 5 {
            let card = Int.random(in: 1...52)
            pCardsArray[numberHit].image = UIImage(named:"card\(card)")
            numberHit = numberHit + 1
        }
    }
    
    @IBAction func stayBtn(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
