//
//  PhoneCode.swift
//  Concurrency
//
//  Created by Aerolab on 26/03/2024.
//

import Foundation

struct PhoneCode: Decodable, Identifiable {
    let id: String
    let flag: String
    let dial_code: String
}
