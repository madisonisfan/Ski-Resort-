//
//  SearchView.swift
//  ski-resort
//
//  Created by Madison Isfan on 10/25/22.
//

import SwiftUI


struct SearchView: View {
    @State private var foundResorts: [Resort]?
    @State private var elevation = 1000.0
    @State private var price = 20.0
     @State private var moguls = false
     @State private var terrainPark = false
    @State private var isEditingElevation = false

    @State private var isEditingPrice = false

    var resorts: [Resort]?
    @Binding var isSearchPresented: Bool
    
    var body: some View {
        VStack(){
            header
      
        ScrollView() {
            
            
            
            
                Text("Minimum Elevation: \(Int(elevation)) ft ").font(.system(size: 20))
            
            Slider(
                        value: $elevation,
                        in: 1000...12000,
                        //step: 100,
                        onEditingChanged: { editing in
                            isEditingElevation = editing
                        }
            ).padding(.bottom, 20)
    
           
                Text("Maximum Price (per ticket): $\(Int(price))").font(.system(size: 20))
            Slider(
                        value: $price,
                        in: 20...400,
                        //step: 100,
                        onEditingChanged: { editing in
                            isEditingPrice = editing
                        }
            ).padding(.bottom, 20)
                
           mogulsSection
           terrainSection
            
           buttons
            
            if foundResorts != nil {
                ForEach(foundResorts!, id: \.self){ resort in
                    Text(resort.name)
                }
            }//IF
            //Spacer()
        }
        .textFieldStyle(.roundedBorder)
        //.padding(.horizontal)//VS
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .leading)
       
        .background(Color(hue: 0.552, saturation: 0.208, brightness: 0.986))
        }
        
        
    }//BODY
    

    var mogulsSection: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Moguls Required: \(moguls ? "Yes" : "No")").font(.system(size: 20))
               // .border(.green)
          
            HStack{
                Toggle("", isOn: $moguls).frame(width: 40)//.border(.pink)//.frame(maxWidth: )
            }
            
           
            
         }
        .padding(.bottom, 25)
    }
    
    var terrainSection: some View {
        VStack(alignment: .center, spacing: 15)  {
            Text("Terrain Park Required: \(terrainPark ? "Yes" : "No")").font(.system(size: 20))
            
      
            Toggle("", isOn: $terrainPark).frame(width: 40, alignment: .center)
               
               
            
               
            
        } .padding(.bottom, 20)
       
    }
    
    var header: some View {
        HStack{
            Spacer()
            Text("Ski Resort Search")
                .font(.title)
                .foregroundColor(.white)
           Spacer()
            //.padding(.bottom, 30)
            
            //Spacer()
        }//.padding(.bottom, 20)
        .frame(maxWidth: .infinity)
        .background(.black)
        
        
        
    }
    
    var buttons: some View {
        VStack{
            Button("Search"){
                findResorts()
                isSearchPresented.toggle()
            }
            .padding(.vertical, 10)
            .font(.system(size: 20))
            .frame(width: 200)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Cancel"){
                isSearchPresented.toggle()
            }
            .foregroundColor(.black)
        }
    }
    
    
    func findResorts(){
       //var foundResorts = [Resort]()
        
        
        if resorts != nil {
            foundResorts = resorts!.filter{ resort in
                
                if (moguls && terrainPark){
                    return  resort.elevation >= Int(elevation) && resort.price <= Int(price) && resort.moguls && resort.terrainPark
                } else if (moguls){
                    return  resort.elevation >= Int(elevation) && resort.price <= Int(price) && resort.moguls
                } else if (terrainPark){
                    return  resort.elevation >= Int(elevation) && resort.price <= Int(price) && resort.terrainPark
                }//ELSE/IF
                
                return  resort.elevation >= Int(elevation) && resort.price <= Int(price)
                
                
                
                
                
            }//FILTER
        }//IF
    }//FIND RESORTS()
}




struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isSearchPresented: .constant(false))
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}


/*
 
 
 TextField("Min elevation in ft", value: $elevation, format: .number).keyboardType(.decimalPad)
 .padding(.bottom, 10)
 */
