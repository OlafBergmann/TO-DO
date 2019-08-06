//
//  ToDoTableViewCell.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 05/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit

protocol TableViewCell {
    func clickedCell(index: Int)
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLbl: UILabel!
    
    var cellDelegate: TableViewCell?
    var index: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func doneBtnWasClicked(_ sender: Any) {
        cellDelegate?.clickedCell(index: index!.row)
        
        
    }


}
