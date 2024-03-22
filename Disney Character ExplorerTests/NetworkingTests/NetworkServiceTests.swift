//
//  MockURLSession.swift
//  Disney Character ExplorerTests
//
//  Created by Emil Vaklinov on 21/03/2024.
//

import Foundation
@testable import Disney_Character_Explorer
//
//class MockURLSession: URLSession {
//    var mockData: Data?
//    var mockResponse: URLResponse?
//    var mockError: Error?
//
//    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return MockURLSessionDataTask {
//            completionHandler(self.mockData, self.mockResponse, self.mockError)
//        }
//    }
//}
//
//class MockURLSessionDataTask: URLSessionDataTask {
//    private let closure: () -> Void
//
//    init(closure: @escaping () -> Void) {
//        self.closure = closure
//    }
//
//    override func resume() {
//        closure()
//    }
//}
