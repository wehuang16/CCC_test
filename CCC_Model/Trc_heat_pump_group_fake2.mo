within CCC_test.CCC_Model;
model Trc_heat_pump_group_fake2

    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate  mHpCon_flow_nominal=0.92;
  parameter Integer numHeaPum=3 "number of heat pumps";
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-112,-70},{-92,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-114,48},{-94,68}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{172,-70},{192,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{172,48},{192,68}})));
  Aixlib_AirToWaterHeatPump_3D_fake                aixlib_HP_3D_integrated[numHeaPum](
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333,
    mCon_flow_nominal=mHpCon_flow_nominal)
    annotation (Placement(transformation(extent={{36,-4},{72,22}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput  comHeaPumMod[numHeaPum]
    "a command of heat pump modes" annotation (Placement(transformation(extent={{-140,
            -20},{-100,20}}),      iconTransformation(extent={{-138,-22},{-98,
            18}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={110,122})));
  Modelica.Blocks.Interfaces.RealInput TSubSet_dhw annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-24,122})));
  Modelica.Blocks.Interfaces.RealInput TSubSet_sch annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={24,122})));
  Modelica.Blocks.Interfaces.RealInput TSubSet_scc annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={76,122}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={68,122})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numHeaPum) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={108,50})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr[
    numHeaPum] annotation (Placement(transformation(extent={{-28,-14},{-8,6}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu[numHeaPum]
    annotation (Placement(transformation(extent={{-32,16},{-12,36}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt[numHeaPum](k=0)
    annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[numHeaPum]
    annotation (Placement(transformation(extent={{14,44},{34,64}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi[numHeaPum]
    "check whether it is space heating or cooling"
    annotation (Placement(transformation(extent={{-26,-44},{-6,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1[numHeaPum]
    "whether it is running domestic hot water or not"
    annotation (Placement(transformation(extent={{44,-62},{64,-42}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr1[
    numHeaPum](t=2)
    annotation (Placement(transformation(extent={{-6,-78},{14,-58}})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=numHeaPum) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,74})));
  Modelica.Blocks.Routing.Replicator replicator2(nout=numHeaPum) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,84})));
  Modelica.Blocks.Routing.Replicator replicator3(nout=numHeaPum) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={76,76})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[numHeaPum](realTrue
      =mHpCon_flow_nominal)
                     "whether it is running domestic hot water or not"
    annotation (Placement(transformation(extent={{136,54},{156,74}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val[numHeaPum](
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    dpValve_nominal=1)
    annotation (Placement(transformation(extent={{-78,-30},{-58,-10}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1[numHeaPum](
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    dpValve_nominal=1)
    annotation (Placement(transformation(extent={{166,-4},{146,16}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1
                                                               [numHeaPum]
                     "whether it is running domestic hot water or not"
    annotation (Placement(transformation(extent={{64,-100},{84,-80}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    V=0.001,
    nPorts=numHeaPum+1)   annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    V=0.001,
    nPorts=numHeaPum+1)   annotation (Placement(transformation(extent={{152,84},{172,104}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    V=0.001,
    nPorts=numHeaPum+1)   annotation (Placement(transformation(extent={{-82,-86},{-62,-66}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHpCon_flow_nominal,
    V=0.001,
    nPorts=numHeaPum+1)   annotation (Placement(transformation(extent={{142,-84},{162,-64}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumPropyleneGlycol, nPorts=1)
    annotation (Placement(transformation(extent={{-178,48},{-158,68}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumPropyleneGlycol, nPorts=1)
    annotation (Placement(transformation(extent={{-160,-84},{-140,-64}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov[numHeaPum](
    redeclare package Medium = MediumPropyleneGlycol,
    addPowerToMedium=false,
    m_flow_nominal=mHpCon_flow_nominal)
    annotation (Placement(transformation(extent={{110,-4},{130,16}})));
equation
  connect(TOutAir, replicator.u) annotation (Line(points={{110,122},{110,70},{108,
          70},{108,62}}, color={0,0,127}));
  connect(replicator.y, aixlib_HP_3D_integrated.TOutAir) annotation (Line(
        points={{108,39},{106,39},{106,-2},{74.34,-2},{74.34,4.71}}, color={0,0,
          127}));
  connect(comHeaPumMod, intGreEquThr.u) annotation (Line(points={{-120,0},{-38,0},
          {-38,-4},{-30,-4}}, color={255,127,0}));
  connect(intGreEquThr.y, aixlib_HP_3D_integrated.Mode) annotation (Line(points={{-6,-4},
          {2,-4},{2,44},{92,44},{92,11.6},{74.16,11.6}},         color={255,0,255}));
  connect(comHeaPumMod, intEqu.u1) annotation (Line(points={{-120,0},{-42,0},{-42,
          26},{-34,26}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2) annotation (Line(points={{-104,34},{-44,34},{-44,
          18},{-34,18}}, color={255,127,0}));
  connect(intEqu.y, not1.u) annotation (Line(points={{-10,26},{0,26},{0,50},{-2,
          50},{-2,54},{12,54}}, color={255,0,255}));
  connect(not1.y, aixlib_HP_3D_integrated.OnOff) annotation (Line(points={{36,54},
          {38,54},{38,28},{22,28},{22,11.6},{33.84,11.6}}, color={255,0,255}));
  connect(swi.y, swi1.u3) annotation (Line(points={{-4,-34},{74,-34},{74,-68},{42,
          -68},{42,-60}}, color={0,0,127}));
  connect(intGreEquThr1.y, swi1.u2) annotation (Line(points={{16,-68},{34,-68},{
          34,-52},{42,-52}}, color={255,0,255}));
  connect(comHeaPumMod, intGreEquThr1.u) annotation (Line(points={{-120,0},{-38,
          0},{-38,-68},{-8,-68}}, color={255,127,0}));
  connect(swi1.y, aixlib_HP_3D_integrated.TSupSet) annotation (Line(points={{66,-52},
          {76,-52},{76,-12},{26,-12},{26,3.93},{34.02,3.93}},      color={0,0,127}));
  connect(TSubSet_dhw, replicator1.u) annotation (Line(points={{-24,122},{-24,94},
          {-26,94},{-26,86}}, color={0,0,127}));
  connect(replicator1.y, swi1.u1) annotation (Line(points={{-26,63},{-26,50},{-2,
          50},{-2,40},{20,40},{20,-44},{42,-44}}, color={0,0,127}));
  connect(TSubSet_sch, replicator2.u)
    annotation (Line(points={{24,122},{24,96}}, color={0,0,127}));
  connect(TSubSet_scc, replicator3.u)
    annotation (Line(points={{76,122},{76,88}}, color={0,0,127}));
  connect(replicator2.y, swi.u1) annotation (Line(points={{24,73},{24,68},{2,68},
          {2,46},{4,46},{4,-18},{-28,-18},{-28,-26}}, color={0,0,127}));
  connect(replicator3.y, swi.u3) annotation (Line(points={{76,65},{76,38},{18,38},
          {18,-50},{-28,-50},{-28,-42}}, color={0,0,127}));
  connect(intGreEquThr.y, swi.u2) annotation (Line(points={{-6,-4},{2,-4},{2,-26},
          {4,-26},{4,-52},{-36,-52},{-36,-34},{-28,-34}}, color={255,0,255}));
  connect(not1.y, booToRea.u) annotation (Line(points={{36,54},{92,54},{92,72},
          {124,72},{124,64},{134,64}}, color={255,0,255}));
  connect(intGreEquThr1.y, booToRea1.u) annotation (Line(points={{16,-68},{40,
          -68},{40,-90},{62,-90}}, color={255,0,255}));
  connect(val.port_2, aixlib_HP_3D_integrated.port_a) annotation (Line(points={{-58,-20},
          {-40,-20},{-40,-54},{24,-54},{24,18.1},{34.2,18.1}},           color=
          {0,127,255}));
  connect(booToRea1.y, val1.y) annotation (Line(points={{86,-90},{168,-90},{168,
          -16},{178,-16},{178,20},{156,20},{156,18}}, color={0,0,127}));
  connect(booToRea1.y, val.y) annotation (Line(points={{86,-90},{94,-90},{94,
          -74},{24,-74},{24,-84},{-44,-84},{-44,2},{-68,2},{-68,-8}}, color={0,
          0,127}));
  connect(port_a1, vol.ports[1]) annotation (Line(points={{-104,58},{-64,58},{
          -64,70}},    color={0,127,255}));
  connect(port_b1, vol1.ports[1]) annotation (Line(points={{182,58},{168,58},{
          168,78},{162,78},{162,84}},     color={0,127,255}));
  connect(port_b2, vol3.ports[1]) annotation (Line(points={{182,-60},{166,-60},
          {166,-88},{152,-88},{152,-84}},     color={0,127,255}));
  connect(port_a2, vol2.ports[1]) annotation (Line(points={{-102,-60},{-102,-92},
          {-72,-92},{-72,-86}},     color={0,127,255}));
  connect(vol2.ports[2:numHeaPum+1], val.port_3) annotation (Line(points={{-72,-86},
          {-68,-86},{-68,-30}},color={0,127,255}));
  connect(vol.ports[2:numHeaPum+1], val.port_1) annotation (Line(points={{-64,70},
          {-64,68},{-66,68},{-66,36},{-62,36},{-62,4},{-76,4},{-76,-6},{-82,-6},
          {-82,-20},{-78,-20}}, color={0,127,255}));
  connect(vol1.ports[2:numHeaPum+1], val1.port_1) annotation (Line(points={{162,84},
          {162,78},{168,78},{168,22},{170,22},{170,6},{166,6}},  color={0,127,
          255}));
  connect(vol3.ports[2:numHeaPum+1], val1.port_3) annotation (Line(points={{152,-84},
          {152,-88},{166,-88},{166,-8},{156,-8},{156,-4}},  color={0,127,255}));
  connect(port_a1, bou.ports[1])
    annotation (Line(points={{-104,58},{-158,58}}, color={0,127,255}));
  connect(port_a2, bou1.ports[1]) annotation (Line(points={{-102,-60},{-134,-60},
          {-134,-74},{-140,-74}}, color={0,127,255}));
  connect(booToRea.y,mov. m_flow_in) annotation (Line(points={{158,64},{104,64},
          {104,58},{96,58},{96,52},{94,52},{94,22},{112,22},{112,18},{120,18}},
                             color={0,0,127}));
  connect(aixlib_HP_3D_integrated.port_b,mov. port_a) annotation (Line(points={{73.44,
          17.84},{73.44,6},{110,6}},      color={0,127,255}));
  connect(mov.port_b, val1.port_2)
    annotation (Line(points={{130,6},{146,6}},           color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {180,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{180,100}})));
end Trc_heat_pump_group_fake2;
