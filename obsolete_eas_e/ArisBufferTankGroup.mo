within CCC_test.obsolete_eas_e;
model ArisBufferTankGroup
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{276,-152},{296,-132}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol,
    T_start=311.15,
    fluidVolume=0.1,
    nPorts=6)
    annotation (Placement(transformation(extent={{322,-154},{342,-134}})));
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit(
    redeclare package Medium1 = MediumPropyleneGlycol,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=293.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{420,-180},{440,-160}})));
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit1(
    redeclare package Medium1 = MediumPropyleneGlycol,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=293.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{470,-250},{490,-230}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{366,-186},{386,-166}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                          fan1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
              annotation (Placement(transformation(extent={{372,-236},{392,-216}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={410,-126})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={470,-196})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{280,-280},{300,-260}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation1(
    redeclare package Medium = MediumPropyleneGlycol,
    T_start=311.15,
    fluidVolume=0.1,
    nPorts=6)
    annotation (Placement(transformation(extent={{334,-292},{354,-272}})));
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit2(
    redeclare package Medium1 = MediumPropyleneGlycol,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=293.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{540,-308},{560,-288}})));
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit3(
    redeclare package Medium1 = MediumPropyleneGlycol,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=293.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{590,-378},{610,-358}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{486,-314},{506,-294}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                          fan3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
              annotation (Placement(transformation(extent={{492,-364},{512,-344}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={530,-254})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan5(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={590,-324})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{266,-196},{286,-176}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{272,-338},{292,-318}})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={224,-192})));
  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={234,-368})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempBufferOutlet(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={328,-216})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempBufferOutlet1(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={354,-356})));
  CCC.Controls.SetpointController_constantSetpoint setpointController10(
    gain_value=0.6,
    setpoint=273.15 + 45,
    reverseActing=true)
    annotation (Placement(transformation(extent={{238,-168},{258,-148}})));
  CCC.Controls.SetpointController_constantSetpoint setpointController11(
    gain_value=0.6,
    setpoint=273.15 + 45,
    reverseActing=true)
    annotation (Placement(transformation(extent={{252,-314},{272,-294}})));
  CCC.Controls.FlowConstraintBreaker flowConstraintBreaker(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={202,-368})));
equation
  connect(const2.y, conservationEquation.Q_flow) annotation (Line(points={{297,
          -142},{297,-138},{320,-138}}, color={0,0,127}));
  connect(conservationEquation.ports[1], pump.port_a) annotation (Line(points={{330.333,
          -154},{330.333,-176},{366,-176}},          color={0,127,255}));
  connect(pump.port_b, fanCoilUnit.port_a1) annotation (Line(points={{386,-176},
          {412,-176},{412,-165.6},{419.8,-165.6}}, color={0,127,255}));
  connect(fanCoilUnit.port_b1, conservationEquation.ports[2]) annotation (Line(
        points={{440.2,-165.6},{448,-165.6},{448,-152},{352,-152},{352,-164},{
          331,-164},{331,-154}}, color={0,127,255}));
  connect(fanCoilUnit.m_flow_water, pump.m_flow_in) annotation (Line(points={{
          441.2,-161.8},{441.2,-152},{376,-152},{376,-164}}, color={0,0,127}));
  connect(conservationEquation.ports[3], fan1.port_a) annotation (Line(points={{331.667,
          -154},{331.667,-200},{364,-200},{364,-226},{372,-226}},
        color={0,127,255}));
  connect(fan1.port_b, fanCoilUnit1.port_a1) annotation (Line(points={{392,-226},
          {392,-235.6},{469.8,-235.6}}, color={0,127,255}));
  connect(fanCoilUnit1.m_flow_water, fan1.m_flow_in) annotation (Line(points={{
          491.2,-231.8},{500,-231.8},{500,-220},{404,-220},{404,-214},{382,-214}},
        color={0,0,127}));
  connect(fanCoilUnit1.port_b1, conservationEquation.ports[4]) annotation (Line(
        points={{490.2,-235.6},{500,-235.6},{500,-220},{404,-220},{404,-200},{
          332.333,-200},{332.333,-154}}, color={0,127,255}));
  connect(fanCoilUnit.port_b2, fan.port_a) annotation (Line(points={{419.8,-175},
          {410,-175},{410,-136}}, color={0,127,255}));
  connect(fanCoilUnit.m_flow_air, fan.m_flow_in) annotation (Line(points={{
          441.2,-178.2},{441.2,-188},{396,-188},{396,-144},{392,-144},{392,-126},
          {398,-126}}, color={0,0,127}));
  connect(fan2.port_a, fanCoilUnit1.port_b2) annotation (Line(points={{470,-206},
          {470,-220},{456,-220},{456,-245},{469.8,-245}}, color={0,127,255}));
  connect(fanCoilUnit1.m_flow_air, fan2.m_flow_in) annotation (Line(points={{
          491.2,-248.2},{500,-248.2},{500,-220},{452,-220},{452,-196},{458,-196}},
        color={0,0,127}));
  connect(const1.y, conservationEquation1.Q_flow) annotation (Line(points={{301,
          -270},{312,-270},{312,-276},{332,-276}}, color={0,0,127}));
  connect(conservationEquation1.ports[1], pump1.port_a) annotation (Line(points={{342.333,
          -292},{342.333,-304},{486,-304}},          color={0,127,255}));
  connect(pump1.port_b, fanCoilUnit2.port_a1) annotation (Line(points={{506,
          -304},{532,-304},{532,-293.6},{539.8,-293.6}}, color={0,127,255}));
  connect(fanCoilUnit2.port_b1, conservationEquation1.ports[2]) annotation (
      Line(points={{560.2,-293.6},{568,-293.6},{568,-280},{368,-280},{368,-292},
          {343,-292}}, color={0,127,255}));
  connect(fanCoilUnit2.m_flow_water, pump1.m_flow_in) annotation (Line(points={
          {561.2,-289.8},{561.2,-280},{496,-280},{496,-292}}, color={0,0,127}));
  connect(conservationEquation1.ports[3], fan3.port_a) annotation (Line(points={{343.667,
          -292},{343.667,-340},{480,-340},{480,-354},{492,-354}},
        color={0,127,255}));
  connect(fan3.port_b, fanCoilUnit3.port_a1) annotation (Line(points={{512,-354},
          {512,-363.6},{589.8,-363.6}}, color={0,127,255}));
  connect(fanCoilUnit3.m_flow_water, fan3.m_flow_in) annotation (Line(points={{
          611.2,-359.8},{620,-359.8},{620,-348},{524,-348},{524,-342},{502,-342}},
        color={0,0,127}));
  connect(fanCoilUnit3.port_b1, conservationEquation1.ports[4]) annotation (
      Line(points={{610.2,-363.6},{620,-363.6},{620,-348},{524,-348},{524,-328},
          {344.333,-328},{344.333,-292}}, color={0,127,255}));
  connect(fanCoilUnit2.port_b2, fan4.port_a) annotation (Line(points={{539.8,
          -303},{530,-303},{530,-264}}, color={0,127,255}));
  connect(fanCoilUnit2.m_flow_air, fan4.m_flow_in) annotation (Line(points={{
          561.2,-306.2},{561.2,-316},{516,-316},{516,-272},{512,-272},{512,-254},
          {518,-254}}, color={0,0,127}));
  connect(fan5.port_a, fanCoilUnit3.port_b2) annotation (Line(points={{590,-334},
          {590,-348},{576,-348},{576,-373},{589.8,-373}}, color={0,127,255}));
  connect(fanCoilUnit3.m_flow_air, fan5.m_flow_in) annotation (Line(points={{
          611.2,-376.2},{620,-376.2},{620,-348},{572,-348},{572,-324},{578,-324}},
        color={0,0,127}));
  connect(pump2.port_b, conservationEquation.ports[5]) annotation (Line(points=
          {{286,-186},{333,-186},{333,-154}}, color={0,127,255}));
  connect(pump3.port_b, conservationEquation1.ports[5]) annotation (Line(points
        ={{292,-328},{345,-328},{345,-292}}, color={0,127,255}));
  connect(jun3.port_2, pump2.port_a) annotation (Line(points={{234,-192},{252,
          -192},{252,-186},{266,-186}}, color={0,127,255}));
  connect(jun3.port_3, pump3.port_a) annotation (Line(points={{224,-202},{224,
          -328},{272,-328}}, color={0,127,255}));
  connect(conservationEquation.ports[6], tempBufferOutlet.port_a) annotation (
      Line(points={{333.667,-154},{328,-154},{328,-206}}, color={0,127,255}));
  connect(conservationEquation1.ports[6], tempBufferOutlet1.port_a) annotation (
     Line(points={{345.667,-292},{345.667,-346},{354,-346}}, color={0,127,255}));
  connect(tempBufferOutlet.port_b, jun4.port_3) annotation (Line(points={{328,
          -226},{328,-252},{234,-252},{234,-358}}, color={0,127,255}));
  connect(tempBufferOutlet1.port_b, jun4.port_1) annotation (Line(points={{354,
          -366},{354,-376},{256,-376},{256,-368},{244,-368}}, color={0,127,255}));
  connect(setpointController10.command, pump2.m_flow_in) annotation (Line(
        points={{259,-157.4},{259,-174},{276,-174}}, color={0,0,127}));
  connect(tempBufferOutlet.T, setpointController10.measurement) annotation (
      Line(points={{339,-216},{348,-216},{348,-164},{268,-164},{268,-140},{236,
          -140},{236,-159.2}}, color={0,0,127}));
  connect(setpointController11.command, pump3.m_flow_in) annotation (Line(
        points={{273,-303.4},{273,-316},{282,-316}}, color={0,0,127}));
  connect(tempBufferOutlet1.T, setpointController11.measurement) annotation (
      Line(points={{365,-356},{372,-356},{372,-304},{280,-304},{280,-288},{244,
          -288},{244,-305.2},{250,-305.2}}, color={0,0,127}));
  connect(flowConstraintBreaker.port_a, jun4.port_2) annotation (Line(points={{
          212.4,-369.6},{218.2,-369.6},{218.2,-368},{224,-368}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{160,
            -420},{640,-100}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{160,-420},{640,
            -100}})));
end ArisBufferTankGroup;
