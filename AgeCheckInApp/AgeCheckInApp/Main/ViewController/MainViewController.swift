//
//  MainViewController.swift
//  AgeCheckInApp
//
//  Created by Daniel Cazorro Frias  on 17/1/24.
//

import UIKit

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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - IBActions
    
    @IBAction func tapFinishButton(_ sender: Any) {
        
    }
    
    @IBAction func tapResetButton(_ sender: Any) {
    }
    
    
}
