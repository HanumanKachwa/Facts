//
//  ViewModal.swift
//  Facts
//
//  Created by Hanuman on 21/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation
import UIKit

class FactItem {
    let title: String?
    let description: String?
    let imageHref: String?
    var size: CGSize?
    
    init(title: String?, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}

class ViewManager {
    var countryFacts: CountryFacts?
    var factItems = [FactItem]()
    
    func fetchFacts(completionHandler: @escaping (_ error: Error?) -> Void) {
        factItems.removeAll()
        CountryFactsAPI.getFacts { (facts, error) in
            self.countryFacts = facts
            for fact in self.countryFacts?.facts ?? [] {
                let factItem = FactItem(title: fact.title, description: fact.description, imageHref: fact.imageHref)
                self.factItems.append(factItem)
            }
            completionHandler(error)            
        }
    }
    
    func getCountryTitle() -> String {
        return countryFacts?.title ?? ""
    }
    
    func getFactItem(representedByRowNumber: Int) -> FactItem? {
        guard let facts = countryFacts?.facts, representedByRowNumber < facts.count else {
            return nil
        }
        return factItems[representedByRowNumber]
    }
    
    func factsCount() -> Int {
        return countryFacts?.facts?.count ?? 0
    }

}
