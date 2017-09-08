//
//  ReviewsViewController.swift
//  ReviewMonitor
//
//  Created by Tayal, Rishabh on 9/7/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var reviews: [Review] = []
    var app: App!
    override func viewDidLoad() {
        super.viewDidLoad()

        getReviews()
    }

    func getReviews() {
        ServiceCaller.getReviews(app: app) { result, error in
            if let result = result as? [[String: Any]] {
                for reviewDict in result {
                    let review = Review(dict: reviewDict)
                    self.reviews.append(review)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = reviews[indexPath.row].title
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}