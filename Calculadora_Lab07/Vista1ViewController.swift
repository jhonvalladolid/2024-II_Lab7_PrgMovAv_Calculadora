//
//  Vista1ViewController.swift
//  Calculadora_Lab07
//
//  Created by Mac05 on 4/10/24.
//

import UIKit

class Vista1ViewController: UIViewController {

    @IBOutlet weak var txtResultado: UITextField!
    
    var numero1: Double = 5  // Variable para almacenar el primer número
    var numero2: Double = 5  // Variable para almacenar el segundo número
    var operacionEnCurso = false  // Indica si una operación está en curso
    var operacion = ""  // Almacena la operación actual (+, -, *, /)
    var nuevaOperacion = true  // Indica si es el comienzo de una nueva operación

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuración inicial de la vista
        txtResultado.text = "0"  // Inicializamos la pantalla con "0"
    }
    
    // Función para manejar la entrada de números
    @IBAction func numerosPresionados(_ sender: Any) {
        // Verificamos que el objeto 'sender' es un UIButton
        guard let boton = sender as? UIButton else {
            print("Error: El objeto no es un UIButton")
            return
        }

        // Verificamos el tag o el título para identificar el número presionado
        switch boton.tag {
        case 0...9:
            manejarNumero(String(boton.tag))  // Los números del 0 al 9
        case 14:
            manejarNumero(".")  // Botón de punto decimal
        case 15:
            borrarUltimoCaracter()  // Botón "<<" para eliminar caracteres
        default:
            print("Error: Botón no reconocido")
        }
    }
    
    // Función auxiliar para manejar el número presionado
    func manejarNumero(_ numero: String) {
        print("Número presionado: \(numero)")  // Log para depuración

        if numero == "." {
            // Evitar agregar otro punto decimal si ya existe uno en el número
            if txtResultado.text?.contains(".") == true {
                return
            }
            
            // Si el texto actual es "0", cambiar a "0."
            if txtResultado.text == "0" {
                txtResultado.text = "0."
                nuevaOperacion = false
                return
            }
        }

        if txtResultado.text == "0" || nuevaOperacion {
            txtResultado.text = numero
            nuevaOperacion = false
        } else {
            txtResultado.text! += numero
        }
    }

    // Función para borrar el último carácter
    func borrarUltimoCaracter() {
        if var textoActual = txtResultado.text {
            if !textoActual.isEmpty {
                textoActual.removeLast()  // Elimina el último carácter
                txtResultado.text = textoActual.isEmpty ? "0" : textoActual  // Si está vacío, poner 0
            }
        }
    }

    // Función para manejar la selección de operadores (+, -, *, /)
    @IBAction func operadorPresionado(_ sender: Any) {
        // Verificamos que el objeto 'sender' es un UIButton
        guard let boton = sender as? UIButton else {
            print("Error: El objeto no es un UIButton")
            return
        }
        
        // Usamos los tags para determinar qué operador se presionó
        switch boton.tag {
        case 10:
            operacion = "+"  // Suma
        case 11:
            operacion = "-"  // Resta
        case 12:
            operacion = "×"  // Multiplicación
        case 13:
            operacion = "÷"  // División
        default:
            print("Error: Operador no reconocido")
            return
        }
        
        // Guardamos el número actual como el primer número
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            numero1 = valorActual
            operacionEnCurso = true  // Indicamos que una operación está en curso
            nuevaOperacion = true  // Indicamos que estamos listos para una nueva entrada de número
        }
    }
    
    // Función para realizar la operación cuando se presiona el botón "="
    @IBAction func igualPresionado(_ sender: UIButton) {
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            numero2 = valorActual  // Guardamos el número actual como el segundo número
            var resultado: Double = 0.0  // Variable para almacenar el resultado de la operación
            
            // Realizamos la operación según el operador seleccionado
            switch operacion {
            case "+":
                resultado = numero1 + numero2  // Suma
            case "-":
                resultado = numero1 - numero2  // Resta
            case "×":
                resultado = numero1 * numero2  // Multiplicación
            case "÷":
                if numero2 != 0 {
                    resultado = numero1 / numero2  // División
                } else {
                    txtResultado.text = "Error"  // Manejo de la división por cero
                    return
                }
            default:
                break
            }
            
            // Mostramos el resultado en el campo de texto
            txtResultado.text = String(resultado)
            nuevaOperacion = true  // Marcamos que estamos listos para una nueva operación
        }
    }
    
    // Función para reiniciar la calculadora cuando se presiona el botón "C"
    @IBAction func limpiarPresionado(_ sender: UIButton) {
        txtResultado.text = "0"  // Reiniciamos el resultado a "0"
        numero1 = 0  // Reiniciamos el primer número
        numero2 = 0  // Reiniciamos el segundo número
        operacion = ""  // Borramos la operación actual
        operacionEnCurso = false  // Indicamos que no hay operación en curso
        nuevaOperacion = true  // Indicamos que estamos listos para una nueva operación
    }
    
    // Función para cambiar el signo de un número (+/-)
    @IBAction func cambiarSignoPresionado(_ sender: UIButton) {
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            txtResultado.text = String(valorActual * -1)  // Cambia el signo del número
        }
    }
    
    // Función para convertir el número a porcentaje (%)
    @IBAction func porcentajePresionado(_ sender: UIButton) {
        if let textoActual = txtResultado.text, let valorActual = Double(textoActual) {
            txtResultado.text = String(valorActual / 100)  // Convierte el número a porcentaje
        }
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
