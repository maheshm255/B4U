//
//  b4u-CateforyTblView.swift
//  bro4u
//
//  Created by Tools Team India on 28/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

protocol tableViewCustomDelegate: NSObjectProtocol {
    func didSelectRowAt(section:Int)
}


class b4u_CateforyTblView: UITableView ,categoryHeaderViewDelegate{
    
    var sectionOpen:Int = NSNotFound
    
    var customTblDelegate:tableViewCustomDelegate?

    // MARK: HeaderViewDelegate
    func headerViewOpen(section: Int) {
        
        if self.sectionOpen != NSNotFound {
            headerViewClose(self.sectionOpen)
        }
        
        self.sectionOpen = section

        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToInsert:[NSIndexPath] = []
        

        for var i = 0; i < numberOfRows; i++ {

            indexesPathToInsert.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        if indexesPathToInsert.count > 0 {
            self.beginUpdates()
            self.insertRowsAtIndexPaths(indexesPathToInsert, withRowAnimation: UITableViewRowAnimation.Automatic)
            self.endUpdates()
        }else
        {
            self.sectionOpen = NSNotFound

            customTblDelegate?.didSelectRowAt(section)
        }
        
        
    }
    
    func headerViewClose(section: Int) {
        
        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToDelete:[NSIndexPath] = []
        self.sectionOpen = NSNotFound
        
        for var i = 0 ; i < numberOfRows; i++ {
            indexesPathToDelete.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        if indexesPathToDelete.count > 0 {
            self.beginUpdates()
            self.deleteRowsAtIndexPaths(indexesPathToDelete, withRowAnimation: UITableViewRowAnimation.Top)
            self.endUpdates()
        }
        
    }
    
    
}
