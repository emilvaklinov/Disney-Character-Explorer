//
//  Endpoint.swift
//  Disney Character Explorer
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import Foundation

struct Endpoint {
    let path: String
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.disneyapi.dev"
        components.path = "/\(path)"
        return components.url
    }
}
