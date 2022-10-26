//
//  HomeScreen.swift
//  ski-resort
//
//  Created by Madison Isfan on 10/25/22.
//

import SwiftUI
import Foundation

struct Fruit: Identifiable {
    var id: Int = 1
    var name: String = ""
    //var cost: Int = 0
    var color: String = ""
    
    init(raw: [String]){
        name = raw[0]
        //cost = Int(raw[1])
        color = raw[2]
    }
}

struct HomeScreen: View {
    
    var fruits: [Fruit]? {
        
        getData()
    }
    
   
    
    var body: some View {
        VStack {
            Text("Ski Resort Finder")
           
            if fruits != nil {
                List(fruits!) { fruit in
                    Text(fruit.name)
                }
            }
            
        }
        
    }
    
    func getData() -> [Fruit] { // -> [Fruit]
      var csvToStruct = [Fruit]()
        
        guard let filePath = Bundle.main.path(forResource: "fruit", ofType: "csv") else {
            print("Could not access file path")
            return []
        }
        
        print("filepath", filePath)
        
        
        
        var data = ""
        
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return []
        }
        
        print("data", data)
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeFirst()
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            print("row", row)
            
            let csvColumns = row.components(separatedBy: ",")
            print("colums", csvColumns)
           // let fruitStruct = Fruit.init(raw: csvColumns)
            let fruitStruct = Fruit(raw: csvColumns)
            csvToStruct.append(fruitStruct)
            
        }
        
        print("returned data", csvToStruct)
        return csvToStruct
    }
    
    /*
    func getCSVData() -> Array<String> {
        print("getcvs data called")
        do {
            let content = try String(contentsOfFile: "./fruit.csv")
            print("content", content)
            let parsedCSV: [String] = content.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] }
            print("parsed data", parsedCSV)
            return parsedCSV
        }
        catch {
            print("data caught")
            return []
        }
    }*/
    
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
