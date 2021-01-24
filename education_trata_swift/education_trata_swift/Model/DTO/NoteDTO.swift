//
//  NoteDTO.swift
//  education_trata_swift
//
//  Created by 18577745 on 19.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation

class NoteDTO {
    var title: String?
    var sum: Double
    var date: Date
    var coordinateLatitude: Float?
    var coordinateLongitude: Float?
    
    var category: CategoryDTO?
    
    init(entity: Note) {
        self.title = entity.title
        self.sum = entity.sum
        self.date = entity.date ?? Date()
        self.coordinateLatitude = entity.coordinateLatitude
        self.coordinateLongitude = entity.coordinateLongitude
//        self.category = category
    }
}
