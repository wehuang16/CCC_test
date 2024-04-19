within CCC_test.Examples;
model TestMultipleFluidPort

replaceable package Medium = Buildings.Media.Air;
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Interfaces.FluidPort_a port_a[2](redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-10},{-94,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b[2](redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2) annotation (Placement(transformation(extent={{-30,54},{10,94}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor1(
    zoneName="Level4:4RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2) annotation (Placement(transformation(extent={{-44,-68},{-4,-28}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/400_3rd_Street_v1.1_Aprt_4R_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-Downtown.Manhattan.Heli.720553_TMYx.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-Downtown.Manhattan.Heli.720553_TMYx.mos"))
    annotation (Placement(transformation(extent={{-150,38},{-130,58}})));

  Modelica.Blocks.Sources.Constant HeatGain_LBed1[3](each k=0)
    annotation (Placement(transformation(extent={{-88,62},{-68,82}})));
equation
  connect(port_a[1], nor.ports[1]) annotation (Line(points={{-104,-2.5},{-11,
          -2.5},{-11,54.9}}, color={0,127,255}));
  connect(HeatGain_LBed1.y, nor.qGai_flow) annotation (Line(points={{-67,72},{
          -40,72},{-40,84},{-32,84}}, color={0,0,127}));
  connect(HeatGain_LBed1.y, nor1.qGai_flow) annotation (Line(points={{-67,72},{
          -48,72},{-48,-30},{-54,-30},{-54,-38},{-46,-38}}, color={0,0,127}));
  connect(port_a[2], nor1.ports[1]) annotation (Line(points={{-104,2.5},{-82,
          2.5},{-82,-70},{-25,-70},{-25,-67.1}}, color={0,127,255}));
  connect(port_b[1], nor.ports[2]) annotation (Line(points={{104,-2.5},{-9,-2.5},
          {-9,54.9}}, color={0,127,255}));
  connect(port_b[2], nor1.ports[2]) annotation (Line(points={{104,2.5},{56,2.5},
          {56,-82},{-23,-82},{-23,-67.1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestMultipleFluidPort;
