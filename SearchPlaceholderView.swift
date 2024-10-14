//
//  SearchPlaceholderView.swift
//  Project_2
//
//  Created by 박수연 on 10/11/24.
//

import UIKit

class SearchPlaceholderView : UIView{
    
    
    
    private let imageView: UIImageView =  {
        
        let image = UIImage(named: "imDca")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
     
        return imageView
        
    }()
    
    private let label:  UILabel = {
        let label = UILabel()
        label.text = "hahahahhahaahhhhahahahahha"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)!
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    override init(frame fram: CGRect){
        super.init(frame: fram)
       setupviews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupviews(){
        addSubview(stackView)
        NSLayoutConstraint.activate([
            
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 88)
            
        ])
    }
    
    
    
    
    
}
