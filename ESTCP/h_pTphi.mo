within CCC_test.ESTCP;
function h_pTphi
  "Specific enthalpy for given pressure, dry bulb temperature and relative humidity"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Pressure p "Absolute pressure of the medium";
  input Modelica.Units.SI.Temperature TDryBul "Dry bulb temperature";
  input Real phi(unit="1") "Relative humidity";
  output Real h(
    final quantity="SpecificEnergy",
    final unit="J/kg")
    "Specific enthalpy";

protected

  Real TDryBul_degC(
    final unit="degC",
    displayUnit="degC")
    "Dry bulb temperature in degree Celsius";
  Real p_w(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="Pa")
    "Water vapor pressure";
  Real x_w(
    final unit="1")
    "Water vapor mass fraction in kg per kg dry air";

algorithm
  TDryBul_degC:=TDryBul - 273.15;
  p_w:=phi*Buildings.Utilities.Psychrometrics.Functions.saturationPressure(
    TDryBul);
  x_w:=0.6219647130774989*p_w/(p - p_w);
  h:=1006*TDryBul_degC+x_w*(2501014.5+1860*TDryBul_degC);
  annotation (
    Documentation(info="<html>
<p>
Specific enthalpy of air for given pressure,
dry bulb temperature and relative humidity.
</p>
<p>
Note that the specific enthalpy is in <i>kg/kg</i>
dry air, and not total air.
</p>
</html>",
revisions="<html>
<ul>
<li>
April 4, 2019 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end h_pTphi;
