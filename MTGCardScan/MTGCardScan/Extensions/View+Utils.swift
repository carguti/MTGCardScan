//
//  View+Utils.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 3/6/24.
//

import SwiftUI

extension View {
      func flipRotate(_ degrees : Double) -> some View {
            return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 0.0, z: 0.0))
      }

      func placedOnCard(_ color: Color) -> some View {
            return padding(5).frame(width: 250, height: 150, alignment: .center).background(color)
      }
}
