//
//  Errors.swift
//  Сhucknorris
//
//  Created by Kr Qqq on 06.11.2023.
//

import Foundation

enum NetworkError: Error {
    case error(String)
    case parseError
    case emptyData
}
