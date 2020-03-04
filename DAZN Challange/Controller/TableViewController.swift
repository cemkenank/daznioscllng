//
//  TableViewController.swift
//  DAZN Challange
//
//  Created by MrDark on 4.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit
import DropDownTableView
import Kingfisher
import Foundation
import PKHUD

class TableViewController: DropDownTableViewController {

    private let newsViewModel = NewsViewModel()
    private var newsItems = [Item]()
    private let scoresViewModel = ScoresViewModel()
    private var scoreItems = [Match]()
    private let newsSubRowHeight: CGFloat = 156.0
    private let scoresSubRowHeight: CGFloat = 70.0
    private let cellHeight: CGFloat = 70.0
    private let headerHeight: CGFloat = 70.0
    private var theMainMenuButton: UIButton = UIButton.getDropdownButton(title: "The Main Menu")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // - MARK: Configure TableView

        configureTableView()

        // - MARK: Fetch News And Scores Data

        newsViewModel.fetchNewsData { (items) in
            self.newsItems = items
        }
        scoresViewModel.fetchScoresData { (matches) in
            self.scoreItems = matches
        }

        // - MARK: Refresh Data with Timer

        let refreshTimer = Timer(timeInterval: 30.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        RunLoop.main.add(refreshTimer, forMode: .default)


    }

    // - MARK: Refreshing Scores Data in 30 seconds

    @objc private func refresh()
    {
        HUD.show(.progress)
        self.scoreItems.removeAll()
        scoresViewModel.fetchScoresData { (matches) in
            self.scoreItems = matches

            DispatchQueue.main.async {
                self.tableView.reloadData()
                HUD.hide()
            }
        }

    }

     @objc private func dropDownTheMainMenuAction()
     {
        UIView.animate(withDuration: 0.5) {

                  if !self.theMainMenuButton.isSelected {
                      self.theMainMenuButton.isSelected = true
                    self.tableView.rowHeight = 0.0
                    self.tableView.reloadData()

                  } else {

                    self.theMainMenuButton.isSelected = false
                    self.tableView.rowHeight = 50.0
                    self.tableView.reloadData()


                  }

                  self.view.layoutIfNeeded()
              }
    }
    private func configureTableView()
    {
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsitemcell")
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "scorescell")

        tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func numberOfRows(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        if row == 0
        {
            return self.newsItems.count
        } else if row == 1
        {
            return self.scoreItems.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        self.theMainMenuButton.addTarget(self, action: #selector(dropDownTheMainMenuAction), for: .touchUpInside)
        return self.theMainMenuButton
    }

    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "buttonscell", for: indexPath)

        // - MARK: Sub Menu Items

        if row == 0 {

            cell.textLabel?.text = "News"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        } else if row == 1 {

            cell.textLabel?.text = "Scores"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        } else
        {
            cell.textLabel?.text = "Standings"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        }

        // - MARK: Selected Cell Changing Arrow

        if row == self.nsk_selectedRow {
            cell.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
        } else {
            cell.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        if row == 0
        {
            return newsSubRowHeight
        } else
        {
            return scoresSubRowHeight
        }

    }

    override func tableView(_ tableView: UITableView, heightForRow row: Int) -> CGFloat {
        if row == 0 && self.theMainMenuButton.isSelected
        {
            return 0.0
        } else if row == 1 && self.theMainMenuButton.isSelected {
            return 0.0
        } else if row == 2 && self.theMainMenuButton.isSelected
        {
            return 0.0
        }
        return cellHeight

    }
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {

        if row == 0
        {
             // - MARK: Binding News Data

             let cell = tableView.dequeueReusableCell(withIdentifier: "newsitemcell", for: indexPath) as? NewsTableViewCell
            let items = newsItems[subrow]

            cell?.newsTitleLabel.text = items.title
            cell?.newsPubDateLabel.text = items.pubDate
            cell?.newsDescriptionLabel.text = items.description
            let url = URL(string:items.enclosure[row].url)

            cell?.imageView?.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(ImageTransition.fade(1))],
                                          progressBlock: { receivedSize, totalSize in

              },
                                          completionHandler: { image, error, cacheType, imageURL in
                                              cell?.imageView?.image = self.resizeImage(image: image!, newWidth: 120.0)

              })

            return cell!
        } else if row == 1
        {
            // - MARK: Binding Scores Data

            let cell = tableView.dequeueReusableCell(withIdentifier: "scorescell", for: indexPath) as? ScoreTableViewCell
            let scores = self.scoreItems[subrow]
            cell?.teamALabel.text = scores.teamAName
            cell?.teamBLabel.text = scores.teamBName
            cell?.teamAPointLabel.text = scores.fsATeam
            cell?.teamBPointLabel.text = scores.fsBTeam
            
            if subrow % 2 == 0
            {
                cell?.backgroundColor = .lightGray
            } else
            {
                cell?.backgroundColor = .white
            }

            return cell!

        } else
        {
            let cell = UITableViewCell()
            return cell
        }

    }
    override func tableView(_ tableView: UITableView, didSelectRow row: Int) {
        switch (self.nsk_selectedRow, row) {
            case (let sr?, _) where row == sr:
                tableView.cellForRow(at: row)?.accessoryView =  UIImageView(image: UIImage(named: "down_arrow"))
                tableView.deselect(row: row, animated: true)
            break
            case (let sr?, _) where row != sr:
                tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
                tableView.cellForRow(at: sr)?.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
            break
            case (nil, _):
                tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            break
            default:
            break
        }
        super.tableView(tableView, didSelectRow: row)


    }

    override func tableView(_ tableView: UITableView, didSelectSubrow subrow: Int, inRow row: Int) {

        //  - MARK: Open News Detail

        if row == 0
               {
                   let detailViewController = storyboard?.instantiateViewController(identifier: "detailViewController") as? DetailViewController
                   detailViewController?.detailLink = self.newsItems[subrow].link
                   self.navigationController?.pushViewController(detailViewController!, animated: true)
               }
    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }


}

