//
//  IntroView.swift
//  IntroAnimation
//
//  Created by nguyen.van.thuanc on 17/10/2022.
//
  
import SwiftUI

struct IntroView: View {
    // MARK: Anitaion Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    
    var body: some View {
        
        ZStack {
            if showHomeView {
                HomeView()
                    .transition(.move(edge: .leading))
            } else {
                ZStack {
                    Color("BG")
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    WalkThroughScreens()
                    
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1,
                                              dampingFraction: 0.85,
                                              blendDuration: 0.85),
                           value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.interactiveSpring(response: 0.9,
                                      dampingFraction: 0.85,
                                      blendDuration: 0.6),
                   value: showHomeView)
    }
    
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        
        GeometryReader {
            let size = $0.size
            
            ZStack {
                // MARK: Walk Through Screen
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // MARK: Next Button
            .overlay(alignment: .bottom) {
                // MARK: Converting Next Button Into  SignUp Button
                
                
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? (size.width / 1.5) : 55,
                       height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30,
                                     style: isLast ? .continuous : .circular)
                        .fill(.black)
                }
                .onTapGesture {
                    // MARK: Update Current Index
                    if currentIndex == intros.count {
                        // MARK: Moving To Home Screen
                        showHomeView = true
                    } else {
                        currentIndex += 1
                    }
                }
                .offset(y: isLast ? -40 : -90)
                .animation(.interactiveSpring(response: 0.8,
                                              dampingFraction: 0.5,
                                              blendDuration: 0.5),
                           value: isLast)
                
            }
            .overlay(alignment: .bottom) {
                // MARK: Bottom Sign In Button
                let isLast = currentIndex == intros.count
                
                HStack(spacing: 5) {
                    Text("Already have an account?")
                    
                    Button("Login") {
                        
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0.1),
                           value: isLast)
            }
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.system(size: 28, weight: .bold))
                // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                // MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0.2),
                           value: currentIndex)
            
            Text(dummyText)
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0.1),
                           value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0),
                           value: currentIndex)
        }
    }
    
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int) -> some View {
        VStack(spacing: 10) {
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0),
                           value: currentIndex)
            
            Text("Welcome")
                .font(.system(size: 28, weight: .bold))
                // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                // MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0.2),
                           value: currentIndex)
            
            Text("Stay organised and live stress-free with\nyou-do app.")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,
                                              dampingFraction: 0.8,
                                              blendDuration: 0.5).delay(0.1),
                           value: currentIndex)
        }
    }
    
    @ViewBuilder
    func NavBar() -> some View {
        let islast = currentIndex == intros.count
        
        HStack {
            Button {
                // MARK: If Greeter Than Zero Then Eliminating Index
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            Button("skip") {
                currentIndex = intros.count
            }
            .font(.system(size: 14, weight: .regular))
            
            .foregroundColor(Color.black)
            .opacity(islast ? 0 : 1)
            .animation(.easeInOut, value: islast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                    .padding(.top, 60)
                
                Text("Clearhead")
                    .font(.system(size: 27).bold())
                    .padding(.top, 55)
                
                Text(dummyText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("Let's begin")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(Color(.black))
                    }
                    .padding(.top, 30)
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // MARK: Moving Up When Click
            .offset(y: showWalkThroughScreens ? (-size.height) : 0)
        }
        .ignoresSafeArea()
    }
    
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
