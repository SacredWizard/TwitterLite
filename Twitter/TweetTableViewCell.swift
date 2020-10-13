//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Rakesh R on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetID:Int = -1
    
    func setFavorited(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error Retweeting! \(error)")
        })
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(true)
            }, failure: { (error) in
                print("Favorited did not succeed! \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("Unfavoriting did not work! \(error)")
            })
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
