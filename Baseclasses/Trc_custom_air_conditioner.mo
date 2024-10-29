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
  Modelica.Blocks.Sources.Constant const(k=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
  Modelica.Blocks.Math.Gain        gain(k=HeaCooCap)
    annotation (Placement(transformation(extent={{-108,0},{-88,20}})));
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
  Modelica.Blocks.Continuous.Integrator coolingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{16,-66},{36,-46}})));
  Modelica.Blocks.Continuous.Integrator heatingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));
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
    annotation (Line(points={{-98,-28},{-84,-28},{-84,-26},{-78,-26}},
                                                color={0,127,255}));
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-159,-12},{-116,-12},
          {-116,-8},{-108,-8},{-108,-16}},
                      color={0,0,127}));
  connect(gain.y,hea. u)
    annotation (Line(points={{-87,10},{-82,10},{-82,-10},{-88,-10},{-88,-20},{
          -80,-20}},                                      color={0,0,127}));
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
  connect(add.y,gain. u) annotation (Line(points={{63,12},{68,12},{68,-4},{-30,
          -4},{-30,18},{-82,18},{-82,26},{-118,26},{-118,10},{-110,10}},
                           color={0,0,127}));
  connect(hea.Q_flow, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-57,-20},{-48,-20},{-48,-40},{-50,-40},{-50,-48},
          {-42,-48}},                                              color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,
    heatingEnergy0.u) annotation (Line(points={{-18,-44.4},{-8,-44.4},{-8,-24},
          {6,-24}},   color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    coolingEnergy0.u) annotation (Line(points={{-18,-53.8},{6,-53.8},{6,-56},{
          14,-56}},   color={0,0,127}));
  connect(conLoo.TZon, ZAT) annotation (Line(points={{-18,22},{-32,22},{-32,64},
          {-120,64}},color={0,0,127}));
  connect(coolingEnergy0.y, coolingEnergy) annotation (Line(points={{37,-56},{
          120,-56},{120,8}},     color={0,0,127}));
  connect(heatingEnergy0.y, heatingEnergy) annotation (Line(points={{29,-24},{
          174,-24},{174,76},{120,76}},                                   color={
          0,0,127}));
  connect(port_a, fan.port_a) annotation (Line(points={{-104,-74},{-104,-44},{
          -124,-44},{-124,-28},{-118,-28}},
                           color={0,127,255}));
  connect(hea.port_b, port_b) annotation (Line(points={{-58,-26},{54,-26},{54,
          -76},{108,-76}},      color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Trc_custom_air_conditioner;
