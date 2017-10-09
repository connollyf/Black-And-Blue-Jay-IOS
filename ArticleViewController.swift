//
//  ArticleViewController.swift
//  The Black And Blue Jay
//
//  Created by joseph Connolly on 7/20/17.
//  Copyright © 2017 joseph Connolly. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    var article: Article! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = article.title
        titleTextLabel.text = article.title
        
        if let imageFromArticleObject = article.image {
            articleImage.image = imageFromArticleObject
        } else {
            let queue = DispatchQueue(label: "imageLoaderAVC", qos: .userInitiated)
            queue.async {
                do {
                    let image = try UIImage(data: Data(contentsOf: self.article.safeImageUrl))
                        DispatchQueue.main.async {
                            self.articleImage.image = image
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        let articleContentData = article.content.data(using: .unicode, allowLossyConversion: true) //convert to data to format to HTML
        do {
            let formattedArticleContent = try NSAttributedString(data: articleContentData!,
                                                         options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                         documentAttributes: nil)
            articleTextLabel.attributedText = formattedArticleContent
        } catch {
            print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
       let avc = UIActivityViewController(activityItems: [article.title, article.articleUrl],
                                          applicationActivities: nil)
        navigationController?.present(avc, animated: true, completion: nil)
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
