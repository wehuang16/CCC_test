within CCC_test.HIL_testing;
model SpeedControlledPump_storage

              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

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
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           fanSup1(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)                "Supply air fan"
    annotation (Placement(transformation(extent={{-8,-34},{12,-14}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb2(redeclare package Medium = MediumA, T=
        293.15) "Ambient conditions"
    annotation (Placement(transformation(extent={{-78,-64},{-56,-42}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb3(redeclare package Medium = MediumA)
                "Ambient conditions"
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={91,-59})));
  hil_flexlab_model.Test1.BaseClasses1.ModeAndSetPoints TZonSet[numZon](
    final TZonHeaOn=fill(273.15 + 21.1, numZon),
    final TZonHeaOff=fill(273.15 + 21.1, numZon),
    TZonCooOn=fill(273.15 + 23.3, numZon),
    final TZonCooOff=fill(273.15 + 23.3, numZon)) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{-2,64},{18,84}})));
  Modelica.Blocks.Math.Gain gain[numZon](k=5)
    annotation (Placement(transformation(extent={{46,68},{66,88}})));
  hil_flexlab_model.Test1.BaseClasses1.ModeAndSetPoints TZonSet1(
    final TZonHeaOn=(273.15 + 21.1) + 273.15,
    final TZonHeaOff=(273.15 + 21.1) + 273.15,
    TZonCooOn=(273.15 + 23.3) + 273.15,
    final TZonCooOff=(273.15 + 23.3) + 273.15) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{38,-74},{58,-54}})));
equation
  connect(FanSpeed1.y, fanSup.y)
    annotation (Line(points={{-23,42},{28,42},{28,18}}, color={0,0,127}));
  connect(fanSup.port_b, amb1.ports[1]) annotation (Line(points={{38,6},{66,6},{
          66,13},{72,13}}, color={0,127,255}));
  connect(amb.ports[1], fanSup.port_a) annotation (Line(points={{-46,5},{-14,5},
          {-14,6},{18,6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SpeedControlledPump_storage;
