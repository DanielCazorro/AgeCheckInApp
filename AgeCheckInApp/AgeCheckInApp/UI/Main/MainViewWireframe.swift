//
//  MainViewWireframe.swift
//  AgeCheckInApp
//
//  Created by Daniel Cazorro Frias  on 8/2/24.
//

import Foundation

class MainViewWireframe {
    
    // MARK: - Properties
    // Esta propiedad calculada proporciona una instancia de MainViewController cuando se accede a ella.
    var viewController: MainViewController {
        // Generando los componentes del módulo
        
        // Creamos una instancia de MainViewController
        let viewController = MainViewController()
        
        // Creamos una instancia de MainViewModel utilizando el método privado createViewModel(with:)
        let viewModel: MainViewModel = createViewModel()
        
        // Configuramos el viewModel creado en el viewController
        viewController.set(viewModel: viewModel)
        
        // Devolvemos el viewController configurado
        return viewController
    }
    
    // MARK: - Private methods
    
    // Este método privado crea una instancia de MainViewModel con un MainViewDataManager proporcionado como argumento.
    private func createViewModel() -> MainViewModel {
        return MainViewModel()
    }

}
