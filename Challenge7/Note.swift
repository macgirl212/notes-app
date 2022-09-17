//
//  Note.swift
//  Challenge7
//
//  Created by Melody Davis on 9/17/22.
//

import Foundation

class Note: NSObject, Codable {
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
