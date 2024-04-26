//
//  Habit.swift
//  AquaMove
//
//  Created by Frida Dahlqvist on 2024-04-25.
//

import Foundation
import FirebaseFirestoreSwift

class Habit : Identifiable, Codable {
    
    @DocumentID var id: String?
    
    var name : String
    var description : String
    
    enum CodingKeys: String, CodingKey {
            case name, description
       }
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
       
    }
  
        
   required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
       self.description = try container.decode(String.self, forKey: .description)
     
    }
}
    
