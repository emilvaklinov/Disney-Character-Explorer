//
//  MockUserDefaults.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 22/03/2024.
//

import XCTest
@testable import Disney_Character_Explorer

final class MockUserDefaults: UserDefaults {
    var store = [String: Any]()

    override func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }

    override func array(forKey defaultName: String) -> [Any]? {
        store[defaultName] as? [Any]
    }
}
