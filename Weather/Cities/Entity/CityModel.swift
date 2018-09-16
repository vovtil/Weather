//
//  CityModel.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import RealmSwift
import Realm

/// Модель города
final class CityModel: Object, Decodable {
    
    @objc dynamic var cityId: Int = 0 /// Ид города
    @objc dynamic var name: String = "" /// Название
    @objc dynamic var searchName: String = "" /// Название для поиска
    @objc dynamic var country: String = "" /// Код страны

    override static func primaryKey() -> String? {
        return "cityId"
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
    }
    
    convenience init(cityId: Int, name: String, country: String) {
        self.init()
        self.cityId = cityId
        self.country = country
        self.searchName = name.lowercased()
        self.name = name
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cityId = try container.decode(Int.self, forKey: .id)
        let country = try container.decode(String.self, forKey: .country)
        let name = try container.decode(String.self, forKey: .name)
        self.init(cityId: cityId, name: name, country: country)
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
