within CCC_test.HIL_testing;
model testSpeedControlledPump


              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  constant Integer numZon=3 "Total number of served VAV boxes";
   parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.45 "Nominal mass flow rate";


  parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(redeclare package Medium =
        MediumAir,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,0})))
                                                               "Supply air fan"
    annotation (Placement(transformation(extent={{18,-4},{38,16}})));

  Modelica.Blocks.Sources.Constant FanSpeed1(k=0.3)
    annotation (Placement(transformation(extent={{-44,32},{-24,52}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb(
    redeclare package Medium = MediumAir,
    T=293.15,
      nPorts=1) "Ambient conditions"
    annotation (Placement(transformation(extent={{-68,-6},{-46,16}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb1(redeclare package Medium = MediumAir,
      nPorts=1) "Ambient conditions"
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={83,13})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(final nout=
        numZon)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-154,12},{-134,32}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(final nout=
        numZon)
    "Replicate real input"
    annotation (Placement(transformation(extent={{-68,78},{-48,98}})));
  Modelica.Blocks.Sources.Constant const(k=3600*5)
    annotation (Placement(transformation(extent={{-204,58},{-184,78}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep1(final nout=
        numZon)
    "Replicate real input"
    annotation (Placement(transformation(extent={{-150,-42},{-130,-22}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 19)
    annotation (Placement(transformation(extent={{-234,-30},{-214,-10}})));
  hil_flexlab_model.Test1.BaseClasses1.ModeAndSetPoints TZonSet1(
    final TZonHeaOn=(273.15 + 21.1) + 273.15,
    final TZonHeaOff=(273.15 + 21.1) + 273.15,
    TZonCooOn=(273.15 + 23.3) + 273.15,
    final TZonCooOff=(273.15 + 23.3) + 273.15) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{10,72},{30,92}})));
equation
  connect(FanSpeed1.y, fanSup.y)
    annotation (Line(points={{-23,42},{28,42},{28,18}}, color={0,0,127}));
  connect(fanSup.port_b, amb1.ports[1]) annotation (Line(points={{38,6},{66,6},{
          66,13},{72,13}}, color={0,127,255}));
  connect(amb.ports[1], fanSup.port_a) annotation (Line(points={{-46,5},{-14,5},
          {-14,6},{18,6}}, color={0,127,255}));
  connect(booleanConstant.y, booRep.u) annotation (Line(points={{-133,22},{-110,
          22},{-110,36},{-102,36}}, color={255,0,255}));
  connect(const.y, reaRep.u) annotation (Line(points={{-183,68},{-80,68},{-80,
          88},{-70,88}}, color={0,0,127}));
  connect(const1.y, reaRep1.u) annotation (Line(points={{-213,-20},{-160,-20},{
          -160,-32},{-152,-32}}, color={0,0,127}));
  connect(const.y, TZonSet1.tNexOcc) annotation (Line(points={{-183,68},{-80,68},
          {-80,104},{8,104},{8,91}}, color={0,0,127}));
  connect(booleanConstant.y, TZonSet1.uOcc) annotation (Line(points={{-133,22},
          {-110,22},{-110,72},{-32,72},{-32,88.025},{8,88.025}}, color={255,0,
          255}));
  connect(const1.y, TZonSet1.TZon) annotation (Line(points={{-213,-20},{-156,
          -20},{-156,6},{-74,6},{-74,28},{-50,28},{-50,70},{0,70},{0,85},{8,85}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testSpeedControlledPump;
