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
    @State private var isSheetPresented: Bool = false
    @State private var isMetric: Bool = true
    @State private var data: (temprature: Temprature, location: Locations.Location)?

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
                tempratureText(data.temprature, data.location)
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
    }
    
    var noTempratureText: some View {
        Text("no_temprature_found")
            .multilineTextAlignment(.center)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundStyle(Color.fontColor(isLightMode))
            .frame(maxWidth: .infinity)
    }

    func tempratureText(_ temprature: Temprature, _ location: Locations.Location) -> some View {
        VStack(spacing: 0) {
            Text(location.name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            + Text(" (\(location.country))")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            Spacer()
                .frame(height: 24)
            Text("\(isMetric ? temprature.metricTemp : temprature.imperialTemp) ")
            + Text(isMetric ? "metric_unit" : "imperial_unit")
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
        .padding([.bottom, .trailing])
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
}

#Preview {
    TempratureView()
}
