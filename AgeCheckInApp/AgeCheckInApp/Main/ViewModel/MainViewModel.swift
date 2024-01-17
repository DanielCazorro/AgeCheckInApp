//
//  MainViewModel.swift
//  AgeCheckInApp
//
//  Created by Daniel Cazorro Frias  on 17/1/24.
//

import Foundation

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    
    func updateAge(with birthDate: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        let isMinor = (components.year ?? 0) < 18
        
        // Notificar al delegado sobre el cambio en el estado de la edad
        delegate?.didUpdateAgeStatus(isMinor: isMinor)
    }
    
    func isFormComplete(name: String, surName: String, school: String, observations: String, birthDate: Date) -> Bool {
        return !name.isEmpty && !surName.isEmpty && birthDateValid(birthDate) && (!isSchoolRequired(birthDate) || !school.isEmpty)
    }
    
    func birthDateValid(_ birthDate: Date) -> Bool {
        // Devuelve true si es válido, false si no
        return birthDate <= Date()
    }
    
    func isSchoolRequired(_ birthDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        let isMinorAge = (components.year ?? 0) < 18
        
        return isMinorAge
    }
}
