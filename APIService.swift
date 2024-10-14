//
//  APIService.swift
//  Project_2
//
//  Created by 박수연 on 10/10/24.
//

import Foundation
import Combine

struct APIService {
    var API_KEY: String  {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["DNOPJIXN71FZ8CF4","XJ5CX3N4Q0UKCXSF","YYWFNYZ62C7TVNWA"]
    
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error>{
        
        let urlString =
        "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
       // "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=tesco&apikey=demo"
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    
    
    
}
