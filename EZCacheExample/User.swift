//
//  User.swift
//  Cache
//
//  Created by Michael Green on 27/12/2019.
//  Copyright © 2019 Michael Green. All rights reserved.
//

import Foundation
import EZCache

struct User {
  let id: Int
  let name: String
  let username: String
  let email: String
}

extension User: Codable { }

extension User: Cacheable { }
