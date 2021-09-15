//
//  DetailViewController.swift
//  MVP
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var commentLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }
}
