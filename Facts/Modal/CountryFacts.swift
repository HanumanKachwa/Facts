//
//  CountryFacts.swift
//  Facts
//
//  Created by Hanuman on 20/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation

struct CountryFacts : Codable {
	let title : String?
	let facts : [Fact]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case facts = "rows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		facts = try values.decodeIfPresent([Fact].self, forKey: .facts)
	}

}
