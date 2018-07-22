//
//  SummaryObject.swift
//  My garden
//
//  Created by Александр Филимонов on 22/07/2018.
//  Copyright © 2018 Alex Filimonov. All rights reserved.
//

import Foundation

struct SummaryObject: Decodable {
    let extract: String
    let originalimage: OriginalImage
}

struct OriginalImage: Decodable {
    let source: String
}
