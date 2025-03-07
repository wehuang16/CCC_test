within CCC_test.CCC_Model;
model BufferTankGroupUnitTest2
             extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
   parameter Integer numHeaPum=1 "number of heat pumps";
   parameter Integer numApa=2 "number of apartments";
parameter Integer numZon=54 "number of zones";
         parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  CCC.Fluid.BaseClasses.low_rise_rochester_designbuilder
                                      low_rise_rochester_designbuilder
    annotation (Placement(transformation(extent={{16,-2},{36,18}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator    reaScaRep(nout=
        numApa)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-90})));
  CCC.Fluid.BaseClasses.TRC_1BufferTank_3fcus_SimpleConstantAir
                                 tRC_1BufferTank_3fcus_SimpleConstantAir
                                                               [numApa](
      zone_temp_cooling_setpoint=297.04, zone_temp_heating_setpoint=294.26)
    annotation (Placement(transformation(extent={{20,-58},{68,-26}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 50)
    annotation (Placement(transformation(extent={{-100,56},{-80,76}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={12,59})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 7)
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-44,26},{-24,46}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=-0.1)
    annotation (Placement(transformation(extent={{200,10},{220,30}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{174,-72},{194,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Abs abs1
    annotation (Placement(transformation(extent={{230,-74},{250,-54}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=0.92)
    annotation (Placement(transformation(extent={{280,-72},{300,-52}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={220,-125})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{86,-134},{106,-114}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=0.92)
    annotation (Placement(transformation(extent={{50,44},{70,64}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=3)       annotation (Placement(transformation(extent={{104,50},
            {124,70}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol4(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=3)       annotation (Placement(transformation(extent={{18,-138},{38,
            -118}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        numApa)
    annotation (Placement(transformation(extent={{-34,-72},{-14,-52}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt[numApa](k=0)
    "Real inputs"
    annotation (Placement(transformation(extent={{-174,-38},{-154,-18}})));
  CCC.Controls.MultipleHeatPumpZoneController multipleHeatPumpZoneController(numHeaPum
      =numHeaPum, numApa=numApa)
    annotation (Placement(transformation(extent={{-128,-48},{-74,-28}})));
equation
  connect(low_rise_rochester_designbuilder.TOut, reaScaRep.u) annotation (Line(
        points={{25.8,19.2},{25.8,24},{84,24},{84,-102},{40,-102}}, color={0,0,127}));
  connect(reaScaRep.y, tRC_1BufferTank_3fcus_SimpleConstantAir.TOut)
    annotation (Line(points={{40,-78},{40,-66},{44.8,-66},{44.8,-60}}, color={0,
          0,127}));

  connect(low_rise_rochester_designbuilder.TAir[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].TZoneAir) annotation (Line(
        points={{38,1.72727},{46,1.72727},{46,6},{45.8,6},{45.8,-24.8}}, color=
          {0,0,127}));

  connect(low_rise_rochester_designbuilder.TAir[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].TZoneAir) annotation (Line(
        points={{38,1.83636},{46,1.83636},{46,6},{45.8,6},{45.8,-24.8}}, color=
          {0,0,127}));
/*
connect(low_rise_rochester_designbuilder.TAir[44:46], tRC_1BufferTank_3fcus[3].TZoneAir)
annotation (Line(points={{38,3.25455},{46,3.25455},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[47:49], tRC_1BufferTank_3fcus[4].TZoneAir)
annotation (Line(points={{38,3.36364},{46,3.36364},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[50:52], tRC_1BufferTank_3fcus[5].TZoneAir)
annotation (Line(points={{38,3.47273},{46,3.47273},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[53:55], tRC_1BufferTank_3fcus[6].TZoneAir)
annotation (Line(points={{38,3.58182},{46,3.58182},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));
*/
  connect(low_rise_rochester_designbuilder.port_b[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].port_a) annotation (Line(points=
          {{36.4,15.3636},{56,15.3636},{56,-8},{14,-8},{14,-31.4},{19.4,-31.4}},
        color={0,127,255}));

  connect(low_rise_rochester_designbuilder.port_b[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].port_a) annotation (Line(points=
          {{36.4,15.4182},{56,15.4182},{56,-8},{14,-8},{14,-31.4},{19.4,-31.4}},
        color={0,127,255}));
/*
connect(low_rise_rochester_designbuilder.port_b[44:46], tRC_1BufferTank_3fcus[3].port_a)
annotation (Line(points={{36.4,16.1273},{56,16.1273},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[47:49], tRC_1BufferTank_3fcus[4].port_a)
annotation (Line(points={{36.4,16.1818},{56,16.1818},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[50:52], tRC_1BufferTank_3fcus[5].port_a)
annotation (Line(points={{36.4,16.2364},{56,16.2364},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[53:55], tRC_1BufferTank_3fcus[6].port_a)
annotation (Line(points={{36.4,16.2909},{56,16.2909},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));
               */

  connect(low_rise_rochester_designbuilder.port_a[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].port_b) annotation (Line(points=
          {{15.6,15.3636},{8,15.3636},{8,-12},{74,-12},{74,-31.4},{68.6,-31.4}},
        color={0,127,255}));

  connect(low_rise_rochester_designbuilder.port_a[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].port_b) annotation (Line(points=
          {{15.6,15.4182},{8,15.4182},{8,-12},{74,-12},{74,-31.4},{68.6,-31.4}},
        color={0,127,255}));
/*
connect(low_rise_rochester_designbuilder.port_a[44:46], tRC_1BufferTank_3fcus[3].port_b)
annotation (Line(points={{15.6,16.1273},{8,16.1273},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[47:49], tRC_1BufferTank_3fcus[4].port_b)
annotation (Line(points={{15.6,16.1818},{8,16.1818},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[50:52], tRC_1BufferTank_3fcus[5].port_b)
annotation (Line(points={{15.6,16.2364},{8,16.2364},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[53:55], tRC_1BufferTank_3fcus[6].port_b)
annotation (Line(points={{15.6,16.2909},{8,16.2909},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));
*/
  connect(const6.y,switch1. u1) annotation (Line(points={{-79,66},{-54,66},{-54,
          44},{-46,44}},       color={0,0,127}));
  connect(const1.y,switch1. u3)
    annotation (Line(points={{-89,20},{-56,20},{-56,28},{-46,28}},
                                                             color={0,0,127}));
  connect(switch1.y,boundary4. T_in) annotation (Line(points={{-23,36},{-18,36},
          {-18,55.4},{0,55.4}},         color={0,0,127}));
  connect(greThr.y,switch1. u2) annotation (Line(points={{222,20},{264,20},{264,
          36},{-46,36}},  color={255,0,255}));
  connect(intToRea.y,greThr. u) annotation (Line(points={{196,-61},{196,-62},{204,
          -62},{204,4},{190,4},{190,20},{198,20}}, color={0,0,127}));
  connect(intToRea.y,abs1. u) annotation (Line(points={{196,-61},{196,-62},{220,
          -62},{220,-64},{228,-64}}, color={0,0,127}));
  connect(abs1.y,gai. u) annotation (Line(points={{252,-64},{270,-64},{270,-62},
          {278,-62}}, color={0,0,127}));
  connect(gai.y,pump2. m_flow_in) annotation (Line(points={{302,-62},{330,-62},{
          330,-112},{96,-112}},
                             color={0,0,127}));
  connect(pump2.port_b,boundary6. ports[1]) annotation (Line(points={{106,-124},
          {206,-124},{206,-125},{210,-125}},
                                     color={0,127,255}));
  connect(boundary4.ports[1], senTem1.port_a) annotation (Line(points={{22,59},{
          44,59},{44,54},{50,54}}, color={0,127,255}));
  connect(vol3.ports[1], senTem1.port_b) annotation (Line(points={{112.667,50},
          {112.667,44},{76,44},{76,54},{70,54}}, color={0,127,255}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.port_a5, vol3.ports[2:3])
    annotation (Line(points={{28,-25.8},{70,-25.8},{70,-6},{115.333,-6},{
          115.333,50}}, color={0,127,255}));
  connect(pump2.port_a, vol4.ports[1]) annotation (Line(points={{86,-124},{44,
          -124},{44,-144},{26.6667,-144},{26.6667,-138}}, color={0,127,255}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.port_b5, vol4.ports[2:3])
    annotation (Line(points={{28,-58.2},{2,-58.2},{2,-138},{29.3333,-138}},
        color={0,127,255}));
  connect(booScaRep.y, tRC_1BufferTank_3fcus_SimpleConstantAir.heaCooMod)
    annotation (Line(points={{-12,-62},{0,-62},{0,-39.8},{17.6,-39.8}}, color={
          255,0,255}));
  connect(conInt.y,multipleHeatPumpZoneController. reqDomHotWat) annotation (
      Line(points={{-152,-28},{-138,-28},{-138,-30},{-130,-30}},
                                                           color={255,127,0}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.RequestSpaCon,
    multipleHeatPumpZoneController.reqSpaCon) annotation (Line(points={{59.4,-60},
          {59.4,-68},{-4,-68},{-4,-78},{-140,-78},{-140,-42.6},{-130.2,-42.6}},
        color={255,127,0}));
  connect(multipleHeatPumpZoneController.heaCooMod, booScaRep.u) annotation (
      Line(points={{-72,-45.8},{-72,-62},{-36,-62}}, color={255,0,255}));
  connect(multipleHeatPumpZoneController.comHeaPumMod[1], intToRea.u)
    annotation (Line(points={{-72,-37.8},{4,-37.8},{4,-70},{162,-70},{162,-61},
          {172,-61}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=21600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end BufferTankGroupUnitTest2;
