//
//  Initializer.swift
//  Eject
//
//  Created by Brian King on 10/19/16.
//  Copyright © 2016 Brian King. All rights reserved.
//

import Foundation

struct Initializer: CodeGenerator {
    let objectIdentifier: String
    let className: String
    let injectedProperties: [String]

    func generateCode(in document: XIBDocument) throws -> String {
        let object = try document.lookupReference(for: objectIdentifier)
        let variable = document.variable(for: object)
        let arguments = try injectedProperties.map() { (property: String) -> String? in
            if let generator = object.values[property] {
                return "\(property): \(try generator.generateCode(in: document))"
            }
            return nil
        }.flatMap() { $0 }

        return "let \(variable) = \(className)(\(arguments.joined(separator: ", ")))"
    }
}
