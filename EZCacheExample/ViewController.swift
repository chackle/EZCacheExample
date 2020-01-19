//
//  ViewController.swift
//  Cache
//
//  Created by Michael Green on 21/12/2019.
//  Copyright © 2019 Michael Green. All rights reserved.
//

import UIKit
import EZCache

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!

  private let imageURL = URL(string: "http://www2.pictures.zimbio.com/pc/Andrew+Garfield+Social+Network+Photocall+s3SmS9GOG9Zl.jpg")!
  private let imageFetcher = DataFetcher<CacheableImage>()
  
  private let userURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
  private let userFetcher = DataFetcher<[User]>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.startFetchingData()
  }
  
  @IBAction func startFetchingData() {
    // Testing Image Caching
    self.imageFetcher.fetch(from: self.imageURL) { (result) in
      switch result {
      case .success(let image):
        self.imageView.image = image.rawValue
      case .failure(let error):
        print("ImageFetcher Error: \(error)")
      }
    }
    // Testing User Caching
    self.userFetcher.fetch(from: self.userURL) { (result) in
      switch result {
        case .success(_):
          self.tableView.reloadData()
        case .failure(let error):
          print("UserFetcher Error: \(error)")
      }
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.userFetcher[self.userURL]?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let users = self.userFetcher[self.userURL], users.count > indexPath.row else { return UITableViewCell() }
    let user = users[indexPath.row]
    let cell = UITableViewCell()
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.username
    return cell
  }
}

