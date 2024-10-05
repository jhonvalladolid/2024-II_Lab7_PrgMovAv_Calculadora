//
//  Vista2ViewController.swift
//  Calculadora_Lab07
//
//  Created by Mac05 on 4/10/24.
//

import UIKit

class Vista2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuración inicial de la vista
    }
    
    // Función para manejar la transición de la pantalla al cambiar la orientación
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            // Detectar si estamos en modo horizontal
            if let tabBarVC = self.tabBarController {
                tabBarVC.selectedIndex = 1  // Cambia a la Vista2ViewController (calculadora científica)
            }
        }
    }

    /*
    // MARK: - Navegación

    // En una aplicación basada en storyboard, a menudo querrás hacer alguna preparación antes de la navegación
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Obtener el nuevo ViewController usando segue.destination.
        // Pasar el objeto seleccionado al nuevo ViewController.
    }
    */

}
