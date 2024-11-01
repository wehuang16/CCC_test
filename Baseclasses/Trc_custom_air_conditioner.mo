within CCC_test.Baseclasses;
model Trc_custom_air_conditioner

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

              parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";

                  parameter Real TSupCooSet(unit="K")=273.15+12
    "Ccooling supply temperature setpoint";
        parameter Real TSupHeaSet(unit="K")=273.15+35
    "Heating supply temperature setpoint";
            parameter Real HeaCooCap(unit="J")=50000
    "Heater cooler capacity";
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mRec_flow_nominal)
    "Fan"
    annotation (Placement(transformation(extent={{-118,-38},{-98,-18}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                hea(
    redeclare final package Medium = MediumAir,
    m_flow_nominal=mRec_flow_nominal,
    dp_nominal=200,
    show_T=true,
    Q_flow_nominal=1)
    "Ideal heater"
    annotation (Placement(transformation(extent={{-78,-36},{-58,-16}})));
  Modelica.Blocks.Math.Gain        gain1(k=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-214,-24},{-194,-4}})));
  Modelica.Blocks.Math.Gain        gain(k=HeaCooCap)
    annotation (Placement(transformation(extent={{-170,30},{-150,50}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=300,
    kHeaCon=0.3,
    TiHeaCon=300)
    annotation (Placement(transformation(extent={{-16,12},{4,32}})));
  Modelica.Blocks.Sources.Constant const2(k=TCooSet)
    annotation (Placement(transformation(extent={{-66,26},{-46,46}})));
  Modelica.Blocks.Sources.Constant const3(k=THeaSet)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{42,2},{62,22}})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-40,-58},{-20,-38}})));
  Modelica.Blocks.Interfaces.RealInput ZAT annotation (Placement(transformation(
          extent={{-140,44},{-100,84}}), iconTransformation(extent={{-140,44},{-100,
            84}})));
  Modelica.Blocks.Interfaces.RealOutput totalCoolingPower annotation (Placement(
        transformation(extent={{100,-12},{140,28}}), iconTransformation(extent=
            {{100,-12},{140,28}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{-114,-84},{-94,
            -64}}), iconTransformation(extent={{-114,-84},{-94,-64}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{98,-86},{118,-66}}),
        iconTransformation(extent={{98,-86},{118,-66}})));
  CCC.Controls.Dehumidifier dehumidifier
    annotation (Placement(transformation(extent={{64,-86},{84,-66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-24,-96},{-4,-76}})));
  Buildings.Controls.Continuous.LimPID conPIDHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-68,-130},{-48,-110}})));
  Buildings.Controls.Continuous.LimPID conPIDCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-54,-182},{-34,-162}})));
  Modelica.Blocks.Sources.Constant const1(k=TSupCooSet)
    annotation (Placement(transformation(extent={{-118,-188},{-98,-168}})));
  Modelica.Blocks.Sources.Constant const4(k=TSupHeaSet)
    annotation (Placement(transformation(extent={{-116,-134},{-96,-114}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                               greaterEqualThreshold
    annotation (Placement(transformation(extent={{32,-162},{52,-142}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{76,-162},{96,-142}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-176,-30},{-156,-10}})));
  Modelica.Blocks.Sources.Constant const5(k=0.05)
    annotation (Placement(transformation(extent={{-208,-66},{-188,-46}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{70,-48},{90,-28}})));
  Modelica.Blocks.Sources.Constant const6(k=0.5)
    annotation (Placement(transformation(extent={{-164,-90},{-144,-70}})));
equation
  connect(fan.port_b,hea.port_a)
    annotation (Line(points={{-98,-28},{-84,-28},{-84,-26},{-78,-26}},
                                                color={0,127,255}));
  connect(const2.y,conLoo. TCooSet)
    annotation (Line(points={{-45,36},{-28,36},{-28,28},{-18,28}},
                                                         color={0,0,127}));
  connect(const3.y,conLoo. THeaSet)
    annotation (Line(points={{-39,0},{-28,0},{-28,16},{-18,16}},
                                                          color={0,0,127}));
  connect(conLoo.yCoo,add. u1) annotation (Line(points={{6,28},{32,28},{32,18},
          {40,18}}, color={0,0,127}));
  connect(conLoo.yHea,add. u2) annotation (Line(points={{6,16},{30,16},{30,6},{
          40,6}},    color={0,0,127}));
  connect(add.y,gain. u) annotation (Line(points={{63,12},{68,12},{68,92},{-182,
          92},{-182,40},{-172,40}},
                           color={0,0,127}));
  connect(hea.Q_flow, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-57,-20},{-48,-20},{-48,-40},{-50,-40},{-50,-48},
          {-42,-48}},                                              color={0,0,127}));
  connect(conLoo.TZon, ZAT) annotation (Line(points={{-18,22},{-32,22},{-32,64},
          {-120,64}},color={0,0,127}));
  connect(port_a, fan.port_a) annotation (Line(points={{-104,-74},{-104,-44},{
          -124,-44},{-124,-28},{-118,-28}},
                           color={0,127,255}));
  connect(dehumidifier.port_b, port_b) annotation (Line(points={{85,-75.8},{96.5,
          -75.8},{96.5,-76},{108,-76}}, color={0,127,255}));
  connect(hea.port_b, senTem.port_a) annotation (Line(points={{-58,-26},{-50,
          -26},{-50,-38},{-52,-38},{-52,-86},{-24,-86}},
                                color={0,127,255}));
  connect(senTem.port_b, dehumidifier.port_a) annotation (Line(points={{-4,-86},
          {58,-86},{58,-76.2},{62.6,-76.2}}, color={0,127,255}));
  connect(senTem.T, conPIDHea.u_m) annotation (Line(points={{-14,-75},{-4,-75},
          {-4,-74},{6,-74},{6,-132},{-58,-132}}, color={0,0,127}));
  connect(senTem.T, conPIDCoo.u_m) annotation (Line(points={{-14,-75},{2,-75},{
          2,-76},{14,-76},{14,-184},{-44,-184}}, color={0,0,127}));
  connect(const4.y, conPIDHea.u_s) annotation (Line(points={{-95,-124},{-80,
          -124},{-80,-120},{-70,-120}}, color={0,0,127}));
  connect(const1.y, conPIDCoo.u_s) annotation (Line(points={{-97,-178},{-66,
          -178},{-66,-172},{-56,-172}}, color={0,0,127}));
  connect(add.y, greaterEqualThreshold.u) annotation (Line(points={{63,12},{68,
          12},{68,-4},{40,-4},{40,-40},{42,-40},{42,-136},{22,-136},{22,-152},{
          30,-152}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, switch1.u2)
    annotation (Line(points={{53,-152},{74,-152}}, color={255,0,255}));
  connect(conPIDHea.y, switch1.u1) annotation (Line(points={{-47,-120},{66,-120},
          {66,-144},{74,-144}}, color={0,0,127}));
  connect(conPIDCoo.y, switch1.u3) annotation (Line(points={{-33,-172},{66,-172},
          {66,-160},{74,-160}}, color={0,0,127}));
  connect(switch1.y, gain1.u) annotation (Line(points={{97,-152},{102,-152},{
          102,-196},{-226,-196},{-226,-14},{-216,-14}}, color={0,0,127}));
  connect(gain1.y, max1.u1)
    annotation (Line(points={{-193,-14},{-178,-14}}, color={0,0,127}));
  connect(const5.y, max1.u2) annotation (Line(points={{-187,-56},{-180,-56},{
          -180,-36},{-186,-36},{-186,-26},{-178,-26}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, add1.u1)
    annotation (Line(points={{-18,-53.8},{-18,-54},{60,-54},{60,-32},{68,-32}},
        color={0,0,127}));
  connect(dehumidifier.latCooPow, add1.u2) annotation (Line(points={{79.4,-87},
          {79.4,-44},{68,-44}}, color={0,0,127}));
  connect(add1.y, totalCoolingPower) annotation (Line(points={{91,-38},{98,-38},
          {98,-18},{94,-18},{94,8},{120,8}}, color={0,0,127}));
  connect(gain.y, hea.u) annotation (Line(points={{-149,40},{-150,40},{-150,-8},
          {-88,-8},{-88,-20},{-80,-20}}, color={0,0,127}));
  connect(max1.y, fan.m_flow_in) annotation (Line(points={{-155,-20},{-148,-20},
          {-148,-6},{-108,-6},{-108,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Trc_custom_air_conditioner;
