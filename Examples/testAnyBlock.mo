within CCC_test.Examples;
model testAnyBlock

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant const(k=273.15 - 6)
    annotation (Placement(transformation(extent={{-56,28},{-36,48}})));
  Modelica.Blocks.Sources.Constant const1(k=4)
    annotation (Placement(transformation(extent={{-88,-4},{-68,16}})));
  Modelica.Blocks.Sources.Constant const2(k=9)
    annotation (Placement(transformation(extent={{-88,-50},{-68,-30}})));
  CCC.Controls.DesignInfiltration designInfiltration(desFloRat=0.04)
    annotation (Placement(transformation(extent={{6,18},{26,38}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/400_3rd_Street_v2.2_V960.idf"),

    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.epw"),

    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos"))
    annotation (Placement(transformation(extent={{-48,-8},{-28,12}})));
equation
  connect(const.y, designInfiltration.zonAirTem) annotation (Line(points={{-35,
          38},{-6,38},{-6,32.2},{4,32.2}}, color={0,0,127}));
  connect(building.weaBus, designInfiltration.weaBus) annotation (Line(
      points={{-28,2},{0,2},{0,22.6},{5.6,22.6}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
