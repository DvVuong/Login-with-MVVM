//
//  TableViewCell.swift
//  LoginMVVM
//
//  Created by admin on 12/10/2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didTapCell()
}

class TableViewCell: UITableViewCell {

    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
