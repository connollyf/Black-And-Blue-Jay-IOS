//
//  LoadViewController.swift
//  The Black And Blue Jay
//
//  Created by joseph Connolly on 7/18/17.
//  Copyright © 2017 joseph Connolly. All rights reserved.
//

import UIKit

class ArticleLoader: NSObject, XMLParserDelegate {
    
    
    public var articles = [Article]()
    public var delegate: ArticleLoaderDelegate?
    
    private var currentArticle = Article()
    private var currentElement = String()
    private var innerText = ""
    private let dateFormatter = DateFormatter()
    private let blackAndBlueJayLogo = "https://2.gravatar.com/avatar/e379b864dae13019d62d940165bdb59a?s=96&#38;d=identicon&#38;r=G"
    
    private let start = CACurrentMediaTime()
    
    // Do any additional setup after loading the view.
    
    func startLoading() {
        dateFormatter.dateFormat = "E, dd LLL yyyy HH:mm:ss "
        setupXML()
    }
    
    
    private func setupXML() {
        let queue = DispatchQueue(label: "xmlLoader", qos: .userInitiated)
        queue.async {
            let parser = XMLParser(contentsOf: URL(string: "https:/theblackandbluejay.com/feed/")!)
            parser?.delegate = self
            parser?.parse()
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch (elementName) {
        case "item":
            currentArticle = Article()
        case "title", "description", "content:encoded", "pubDate", "link":
            currentElement = elementName
            innerText = ""
        case "media:thumbnail":
            if let urlString = attributeDict["url"] {
                currentArticle.imageUrl = URL(string: urlString)
            }
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        innerText += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch (elementName) {
        case "item":
            articles.append(currentArticle)
            delegate?.didAddArticle(at: articles.count - 1)
        case "title":
            currentArticle.title = innerText
        case "description":
            currentArticle.articleDescription = innerText
        case "content:encoded":
            currentArticle.content = innerText
        case "pubDate":
            currentArticle.datePublished = dateFormatter.date(from: truncateAtPlus(innerText))
        case "link":
            if let articleUrlFromXML = URL(string: innerText) {
                currentArticle.articleUrl = articleUrlFromXML
            }
        default:
            break
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Done loading articles")
        let end = CACurrentMediaTime()
        print("Time: \(end - start)")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    private func truncateAtPlus(_ string: String) -> String {
        let cutoff = string.range(of: "+")?.lowerBound
        return string.substring(to: cutoff!)
    }
    
}

protocol ArticleLoaderDelegate {
    
    func didAddArticle(at index: Int)
}

