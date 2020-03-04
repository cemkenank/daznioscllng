//
//  ScoresViewModel.swift
//  DAZN Challange
//
//  Created by MrDark on 1.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import SWXMLHash

class ScoresViewModel  {

    func fetchScoresData(completion: @escaping ([Match]) -> Void)
    {
        let url = URL(string: Constants.scoresURL)!

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard let data = data else { print("FETCH DATA ERROR : \(String(describing: error?.localizedDescription))"); return }

            let xml = SWXMLHash.parse(data)
            var group: [Match] = []

            let groupElement = xml["gsmrs"]["competition"]["season"]["round"]["group"]
            for groupes in groupElement.all
            {
                for matches in groupes["match"].all
                {

                    group.append(Match(date: matches.element!.attribute(by: "date_utc")!.text, teamAName:matches.element!.attribute(by: "team_A_name")!.text , teamBName:matches.element!.attribute(by: "team_B_name")!.text , fsATeam:matches.element!.attribute(by: "fs_A")!.text , fsBTeam: matches.element!.attribute(by: "fs_B")!.text))

                }

            }
            completion(group)

        }).resume()

    }
}

