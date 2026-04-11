//
//  MomentsView.swift
//  DogWalk
//
//  Created by MacBook on 31.03.2026.
//
import SwiftUI
import UIKit

struct MomentsView: View {
    
    @State private var selectedTab = 0
    var onCheckScheduleTapped: () -> Void = {}
    
    
    var body: some View {
      
            ScrollView {
                ZStack(alignment: .topLeading) {
                    
                    // MARK:  Фон
                    Color.onSurfase
                        .ignoresSafeArea()
                    
                    HStack {
                        Image("Alex Murray")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 479, height: 447)
                            .offset(x: -37, y: 0)
                            .opacity(1)
                            .ignoresSafeArea()
                        
                    }
                    Button(action: {
                        print(" Close tapped")
                    }) {
                        Image("Close")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.top, 10)
                    .padding(.leading, 35)
                    
                    Button(action: {
                        
                    }) {
                        Image( "Verified")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 77, height: 20)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.top, 12)
                    .padding(.leading, 348)
                    
                    //   MARK: Stack
                    
                    HStack(spacing: 8) {
                        VStack{
                            Text("Alex Murray")
                                .font(.system(size: 25, weight: .semibold))
                                .frame(width: 173,height: 42)
                            
                                .foregroundColor(.black)
                                .lineLimit(1)
                            
                            HStack{
                                
                                Text("5$/hr")
                                    .font(.system(size: 13,weight: .regular))
                                    .frame(width: 37,height: 20,alignment: .bottom)
                                    .lineLimit(1)
                                
                                Text("10 km")
                                    .font(.system(size: 13,weight: .regular))
                                    .frame(width: 37,height: 20,alignment: .bottom)
                                    .lineLimit(1)
                                
                                
                                HStack(spacing: 2){
                                    Text("4.4")
                                        .font(.system(size: 13,weight: .regular))
                                        .lineLimit(1)
                                    Image(systemName:"star.fill")
                                        .font(.system(size: 12,weight: .regular))
                                        .foregroundColor(.gray)
                                    
                                }
                                .frame(width: 45,height: 20)
                                
                                Text("450 walks")
                                    .font(.system(size: 13,weight: .regular))
                                    .frame(width: 66,height: 20,alignment: .bottom)
                                    .lineLimit(1)
                            }
                            
                        }
                        .padding(.bottom,367)
                        .frame(width: 245,height: 72)
                    }
                    .padding(.horizontal,20)
                    .frame(width: 469, height: 489)
                    .background(Color(.systemGray6))
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .offset(y: 343)
                    
                    //  MARK: Rectangle
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.9))
                        .frame(width: 415, height: 1.5)
                        .offset(x: 16, y: 461)
                    
                    
                    // MARK: Segmented Stack
                    
                    HStack (spacing: 10) {
                        
                        Button(action:{
                            selectedTab = 0
                            
                        }) {
                            Text ("About")
                                .foregroundColor(.gray)
                                .font(.system(size: 12,weight: .semibold))
                                .frame(width: 99,height: 44)
                            
                                .background(selectedTab == 0 ? Color.black : Color(.systemGray6))
                            
                        }
                        .cornerRadius(20)
                        .padding(.top,12)
                        .padding(.trailing,19)
                        .padding(.leading,29)
                        .padding(.bottom,12)
                        
                        
                        Button(action: {
                            
                        }) {
                            Text("Location")
                                .foregroundColor(.gray)
                                .frame(width: 90,height: 44)
                                .background(selectedTab == 1 ? Color.black : Color(.systemGray6))
                        }
                        
                        .cornerRadius(20)
                        
                        .padding(.top,12)
                        .padding(.trailing,22)
                        .padding(.leading,22)
                        .padding(.bottom,12)
                        
                        
                        Button (action:{
                            
                        }){
                            Text("Reviews")
                                .foregroundColor(.gray)
                            
                                .frame(width: 99,height: 44)
                                .background(selectedTab == 2 ? Color.black : Color(.systemGray6))
                        }
                        .cornerRadius(20)
                        .padding(.top,12)
                        .padding(.trailing,23)
                        .padding(.leading,23)
                        .padding(.bottom,12)
                        
                        
                    }
                    
                    .background(.white)
                    .padding(.top,483)
                    .padding(.horizontal, 16)
                    
                    HStack (spacing: 8){
                        VStack{
                            Text ("Age")
                                .font(.system(size: 13))
                                .frame(width: 26,height: 20)
                            //.padding(.trailing,1)
                                .foregroundColor(.gray)
                            
                            Text("30 years")
                                .font(.system(size: 17))
                                .frame(width: 73,height: 26)
                        }
                        .frame(width: 200,height: 46)
                        .offset(x: 16, y: 549)
                        
                        VStack{
                            Text ("Experience")
                                .font(.system(size: 13))
                                .frame(width: 71,height: 20)
                                .foregroundColor(.gray)
                            
                            Text("11 months")
                                .font(.system(size: 17))
                                .frame(width: 82,height: 26)
                            
                            
                        }
                        .frame(width: 200,height: 46)
                        .offset(x: 16, y: 549)
                    }
                    
                    
                    .frame(width: 339,height: 44)
                    .offset(x: 16, y: 24)
                    
                    Text ("Alex has loved dogs since childhood. He is currently a veterinary student. Visits the dog shelter we...")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .frame(width: 279,height: 80)
                        .padding(.top,619)
                        .padding(.leading,45)
                    
                    Text("Read more")
                        .font(.system(size: 13))
                    
                    
                        .frame(width: 155, height: 80)
                        .padding(.top, 645)
                        .foregroundColor(.red)
                    
                    
                    // MARK: КНОПКА
                    
                    Button ( action:{
                        onCheckScheduleTapped() 
                    }) {
                        Text ("Check schedule")
                            .foregroundColor(.white)
                            .padding(.vertical,15)
                            .padding(.horizontal,102)
                    }
                    .frame(width: 343,height: 56)
                    .background(Color.orange.opacity(0.9))
                    .cornerRadius(14)
                    .padding(.top,700)
                    .padding(.leading,59)
                    
                    
                    
                }
                
                }
            }
        }
    

#Preview {
    MomentsView()
}
