within CCC_test.ESTCP;
function LewisFactor_x
  "Calculate the Lewis factor based on absulute fraction of air and air at saturated water"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.MassFraction x_w_sw
    "Saturated water mass fraction per mass of dry air at the contact water temperature";
  input Modelica.Units.SI.MassFraction x_w
    "Water mass fraction per mass of dry air";
  output Real Le(unit="1")
    "Lewis factor";
algorithm
  Le:=0.865^0.667*((x_w_sw+0.622)/(x_w+0.622)-1)/log((x_w_sw+0.622)/(x_w+0.622));
end LewisFactor_x;
