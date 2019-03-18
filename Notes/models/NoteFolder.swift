//
//  NoteFolder.swift
//  Notes
//
//  Created by Max Nelson on 3/16/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import Foundation

struct NoteFolder: Equatable {
    static func == (lhs: NoteFolder, rhs: NoteFolder) -> Bool {
        return lhs.title == rhs.title && lhs.notes == rhs.notes
    }
    
    var title:String
    var notes:[Note]
}

