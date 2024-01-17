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
        let name = nameTextField.text ?? ""
        let surName = surNameTextField.text ?? ""
        let school = schoolTextField.text ?? ""
        let observations = observationsTextField.text ?? ""
        
        if viewModel.isFormComplete(name: name, surName: surName, school: school, observations: observations, birthDate: datePicker.date) {
            showAlertFormComplete()
        } else {
            showAlertFormNotComplete()
        }
    }
    
    @IBAction func tapResetButton(_ sender: Any) {
        nameTextField.text = ""
        surNameTextField.text = ""
        schoolTextField.text = ""
        observationsTextField.text = ""
        datePicker.date = Date()
        
        showResetAlert()
    }
    
    // MARK: -Functions
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        viewModel.updateAge(with: sender.date)
        
        // Pasa la fecha a las funciones del ViewModel
        let birthDate = sender.date
        _ = viewModel.birthDateValid(birthDate)
        let isSchoolRequired = viewModel.isSchoolRequired(birthDate)
        
        // Actualiza la visibilidad del campo del colegio según esColegioObligatorio
        schoolTextField.isHidden = !isSchoolRequired
    }
    
    @objc func dismissKeyboard() {
        // Ocultar el teclado al tocar en cualquier parte de la pantalla
        view.endEditing(true)
    }
    
    private func showResetAlert() {
        let alert = UIAlertController(title: "Formulario reiniciado", message: "Complete el formulario", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertFormComplete() {
        let alert = UIAlertController(title: "Formulario Completado", message: "¡Gracias por completar el formulario!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertFormNotComplete() {
        let alert = UIAlertController(title: "Formulario Incompleto", message: "Por favor, rellene todos los campos", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
