//
//  b4u-ExpandableTableView.swift
//  bro4u
//
//  Created by Tools Team India on 22/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_ExpandableTableView: UITableView ,ExpandableTblHeaderViewDelegate {

    var sectionOpen:Int = NSNotFound
    
    // MARK: HeaderViewDelegate
    func headerViewOpen(section: Int) {
        
        if self.sectionOpen != NSNotFound {
            headerViewClose(self.sectionOpen)
        }
        
        self.sectionOpen = section
        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToInsert:[NSIndexPath] = []
        
        for var i = 0; i < numberOfRows; i += 1 {
            indexesPathToInsert.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        if indexesPathToInsert.count > 0 {
            self.beginUpdates()
            self.insertRowsAtIndexPaths(indexesPathToInsert, withRowAnimation: UITableViewRowAnimation.Automatic)
            self.endUpdates()
        }
    }
    
    func headerViewClose(section: Int) {
        
        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToDelete:[NSIndexPath] = []
        self.sectionOpen = NSNotFound
        
        for var i = 0 ; i < numberOfRows; i += 1 {
            indexesPathToDelete.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        if indexesPathToDelete.count > 0 {
            self.beginUpdates()
            self.deleteRowsAtIndexPaths(indexesPathToDelete, withRowAnimation: UITableViewRowAnimation.Top)
            self.endUpdates()
        }
    }
    

}
