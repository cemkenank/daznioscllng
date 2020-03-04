//
//  NewsViewModel.swift
//  DAZN Challange
//
//  Created by MrDark on 1.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import SWXMLHash

class NewsViewModel  {

    func fetchNewsData(completion: @escaping ([Item]) -> Void)
    {
        let url = URL(string: Constants.newsURL)!

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard let data = data else { print("NEWS DATA ERROR : \(String(describing: error?.localizedDescription))"); return }

            let xml = SWXMLHash.parse(data)
            do {
                let items: [Item] = try xml["rss"]["channel"]["item"].value()
                completion(items)
            }
            catch(let error)
            {
                print("ERROR : \(error)")
            }

        }).resume()

    }

    func newsDropDownButton(selector:Selector) -> UIButton
    {
        let newsDropDownButton = UIButton(type: .system)
        newsDropDownButton.setTitle("News", for: .normal)
        newsDropDownButton.setTitleColor(.black, for: .normal)
        newsDropDownButton.addTarget(newsDropDownButton.self, action: selector, for: .touchUpInside)

        return newsDropDownButton

    }
}
