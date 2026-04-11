within CCC_test.ESTCP;
function RightHandSide_dx_w
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.MassFlowRate m_w
    "Mass flow rate of water";
  input Modelica.Units.SI.MassFlowRate m_a
    "Mass flow rate of air";
  input Modelica.Units.SI.Pressure p "Absolute pressure of the medium";
  input Modelica.Units.SI.Temperature T_w "Water temperature";
  input Modelica.Units.SI.Temperature T_a "Dry bulb temperature";
  input Real phi(unit="1") "Relative humidity";
  output Real rhs_value "Output right-hand-side value";

protected
  Modelica.Units.SI.MassFraction x_w
    "Water vapor mass fraction per unit mass dry air";
  Modelica.Units.SI.MassFraction x_w_sw
    "Saturated water mass fraction per mass of dry air at the contact water temperature";
  Real Le(unit="1")
    "Lewis factor";

  Real h_ma(
    final quantity="SpecificEnergy",
    final unit="J/kg")
    "Specific enthalpy for the mixed air";
  Real h_masw(
    final quantity="SpecificEnergy",
    final unit="J/kg")
    "Specific enthalpy for the saturated mixed air at the contact water temperature";
  Real h_v(
    final quantity="SpecificEnergy",
    final unit="J/kg")
    "Specific enthalpy for vapor at the contact water temperature";
algorithm

  x_w := CCC_test.ESTCP.x_pTphi(p,T_a,phi);
  x_w_sw := CCC_test.ESTCP.x_pTphi(p,T_w,1);
  Le := CCC_test.ESTCP.LewisFactor_x(x_w_sw,x_w);
  h_ma := CCC_test.ESTCP.h_pTphi(p,T_a,phi);
  h_masw := CCC_test.ESTCP.h_pTphi(p,T_w,1);
  h_v :=2501014.5+1860*(T_w-273.15);
  rhs_value := 4184*m_w/m_a*(x_w_sw-x_w)/(h_masw-h_ma+(Le-1)*(h_masw-h_ma-(x_w_sw-x_w)*h_v)-(x_w_sw-x_w)*4184*T_w);



end RightHandSide_dx_w;
