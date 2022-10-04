//
//  MovieModel.swift
//  NetworkPlayground
//
//  Created by Jose Castillo on 10/4/22.
//

import Foundation

struct Root : Decodable {
    var results: [Movie]
}

struct Movie: Identifiable, Decodable {
    var id : Int
    var original_title : String
    var overview : String
    var poster_path : String
}
