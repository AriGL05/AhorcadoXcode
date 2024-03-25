//
//  SplashViewController.swift
//  Ahorcado
//
//  Created by Mac19 on 25/03/24.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imgSplash: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

       

    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2){
            self.imgSplash.frame.origin.y = (self.view.frame.height - self.imgSplash.frame.height)/2.0
            self.imgSplash.alpha = 1.0
        } completion: { respuesta in
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.performSegue(withIdentifier: "sgSplash", sender: nil)
            }
        }
    }

    
}
