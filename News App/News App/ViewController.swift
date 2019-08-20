//
//  ViewController.swift
//  News App
//
//  Created by RONIT NATH on 13/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

/* https://www.youtube.com/watch?v=cZJjhcZSq1w (Part-1) */
/* https://www.youtube.com/watch?v=Tb1EHigjIco (Part-2) */
/* https://www.youtube.com/watch?v=C7gCKUb8LDM (Part-3) */

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* The rest of the two classes are required so that the table view can communicate with the article class */
    
    @IBOutlet weak var tableView: UITableView!
    var articles : [Article]? = []                       /* 14:06 (Part-2)*/
    var source = "bbc-news"
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell" , for: indexPath) as! ArticleCell
        
        cell.Title.text = self.articles?[ indexPath.row ].headline
        cell.Description.text = self.articles?[ indexPath.row ].desc
        cell.Author.text = self.articles?[ indexPath.row ].author
        cell.ImageView.downloadImage(from: ( self.articles?[ indexPath.row ].imageUrl! )! )
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.articles?.count ?? 0    /* 18:20 */
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* For specifying the sequence of events to be performed on clicking a row */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebView
        webVC.url = self.articles?[indexPath.item].url
        self.present( webVC, animated: true, completion: nil )
    }
    
    
    let menuManager = MenuManager()
    @IBAction func menuPressed(_ sender: Any)
    {
        menuManager.openMenu()
        menuManager.mainVC = self
    }
    
    
    
    func fetchArticles(fromSource provider : String)                    /* method for fetching the articles from the URL specified below */
    {
        let urlRequest = URLRequest( url: URL(string: "https://newsapi.org/v2/top-headlines?sources=\(provider)&apiKey=9bda0e0525d740e2933d7d8be1f8be8f" )! )
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in

            if error != nil
            {
                print(error)
                return
            }

            self.articles = [Article]()
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]

                if let articlesfromJson = json["articles"] as? [[ String : AnyObject ]]       /* The articles are in the form of array of dictionaries */
                {
                    for article in articlesfromJson
                    {
                        let article_obj = Article()

                        if let title = article["title"] as? String , let author = article["author"] as? String , let desc = article["description"] as? String,
                        let url = article["url"] as? String , let urlToImage = article["urlToImage"] as? String     /* If all the fields have non-null value */
                        {
                            article_obj.author = author
                            article_obj.desc = desc
                            article_obj.headline = title
                            article_obj.url = url
                            article_obj.imageUrl = urlToImage
                            
                            print(title)
                        }

                        self.articles?.append(article_obj)

                    }
                }
                
                DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                }

            }catch let error
            {
                print(error)
            }

        }
        task.resume()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles( fromSource : source )
    }

}


extension UIImageView
{
    func downloadImage( from url : String )
    {
        let urlRequest = URLRequest( url: URL(string: url )! )
        let task = URLSession.shared.dataTask(with: urlRequest){ ( data , response , error ) in
        
            if( error != nil )
            {
                print(error)
            }
            
            DispatchQueue.main.async
            {
                self.image = UIImage( data : data! )
            }
        }
        
        task.resume()
    }
}
