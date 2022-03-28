//
//  CreditViewController.swift
//  IOSProject
//
//  Created by w0451169 on 2022-03-21.
//

import UIKit

class CreditViewController: UIViewController {
    
    var pname: String?
    var ppts: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackBtn(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        
        if pname != nil {
            controller.name = pname
        } else {
            controller.name = ""
        }
        if ppts != nil {
            controller.pontos = ppts
        } else {
            controller.pontos = "0"
        }
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion:nil)
    }

}
