//
//  MenuViewController.swift
//  Ahorcado
//
//  Created by Mac19 on 25/03/24.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {

    var reproductor = AVAudioPlayer()
    let cancion = "03. Lost At A Sleepover"
   
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
          super.viewDidLoad()

          let audioURL = Bundle.main.url(forResource: cancion, withExtension: "mp3")!
          do {
              audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
              if audioPlayer?.currentTime == 45{
                  audioPlayer?.currentTime = 0
              }
               // Iniciar reproducción en el segundo 45
              audioPlayer?.numberOfLoops = -1 // Repetir infinitamente
              audioPlayer?.play()
          } catch {
              print("Error al reproducir música: \(error)")
          }
      }

      override func viewDidDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
          audioPlayer?.stop()
      }
  }

