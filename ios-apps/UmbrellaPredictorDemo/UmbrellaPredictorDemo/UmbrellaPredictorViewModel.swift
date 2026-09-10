//
//  UmbrellaPredictorViewModel.swift
//  UmbrellaPredictorDemo
//
//  Created by Yvonne Gustain on 09.09.26.
//

import CoreML
import Observation

@MainActor @Observable
class UmbrellaPredictorViewModel {
    private let model: UmbrellaPredictor?
    var umbrellaNeededState: Bool

    init() {
        model = try? UmbrellaPredictor(configuration: MLModelConfiguration())
        umbrellaNeededState = false
    }

    func predict(temperature: Double, humidity: Double) {
        guard let model else {
            print("Model not loaded")
            return
        }

        do {
            let prediction = try model.prediction(
                humidity: humidity,
                temperature: temperature
            )
            umbrellaNeededState = prediction.umbrella_needed == 1
        } catch {
            print("Prediction failed: \(error)")
        }
    }
}
