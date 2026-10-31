within CCC_test.EvaporativeCooler;
model IndirectDry2
  replaceable parameter
    Buildings.Fluid.Humidifiers.EvaporativeCoolers.Data.Generic perPad
    constrainedby Buildings.Fluid.Humidifiers.EvaporativeCoolers.Data.Generic
    "Record with performance data for evaporative pads" annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-10,-118},{10,
            -98}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium1,
    m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-22,10},{-2,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare final package Medium = Medium1,
    m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{330,50},{310,70}}),
        iconTransformation(extent={{198,10},{178,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput evaCooAct
    "True: the evaporative cooling is active"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
      iconTransformation(extent={{-110,-20},{-70,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dmWat_flow(final unit="kg/s",
      final quantity="MassFlowRate")
    "Water vapor mass flow rate difference between inlet and outlet of secondary air"
    annotation (Placement(transformation(origin={340,0}, extent={{-20,-20},{20,20}}),
      iconTransformation(origin={90,0}, extent={{-20,-20},{20,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TLvg annotation (Placement(
        transformation(extent={{320,70},{360,110}}), iconTransformation(extent=
            {{-2,-84},{38,-44}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput relFanSpe annotation (
      Placement(transformation(extent={{-140,10},{-100,50}}),
        iconTransformation(extent={{-2,-84},{38,-44}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDro(
    redeclare final package Medium = Medium,
    final n=n,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearizeFlowResistance,
    final homotopyInitialization=homotopyInitialization,
    final dp_nominal=dp_nominal) "Flow resistance"
    annotation (Placement(transformation(extent={{110,-70},{130,-50}})));
              Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    nPorts=2,
    V=m_flow_nominal*tau/rho_default,
    final allowFlowReversal=allowFlowReversal,
    final mSenFac=1,
    final m_flow_nominal=m_flow_nominal,
    final energyDynamics=energyDynamics,
    final massDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start) "Volume for fluid stream"
     annotation (Placement(transformation(extent={{179,-60},{199,-80}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare final package Medium = Medium1,
    m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
        iconTransformation(extent={{-22,10},{-2,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare final package Medium = Medium1,
    m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{330,-70},{310,-50}}),
        iconTransformation(extent={{198,10},{178,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput PFan annotation (Placement(
        transformation(extent={{320,110},{360,150}}), iconTransformation(extent
          ={{-2,-84},{38,-44}})));
protected
  Buildings.Fluid.Humidifiers.EvaporativeCoolers.Direct dirEvaCoo(
    redeclare final package Medium = Medium2,
    final padAre=padAre,
    per(
      final efficiency=perPad.efficiency,
      final v_nominal=perPad.v_nominal,
      final dp_nominal=perPad.dp_nominal,
      final n=perPad.n))
    "Direct evaporative cooler for representing the cooling effect on the secondary air"
    annotation (Placement(transformation(origin={0,-60}, extent={{-10,-10},{10,
            10}})));
  Buildings.Fluid.HeatExchangers.CoolingTowers.DryCooler
                                                       dryCooler
    "Heat exchanger for heat transfer between primary and secondary air"
    annotation (Placement(transformation(origin={110,60},
                                                       extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{140,10},{160,30}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y(
      final quantity="Power",
      final unit="W") = dryCooler.Q_flow*(-1)) "Heat transfer"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
equation
  connect(dirEvaCoo.dmWat_flow,dmWat_flow)
    annotation (Line(points={{9,-56},{40,-56},{40,0},{340,0}},   color={0,0,127}));
  connect(evaCooAct,dirEvaCoo. evaCooAct)
    annotation (Line(points={{-120,-20},{-20,-20},{-20,-64},{-9,-64}},
      color={255,0,255}));
  connect(port_a1, dryCooler.port_a)
    annotation (Line(points={{-100,60},{100,60}}, color={0,127,255}));
  connect(dryCooler.port_b, port_b1)
    annotation (Line(points={{120,60},{320,60}}, color={0,127,255}));
  connect(senTem.port_a, dirEvaCoo.port_b)
    annotation (Line(points={{60,-60},{10,-60}}, color={0,127,255}));
  connect(senTem.T, dryCooler.TDryBul)
    annotation (Line(points={{70,-49},{70,64},{98,64}}, color={0,0,127}));
  connect(dryCooler.TLvg, TLvg) annotation (Line(points={{121,54},{260,54},{260,
          90},{340,90}}, color={0,0,127}));
  connect(preDro.port_a, senTem.port_b)
    annotation (Line(points={{110,-60},{80,-60}}, color={0,127,255}));
  connect(preDro.port_b, vol.ports[1])
    annotation (Line(points={{130,-60},{188,-60}}, color={0,127,255}));
  connect(preHea.port, vol.heatPort) annotation (Line(points={{160,20},{170,20},
          {170,-70},{179,-70}},      color={191,0,0}));
  connect(Q_flow.y, preHea.Q_flow) annotation (Line(points={{121,20},{140,20}},
                               color={0,0,127}));
  connect(relFanSpe, dryCooler.y) annotation (Line(points={{-120,30},{-52,30},{
          -52,68},{98,68}}, color={0,0,127}));
  connect(port_a2, dirEvaCoo.port_a)
    annotation (Line(points={{-100,-60},{-10,-60}}, color={0,127,255}));
  connect(port_b2, vol.ports[2])
    annotation (Line(points={{320,-60},{190,-60}}, color={0,127,255}));
  connect(dryCooler.PFan, PFan) annotation (Line(points={{121,68},{220,68},{220,
          130},{340,130}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-140},{320,100}},
        grid={2,2})), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-140},{320,100}},
        grid={2,2})));
end IndirectDry2;
