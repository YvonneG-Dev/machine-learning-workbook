//
//  UmbrellaPredictorView.swift
//  UmbrellaPredictorDemo
//
//  Created by Yvonne Gustain on 09.09.26.
//

import SwiftUI

struct UmbrellaPredictorView: View {
    @State var viewModel = UmbrellaPredictorViewModel()
    @State private var temperature: Double = -2
    @State private var humidity: Double = 60

    var body: some View {
        VStack {
            VStack {
                Text("Umbrella Predictor")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                Image(
                    systemName: viewModel.umbrellaNeededState
                        ? "umbrella.fill" : "sun.max.fill"
                )
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .foregroundStyle(.pink)
                .padding()
            }
            .padding(24)
            VStack {
                UmbrellaSliderView(
                    sliderTitel: "Temperature: \(Int(temperature)) °C",
                    sliderValue: $temperature,
                    sliderMinValue: -2,
                    sliderMaxValue: 30,
                    sliderAction: {
                        viewModel.predict(
                            temperature: temperature,
                            humidity: humidity
                        )
                    }
                )
                .padding()
                UmbrellaSliderView(
                    sliderTitel: "Humidity: \(Int(humidity)) %",
                    sliderValue: $humidity,
                    sliderMinValue: 60,
                    sliderMaxValue: 90,
                    sliderAction: {
                        viewModel.predict(
                            temperature: temperature,
                            humidity: humidity
                        )
                    }
                )
                .padding()
            }
            .padding(24)
        }
        .onAppear {
            viewModel.predict(
                temperature: temperature,
                humidity: humidity
            )
        }
        Spacer()
    }
}

struct UmbrellaSliderView: View {
    var sliderTitel: String
    @Binding var sliderValue: Double
    var sliderMinValue: Double
    var sliderMaxValue: Double
    var sliderAction: () -> Void

    var body: some View {
        Text(sliderTitel)
            .font(.system(.headline, design: .rounded))
            .fontWeight(.semibold)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.pink.opacity(0.25))
            .foregroundStyle(.black)
            .clipShape(Capsule())

        Slider(
            value: $sliderValue,
            in: sliderMinValue...sliderMaxValue,
            step: 1
        )
        .tint(.pink)
        .onChange(of: sliderValue) { _, _ in
            sliderAction()
        }
    }
}

#Preview {
    UmbrellaPredictorView()
}
