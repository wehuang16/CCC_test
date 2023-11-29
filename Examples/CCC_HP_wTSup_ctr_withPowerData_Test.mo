within CCC_test.Examples;
model CCC_HP_wTSup_ctr_withPowerData_Test
  "Heat pump model for use with any heat pump data"
  replaceable package MediumAir =
      IBPSA.Media.Air "Medium model for air";
  replaceable package MediumWat =
      IBPSA.Media.Water "Medium model for water";

replaceable parameter IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater datTabHea;
  replaceable parameter IBPSA.Fluid.Chillers.ModularReversible.Data.EuropeanNorm2D.Generic
    datTabCoo;

         replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHeaHpwh;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCooHpwh;
  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrParEurNor;

 parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=14800
    "Nominal heat flow rate of radiator";

 parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal=0.575;
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=1.293;

  CCC.Fluid.HeatPumps.BaseClasses.ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData(
    redeclare package MediumCon = MediumWat,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=Q_flow_nominal,
    y_nominal=1,
    use_intSafCtr=false,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=293.15,
    dpEva_nominal=2000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    datTabHea=datTabHeaHpwh,
    datTabCoo=datTabCooHpwh,
    safCtrParEurNor=safCtrParEurNor)
    annotation (Placement(transformation(extent={{6,36},{-14,60}})));
  IBPSA.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    T=293.15,                                        nPorts=1)
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
  IBPSA.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,            nPorts=1)
    annotation (Placement(transformation(extent={{44,-4},{24,16}})));
  IBPSA.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium =
        MediumAir, m_flow_nominal=mEva_flow_nominal)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,30})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{32,56},{52,76}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{64,10},{84,30}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor1(
    redeclare package Medium = MediumWat,
    m_flow=0.1,
    T=318.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,90})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWat,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-52,81})));
equation
  connect(sou.ports[1], mov.port_a) annotation (Line(points={{-46,8},{-28,8},{-28,
          20}},       color={0,127,255}));
  connect(mov.port_b, reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a2)
    annotation (Line(points={{-28,40},{-28,42},{-14,42}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b2, sin.ports[1])
    annotation (Line(points={{6,42},{18,42},{18,6},{24,6}}, color={0,127,255}));
  connect(const.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.ySet)
    annotation (Line(points={{53,66},{70,66},{70,50},{7.6,50}}, color={0,0,127}));
  connect(booleanConstant.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.hea)
    annotation (Line(points={{85,20},{90,20},{90,39},{7.6,39}}, color={255,0,
          255}));
  connect(const1.y, mov.m_flow_in) annotation (Line(points={{-71,42},{-48,42},{
          -48,30},{-40,30}}, color={0,0,127}));
  connect(freshAirCor1.ports[1],
    reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a1) annotation (Line(
        points={{72,90},{26,90},{26,56},{6,56},{6,54}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b1, boundary2.ports[
    1]) annotation (Line(points={{-14,54},{-30,54},{-30,58},{-34,58},{-34,81},{
          -42,81}}, color={0,127,255}));
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
end CCC_HP_wTSup_ctr_withPowerData_Test;
