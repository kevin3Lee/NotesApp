//
//  Note.swift
//  Notes
//
//  Created by Max Nelson on 3/16/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import Foundation

struct Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.title == rhs.title && lhs.date == rhs.date && lhs.text == rhs.text
    }
    var title:String!
    var date:Date!
    var text:String!
}

