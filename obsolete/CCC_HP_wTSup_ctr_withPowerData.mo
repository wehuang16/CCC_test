within CCC_test.obsolete;
model CCC_HP_wTSup_ctr_withPowerData
  "Heat pump model for use with any heat pump data"
  replaceable package MediumAir =
      IBPSA.Media.Air "Medium model for air";
  replaceable package MediumWat =
      IBPSA.Media.Water "Medium model for water";

replaceable parameter IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater datTabHea;
  replaceable parameter IBPSA.Fluid.Chillers.ModularReversible.Data.EuropeanNorm2D.Generic
    datTabCoo;
  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrParEurNor;

 parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=14800
    "Nominal heat flow rate of radiator";

     parameter Modelica.Units.SI.Temperature TCon_nominal=273.15+60;
     parameter Modelica.Units.SI.Temperature TEva_nominal=273.15+20;
 parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal=0.575;
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=1.293;

  ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData(
    redeclare package MediumCon = MediumWat,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=Q_flow_nominal,
    y_nominal=1,
    use_intSafCtr=false,
    TCon_nominal=TCon_nominal,
    dpCon_nominal=10,
    TEva_nominal=TEva_nominal,
    dpEva_nominal=10,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    datTabHea=datTabHea,
    datTabCoo=datTabCoo,
    safCtrParEurNor=safCtrParEurNor)
    annotation (Placement(transformation(extent={{6,36},{-14,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    annotation (Placement(transformation(extent={{-120,68},{-100,88}}),
        iconTransformation(extent={{-120,68},{-100,88}})));
  IBPSA.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
                                      use_T_in=true, nPorts=1)
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
  IBPSA.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
                                      use_T_in=true, nPorts=1)
    annotation (Placement(transformation(extent={{44,-4},{24,16}})));
  IBPSA.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium =
        MediumAir, m_flow_nominal=mEva_flow_nominal)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,30})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
        MediumWat, m_flow_nominal=mCon_flow_nominal)
                                                 annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={-40,75})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
        MediumWat, m_flow_nominal=mCon_flow_nominal)
                                                 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={39,77})));
  Modelica.Blocks.Interfaces.RealInput TOutAir
    annotation (Placement(transformation(extent={{126,-46},{100,-20}}),
        iconTransformation(extent={{126,-46},{100,-20}})));
  Modelica.Blocks.Interfaces.BooleanInput IO
    annotation (Placement(transformation(extent={{-124,-16},{-100,8}}),
        iconTransformation(extent={{-124,-16},{-100,8}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode "true=heating, false=cooling"
    annotation (Placement(transformation(extent={{124,8},{100,32}}),
        iconTransformation(extent={{124,8},{100,32}})));
  Modelica.Blocks.Sources.Constant const(k=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Modelica.Blocks.Sources.Constant constTSetRooHea(final k=0)
    "Room set point temperature for heating"
    annotation (Placement(transformation(extent={{-72,-44},{-62,-34}})));
  Modelica.Blocks.Continuous.LimPID PIDHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=400,
    yMax=1,
    yMin=0)   "PI control for heating"
    annotation (Placement(transformation(extent={{-24,-16},{-4,4}})));
  Modelica.Blocks.Logical.Switch swiHeaCooYSet
    "Switch ySet for heating and cooling" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={22,-48},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(extent={{-124,-36},{-100,-12}}), iconTransformation(
          extent={{-122,-50},{-100,-28}})));
  Modelica.Blocks.Interfaces.RealOutput QCon_flow(final unit="W", final
      displayUnit="W")
    "Heat flow rate from the refrigerant to the condenser medium"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,110})));
  Modelica.Blocks.Interfaces.RealOutput QEva_flow(final unit="W", final
      displayUnit="W")
    "Heat flow rate from the evaporator medium to the refrigerant"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-4,110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-4,110})));
  Modelica.Blocks.Interfaces.RealOutput PEle(final unit="W", final displayUnit=
        "W")
    "Routing block that picks the component for electric power consumption"
    annotation (Placement(
        transformation(
        extent={{-10.5,-10.5},{10.5,10.5}},
        rotation=90,
        origin={32.5,111.5})));
equation
  connect(sou.ports[1], mov.port_a) annotation (Line(points={{-46,8},{-28,8},{-28,
          20}},       color={0,127,255}));
  connect(mov.port_b, reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a2)
    annotation (Line(points={{-28,40},{-28,42},{-14,42}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b2, sin.ports[1])
    annotation (Line(points={{6,42},{18,42},{18,6},{24,6}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b1, TWatSup.port_a)
    annotation (Line(points={{-14,54},{-40,54},{-40,68}}, color={0,127,255}));
  connect(TWatSup.port_b, port_b)
    annotation (Line(points={{-40,82},{-40,78},{-110,78}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a1, TWatRet.port_b)
    annotation (Line(points={{6,54},{39,54},{39,70}}, color={0,127,255}));
  connect(TWatRet.port_a, port_a)
    annotation (Line(points={{39,84},{39,80},{110,80}}, color={0,127,255}));
  connect(TOutAir, sin.T_in) annotation (Line(points={{113,-33},{56,-33},{56,10},
          {46,10}},  color={0,0,127}));
  connect(TOutAir,sou. T_in) annotation (Line(points={{113,-33},{-80,-33},{-80,12},
          {-68,12}},  color={0,0,127}));
  connect(const.y, mov.m_flow_in) annotation (Line(points={{-69,38},{-50,38},{-50,
          30},{-40,30}},
                       color={0,0,127}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.hea, Mode)
    annotation (Line(points={{7.6,39},{94,39},{94,20},{112,20}}, color={255,0,
          255}));
  connect(IO, swiHeaCooYSet.u2) annotation (Line(points={{-112,-4},{-82,-4},{
          -82,-20},{-92,-20},{-92,-48},{10,-48}}, color={255,0,255}));
  connect(swiHeaCooYSet.u3, constTSetRooHea.y) annotation (Line(points={{10,-40},
          {10,-32},{-18,-32},{-18,-39},{-61.5,-39}}, color={0,0,127}));
  connect(PIDHea.y, swiHeaCooYSet.u1) annotation (Line(points={{-3,-6},{2,-6},{
          2,-56},{10,-56}}, color={0,0,127}));
  connect(swiHeaCooYSet.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.ySet)
    annotation (Line(points={{33,-48},{38,-48},{38,-8},{14,-8},{14,50},{7.6,50}},
        color={0,0,127}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.QCon_flow, QCon_flow)
    annotation (Line(points={{-15,51.2},{-24,51.2},{-24,94},{-38,94},{-38,110}},
        color={0,0,127}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.QEva_flow, QEva_flow)
    annotation (Line(points={{-15,48.6},{-30,48.6},{-30,68},{-4,68},{-4,110}},
        color={0,0,127}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.PEle, PEle)
    annotation (Line(points={{-15.05,45.95},{-34,45.95},{-34,64},{32.5,64},{
          32.5,111.5}}, color={0,0,127}));
  connect(TWatSup.T, PIDHea.u_m) annotation (Line(points={{-48.8,75},{-54,75},{
          -54,-24},{-14,-24},{-14,-18}}, color={0,0,127}));
  connect(TSupSet, PIDHea.u_s) annotation (Line(points={{-112,-24},{-74,-24},{
          -74,-22},{-34,-22},{-34,-6},{-26,-6}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-60},{100,100}})), Icon(
        coordinateSystem(extent={{-100,-60},{100,100}}), graphics={
        Rectangle(
          extent={{-12,80},{12,-80}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          rotation=90,
          origin={0,78}),
        Line(
          points={{60,80},{-56,80}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Rectangle(
          extent={{-80,60},{80,-20}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,80},{12,-80}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={0,-38},
          rotation=90)}));
end CCC_HP_wTSup_ctr_withPowerData;
