within CCC_test.EvaporativeCooler;
model IndirectDryTest2 "Indirect dry evaporative cooler"
  //extends Buildings.Fluid.Interfaces.PartialFourPortParallel;

  replaceable package Medium1 =
    Modelica.Media.Interfaces.PartialMedium
    "Medium to be cooled"
    annotation (choices(
      choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
      choice(redeclare package Medium = Buildings.Media.Water "Water"),
      choice(redeclare package Medium =
            Buildings.Media.Antifreeze.PropyleneGlycolWater (
        property_T=293.15,
        X_a=0.40)
        "Propylene glycol water, 40% mass fraction")));
  replaceable package Medium2 =
    Modelica.Media.Interfaces.PartialMedium
    "Medium rejected to outdoor air"
    annotation (choices(
      choice(redeclare package Medium = Buildings.Media.Air "Moist air")));
  parameter Modelica.Units.SI.Pressure dp1_nominal
    "Nominal heat exchanger pressure drop of medium flow to be cooled";
  parameter Modelica.Units.SI.Pressure dp2_nominal
    "Nominal heat exchanger pressure drop of medium rejected to outdoor air";
  parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal
    "Nominal heat exchanger mass flow rate of medium to be cooled";
  final parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=per.v_nominal*padAre*Medium2.dStp
    "Nominal heat exchanger mass flow rate of medium rejected to outdoor air";
  parameter Modelica.Units.SI.Area padAre
    "Area of the rigid media evaporative pad";
  replaceable parameter Buildings.Fluid.Humidifiers.EvaporativeCoolers.Data.Generic per
    constrainedby Buildings.Fluid.Humidifiers.EvaporativeCoolers.Data.Generic
    "Record with performance data for evaporative pads"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-60,-40},{-40,-20}})));
  parameter Buildings.Fluid.Humidifiers.EvaporativeCoolers.DryCoil.Data.Generic
    dat(
    Q_flow_nominal=-m1_flow_nominal*4200*(35 - 30),
    TCooIn_nominal=308.15,
    TCooOut_nominal=303.15,
    dp_nominal=dp1_nominal,
    TAirIn_nominal=298.15) "Performance data for dry cooler"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput evaCooAct
    "True: the evaporative cooling is active"
    annotation (Placement(transformation(extent={{-260,-40},{-220,0}}),
      iconTransformation(extent={{-110,-20},{-70,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dmWat_flow(
    final unit="kg/s",
    final quantity="MassFlowRate")
    "Water vapor mass flow rate difference between inlet and outlet of secondary air"
    annotation (Placement(transformation(origin={280,30},extent={{-20,-20},{20,20}}),
      iconTransformation(origin={90,-20},
                                        extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium1) annotation (Placement(transformation(extent={{-230,50},{-210,
            70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium1) annotation (Placement(transformation(extent={{250,50},{270,70}}),
        iconTransformation(extent={{90,50},{110,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium2, m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDro(
    redeclare final package Medium = Medium2,
    final m_flow_nominal=m2_flow_nominal,
    //final homotopyInitialization=homotopyInitialization,
    final dp_nominal=dp2_nominal) "Flow resistance"
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
              Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium2,
    nPorts=2,
    V=0.01,
    final m_flow_nominal=m2_flow_nominal) "Volume for fluid stream"
    annotation (Placement(transformation(extent={{159,-60},{179,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TLvg annotation (Placement(
        transformation(extent={{260,70},{300,110}}), iconTransformation(extent=
            {{70,0},{110,40}})));
  Buildings.Fluid.Movers.SpeedControlled_y
                           fan(
    redeclare package Medium = MediumA,
    per=BIDW12,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{200,-70},{220,-50}})));
  Modelica.Blocks.Interfaces.RealInput TDryBul(
    final min=0,
    final unit="K",
    displayUnit="degC") "Entering air dry bulb temperature"
    annotation (Placement(transformation(extent={{-260,-100},{-220,-60}}),
        iconTransformation(extent={{-130,-102},{-90,-62}})));
  Modelica.Blocks.Interfaces.RealInput yFan(final min=0)
    "Entering air dry bulb temperature" annotation (Placement(transformation(
          extent={{-260,0},{-220,40}}), iconTransformation(extent={{-130,-102},
            {-90,-62}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare final package Medium = MediumA,
    use_T_in=true,
    final nPorts=1) "Sink for secondary airflow"
    annotation (Placement(transformation(origin={-190,-60},extent={{10,-10},{-10,10}},
        rotation=180)));
  Buildings.Fluid.Sources.Boundary_pT sin2(redeclare final package Medium =
        MediumA, final nPorts=1)
                    "Sink for secondary airflow"
    annotation (Placement(transformation(origin={250,-60}, extent={{10,-10},{-10,10}},
        rotation=0)));
  parameter Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW12
                                              BIDW12
    annotation (Placement(transformation(extent={{180,-140},{220,-100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput PFan
    "Water vapor mass flow rate difference between inlet and outlet of secondary air"
    annotation (Placement(transformation(origin={280,-10}, extent={{-20,-20},{
            20,20}}), iconTransformation(origin={90,-20}, extent={{-20,-20},{20,
            20}})));
  Buildings.Fluid.Actuators.Dampers.Exponential
                                      damPad(
    dpDamper_nominal=10,
    dpFixed_nominal=10,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    from_dp=false,
    strokeTime=15) "Outdoor air damper"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Buildings.Fluid.Actuators.Dampers.Exponential damByp(
    dpDamper_nominal=10,
    dpFixed_nominal=10,
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    from_dp=false,
    strokeTime=15) "Outdoor air damper"
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
  Buildings.Fluid.FixedResistances.Junction spl1(
    redeclare package Medium = MediumA,
    tau=15,
    m_flow_nominal=mAir_flow_nominal*{1,1,1},
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    linearized=true) "Flow splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-150,-60})));
  Buildings.Fluid.FixedResistances.Junction spl2(
    redeclare package Medium = MediumA,
    tau=15,
    m_flow_nominal=mAir_flow_nominal*{1,1,1},
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    linearized=true) "Flow splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-60})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=1,
      realFalse=0)
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1(realTrue=0,
      realFalse=1)
    annotation (Placement(transformation(extent={{-160,30},{-140,50}})));
protected
  Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct dirEvaCoo(
    redeclare final package Medium = Medium2,
    final padAre=padAre,
    per(final efficiency=per.efficiency,
      final v_nominal=per.v_nominal,
      final dp_nominal=per.dp_nominal,
      final n=per.n))
    "Direct evaporative cooler for representing the cooling effect on the secondary air"
    annotation (Placement(transformation(origin={-50,-60},
                                                         extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Humidifiers.EvaporativeCoolers.DryCoil.DryCoil dryCoil(
      redeclare package Medium = Medium1, dat=dat)
    "Heat exchanger for heat transfer between primary and secondary air"
    annotation (Placement(transformation(origin={90,60}, extent={{-10,-10},{10,
            10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
equation
  connect(dirEvaCoo.dmWat_flow, dmWat_flow)
    annotation (Line(points={{-41,-56},{-20,-56},{-20,30},{280,30}},
                                                                 color={0,0,127}));
  connect(evaCooAct, dirEvaCoo.evaCooAct)
    annotation (Line(points={{-240,-20},{-80,-20},{-80,-64},{-59,-64}},
      color={255,0,255}));
  connect(preHea.port,vol. heatPort) annotation (Line(points={{140,-20},{150,
          -20},{150,-70},{159,-70}}, color={191,0,0}));
  connect(senTem.port_b, preDro.port_a)
    annotation (Line(points={{60,-60},{80,-60}}, color={0,127,255}));
  connect(preDro.port_b, vol.ports[1])
    annotation (Line(points={{100,-60},{168,-60}}, color={0,127,255}));
  connect(senTem.T, dryCoil.TDryBul)
    annotation (Line(points={{50,-49},{50,64},{78,64}}, color={0,0,127}));
  connect(port_a, dryCoil.port_a)
    annotation (Line(points={{-220,60},{80,60}}, color={0,127,255}));
  connect(dryCoil.port_b, port_b)
    annotation (Line(points={{100,60},{260,60}}, color={0,127,255}));
  connect(dryCoil.TLvg, TLvg) annotation (Line(points={{101,54},{200,54},{200,
          90},{280,90}}, color={0,0,127}));
  connect(dryCoil.QCoi_flow, preHea.Q_flow) annotation (Line(points={{101,68},{
          110,68},{110,-20},{120,-20}},
                                      color={0,0,127}));
  connect(vol.ports[2], fan.port_a)
    annotation (Line(points={{170,-60},{200,-60}}, color={0,127,255}));
  connect(fan.port_b, sin2.ports[1])
    annotation (Line(points={{220,-60},{240,-60}}, color={0,127,255}));
  connect(TDryBul, sin1.T_in) annotation (Line(points={{-240,-80},{-210,-80},{
          -210,-64},{-202,-64}}, color={0,0,127}));
  connect(yFan, dryCoil.mAir_flow) annotation (Line(points={{-240,20},{-40,20},
          {-40,68},{78,68}}, color={0,0,127}));
  connect(yFan, fan.y) annotation (Line(points={{-240,20},{-40,20},{-40,0},{210,
          0},{210,-48}}, color={0,0,127}));
  connect(sin1.ports[1], spl1.port_1)
    annotation (Line(points={{-180,-60},{-160,-60}}, color={0,127,255}));
  connect(spl1.port_2, damPad.port_a)
    annotation (Line(points={{-140,-60},{-120,-60}}, color={0,127,255}));
  connect(spl1.port_3, damByp.port_a) annotation (Line(points={{-150,-70},{-150,
          -110},{-100,-110}}, color={0,127,255}));
  connect(PFan, fan.P) annotation (Line(points={{280,-10},{230,-10},{230,-51},{
          221,-51}}, color={0,0,127}));
  connect(booToRea.y, damPad.y)
    annotation (Line(points={{-138,0},{-110,0},{-110,-48}}, color={0,0,127}));
  connect(evaCooAct, booToRea1.u) annotation (Line(points={{-240,-20},{-200,-20},
          {-200,40},{-162,40}}, color={255,0,255}));
  connect(evaCooAct, booToRea.u) annotation (Line(points={{-240,-20},{-200,-20},
          {-200,0},{-162,0}}, color={255,0,255}));
  connect(booToRea1.y, damByp.y)
    annotation (Line(points={{-138,40},{-90,40},{-90,-98}}, color={0,0,127}));
  connect(dirEvaCoo.port_b, spl2.port_1)
    annotation (Line(points={{-40,-60},{0,-60}}, color={0,127,255}));
  connect(spl2.port_2, senTem.port_a)
    annotation (Line(points={{20,-60},{40,-60}}, color={0,127,255}));
  connect(damByp.port_b, spl2.port_3) annotation (Line(points={{-80,-110},{10,
          -110},{10,-70}}, color={0,127,255}));
  connect(damPad.port_b, dirEvaCoo.port_a)
    annotation (Line(points={{-100,-60},{-60,-60}}, color={0,127,255}));
annotation (defaultComponentName="indDryEva",
Documentation(info="<html>
<p>
Model for an indirect dry evaporative cooler.
</p>
<p>
This model contains two components, a direct evaporative cooler 
(<a href=\"modelica://Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct\">
Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct</a>) 
and a heat exchanger with constant effectiveness
(<a href=\"modelica://Buildings.Fluid.HeatExchangers.ConstantEffectiveness\">
Buildings.Fluid.HeatExchangers.ConstantEffectiveness</a>). 
The secondary air travels through the evaporative cooler and enters the heat
exchanger where it cools the primary fluid flowing through the heat exchanger tubes.
</p>
<p>
The input variable <code>evaCooAct</code> determines whether evaporative cooling is
active for the direct evaporative cooler. When evaporative cooling is not active
(the evaporative pad is dry), no water vapor is added to the air.
</p>
<p>
<b>Note:</b> The model works correctly only when the ports a1 and a2 are used as
inlet ports, and ports b1 and b2 are used as outlet ports, for the primary and
secondary flow respectively.
</p>
<p>
A diagram for this model is shown below:
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Fluid/Humidifiers/EvaporativeCoolers/IndirectDryEvaporativeCooler.png\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
July 21, 2026, by Weiping Huang:<br/>
Added a Modelica data record to calculate saturation efficiency and pressure drop,
as well as added a flag to turn on and off the evaporative cooling for the
evaporative cooler.
</li>
<li>
September 20, 2023 by Cerrina Mouchref, Karthikeya Devaprasad, Lingzhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(coordinateSystem(extent={{-220,-140},{260,100}}),
     graphics={Rectangle(lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, pattern = LinePattern.None,
            fillPattern = FillPattern.Solid, extent={{-70,60},{70,-60}}),
  Rectangle(lineColor = {0, 0, 255}, pattern = LinePattern.None,
            fillPattern = FillPattern.Solid, extent={{-102,65},{98,56}}),
  Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          points={{42,42},{54,34},{54,34},{42,28},{42,30},{50,34},{50,34},{42,40},{42,42}}),
  Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
            fillPattern = FillPattern.Solid, extent={{58,-54},{54,52}}),
  Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          points={{42,10},{54,2},{54,2},{42,-4},{42,-2},{50,2},{50,2},{42,8},{42,10}}),
  Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          points={{42,-26},{54,-34},{54,-34},{42,-40},{42,-38},{50,-34},{50,-34},{42,-28},{42,-26}}),
  Rectangle(lineColor = {0, 0, 255}, pattern = LinePattern.None,
            fillPattern = FillPattern.Solid, extent={{-100,-55},{100,-64}}),
  Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 62, 0}, pattern = LinePattern.None,
            fillPattern = FillPattern.Solid, extent={{-70,68},{70,-66}}),
  Rectangle(extent={{10,40},{20,-40}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
  Rectangle(extent={{20,40},{30,-40}},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
  Rectangle(extent={{30,40},{40,-40}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
  Rectangle(extent={{40,40},{50,-40}},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
  Rectangle(extent={{50,40},{60,-40}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
  Rectangle(lineColor={255, 255, 255}, fillColor={255,236,32},
            fillPattern=FillPattern.Solid, extent={{-20,52},{-60,56}}),
  Rectangle(lineColor={255, 255, 255}, fillColor={255,236,32},
            fillPattern=FillPattern.Solid, extent={{-56,-52},{-60,52}}),
  Polygon(points={{-46,38},{-48,28},{-42,24},{-34,28},{-36,38},{-42,50},{-46,38}},
          lineColor={0,255,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
  Polygon(points={{-46,2},{-48,-8},{-42,-12},{-34,-8},{-36,2},{-42,14},{-46,2}},
          lineColor={0,255,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
  Polygon(points={{-46,-32},{-48,-42},{-42,-46},{-34,-42},{-36,-32},{-42,-20},{
              -46,-32}},
          lineColor={0,255,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
  Rectangle(lineColor={255, 255, 255}, fillColor={255,236,32},
            fillPattern=FillPattern.Solid, extent={{-20,-56},{-60,-52}}),
  Rectangle(lineColor={255, 255, 255}, fillColor={255,236,32},
            fillPattern=FillPattern.Solid, extent={{-20,-52},{-24,52}})}),
    Diagram(coordinateSystem(extent={{-220,-140},{260,100}})));
end IndirectDryTest2;
