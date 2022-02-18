//
//  ContentView.swift
//  Shared
//
//  Created by Katia Flores on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var guess1 = ""
    @State var guess2 = ""
    @State var guess3 = ""
    @State private var totalInput: Int? = 18
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
    
       VStack {
            HStack {
                VStack {
                    TextEditor(text: $guess1)
                    TextEditor(text: $guess2)
                    TextEditor(text: $guess3)
                }
                
                Button("Calculate Test Spherical Bessel Functions", action: calculateTestBesselFunc)
                    }
            .frame(minHeight: 500, maxHeight: 800)
            .frame(minWidth: 480, maxWidth: 800)
            .padding()
        
        HStack{
            
            Text(verbatim: "Order:")
                .padding()
            TextField("Total", value: $totalInput, formatter: intFormatter)
        
                .padding()
            
            }
        }
        
    }
    
    func calculateTestBesselFunc()  {

        let step = 0.1                      /* delta x  */
        let order = totalInput ?? 0                      /* order of Bessel function */
        let start = order+25 /* used for downward algorithm */
        let xmin1 = 0.1
        let xmin2 = 1.0
        let xmin3 = 10.0
        var x1 = 0.0
        var x2 = 0.0
        var x3 = 0.0
        var downward = 0.0
        var upward = 0.0
        var relDiff = 0.0

            guess1 = String(format: "J%d(x)\n", order)
            guess2 = String(format: "J%d(x)\n", order)
            guess3 = String(format: "J%d(x)\n", order)

        for index in (0...25)
        {
            x1 = Double(index)*step + xmin1
            downward = calculateDownwardRecursion(xValue: x1, order: order, start: start)
            upward = calculateUpwardRecursion(xValue: x1, order: order)
                let top = abs(upward - downward)
                let bottom = abs(upward) + abs(downward)
            relDiff = top / bottom
            
            guess1 += String(format: "x = %f, Downward = %7.5e, Upward = %7.5e\n, Relative Difference = %7.5e\n", x1, downward, upward, relDiff)
        
        }
        
        for index in (0...25)
        {
            x2 = Double(index)*step + xmin2
            downward = calculateDownwardRecursion(xValue: x2, order: order, start: start)
            upward = calculateUpwardRecursion(xValue: x2, order: order)
                let top = abs(upward - downward)
                let bottom = abs(upward) + abs(downward)
            relDiff = top / bottom
            
            guess2 += String(format: "x = %f, Downward = %7.5e, Upward = %7.5e\n, Relative Difference = %7.5e\n", x2, downward, upward, relDiff)
        }
        
        for index in (0...25)
        {
            x3 = Double(index)*step + xmin3
            downward = calculateDownwardRecursion(xValue: x3, order: order, start: start)
            upward = calculateUpwardRecursion(xValue: x3, order: order)
                let top = abs(upward - downward)
                let bottom = abs(upward) + abs(downward)
            relDiff = top / bottom
            
            guess3 += String(format: "x = %f, Downward = %7.5e, Upward = %7.5e\n, Relative Difference = %7.5e\n", x3, downward, upward, relDiff)
        }
        

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
