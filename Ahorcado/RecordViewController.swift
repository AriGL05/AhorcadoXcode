//
//  RecordViewController.swift
//  Ahorcado
//
//  Created by Mac19 on 02/04/24.
//

import UIKit
import CoreData

class RecordViewController: UIViewController {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") // Nombre del archivo .xcdatamodeld
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Error al cargar el contenedor persistente: \(error)")
            }
        })
        return container
    }()
    
    @IBOutlet weak var lblPrimero: UILabel!
    @IBOutlet weak var lblSegundo: UILabel!
    @IBOutlet weak var lblTercero: UILabel!
    @IBOutlet weak var lblCuarto: UILabel!
    
    var puntuaciones = [String?]()
    override func viewDidLoad() {
        super.viewDidLoad()

        obtenerTopJugadores()
//        lblPrimero.text = puntuaciones[0] ?? "..."
//        lblSegundo.text = puntuaciones[1] ?? "..."
//        lblTercero.text = puntuaciones[2] ?? "..."
//        lblCuarto.text = puntuaciones[3] ?? "..."
    }
    

    func obtenerTopJugadores() {
         let context = persistentContainer.viewContext

         let fetchRequest: NSFetchRequest<Jugador> = Jugador.fetchRequest()
         fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
         fetchRequest.fetchLimit = 4 // Obtener solo los tres jugadores más altos

         do {
             let topJugadores = try context.fetch(fetchRequest)
             for jugador in topJugadores {
                 print("Nombre: \(jugador.name ?? "Sin nombre") - Puntuación: \(jugador.score)")
                 puntuaciones.append("Nombre: \(jugador.name ?? "Sin nombre") - Puntuación: \(jugador.score)")
             }
             actualizarEtiquetas()
         } catch {
             print("Error al obtener los jugadores: \(error)")
         }
     }
    func actualizarEtiquetas() {
           if puntuaciones.isEmpty {
               lblPrimero.text = "Nombre: Olimar Puntuación: -10"
               lblSegundo.text = "Nombre: Uriel Puntuación: -200"
               lblTercero.text = "Nombre: Jafet Puntuación: -240"
               lblCuarto.text = "Nombre: Maracas Puntuación: -400"
           } else {
               lblPrimero.text = puntuaciones.indices.contains(0) ? puntuaciones[0] : "Nombre: Olimar Puntuación: -10"
               lblSegundo.text = puntuaciones.indices.contains(1) ? puntuaciones[1] : "Nombre: Uriel Puntuación: -200"
               lblTercero.text = puntuaciones.indices.contains(2) ? puntuaciones[2] : "Nombre: Jafet Puntuación: -240"
               lblCuarto.text = puntuaciones.indices.contains(3) ? puntuaciones[3] : "Nombre: Maracas Puntuación: -400"
           }
       }

}
