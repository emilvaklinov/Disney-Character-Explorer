//
//  NetworkError.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case httpError
    case decodingError
}
