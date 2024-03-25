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

        let w = imgSplash.frame.width/2
        let h = imgSplash.frame.height/2
        let x = (view.frame.width - w)/2
        let y = -h
        imgSplash.frame = CGRect(x: x, y: y, width: w, height: h)
//        imgSplash.frame.origin.x = (view.frame.width - imgSplash.frame.width)/2.0
//        imgSplash.frame.origin.y = view.frame.height
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2){
            self.imgSplash.frame.origin.y = (self.view.frame.height - self.imgSplash.frame.height)/2.0
            self.imgSplash.alpha = 1.0
        } completion: { respuesta in
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.performSegue(withIdentifier: "sgSplash", sender: nil)
            }
        }
    }

    
}
