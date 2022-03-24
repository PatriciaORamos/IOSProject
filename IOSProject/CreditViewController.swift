//
//  CreditViewController.swift
//  IOSProject
//
//  Created by w0451169 on 2022-03-21.
//

import UIKit

class CreditViewController: UIViewController {
    
    
    @IBOutlet weak var pNameLbl: UILabel!
    @IBOutlet weak var pptsLbl: UILabel!
    
    var pname: String?
    var ppts: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pname != nil {
            pNameLbl.text = pname
        }
        if ppts != nil {
            pptsLbl.text = ppts
        } else {
            pptsLbl.text = "0"
        }
        
    }
    
    @IBAction func goBackBtn(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        controller.name = pNameLbl.text
        controller.pontos = pptsLbl.text
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion:nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
