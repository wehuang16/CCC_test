within CCC_test.HIL_testing;
model testSpeedControlledPump2

              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  constant Integer numZon=3 "Total number of served VAV boxes";
   parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.45 "Nominal mass flow rate";

  parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";

  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-112,20},{-92,40}})));
  Modelica.Blocks.Sources.Constant const(k=3600*5)
    annotation (Placement(transformation(extent={{-204,58},{-184,78}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 19)
    annotation (Placement(transformation(extent={{-172,-22},{-152,-2}})));
  Modelica.Blocks.Sources.Constant FanSpeed1(k=0.3)
    annotation (Placement(transformation(extent={{80,-52},{100,-32}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb(
    redeclare package Medium = MediumAir,
    T=293.15,
    nPorts=1)   "Ambient conditions"
    annotation (Placement(transformation(extent={{22,-82},{44,-60}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(redeclare package Medium =
        MediumAir, per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10
             + dpBuiStaSet,0})))                               "Supply air fan"
    annotation (Placement(transformation(extent={{54,-82},{74,-62}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb1(redeclare package Medium = MediumAir,
      nPorts=1) "Ambient conditions"
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={101,-71})));
protected
  hil_flexlab_model.Test1.BaseClasses1.OperationMode
                opeModSel(
    have_winSen=true,
    final numZon=1,
    final preWarCooTim=300,
    final TZonFreProOn=543.3,
    final TZonFreProOff=545.3)         "Operation mode selector"
    annotation (Placement(transformation(extent={{4,48},{24,68}})));
equation
  connect(fanSup.port_b,amb1. ports[1]) annotation (Line(points={{74,-72},{74,
          -71},{90,-71}},  color={0,127,255}));
  connect(FanSpeed1.y,fanSup. y)
    annotation (Line(points={{101,-42},{106,-42},{106,-56},{72,-56},{72,-52},{
          64,-52},{64,-60}},                            color={0,0,127}));
  connect(amb.ports[1],fanSup. port_a) annotation (Line(points={{44,-71},{44,
          -72},{54,-72}},  color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testSpeedControlledPump2;
