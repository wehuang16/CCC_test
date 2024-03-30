within CCC_test.obsolete_eas_e;
model ArisHeatPumpConfiguration_1HeatPump_03202024
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{16,20},{36,36}})));
  Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={170,2})));
  Modelica.Blocks.Interfaces.BooleanInput ModeHp
    "true for heating, false for cooling"
    annotation (Placement(transformation(extent={{-120,28},{-100,48}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumPropyleneGlycol) "space conditioning inlet"
    annotation (Placement(transformation(extent={{-114,72},{-94,92}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumPropyleneGlycol) "space conditioning outlet"
    annotation (Placement(transformation(extent={{154,72},{174,92}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumPropyleneGlycol) "domestic hot water inlet"
    annotation (Placement(transformation(extent={{-114,-96},{-94,-76}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumPropyleneGlycol) "domestic hot water outlet"
    annotation (Placement(transformation(extent={{154,-96},{174,-76}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-14})));
  Modelica.Blocks.Interfaces.BooleanInput DhwRequestPriority
    "True if domestic hot water is requested, so that domestic hot water should be prioritized and we shut off water supply to space conditioning buffer tanks"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={38,-120})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=1,
    use_inputFilter=false,
    riseTime=1)
    annotation (Placement(transformation(extent={{-34,60},{-14,80}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=1,
    use_inputFilter=false,
    riseTime=1)
    annotation (Placement(transformation(extent={{98,48},{118,68}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=1,
    use_inputFilter=false,
    riseTime=1)
    annotation (Placement(transformation(extent={{-26,-36},{-6,-16}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val4(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=1,
    use_inputFilter=false,
    riseTime=1)
    annotation (Placement(transformation(extent={{78,-42},{98,-22}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0, realFalse=1)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-62})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,-58})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{12,78},{32,98}})));
  Buildings.Fluid.Sensors.VolumeFlowRate HeaPumWatFlo(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,38})));
equation
  connect(aixlib_HP_3D_integrated.TOutAir, TOut) annotation (Line(points={{37.3,
          25.36},{156,25.36},{156,2},{170,2}},           color={0,0,127}));
  connect(ModeHp, aixlib_HP_3D_integrated.Mode) annotation (Line(points={{-110,38},
          {12,38},{12,40},{37.2,40},{37.2,29.6}},
                                              color={255,0,255}));
  connect(aixlib_HP_3D_integrated.TSupSet, TSupSet) annotation (Line(points={{14.9,
          24.88},{-96,24.88},{-96,-14},{-110,-14}},      color={0,0,127}));
  connect(port_a1, val1.port_a) annotation (Line(points={{-104,82},{-40,82},{
          -40,70},{-34,70}}, color={0,127,255}));
  connect(val1.port_b, aixlib_HP_3D_integrated.port_a) annotation (Line(points={{-14,70},
          {-10,70},{-10,33.6},{15,33.6}},         color={0,127,255}));
  connect(val2.port_b, port_b1)
    annotation (Line(points={{118,58},{164,58},{164,82}}, color={0,127,255}));
  connect(port_a2, val3.port_a) annotation (Line(points={{-104,-86},{-104,-26},
          {-26,-26}}, color={0,127,255}));
  connect(val3.port_b, aixlib_HP_3D_integrated.port_a) annotation (Line(points={{-6,-26},
          {-2,-26},{-2,33.6},{15,33.6}},           color={0,127,255}));
  connect(val4.port_b, port_b2) annotation (Line(points={{98,-32},{164,-32},{
          164,-86}}, color={0,127,255}));
  connect(DhwRequestPriority, booleanToReal.u) annotation (Line(points={{38,
          -120},{38,-84},{-50,-84},{-50,-74}}, color={255,0,255}));
  connect(DhwRequestPriority, booleanToReal1.u) annotation (Line(points={{38,
          -120},{38,-78},{48,-78},{48,-70}}, color={255,0,255}));
  connect(booleanToReal.y, val1.y) annotation (Line(points={{-50,-51},{-48,-51},
          {-48,90},{-24,90},{-24,82}}, color={0,0,127}));
  connect(booleanToReal.y, val2.y) annotation (Line(points={{-50,-51},{-18,-51},
          {-18,72},{108,72},{108,70}}, color={0,0,127}));
  connect(booleanToReal1.y, val3.y) annotation (Line(points={{48,-47},{48,-10},
          {-16,-10},{-16,-14}}, color={0,0,127}));
  connect(booleanToReal1.y, val4.y) annotation (Line(points={{48,-47},{48,-10},
          {88,-10},{88,-20}}, color={0,0,127}));
  connect(booleanConstant.y, aixlib_HP_3D_integrated.OnOff) annotation (Line(
        points={{33,88},{38,88},{38,42},{14.8,42},{14.8,29.6}},
                                                        color={255,0,255}));
  connect(aixlib_HP_3D_integrated.port_b, HeaPumWatFlo.port_a) annotation (Line(
        points={{36.8,33.44},{50,33.44},{50,38},{56,38}}, color={0,127,255}));
  connect(HeaPumWatFlo.port_b, val2.port_a) annotation (Line(points={{76,38},{
          92,38},{92,58},{98,58}}, color={0,127,255}));
  connect(HeaPumWatFlo.port_b, val4.port_a) annotation (Line(points={{76,38},{
          80,38},{80,-18},{74,-18},{74,-32},{78,-32}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            100}})));
end ArisHeatPumpConfiguration_1HeatPump_03202024;
