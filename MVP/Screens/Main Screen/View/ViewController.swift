//
//  ViewController.swift
//  MVP
//
//  Created by Илья Москалев on 15.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

//MARK: Extension
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = presenter.comments?[indexPath.row]
        
        cell.textLabel?.text = comment?.body
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        let detailViewController = ModelBuilder.createDetailModule(comment: comment)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let ac = UIAlertController(title: "Error", message: "Error - \(error.localizedDescription)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.presenter.getComments()
        }))
        present(ac,animated: true)
    }
}
