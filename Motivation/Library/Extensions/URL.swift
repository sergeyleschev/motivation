//
//  URL.swift
//  Motivation
//
//  Created by Sergey Leschev on 16.08.21.
//  Copyright © 2021 Sergey Leschev. All rights reserved.
//

import Foundation
import CommonCrypto


typealias URLParameters = [AnyHashable : Any]


extension URL {
    subscript(queryKey: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryKey })?.value
    }
    
    
    func with(parameters: URLParameters?) -> URL {
        guard let validParameters = parameters else { return self }
        guard var components = URLComponents(string: self.absoluteString) else { return self }
        
        components.queryItems = []
        
        for parameter in validParameters {
            let name = "\(parameter.key)"
            let value = "\(parameter.value)"
            let item = URLQueryItem(name: name, value: value)
            
            components.queryItems?.append(item)
        }
        
        return components.url ?? self
    }
    
    
    var hash: String? {
        do {
            let bufferSize = 1024 * 1024
            let file = try FileHandle(forReadingFrom: self)
            
            var digest = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
            var context = CC_SHA256_CTX()

            defer { file.closeFile() }
            CC_SHA256_Init(&context)

            while autoreleasepool(invoking: {
                let data = file.readData(ofLength: bufferSize)
                
                if data.count > 0 {
                    data.withUnsafeBytes {
                        _ = CC_SHA256_Update(&context, $0, numericCast(data.count))
                    }
                    
                    return true
                } else {
                    return false
                }
            }) {}

            digest.withUnsafeMutableBytes {
                _ = CC_SHA256_Final($0, &context)
            }

            return digest.map { String(format: "%02hhx", $0) }.joined()
        } catch { return nil }
    }
}


func / (left: URL, right: String) -> URL {
    return left.appendingPathComponent(right)
}
