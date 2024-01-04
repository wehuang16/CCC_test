within CCC_test.Examples;
model testAixLibHeatPump
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con = MediumPropyleneGlycol,
    redeclare package Medium_eva = MediumAir,
    useBusConnectorOnly=true,
    use_conCap=false,
    use_evaCap=false)
    annotation (Placement(transformation(extent={{2,0},{22,24}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={80,21})));
  Modelica.Blocks.Sources.Constant const1(k=0.06393)
    annotation (Placement(transformation(extent={{-60,56},{-40,76}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.3,
    duration=4320,
    offset=0.8,
    startTime=2160)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    m_flow=0.05,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-42,23})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)"
                                                                                                     annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-10,-22})));
  Modelica.Blocks.Sources.Constant nSet(final k=1) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-52,-4})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-66,-44},{-46,-24}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    m_flow=0.2,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={86,-35})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-84,-25})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{20,-44},{50,-10}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
equation
  connect(boundary1.ports[1], heatPump.port_a1) annotation (Line(points={{-32,
          23},{-4,23},{-4,18},{2,18}}, color={0,127,255}));
  connect(heatPump.port_b1, boundary2.ports[1]) annotation (Line(points={{22,18},
          {64,18},{64,21},{70,21}}, color={0,127,255}));
  connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-1.2,-22},{
          4.4,-22},{4.4,-1.6}}, color={0,0,127}));
  connect(nSet.y, heatPump.nSet) annotation (Line(points={{-43.2,-4},{-34,-4},{
          -34,14},{0.4,14}}, color={0,0,127}));
  connect(heatPump.modeSet, booleanConstant.y) annotation (Line(points={{0.4,10},
          {-30,10},{-30,-34},{-45,-34}}, color={255,0,255}));
  connect(boundary4.ports[1], heatPump.port_b2) annotation (Line(points={{-74,
          -25},{-74,-26},{-70,-26},{-70,-48},{-24,-48},{-24,6},{2,6}}, color={0,
          127,255}));
  connect(heatPump.port_a2, boundary3.ports[1]) annotation (Line(points={{22,6},
          {72,6},{72,-35},{76,-35}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPump;
