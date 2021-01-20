//
//  ContentView.swift
//  CaluculateDrownWater
//
//  Created by 細川聖矢 on 2021/01/19.
//
import SwiftUI
import GoogleMobileAds


struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        
        banner.adUnitID = "ca-app-pub-4439113960692957/4983286645"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}



struct ContentView: View {
    @State private var selectedSpecies = 0
    @State var bodyWeight:String = ""
    @State var convertedWeight:Double = 0
    @State var caluculatedRer:Double = 0
    @State var drinkingWater:Double = 0
    
    var body: some View {
//        ZStack{
//            Color.white
//                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                .onTapGesture {
//                                    UIApplication.shared.closeKeyboard()
//                                }
        VStack{
            
            Group{
            ZStack{
                Color.blue.opacity(0.7)
            VStack{
                Text("犬猫の1日水分摂取量を計算しよう").font(.headline)
                    .foregroundColor(.white)
            }//VStack
            }//ZStack
            .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            AdView().frame(height: 50)
            }//Group
            
            Spacer()
            
            ZStack{
                Color.blue
                    .opacity(0.7)
                    .cornerRadius(20)
            HStack{
                Text("動物種").font(.title)
                    .foregroundColor(.white)
            Picker(selection: $selectedSpecies, label: Text("動物種")) {
                Text("犬").tag(0)
                    .font(.title)
                    .foregroundColor(.white)
                Text("猫").tag(1)
                    .font(.title)
                    .foregroundColor(.white)
            }//Picker
            .frame(width:100)
            }//HStack
            }//ZStack
            .frame(height:100)
            .padding()
            
            Spacer()
            
            HStack{
                Text("体重").font(.title)
                TextField("入力",text:$bodyWeight)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width:130)
                Text("kg").font(.title)
            }//HStack
            
            Spacer()
            
            Group{
            ZStack{
                Color.blue
                    .cornerRadius(10)
            Button(action: {
                convertedWeight = Double(bodyWeight) ?? 0
                caluculatedRer = 70*pow(convertedWeight,0.75)//累乗はpow
                if(selectedSpecies == 0){
                    drinkingWater = 1.6*caluculatedRer
                }//if
                else{
                    drinkingWater = 1.2*caluculatedRer
                }//else
                UIApplication.shared.closeKeyboard()
            }//action
            )//Button
            {
                Text("計算").font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            
            }//ZStack
            .frame(width:150,height:80)
            }//Group
            
            HStack{
                Text("1日の水分摂取量").font(.largeTitle)
                Text("\(Int(drinkingWater))")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("ml").font(.largeTitle)
            }//HStack
            
            Group{
            Spacer()
            
            AdView().frame(height: 50)
            }//Group
        }//VStack
//        }//ZSTack
        
    }//body
   
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
