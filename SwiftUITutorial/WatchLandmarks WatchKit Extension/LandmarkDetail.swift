//
//  LandmarkDetail.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by GJC03280 on 2021/12/09.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    
    var body: some View {
        CircleImage(image: landmark.image.resizable())
            .scaledToFill()
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        return Group {
            LandmarkDetail(landmark: modelData.landmarks[0])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 5 - 44mm")
            
            LandmarkDetail(landmark: modelData.landmarks[1])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 5 - 40mm")
        }
    }
}
