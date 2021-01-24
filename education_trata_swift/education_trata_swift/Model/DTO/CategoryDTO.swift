//
//  CategoryDTO.swift
//  education_trata_swift
//
//  Created by 18577745 on 19.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import CoreData

class CategoryDTO {
    var iconName: String
    var name: String
    var childes: [CategoryDTO]?
    var parent: CategoryDTO?
    var objectID: NSManagedObjectID

    func createChildesDTOArray(entity: Category) {
        for element in entity.childes! {
            let child = element as! Category
            let childDTO = CategoryDTO(entity: child)
            self.childes?.append(childDTO) ?? (self.childes = [childDTO])
        }
    }
    
    init(entity: Category) {
        self.iconName = entity.iconName ?? ""
        self.name = entity.name ?? ""
        self.objectID = entity.objectID
        
        if entity.childes != nil {
            createChildesDTOArray(entity: entity)
        }
    }
}
