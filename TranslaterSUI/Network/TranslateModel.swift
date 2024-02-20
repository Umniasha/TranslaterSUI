//
//  TranslateModel.swift
//  TranslaterSUI
//
//  Created by Oleg Arnaut  on 09.02.2024.
//

import Foundation
// MARK: - Language
struct Language : Decodable {
    let code, language: String
}


struct TranslateText : Decodable {
    let trans : String
}

