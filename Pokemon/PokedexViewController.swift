//
//  PokedexViewController.swift
//  Pokemon
//
//  Created by Cliff Tanaka on 2017/03/28.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
