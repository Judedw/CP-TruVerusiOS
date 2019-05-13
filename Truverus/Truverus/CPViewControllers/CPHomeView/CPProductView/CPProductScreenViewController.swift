//
//  CPProductScreenViewController.swift
//  Truverus
//
//  Created by User on 8/5/19.
//  Copyright © 2019 ClearPicture. All rights reserved.
//

import UIKit

class CPProductScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableParralex: CPParallaxTableView!
    
    var descriptionText = String()
    var productname = String()
    var originalHeight: CGFloat!
    
    var currentviewFlag : Int!
    
    var scroll = UIScrollView()
    
    var images = [#imageLiteral(resourceName: "jursey"),#imageLiteral(resourceName: "blackJersy"),#imageLiteral(resourceName: "watch"),#imageLiteral(resourceName: "Running")]
    
    var MaximageCount = 4
    
    var image1 = UIImageView()
    var image2 = UIImageView()
    var image3 = UIImageView()
    var image4 = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpTableView()
        
        SetupImageView()
        
        manageContent()
        
        // Do any additional setup after loading the view.
    }
    
    func setdata() {
        
        print("flag :: \(currentviewFlag)")
        TableParralex.reloadData()
        
        SetUpTableView()
        
        SetupImageView()
        //validateImages ()
        
        //manageContent()
        
        
    }
    
    func SetUpTableView(){
        
        TableParralex.constructParallaxHeader()
        TableParralex.delegate = self
        TableParralex.dataSource = self
        
        let imageviewHeight = (UIScreen.main.bounds.height / 5) * 3.2
        
        TableParralex.contentInset = UIEdgeInsets(top: imageviewHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    func SetupImageView(){
        
        view.addSubview(scroll)
        
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: (UIScreen.main.bounds.height / 5) * 3.2)
        
        scroll.frame = rect
        scroll.backgroundColor = UIColor.white
        scroll.contentOffset.x = 0
        scroll.isPagingEnabled = true
        
        for i in 0..<images.count {
            
            if(i == 0){
                
                image1.image = images[i]
                let xPosition = self.view.frame.width * CGFloat(i)
                image1.contentMode = .scaleAspectFill
                image1.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.scroll.frame.height)
                scroll.addSubview(image1)
                
            } else if (i == 1){
                
                image2.image = images[i]
                let xPosition = self.view.frame.width * CGFloat(i)
                image2.contentMode = .scaleAspectFill
                image2.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.scroll.frame.height)
                scroll.addSubview(image2)
                
            } else if (i == 2){
                
                image3.image = images[i]
                let xPosition = self.view.frame.width * CGFloat(i)
                image3.contentMode = .scaleAspectFill
                image3.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.scroll.frame.height)
                scroll.addSubview(image3)
                
            } else if (i == 3){
                
                image4.image = images[i]
                let xPosition = self.view.frame.width * CGFloat(i)
                image4.contentMode = .scaleAspectFill
                image4.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.scroll.frame.height)
                scroll.addSubview(image4)
                
            } else {
                
                print("count is too much than 4")
                
            }
            
            scroll.delegate = self
            
            var j = 0
            if(i > 3){
                j = 3
            }else{
                j = i
            }
            
            scroll.contentSize.width = scroll.frame.width * CGFloat(j + 1)
            
        }
        
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if let _ = scrollView as? UITableView {
            
            //tableview
            
            TableParralex.updateHeaderView()
            
            let height = (UIScreen.main.bounds.height / 5) * 3.2
            let y = height - (scrollView.contentOffset.y + height)
            let h = max(46, y)
            let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
            
            scroll.frame = rect
            image1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: h)
            image2.frame = CGRect(x: self.view.frame.width * CGFloat(1), y: 0, width: view.bounds.width, height: h)
            image3.frame = CGRect(x: self.view.frame.width * CGFloat(2), y: 0, width: view.bounds.width, height: h)
            image4.frame = CGRect(x: self.view.frame.width * CGFloat(3), y: 0, width: view.bounds.width, height: h)
            
        } else{
            
            //scrollview
            
            TableParralex?.visibleCells.forEach { cell in
                if let cell = cell as? CPCustomTableViewCell {
                    
                    let page = Int(scroll.contentOffset.x / scroll.frame.size.width)
                    cell.setPagecontrol(number: page)
                }
            }
            
        }
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let _ = scrollView as? UITableView {
            
            //tableview
            
        } else{
            
            //scrollview
            
            changesize()
        }
        
    }
    
    func changesize(){
        
        
        let pageNumber = Int(scroll.contentOffset.x / scroll.frame.size.width)
        
        if (pageNumber == 0){
            image1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: self.scroll.frame.height)
            scroll.bringSubviewToFront(image1)
        }
        else if (pageNumber == 1){
            image2.frame = CGRect(x: self.view.frame.width * CGFloat(1), y: 0, width: view.bounds.width, height: self.scroll.frame.height)
            scroll.bringSubviewToFront(image2)
        }
        else if (pageNumber == 2){
            image3.frame = CGRect(x: self.view.frame.width * CGFloat(2), y: 0, width: view.bounds.width, height:  self.scroll.frame.height)
            scroll.bringSubviewToFront(image3)
        }
        else if (pageNumber == 3){
            image4.frame = CGRect(x: self.view.frame.width * CGFloat(3), y: 0, width: view.bounds.width, height:  self.scroll.frame.height)
            scroll.bringSubviewToFront(image4)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CPProductCell") as? CPCustomTableViewCell {
            
            cell.SetText(description: descriptionText, productName: productname)
            if (images.count < 2){
                cell.PageControll.numberOfPages = 0
                
            } else if (images.count > 4){
                cell.PageControll.numberOfPages = 4
            } else {
                cell.PageControll.numberOfPages = images.count
            }
            
            if (currentviewFlag == 1){
                
                cell.ProductNameLabel.text = productname
                cell.TransferButton.isHidden = false
                cell.BackButton.isHidden = false
                cell.BackButton.addTarget(self, action: #selector(self.back(_:)), for: .touchUpInside)
                cell.TransferButton.addTarget(self, action: #selector(transfer(_:)), for: .touchUpInside)
                
            } else {
                
                cell.TransferButton.isHidden = true
                cell.BackButton.isHidden = true
                
            }
            
            return cell
        } else {
            
            return CPCustomTableViewCell()
            
        }
    }
  
    @objc func transfer(_ sender: UIButton?) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Transfer", bundle: nil)
        let Acc : CPTransferViewController = storyboard.instantiateViewController(withIdentifier: "CPTransferVC") as! CPTransferViewController
        
        self.navigationController?.pushViewController(Acc, animated: true)

        
    }
    
    @objc func back(_ sender: UIButton?) {
        // Your code here
        if let parent = self.parent as? CPCollectionViewController {
            let transition = CATransition()
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            parent.view.layer.add(transition, forKey: nil)
            parent.handleBack()
        }
        
    }
    
    func manageContent(){
        
        descriptionText = "When you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but it When you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions, but itWhen you think Nike, your mind can take you in so many different directions, but it all comes back to the When you think Nike, your mind can take you in so many different directions. "
        
        productname = "ADIDAS JERCEY"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
