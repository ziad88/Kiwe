//
//  WithConfigurable.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//

import Foundation

public protocol WithConfigurable {}
public extension WithConfigurable where Self: AnyObject {
    @discardableResult
    func with(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: WithConfigurable {}
