//
//  ViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 23/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cartProducts = [Product]()
    private var products = [Product]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = URL(string: "https://raw.githubusercontent.com/stone-pagamentos/desafio-mobile/master/products.json")
        let networkProcessor = NetworkProcessor(url: jsonUrlString!)
        networkProcessor.downloadJSONFromURL { (result) in
            self.products = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else { return UITableViewCell() }
        
        if let titleText = products[indexPath.row].title{
            cell.nameLabel.text = titleText
        }else{
            cell.nameLabel.text = "-"
        }
        
        cell.cartButton.tag = indexPath.row
        cell.cartButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        if let priceText = products[indexPath.row].price{
            var price = String(priceText)
            price.insert(",", at: price.index(price.endIndex, offsetBy: -2))
            if price.characters.count >= 7{
                price.insert(".", at: price.index(price.endIndex, offsetBy: -6))
            }
            cell.priceLabel.text = "R$ " + price
        }else{
            cell.priceLabel.text = "-"
        }
        
        if let sellerText = products[indexPath.row].seller{
            cell.sellerLabel.text = "vendedor: " + sellerText
        }else{
            cell.sellerLabel.text = "-"
        }
        
        if let imageURL = URL(string: products[indexPath.row].thumbnailHd!){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                }
            }
        }else{
            cell.productImageView.image = UIImage(named: "notFound")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    @objc func buttonClick(_ button: UIButton){
        //products[button.tag]
        //print(button.tag)
        let cartProduct = products[button.tag]
        //print(cartProduct.price)
        cartProducts.append(cartProduct)
        //print(cartProducts)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UINavigationController
        let cartlVC = destinationVC.topViewController as! CartViewController
        let cartArray = self.cartProducts
        cartlVC.cartProducts = cartArray
    }

}

