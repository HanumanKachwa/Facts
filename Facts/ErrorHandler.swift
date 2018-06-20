//
//  ErrorHandler.swift
//  Facts
//
//  Created by Hanuman on 21/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation
enum ErrorCode: Int {
    case Generic = 0
    case InvalidOrNoData = -1
    
    func contextString () -> String {
        switch self {
        case .InvalidOrNoData:
            return NSLocalizedString("Unable to fetch country facts", comment: "Empty data")
        default:
            return NSLocalizedString("Unknown Error", comment: "Unknown error")
        }
    }
}

class GenericError: Error {
    fileprivate static let domain = "com.something.app.genericError"
    static func error(withErrorCode errorCode: ErrorCode) -> Error {
        return NSError(domain: GenericError.domain, code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey: errorCode.contextString()])
    }
}

class NetworkError: Error {
    fileprivate static let domain = "com.something.app.Error"
    static func error(withErrorCode errorCode: ErrorCode) -> Error {
        return NSError(domain: NetworkError.domain, code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey: errorCode.contextString()])
    }
}
