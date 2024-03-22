//
//  Truncation+String.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import SwiftUI

extension String {
    func truncated(maxLength: Int) -> String {
        if self.count > maxLength {
            let index = self.index(self.startIndex, offsetBy: maxLength)
            return String(self[..<index]) + ".."
        } else {
            return self
        }
    }
}

