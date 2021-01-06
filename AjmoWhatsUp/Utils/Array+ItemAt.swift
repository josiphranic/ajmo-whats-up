//
//  Array+ItemAt.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import Foundation

extension Array {

    func item(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }

        return self[index]
    }
}
