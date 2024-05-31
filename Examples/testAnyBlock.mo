within CCC_test.Examples;
model testAnyBlock

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.PressureDifference  dpValve_nominal=1;
  CCC.Fluid.BaseClasses.ArisRoomModel_4apartments_NoInfiltration_NewYork_v2_noStairs
    arisRoomModel_8apartments_NoInfiltration_NewYork_v2_1
    annotation (Placement(transformation(extent={{-74,-56},{-32,54}})));
  Modelica.Blocks.Sources.Constant LivingRoomGain[3](k=0)
    annotation (Placement(transformation(extent={{-126,26},{-106,46}})));
equation
  connect(LivingRoomGain.y,
    arisRoomModel_8apartments_NoInfiltration_NewYork_v2_1.SensibleGain_Liv)
    annotation (Line(points={{-105,36},{-82,36},{-82,47.4},{-75.4,47.4}}, color
        ={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
