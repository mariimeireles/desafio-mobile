//
//  CartViewController.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 28/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var cartProducts = [Product]()
    var sum = 0

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //totalLabel.text = String(sum)
        labelDidChange(label: totalLabel, sum: sum)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell") as? CartProductCell else { return UITableViewCell() }
        
        if let titleText = cartProducts[indexPath.row].title{
            cell.nameLabel.text = titleText
        }else{
            cell.nameLabel.text = "-"
        }
        
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
        if let priceText = cartProducts[indexPath.row].price{
            var price = String(priceText)
            price.insert(",", at: price.index(price.endIndex, offsetBy: -2))
            if price.characters.count >= 7{
                price.insert(".", at: price.index(price.endIndex, offsetBy: -6))
            }
            cell.priceLabel.text = "R$ " + price
        }else{
            cell.priceLabel.text = "-"
        }
        
        if let sellerText = cartProducts[indexPath.row].seller{
            cell.sellerLabel.text = "vendedor: " + sellerText
        }else{
            cell.sellerLabel.text = "-"
        }
        
        if let imageURL = URL(string: cartProducts[indexPath.row].thumbnailHd!){
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
        let products = self.cartProducts[button.tag]
        sum -= products.price!
        labelDidChange(label: totalLabel, sum: sum)n
        cartProducts.remove(at: button.tag)
 
        self.tableView.reloadData()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    func labelDidChange(_ label: UILabel) {
        var total = String(sum)
        if sum != 0{
            total.insert(",", at: total.index(total.endIndex, offsetBy: -2))
            if total.characters.count >= 7{
                total.insert(".", at: total.index(total.endIndex, offsetBy: -6))
            }
        }
        label.text = "Total: R$ " + total
    }
    */
        


}
