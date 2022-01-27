//
//  JsonModel.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 26/01/2022.
//

import Foundation

struct JsonModel: Codable {
    var id: Int?
    var color1: String?
    var color2: String?
    var name1: String?
    var name2: String?
    
    enum CodingKeys:String,CodingKey {
        case id
        case color1
        case color2
        case name1
        case name2
    }
}
