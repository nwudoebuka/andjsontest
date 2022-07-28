//
//  MainTableViewCell.swift
//  AndelaJsonTests
//
//  Created by WEMABANK on 28/07/2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var descriptionLabel: UILabel?
  @IBOutlet weak var amountLabel: UILabel?
  static let identifier = "MainTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configure(event: Event){
    titleLabel?.text = event.city
    descriptionLabel?.text = event.artist
    amountLabel?.text = "# \(String(event.price))"
  }

}
