within CCC_test.obsolete;
model Trc_fcu_air_conditioner

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
            parameter Real HeaCooCap(unit="J")=50000
    "Heater cooler capacity";
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mRec_flow_nominal)
    "Fan"
    annotation (Placement(transformation(extent={{-116,-44},{-96,-24}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                hea(
    redeclare final package Medium = MediumAir,
    m_flow_nominal=mRec_flow_nominal,
    dp_nominal=200,
    show_T=true,
    Q_flow_nominal=1)
    "Ideal heater"
    annotation (Placement(transformation(extent={{-76,-42},{-56,-22}})));
  Modelica.Blocks.Sources.Constant const(k=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-178,-28},{-158,-8}})));
  Modelica.Blocks.Math.Gain        gain(k=HeaCooCap)
    annotation (Placement(transformation(extent={{-106,-6},{-86,14}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=300,
    kHeaCon=0.3,
    TiHeaCon=300)
    annotation (Placement(transformation(extent={{2,26},{22,46}})));
  Modelica.Blocks.Sources.Constant const2(k=TCooSet)
    annotation (Placement(transformation(extent={{-48,40},{-28,60}})));
  Modelica.Blocks.Sources.Constant const3(k=THeaSet)
    annotation (Placement(transformation(extent={{-42,4},{-22,24}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{56,14},{76,34}})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-22,-44},{-2,-24}})));
  Modelica.Blocks.Continuous.Integrator coolingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{34,-52},{54,-32}})));
  Modelica.Blocks.Continuous.Integrator heatingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{26,-20},{46,0}})));
  Modelica.Blocks.Interfaces.RealInput ZAT annotation (Placement(transformation(
          extent={{-140,44},{-100,84}}), iconTransformation(extent={{-140,44},{-100,
            84}})));
  Modelica.Blocks.Interfaces.RealOutput heatingEnergy annotation (Placement(
        transformation(extent={{100,56},{140,96}}), iconTransformation(extent={{
            100,56},{140,96}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy annotation (Placement(
        transformation(extent={{100,-12},{140,28}}), iconTransformation(extent={
            {100,-12},{140,28}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{-114,-84},{-94,
            -64}}), iconTransformation(extent={{-114,-84},{-94,-64}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{98,-86},{118,-66}}),
        iconTransformation(extent={{98,-86},{118,-66}})));
equation
  connect(fan.port_b,hea.port_a)
    annotation (Line(points={{-96,-34},{-82,-34},{-82,-32},{-76,-32}},
                                                color={0,127,255}));
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-157,-18},{-114,-18},
          {-114,-14},{-106,-14},{-106,-22}},
                      color={0,0,127}));
  connect(gain.y,hea. u)
    annotation (Line(points={{-85,4},{-80,4},{-80,-16},{-86,-16},{-86,-26},{-78,
          -26}},                                          color={0,0,127}));
  connect(const2.y,conLoo. TCooSet)
    annotation (Line(points={{-27,50},{-10,50},{-10,42},{0,42}},
                                                         color={0,0,127}));
  connect(const3.y,conLoo. THeaSet)
    annotation (Line(points={{-21,14},{-10,14},{-10,30},{0,30}},
                                                          color={0,0,127}));
  connect(conLoo.yCoo,add. u1) annotation (Line(points={{24,42},{46,42},{46,30},
          {54,30}}, color={0,0,127}));
  connect(conLoo.yHea,add. u2) annotation (Line(points={{24,30},{44,30},{44,18},
          {54,18}},  color={0,0,127}));
  connect(add.y,gain. u) annotation (Line(points={{77,24},{82,24},{82,8},{-16,8},
          {-16,-2},{-76,-2},{-76,22},{-116,22},{-116,4},{-108,4}},
                           color={0,0,127}));
  connect(hea.Q_flow, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-55,-26},{-46,-26},{-46,-34},{-24,-34}},
                                                                   color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,
    heatingEnergy0.u) annotation (Line(points={{0,-30.4},{14,-30.4},{14,-10},{
          24,-10}},   color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    coolingEnergy0.u) annotation (Line(points={{0,-39.8},{24,-39.8},{24,-42},{
          32,-42}},   color={0,0,127}));
  connect(conLoo.TZon, ZAT) annotation (Line(points={{0,36},{-22,36},{-22,34},{
          -120,34},{-120,64}},
                     color={0,0,127}));
  connect(coolingEnergy0.y, coolingEnergy) annotation (Line(points={{55,-42},{
          120,-42},{120,8}},     color={0,0,127}));
  connect(heatingEnergy0.y, heatingEnergy) annotation (Line(points={{47,-10},{
          94,-10},{94,76},{120,76}},                                     color={
          0,0,127}));
  connect(port_a, fan.port_a) annotation (Line(points={{-104,-74},{-104,-50},{
          -122,-50},{-122,-34},{-116,-34}},
                           color={0,127,255}));
  connect(hea.port_b, port_b) annotation (Line(points={{-56,-32},{54,-32},{54,
          -76},{108,-76}},      color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Trc_fcu_air_conditioner;
