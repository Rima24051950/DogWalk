//
//  MomentsView.swift
//  DogWalk
//
//  Created by MacBook on 31.03.2026.
//
import SwiftUI

struct MomentsView: View {
    
    @State private var selectedTab = 0
    @State private var isTextExpanded = false
    var onCheckScheduleTapped: () -> Void = {}
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
              
                ZStack(alignment: .topTrailing) {
                    Image("Alex Murray")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipped()
                    
               
                    HStack(spacing: 4) {
                        Text("Verified")
                            .font(.system(size: 16, weight: .semibold))
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 16))
                            .colorInvert()
                            
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .padding(.top, 46)
                    .padding(.trailing, 16)
                }
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Alex Murray")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 8) {
                        Text("5$/hr").font(.system(size: 14)).foregroundColor(.gray)
                        Text("•").foregroundColor(.gray)
                        Text("10 km").font(.system(size: 14)).foregroundColor(.gray)
                        Text("•").foregroundColor(.gray)
                        HStack(spacing: 2) {
                            Text("4.4").font(.system(size: 14))
                            Image(systemName: "star.fill").font(.system(size: 10)).foregroundColor(.orange)
                        }
                        Text("•").foregroundColor(.gray)
                        Text("450 walks").font(.system(size: 14)).foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                //  ТАБЫ
                HStack(spacing: 10) {
                    ForEach(Array(zip(["About", "Location", "Reviews"], [0, 1, 2])), id: \.0) { title, index in
                        Button(action: { selectedTab = index }) {
                            Text(title)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(selectedTab == index ? .white : .gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                        }
                        .background(selectedTab == index ? Color.black : Color(.systemGray6))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 24)
                
             
                HStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Age").font(.system(size: 13)).foregroundColor(.gray)
                        Text("30 years").font(.system(size: 17, weight: .semibold)).foregroundColor(.black)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Experience").font(.system(size: 13)).foregroundColor(.gray)
                        Text("11 months").font(.system(size: 17, weight: .semibold)).foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                
            
                VStack(alignment: .leading, spacing: 8) {
                    Text("Alex has loved dogs since childhood. He is currently a veterinary student. Visits the dog shelter weekly and believes every dog deserves love and care. Alex is patient, responsible, and always follows the walking schedule.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(isTextExpanded ? nil : 3)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isTextExpanded.toggle()
                        }
                    }) {
                        HStack(spacing: 2) {
                            Text(isTextExpanded ? "Show less" : "Read more")
                                .font(.system(size: 14, weight: .semibold))
                            Image(systemName: isTextExpanded ? "chevron.up" : "chevron.down")
                                .font(.system(size: 10))
                        }
                        .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                
                // ✅ 6. КНОПКА "CHECK SCHEDULE"
                Button(action: { onCheckScheduleTapped() }) {
                    Text("Check schedule")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(Color.orange)
                .cornerRadius(14)
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
        }
        .background(Color.onSurfase)
    }
}

#Preview {
    MomentsView()
}
