import Foundation

func fuelRequirements(mass: Int) -> Int {
    return mass / 3 - 2
}

func totalFuelRequirements(moduleMass: Int) -> Int {
    var total = 0
    var mass = moduleMass
    
    while(mass > 0) {
        mass = max(0, fuelRequirements(mass: mass))
        total += mass
    }

    return total
}

let input = """
53247
140268
139961
87816
102986
122415
140484
56099
52832
56999
122823
130608
83149
144224
104559
108523
126571
137284
83197
109996
56795
73112
50043
130097
113563
91200
130589
83725
108625
131977
95213
149800
70756
86240
134854
148919
114460
95062
122989
57274
112074
139530
131217
55652
125522
77304
144873
86811
107768
70704
146300
87256
118752
52585
126269
124559
52592
112097
123090
101778
136424
74547
119337
143570
113426
146458
88135
100236
148224
98718
135181
56608
109671
144027
135192
111620
69411
107957
88448
64972
63010
100625
96144
61998
59813
124503
64306
73119
77094
136295
132224
125713
110137
51478
90272
133506
72218
100082
106377
140290
"""

// TODO: extract lines extension
// TODO: parametrize the code
// TODO: read input from file

public func day1task1() -> Int {
    return input
        .split { $0.isNewline }
        .map { Int($0)! }
        .reduce(0) { $0 + fuelRequirements(mass: $1) }
}

public func day1task2() -> Int {
    return input
        .split { $0.isNewline }
        .map { Int($0)! }
        .reduce(0) { $0 + totalFuelRequirements(moduleMass: $1) }
}
