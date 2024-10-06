//
//  Vista2ViewController.swift
//  Calculadora_Lab07
//
//  Created by Mac05 on 4/10/24.
//

import UIKit

class Vista2ViewController: UIViewController {

    @IBOutlet weak var txtResultado: UITextField!
    
    var numero1: Double = 0  // Primer número
    var numero2: Double = 0  // Segundo número
    var operacionEnCurso = false  // Indica si una operación está en curso
    var operacion = ""  // Almacena la operación actual
    var nuevaOperacion = true  // Indica si es el comienzo de una nueva operación

    override func viewDidLoad() {
        super.viewDidLoad()
        txtResultado.text = "0"  // Inicializamos la pantalla con "0"
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
    
    @IBAction func numerosPresionados(_ sender: UIButton) {
        let numero = sender.currentTitle!  // El número que se presionó
        manejarNumero(numero)
    }
    
    // Función auxiliar para manejar la inserción de números
    func manejarNumero(_ numero: String) {
        if txtResultado.text == "0" || nuevaOperacion {
            txtResultado.text = numero
            nuevaOperacion = false
        } else {
            txtResultado.text! += numero
        }
    }

    @IBAction func operadorPresionado(_ sender: UIButton) {
        let operador = sender.currentTitle!  // Operador presionado (+, -, ×, ÷)
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            numero1 = valorActual
            operacion = operador
            nuevaOperacion = true
        }
    }
    
    // Aquí la calculadora cientifica
    
    
    @IBAction func igualPresionado(_ sender: UIButton) {
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            numero2 = valorActual
            var resultado: Double = 0
            
            switch operacion {
            case "+":
                resultado = numero1 + numero2
            case "-":
                resultado = numero1 - numero2
            case "×":
                resultado = numero1 * numero2
            case "÷":
                if numero2 != 0 {
                    resultado = numero1 / numero2
                } else {
                    txtResultado.text = "Error"
                    return
                }
            default:
                break
            }
            
            txtResultado.text = String(resultado)
            nuevaOperacion = true
        }
    }
    
    @IBAction func limpiarPresionado(_ sender: UIButton) {
        txtResultado.text = "0"
        numero1 = 0
        numero2 = 0
        operacion = ""
        nuevaOperacion = true
    }
    
    // Faltan dos funciones
    
    @IBAction func borrarUltimoCaracter(_ sender: UIButton) {
        if var textoActual = txtResultado.text {
            if !textoActual.isEmpty {
                textoActual.removeLast()
                txtResultado.text = textoActual.isEmpty ? "0" : textoActual
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
