
var deckConstraint =
    walkview.makeUnionConstraint(
        [
         walkview.makePolylinePath(
             [
              [-0.32,    0.00,   1.76],
              [ 6.45,    2.35,   1.15],
              [ 15.37,   1.49,   1.48],
              [ 15.37,  -1.49,   1.48],
              [ 6.45,   -2.35,   1.15],
              [-0.32,    0.00,   1.76],
             ],
             0.20)
        ]);

var walker = walkview.Walker.new("Walk View", deckConstraint);
