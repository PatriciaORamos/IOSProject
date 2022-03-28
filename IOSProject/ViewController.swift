//
//  ViewController.swift
//  IOSProject
//
//  Created by w0451169 on 2022-03-21.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var nameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func playBtn(_ sender: UIButton) {
        
        if !((nameTxt.text ?? "").isEmpty) {
            let controller = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
            // Player can enter name in app
            controller.name = nameTxt.text
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion:nil)
        }
        
    }
    
}

