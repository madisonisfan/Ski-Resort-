//
//  TestingBook.swift
//  ski-resort
//
//  Created by Madison Isfan on 10/25/22.
//

import SwiftUI
import Foundation

struct Book: Identifiable {
    var id: Int = 0
    
    var houseAge: Int = 0
    var distance: Int = 0
    var price: Int = 0
     
    
    init(raw: [String], index: Int){
        houseAge = Int(Float(raw[0])!)
        distance = Int(Float(raw[1])!)
       // print("raw[2]", type(of: Float(raw[2])!))
        //print("raw[2]", Float(raw[2]))
        //price = Int(raw[2])!
        id = index
    }
    
    /*
    var houseAge: String = ""
    var distance:String = ""
    var price:String = ""
    
    init(raw: [String], index: Int){
        houseAge = raw[0]
        distance = raw[1]
        price = raw[2]
    id = index
    }*/
    

    
}

struct TestingBook: View {
    var books: [Book]? {
        getData()
    }
    
    @State private var desiredAge = 0
    @State private var desiredDistance = 0
    @State private var houses: [Book]?
    
    
    
    var body: some View {
        VStack {
            Text("Books").font(.headline).padding(10)
            
            HStack{
                Text("Age less than: ")
                TextField("", value: $desiredAge, format: .number).keyboardType(.decimalPad)
            }
            HStack{
                Text("Distance less than: ")
                TextField("Enter Desired Distance: ", value: $desiredDistance, format: .number).keyboardType(.decimalPad)
            }
           
           
            
            
            Button("Search"){
                houses = findHouses()
            }
            
            
            
            
            if houses != nil {
                Text("Found Houses")
                
                List(houses!) { book in
                    HStack{
                        Text(String(book.houseAge))
                        Spacer()
                        Text(String(book.distance))
                       
                            
                    }
                    
                }
            }
            
            
            
            
            if books != nil {
             Text("All")
                List(books!) { book in
                    HStack{
                        Text(String(book.houseAge))
                        Spacer()
                        Text(String(book.distance))
                       
                            
                    }
                    
                }
            }
            
        }
        
    }
    
    func findHouses()->[Book]{
        var houses = [Book]()
        
        
        if books != nil {
            houses = books!.filter{ book in
                book.houseAge < desiredAge && book.distance < desiredDistance
            }
        }
        
       
        
        print("found houses: ", houses)
        return houses
    }
    
    func getData() -> [Book] { // -> [Fruit]
      var csvToStruct = [Book]()
        
        guard let filePath = Bundle.main.path(forResource: "Book1", ofType: "csv") else {
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
        
        for (index, row) in rows.enumerated() {
            print("row", row)
            
            var csvColumns = row.components(separatedBy: ",")
            
            print("price", csvColumns[2])
            csvColumns[2] = csvColumns[2].replacingOccurrences(of: "/r", with: "")
            print("colums", csvColumns)
           // let fruitStruct = Fruit.init(raw: csvColumns)
            let bookStruct = Book(raw: csvColumns, index: index)
            csvToStruct.append(bookStruct)
            
        }
        
        print("returned data", csvToStruct)
        return csvToStruct
    }
    
}

struct TestingBook_Previews: PreviewProvider {
    static var previews: some View {
        TestingBook()
    }
}
