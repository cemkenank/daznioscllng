//
//  Item.swift
//  DAZN Challange
//
//  Created by MrDark on 1.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import SWXMLHash

struct Item: XMLIndexerDeserializable {
    let guid: Int
    let title: String
    let pubDate: String
    let enclosure: [Enclosure]
    let description: String
    let link: String
    let category: String

    static func deserialize(_ node: XMLIndexer) throws -> Item {
        return try Item(
            guid: node["guid"].value(),
            title: node["title"].value(),
            pubDate: node["pubDate"].value(),
            enclosure : node["enclosure"].value(),
            description: node["description"].value(),
            link: node["link"].value(),
            category : node["category"].value()
        )
    }
}

struct Enclosure: XMLElementDeserializable {

    let url:String
    let type:String
    let length:String


    static func deserialize(_ element: XMLElement) throws -> Enclosure {
        return Enclosure(url: element.attribute(by: "url")!.text,
                         type: element.attribute(by: "type")!.text,
                         length: element.attribute(by: "length")!.text)
    }
}
