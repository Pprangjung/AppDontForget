//
//  TasknoteCollectionViewController.swift
//  AppDontForget
//
//  Created by Prang on 12/18/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
class TasknoteCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ดึงตัว task ออกมาโชว์
        Datasevice.datasevice.fetchDataFromServer{(task) in
            self.tasks.append(task)
           let indexPath = IndexPath(item: self.tasks.count - 1, section: 0)
            self.collectionView?.insertItems(at:[indexPath])
        
        }
        
    }
    
    // MARK: UICollectionViewDataSource

     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.tasks.count
    }


    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCollectionViewCell
        let task = tasks[indexPath.row]
        // Configure the cell
        cell.configureCell(task)
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 5, height: view.frame.size.width / 5)
    }


}

