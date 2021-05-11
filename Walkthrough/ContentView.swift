//
//  ContentView.swift
//  Walkthrough
//
//  Created by Essam Orabi on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        if currentPage > totalPage{
            Home()
        }else{
            WalkThrough()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Home Page
struct Home: View {
    var body: some View{
        Text("Welcome to Home Essam")
            .font(.title)
            .fontWeight(.heavy)
    }
}

//walkThrought
struct WalkThrough: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View{
        //for sliding animation
        ZStack{
            //changing between views
            
            if currentPage == 1{
                ScreenView(image: "image1", title: "Step 1", details: "", bgColor: Color("Color1"))
                    .transition(.scale)
            }
            if currentPage == 2{
                ScreenView(image: "image2", title: "Step 2", details: "", bgColor: Color("Color2"))
                    .transition(.scale)
            }
            if currentPage == 3{
                ScreenView(image: "image3", title: "Step 3", details: "", bgColor: Color("Color3"))
                    .transition(.scale)

            }
        }
        .overlay(
            Button(action: {
                //changing views
                withAnimation(.easeInOut){
                    if currentPage <= totalPage{
                        currentPage += 1
                    }else{
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                
                //circular slider
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(currentPage) / CGFloat(totalPage))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
                
            })
            .padding(.bottom,20)
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    var image: String
    var title: String
    var details: String
    var bgColor: Color
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                if currentPage == 1 {
                    Text("Good morning Essam")
                        .font(.title)
                        .fontWeight(.semibold)
                        //letter spacing
                        .kerning(1.4)
                }else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                        
                    })
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                    
                })
            }
            .foregroundColor(.black)
            .padding()
            Spacer(minLength: 0)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}


var totalPage = 3
