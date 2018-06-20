//
//  Fact.swift
//  Facts
//
//  Created by Hanuman on 20/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation
struct Fact : Codable {
	let title : String?
	let imageHref : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case imageHref = "imageHref"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
