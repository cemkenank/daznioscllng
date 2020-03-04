//
//  Match.swift
//  DAZN Challange
//
//  Created by MrDark on 1.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import SWXMLHash

struct Match: XMLIndexerDeserializable {
    let date:String
    let teamAName: String
    let teamBName: String
    let fsATeam: String
    let fsBTeam: String


    static func deserialize(_ node: XMLIndexer) throws -> Match {
        return try Match(
            date: node["date_utc"].value(),
            teamAName: node["team_A_name"].value(),
            teamBName: node["team_B_name"].value(),
            fsATeam: node["fs_A"].value(),
            fsBTeam : node["fs_B"].value()
        )
    }
}


