//
//  MainViewModel.swift
//  AgeCheckInApp
//
//  Created by Daniel Cazorro Frias  on 17/1/24.
//

import Foundation

class MainViewModel {

    weak var delegate: MainViewModelDelegate?

    func actualizarEdadConFecha(_ fechaNacimiento: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: fechaNacimiento, to: Date())
        let esMenor = (components.year ?? 0) < 18

        // Notificar al delegado sobre el cambio en el estado de la edad
        delegate?.didUpdateAgeStatus(isMinor: esMenor)
    }
}
