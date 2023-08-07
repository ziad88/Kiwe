//
//  RequestConfiguration.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//


import Foundation
import Alamofire

public struct RequestConfiguration {

    // MARK: - Properties
    let path: String
    let method: HTTPMethod
    let headers: String?
    let parameters: Parameters?
    let encoding: ParameterEncoding

    // MARK: - Methods
    internal init(method: HTTPMethod = .get,
                  path: String,
                  headers: String? = nil,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
