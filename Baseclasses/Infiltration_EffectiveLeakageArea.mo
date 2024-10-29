within CCC_test.Baseclasses;
model Infiltration_EffectiveLeakageArea

    parameter Real schFra=1 "schedule fraction";
    parameter Real staCoe=0.00029 "stack coefficient";
    parameter Real winCoe=0.000231 "wind coefficient";
    parameter Real effAirLeaAre=100 "Effective Air Leakage Area in cm2";
    parameter Real airDen=1.2 "air density in kg/m3";

  Modelica.Blocks.Interfaces.RealInput zonAirTem "zone air temperature"
    annotation (Placement(transformation(extent={{-140,22},{-100,62}})));
  Modelica.Blocks.Interfaces.RealOutput infFloRat
    "infiltration flow rate in kg/s"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));

  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-126,-74},{-86,-34}}),
                                                     iconTransformation(extent={{-114,
            -64},{-94,-44}})));
protected
  Modelica.Blocks.Interfaces.RealOutput TDryBul
    annotation (Placement(transformation(extent={{100,42},{140,82}})));
  Modelica.Blocks.Interfaces.RealOutput winSpe
    annotation (Placement(transformation(extent={{100,-88},{140,-48}})));
equation
  infFloRat = schFra*effAirLeaAre*sqrt(staCoe*abs(zonAirTem-TDryBul)+winCoe*winSpe^2)/1000*airDen;

  connect(weaBus.TDryBul, TDryBul) annotation (Line(
      points={{-105.9,-53.9},{94,-53.9},{94,62},{120,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, winSpe) annotation (Line(
      points={{-105.9,-53.9},{94,-53.9},{94,-68},{120,-68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Infiltration_EffectiveLeakageArea;
