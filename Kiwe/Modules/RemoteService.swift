//
//  RemoteService.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//

import Foundation
import Alamofire


public protocol RemoteService: URLRequestConvertible {
    var requestConfiguration: RequestConfiguration { get }
}

extension RemoteService {
    public func asURLRequest() throws -> URLRequest {
        let url = try ("https://").asURL()
            .appendingPathComponent(requestConfiguration.path)
            .asURL()
        var request = URLRequest(url: url)
        request.httpMethod = requestConfiguration.method.rawValue
        if let parameters = requestConfiguration.parameters {
            request = try requestConfiguration.encoding.encode(request, with: parameters)
        }
        return request
    }
}


public enum PaymentService {
    case getForeSquareData(Void)
}

extension PaymentService: RemoteService {
    public var requestConfiguration: RequestConfiguration {
        switch self {
        case .getForeSquareData():
            return RequestConfiguration(
                method: .get,
                path: "api.foursquare.com/v3/places/nearby",
                headers: "accept: application/json",
                encoding: JSONEncoding.default)
        }
    }
}
    

