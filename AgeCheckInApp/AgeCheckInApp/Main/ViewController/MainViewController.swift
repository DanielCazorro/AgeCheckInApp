//
//  MainViewController.swift
//  AgeCheckInApp
//
//  Created by Daniel Cazorro Frias  on 17/1/24.
//

import UIKit

// MARK: - Protocol

protocol MainViewModelDelegate: AnyObject {
    func didUpdateAgeStatus(isMinor: Bool)
}

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameSurnameSV: UIStackView!
    @IBOutlet weak var schoolObservationsSV: UIStackView!
    @IBOutlet weak var finishResetButtonsSV: UIStackView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var observationsTextField: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // viewModel
    var viewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asociar el ViewController como delegado del ViewModel
        viewModel.delegate = self
        
        // Configurar la visibilidad inicial del campo del colegio
        schoolTextField.isHidden = true
        
        // Asociar el UIDatePicker a la acción datePickerValueChanged
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Asignar el delegado del UITextField
        nameTextField.delegate = self
        surNameTextField.delegate = self
        schoolTextField.delegate = self
        observationsTextField.delegate = self
        
        // Agregar gesto para ocultar el teclado al tocar en cualquier parte de la pantalla
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - IBActions
    
    @IBAction func tapFinishButton(_ sender: Any) {
        
    }
    
    @IBAction func tapResetButton(_ sender: Any) {
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Actualizar el ViewModel con la nueva fecha seleccionada
        viewModel.actualizarEdadConFecha(sender.date)
    }
    
    @objc func dismissKeyboard() {
            // Ocultar el teclado al tocar en cualquier parte de la pantalla
            view.endEditing(true)
        }
}

// MARK: -Extension
// Conformar el ViewController al protocolo para recibir actualizaciones del ViewModel
extension MainViewController: MainViewModelDelegate {
    func didUpdateAgeStatus(isMinor: Bool) {
        // Actualizar la visibilidad del campo del colegio
        schoolTextField.isHidden = !isMinor
    }
}

// Conformar el ViewController al protocolo UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Mover al siguiente campo cuando se presiona "Enter"
        switch textField {
        case nameTextField:
            surNameTextField.becomeFirstResponder()
        case surNameTextField:
            if schoolTextField.isHidden != true {
                schoolTextField.becomeFirstResponder()
            } else {
                observationsTextField.becomeFirstResponder()
            }
        case schoolTextField:
            observationsTextField.becomeFirstResponder()
        case observationsTextField:
            observationsTextField.resignFirstResponder() // Para ocultar el teclado después de escribir en Observaciones
        default:
            textField.resignFirstResponder()
        }

        return true
    }
}
