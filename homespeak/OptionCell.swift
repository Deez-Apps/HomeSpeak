//
//  OptionCell.swift
//  homespeak
//
//  Created by Eugene Yurtaev on 07/08/15.
//  Copyright (c) 2015 Deez Apps. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    var changed = false
    @IBAction func changeImage(sender: AnyObject) {
        if(changed == false){
            if(optionImageView.image == UIImage(named: "Health")){
                optionImageView.image = UIImage(named: "Health-Tinted")
            } else if(optionImageView.image == UIImage(named: "Music")){
                optionImageView.image = UIImage(named: "Music-Tinted")
            } else if(optionImageView.image == UIImage(named: "Stock")){
                optionImageView.image = UIImage(named: "Stock-Tinted")
            } else if(optionImageView.image == UIImage(named: "Calendar")){
                optionImageView.image = UIImage(named: "Calendar-Tinted")
            }
        }
        else {
            if(optionImageView.image == UIImage(named: "Health-Tinted")){
                optionImageView.image = UIImage(named: "Health")
            }else if(optionImageView.image == UIImage(named: "Music-Tinted")){
                optionImageView.image = UIImage(named: "Music")
            } else if(optionImageView.image == UIImage(named: "Stock-Tinted")){
                optionImageView.image = UIImage(named: "Stock")
            } else if(optionImageView.image == UIImage(named: "Calendar-Tinted")){
                optionImageView.image = UIImage(named: "Calendar")
            }

        }
        changed = !changed
        
    }
    
    @IBOutlet var cellButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
