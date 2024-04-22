//
//  GameViewController.swift
//  Ahorcado
//
//  Created by Mac19 on 27/03/24.
//

import UIKit
import CoreData
import Foundation
import AVFoundation
import AVFAudio

extension String {
    func quitarAcentos() -> String? {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        return mutableString as String
    }
}

class GameViewController: UIViewController {

    
    @IBOutlet weak var ImgMonito: UIImageView!
    
    @IBOutlet weak var lblPalabra: UILabel!
    
    
    @IBOutlet weak var TimerLabel: UILabel!
    
    
    @IBOutlet weak var crz1: UIImageView!
    @IBOutlet weak var crz2: UIImageView!
    @IBOutlet weak var crz3: UIImageView!
    
    let imagenes = ["hangman1","hangman2","hangman3","hangman4","hangman5","hangman6","hangman7","hangman8","hangman9","hangman10",]
    let valorBaseRonda = 500
    let penalizacionError = 10
    var errores = 0
    let valorPalabraAdivinada = 50
    var palabra_adivinada = 0
    var puntaje:Int = 0
    var count: Int = 0
//    let tiempoLimite = 120
    
    var oportunidad = 0
    var vidas = 3
//    let bancoPalabras = ["Ari"]
    let bancoPalabras = [
        "Algoritmo",
        "Programación",
        "Datos",
        "Lenguaje",
        "Compilador",
        "Intérprete",
        "Código",
        "Estructura",
        "Variable",
        "Función",
        "Clase",
        "Objeto",
        "Método",
        "Herencia",
        "Polimorfismo",
        "Encapsulamiento",
        "Interfaz",
        "Sistema",
        "Kernel",
        "Procesador",
        "Memoria",
        "Disco duro",
        "Archivo",
        "Red",
        "Protocolo",
        "Router",
        "Firewall",
        "Seguridad",
        "Cifrado",
        "Ciberseguridad",
        "Nube",
        "Virtualización",
        "API",
        "Framework",
        "Desarrollo",
        "Testing",
        "Debugging",
        "Deployment",
        "Scrum",
        "Git",
        "Versionamiento",
        "Compresión",
        "Encriptación",
        "Programador",
        "Analista",
        "Ingeniero",
        "Arquitectura",
        "Interfaz",
        "Ingenieria",
        "computacionales",
        "Jonh",
        "Ari",
        "Jafet"
    ]
    var palabraSeleccionada:String = ""
    var letrasDescubiertas = [Character]()

        
    var timer:Timer = Timer()
    var timerCounting:Bool = false

    private var audioPlayer: AVAudioPlayer?
    private var notPlayer: AVAudioPlayer?
    let cancion = "06. Let's Get Together Now!"
    let sonidoWin = "something-sound-effect-omori"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPalabra.text = iniciarPalabra()
        tocarCancion()
        print("palabra es: \(palabraSeleccionada)")
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
       

    }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           audioPlayer?.stop()
       }
    
    
    func iniciarPalabra()-> String {
        if let palabraAleatoria = bancoPalabras.randomElement()
        {
            let palabraActual = palabraAleatoria
            let palabraOculta = String(repeating: "_ ", count: palabraActual.count)
            self.palabraSeleccionada = palabraActual.quitarAcentos()!.lowercased()
            return palabraOculta
        }
        return ""
    }
    func tocarCancion()
    {
        let audioURL = Bundle.main.url(forResource: cancion, withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
        
            audioPlayer?.numberOfLoops = -1 // Repetir infinitamente
            audioPlayer?.play()
        } catch {
            print("Error al reproducir música: \(error)")
        }
    }
    func terminarSonido()
    {
        let audioURL = Bundle.main.url(forResource: sonidoWin, withExtension: "mp3")!
        do {
            notPlayer = try AVAudioPlayer(contentsOf: audioURL)
            notPlayer?.play()
        } catch {
            print("Error al reproducir música: \(error)")
        }
        
    }
    
    @IBAction func BotonPresionado(_ sender: UIButton) {
        var palabraOculta = ""
        
        var letraDescubierta = false
        
        guard let letraBoton = sender.titleLabel?.text?.lowercased().first else { return }

        
        for letra in palabraSeleccionada {
              if letra.lowercased() == String(letraBoton) {
                  print("La palabra contiene la letra '\(letra)'")
                  palabraOculta.append(letra)
                  letraDescubierta = true
                  print("aqui1")
              } else if letrasDescubiertas.contains(letra) {
                  palabraOculta.append(letra) 
                  print("aqui2")
              } else {
                  palabraOculta.append("_ ")
                  print("aqui3")

              }
          }

          if letraDescubierta {

              letrasDescubiertas.append(letraBoton)
              print("aqui4:\(letrasDescubiertas)")

          }
        print("aqui4.2:\(letrasDescubiertas)")

        print("aqui5:\(palabraOculta)")

      lblPalabra.text = palabraOculta
        if letraDescubierta
        {
//            sender.isEnabled = false
            if lblPalabra.text == palabraSeleccionada.lowercased()
            {
//                palabra adivinada
                lblPalabra.text = iniciarPalabra()
                letrasDescubiertas=[]
                palabra_adivinada += 1
            }
        }
        else
        {
            errores += 1
            if imagenes.count != oportunidad
            {
            print("perdio una oportunidad")
                ImgMonito.image = UIImage(named: imagenes[oportunidad])
                oportunidad += 1
            }
            else
            {
                oportunidad = 0
                print("perdio una vida")
//                aqui le quita una vida
                terminarSonido()
                if vidas != 1
                {
                    vidas -= 1
                    if vidas == 2{crz3.tintColor = .darkGray}
                    if vidas == 1{crz2.tintColor = .darkGray}
                    oportunidad = 0
                    ImgMonito.image = UIImage(named: "hangman0.png")
                }
                else{
//                    partido terminado
                    print("terminado ")
                    timer.invalidate()

                    crz1.tintColor = .darkGray
//                    mandar una alerta de que perdio, para que ingrese su nombre
                    var nombre = ""
                    let perdio = UIAlertController(title: "You Lose", message: "Tus vidas se han acabado, tu puntuacion es: \(String(puntuacion()))", preferredStyle: .alert)
                    perdio.addTextField { textfield  in
                        textfield.placeholder = "Escribe tu nombre"
                    }
                    perdio.addAction(UIAlertAction(title: "Ready", style: .default) { _ in
                            if let textField = perdio.textFields?.first, let nombreIngresado = textField.text {
                                nombre = nombreIngresado
                                print("Nombre ingresado: \(nombre)")
                                self.guardarDatos(nombre: nombre, puntaje: self.puntuacion())
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.performSegue(withIdentifier: "HOMESEGUE", sender: nil)
                                }
                            }
                        })
                    present(perdio, animated: true)
                }
            }
        }
        
    }
    func guardarDatos(nombre: String, puntaje: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let juagdor = Jugador(context: context)
        juagdor.name = nombre
        juagdor.score = Int32(Int(puntaje)) // Asegúrate de que el tipo de dato sea correcto según el atributo en tu modelo de datos

        appDelegate.saveContext()
    }
    
    func puntuacion()-> Int
    {//aqui vamos a poner la puntuacion para guardarla
        
        let puntuacion_final = valorBaseRonda - (errores * penalizacionError) + (valorPalabraAdivinada * palabra_adivinada) - count
        print("tiempooo\(count)")
        return puntuacion_final
    }
    
    @objc func botonPresionado(_ sender: UIButton) {
        guard let letra = sender.titleLabel?.text else { return }
        print("Botón presionado: \(letra)")
    }
    
    @objc func timerCounter() -> Void
        {
            count = count + 1
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            TimerLabel.text = timeString
        }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
        
        func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    



    
}
