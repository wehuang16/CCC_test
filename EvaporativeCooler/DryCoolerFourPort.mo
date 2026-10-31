within CCC_test.EvaporativeCooler;
model DryCoolerFourPort
   extends Buildings.Fluid.Interfaces.FourPortHeatMassExchanger;
  parameter Buildings.Fluid.HeatExchangers.CoolingTowers.Data.DryCooler.Generic
    dat "Performance data record"
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Interfaces.RealInput y(unit="1") "Fan control signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-182,10},{-142,50}})));
  Modelica.Blocks.Interfaces.RealOutput TLvg(final unit="K", displayUnit="degC")
    "Leaving water temperature"
    annotation (Placement(transformation(extent={{100,100},{120,120}}),
        iconTransformation(extent={{232,6},{252,26}})));
  Modelica.Blocks.Interfaces.RealOutput TLvgAir(final unit="K", displayUnit=
        "degC") "Leaving water temperature" annotation (Placement(
        transformation(extent={{100,-120},{120,-100}}), iconTransformation(
          extent={{136,-146},{156,-126}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.Fluid.Sensors.Temperature TDryBulIn
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
protected
  Modelica.Blocks.Sources.RealExpression TCooIn(final y=Medium.temperature(
        Medium.setState_phX(
          p=port_a.p,
          h=inStream(port_a.h_outflow),
          X=inStream(port_a.Xi_outflow)))) "Cooling loop fluid inlet temperature" annotation(
    Placement(transformation(extent={{-100,-24},{-80,-6}})));
  Modelica.Blocks.Sources.RealExpression mCoo_flow(final y=port_a.m_flow)   "Cooling fluid mass flow rate" annotation(
    Placement(transformation(extent={{-100,-38},{-80,-20}})));
  Buildings.Fluid.HeatExchangers.CoolingTowers.BaseClasses.DryCooler per(
    redeclare final package Medium = Medium,
    final dat=dat,
    final m_flow_nominal=m_flow_nominal,
    final yMin=yMin)   "Model for thermal performance" annotation(
    Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TVol
    "Water temperature in volume, leaving at port_b"
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TVolAir
    "Water temperature in volume, leaving at port_b"
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaAir
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
equation
  connect(per.y,y)  annotation(
    Line(points={{-22,-2},{-40,-2},{-40,20},{-120,20}},          color = {0, 0, 127}));
  connect(TCooIn.y,per. TCooIn) annotation(
    Line(points={{-79,-15},{-52,-15},{-52,-14},{-22,-14}},      color = {0, 0, 127}));
  connect(preHea.port, TVol.port)
    annotation (Line(points={{-20,110},{20,110}}, color={191,0,0}));
  connect(TVol.T, TLvg)
    annotation (Line(points={{41,110},{110,110}}, color={0,0,127}));
  connect(per.Q_flow, preHea.Q_flow) annotation (Line(points={{1,-10},{40,-10},
          {40,40},{-48,40},{-48,110},{-40,110}}, color={0,0,127}));
  connect(preHea.port, vol1.heatPort) annotation (Line(points={{-20,110},{-18,
          110},{-18,60},{-10,60}}, color={191,0,0}));
  connect(per.Q_flow, gai.u)
    annotation (Line(points={{1,-10},{58,-10}}, color={0,0,127}));
  connect(gai.y, preHeaAir.Q_flow) annotation (Line(points={{82,-10},{90,-10},{
          90,-40},{-52,-40},{-52,-110},{-40,-110}}, color={0,0,127}));
  connect(preHeaAir.port, TVolAir.port)
    annotation (Line(points={{-20,-110},{20,-110}}, color={191,0,0}));
  connect(TVolAir.T, TLvgAir)
    annotation (Line(points={{41,-110},{110,-110}}, color={0,0,127}));
  connect(preHeaAir.port, vol2.heatPort) annotation (Line(points={{-20,-110},{
          18,-110},{18,-60},{12,-60}}, color={191,0,0}));
  connect(preDro2.port_b, TDryBulIn.port) annotation (Line(points={{60,-80},{2,
          -80},{2,-90},{-80,-90}}, color={0,127,255}));
  connect(TDryBulIn.T, per.TDryBul) annotation (Line(points={{-73,-80},{-40,-80},
          {-40,-6},{-22,-6}}, color={0,0,127}));
  connect(mCoo_flow.y, per.m_flow) annotation (Line(points={{-79,-29},{-51.5,
          -29},{-51.5,-18},{-22,-18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DryCoolerFourPort;
