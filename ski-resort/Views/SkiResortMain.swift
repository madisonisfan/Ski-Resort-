//
//  SkiResortMain.swift
//  ski-resort
//
//  Created by Madison Isfan on 10/25/22.
//

import SwiftUI

struct Resort: Identifiable, Hashable {
    var id: Int = 0
    var name: String = ""
    var price: Int = 0
    var moguls: Bool = false
    var terrainPark: Bool = false
    var elevation: Int = 0
    
    
    init(raw: [String], index: Int){
        id = index
        name = raw[0]
        price = Int((raw[2]))!
        elevation = Int(raw[1])!
        moguls = Bool(raw[3])!
        terrainPark = Bool(raw[4])!
        
    }
    
}

struct SkiResortMain: View {
    
    @State var showAllResorts = false
    @State var isSearchPresented = false
    
    var resorts: [Resort]? {
        getData()
    }
    
    var body: some View {
        ScrollView {
        
            Button(){
                isSearchPresented.toggle()
            } label: {
                Text("Start Search").foregroundColor(.white).fontWeight(.medium)
            }.frame(width: 150, height: 30)
                .background(.blue)
                .cornerRadius(20)
            
            
            Button("\(showAllResorts ? "Hide" : "View All") Resort Data"){
                showAllResorts.toggle()
            }
            
            
            if resorts != nil && showAllResorts{
                Text("All Resorts").fontWeight(.bold).font(.system(size: 20)).padding(.top, 10)
                
                ForEach(resorts!, id: \.self){ resort in
                    HStack {
                        Text(resort.name)
                        Spacer()
                        Text(String(resort.elevation))
                        Text(String(resort.price))
                        Text(resort.moguls ? "yes" : "no")
                        Text(resort.terrainPark ? "yes" : "no")
                    }//HS
                }//FE
                
            }
        }//SV
        .padding(.horizontal, 10)
        .sheet(isPresented: $isSearchPresented){
            SearchView(resorts: resorts, isSearchPresented: $isSearchPresented)
        }
    
    }//body
    
    func getData() -> [Resort] { // -> [Fruit]
      var csvToStruct = [Resort]()
        
        guard let filePath = Bundle.main.path(forResource: "ski-resort-data-testing", ofType: "csv") else {
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
        rows.removeLast()
   
        
        for (index, row) in rows.enumerated() {
            print("row", row)
            
            var csvColumns = row.components(separatedBy: ",")
            
            print("price", csvColumns[2])
            csvColumns[2] = csvColumns[2].replacingOccurrences(of: "/r", with: "")
            print("colums", csvColumns)
           // let fruitStruct = Fruit.init(raw: csvColumns)
            let resortStruct = Resort(raw: csvColumns, index: index)
            csvToStruct.append(resortStruct)
            
        }
        
        print("returned data", csvToStruct)
        return csvToStruct
    }
}
    

struct SkiResortMain_Previews: PreviewProvider {
    static var previews: some View {
        SkiResortMain()
    }
}
