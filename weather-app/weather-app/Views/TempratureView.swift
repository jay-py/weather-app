//
//  TempratureView.swift
//  weather-app
//
//  Created by Jean paul Massoud on 2024-05-28.
//

import SwiftUI
import Domain

struct TempratureView: View {
    @AppStorage("isLightMode") private var isLightMode: Bool = false
    @StateObject private var vm = TempratureViewModel()
    @State private var isSheetPresented: Bool = false
    @State private var isMetric: Bool = true
    @State private var data: Temprature?
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("navigation_title_temprature")
                .toolbar {
                    ToolbarItem {
                        toolBarButton
                    }
                }
        }
        .preferredColorScheme(isLightMode ? .light : .dark)
        .environment(\.colorScheme, isLightMode ? .light : .dark)
    }
    
    var content: some View {
        VStack {
            Spacer()
            if let data {
                tempratureText(data)
            }
            else {
                noTempratureText
            }
            Spacer()
        }
        .overlay {
            overlayItems
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchView(isPresented: $isSheetPresented, result: $data)
                .presentationDetents([.medium])
        }
        .onReceive(vm.$currentTemprature, perform: { data in
            if let data {
                self.data = data
            }
        })
        .onAppear {
            vm.requestLocation()
        }
    }
}

// view components
extension TempratureView {
    
    var noTempratureText: some View {
        Text("no_temprature_found")
            .multilineTextAlignment(.center)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundStyle(Color.fontColor(isLightMode))
            .frame(maxWidth: .infinity)
    }
    
    func tempratureText(_ temprature: Temprature) -> some View {
        VStack(spacing: 0) {
            Text(temprature.name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            + Text(" (\(temprature.country))")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            Spacer()
                .frame(height: 24)
            Text("\(isMetric ? temprature.metricTemp : temprature.imperialTemp) ")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            + Text(isMetric ? "metric_unit" : "imperial_unit")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(Color.fontColor(isLightMode))
        .frame(maxWidth: .infinity)
    }
    
    
    var toolBarButton: some View {
        Button {
            withAnimation {
                isLightMode.toggle()
            }
        } label: {
            Image(systemName: isLightMode ? "moon.fill" : "sun.max.fill")
                .foregroundStyle(Color.themeColor)
                .rotationEffect(.degrees(isLightMode ? 0 : 180))
                .animation(.easeInOut, value: isLightMode)
        }
    }
    
    var overlayItems: some View {
        VStack {
            Spacer()
            if let _ = self.data {
                floatingConvertButton
                    .padding(.bottom)
            }
            floatingLocationButton
                .padding([.bottom, .top])
            floatingSearchButton
                .padding([.bottom, .top])
        }
        .padding([.trailing])
    }
    
    var floatingSearchButton: some View {
        HStack {
            Spacer()
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.themeColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.6), radius: 10)
                
            }
        }
    }
    
    var floatingConvertButton: some View {
        HStack {
            Spacer()
            Button(action: {
                isMetric.toggle()
            }) {
                Text(isMetric ? "imperial_label" : "metric_label")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.themeColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.6), radius: 10)
            }
        }
    }
    
    var floatingLocationButton: some View {
        HStack {
            Spacer()
            Button(action: {
                vm.requestLocation()
            }) {
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.themeColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.6), radius: 10)
            }
        }
    }
}

#Preview {
    TempratureView()
}
