within CCC_test.HIL_testing;
model testConAHU
   parameter Real yFanMin = 0.1 "Minimum fan speed";

     parameter Modelica.Units.SI.VolumeFlowRate VPriSysMax_flow=m_flow_nominal/1.2
    "Maximum expected system primary airflow rate at design stage";


      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.7 "Nominal mass flow rate";
  hil_flexlab_model.Test1.BaseClasses1.Controls.Controller_G36        conAHU(
    final pMaxSet=410,
    final yFanMin=yFanMin,
    final VPriSysMax_flow=VPriSysMax_flow,
    final peaSysPop=5,
    numIgnReqSupTem=0) "AHU controller"
    annotation (Placement(transformation(extent={{68,-124},{212,120}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-24,130},{-4,150}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 19)
    annotation (Placement(transformation(extent={{-26,86},{-6,106}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 22)
    annotation (Placement(transformation(extent={{4,108},{24,128}})));
  Modelica.Blocks.Sources.Constant const3(k=350)
    annotation (Placement(transformation(extent={{-72,60},{-52,80}})));
  Modelica.Blocks.Sources.Constant const4(k=4)
    annotation (Placement(transformation(extent={{-48,24},{-28,44}})));
  Modelica.Blocks.Sources.Constant const5(k=0.8)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modelica.Blocks.Sources.Constant const6(k=0.1)
    annotation (Placement(transformation(extent={{-74,-8},{-54,12}})));
  Modelica.Blocks.Sources.Constant const7(k=0.07)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant const8(k=273.15 + 10)
    annotation (Placement(transformation(extent={{-22,-56},{-2,-36}})));
  Modelica.Blocks.Sources.Constant const9(k=273.15 + 24)
    annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
  Modelica.Blocks.Sources.Constant const10(k=0.04)
    annotation (Placement(transformation(extent={{-64,-116},{-44,-96}})));
  Modelica.Blocks.Sources.Constant const11(k=273.15 + 19.5)
    annotation (Placement(transformation(extent={{-50,-144},{-30,-124}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{6,-170},{26,-150}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=3)
    annotation (Placement(transformation(extent={{-96,-166},{-76,-146}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant1(k=7)
    annotation (Placement(transformation(extent={{-108,-84},{-88,-64}})));
equation
  connect(const.y, conAHU.TZonHeaSet) annotation (Line(points={{-3,140},{46,140},
          {46,127.176},{60.8,127.176}}, color={0,0,127}));
  connect(const2.y, conAHU.TZonCooSet) annotation (Line(points={{25,118},{46,
          118},{46,116.412},{60.8,116.412}}, color={0,0,127}));
  connect(const1.y, conAHU.TOut) annotation (Line(points={{-5,96},{46,96},{46,
          105.647},{60.8,105.647}}, color={0,0,127}));
  connect(const3.y, conAHU.ducStaPre) annotation (Line(points={{-51,70},{-20,70},
          {-20,80},{46,80},{46,94.8824},{60.8,94.8824}}, color={0,0,127}));
  connect(const4.y, conAHU.sumDesZonPop) annotation (Line(points={{-27,34},{-18,
          34},{-18,73.3529},{60.8,73.3529}}, color={0,0,127}));
  connect(const5.y, conAHU.uDesSysVenEff) annotation (Line(points={{-7,0},{46,0},
          {46,41.0588},{60.8,41.0588}}, color={0,0,127}));
  connect(const6.y, conAHU.VSumUncOutAir_flow) annotation (Line(points={{-53,2},
          {-34,2},{-34,18},{42,18},{42,30.2941},{60.8,30.2941}}, color={0,0,127}));
  connect(const6.y, conAHU.VSumDesPopBreZon_flow) annotation (Line(points={{-53,
          2},{-34,2},{-34,18},{42,18},{42,62.5882},{60.8,62.5882}}, color={0,0,
          127}));
  connect(const6.y, conAHU.VSumDesAreBreZon_flow) annotation (Line(points={{-53,
          2},{-34,2},{-34,18},{42,18},{42,51.8235},{60.8,51.8235}}, color={0,0,
          127}));
  connect(const7.y, conAHU.VSumSysPriAir_flow) annotation (Line(points={{-39,
          -30},{2,-30},{2,16},{44,16},{44,19.5294},{60.8,19.5294}}, color={0,0,
          127}));
  connect(const5.y, conAHU.uOutAirFra_max) annotation (Line(points={{-7,0},{46,
          0},{46,8.76471},{60.8,8.76471}}, color={0,0,127}));
  connect(const8.y, conAHU.TSup) annotation (Line(points={{-1,-46},{46,-46},{46,
          -12.7647},{60.8,-12.7647}}, color={0,0,127}));
  connect(conAHU.TOutCut, const9.y) annotation (Line(points={{60.8,-23.5294},{
          60.8,-46},{46,-46},{46,-100},{-1,-100}}, color={0,0,127}));
  connect(const10.y, conAHU.VOut_flow) annotation (Line(points={{-43,-106},{-28,
          -106},{-28,-62},{42,-62},{42,-55.8235},{60.8,-55.8235}}, color={0,0,
          127}));
  connect(const11.y, conAHU.TMix) annotation (Line(points={{-29,-134},{10,-134},
          {10,-70.1765},{60.8,-70.1765}}, color={0,0,127}));
  connect(booleanConstant.y, conAHU.u_UnOcc) annotation (Line(points={{27,-160},
          {60.08,-160},{60.08,-128.306}}, color={255,0,255}));
  connect(integerConstant.y, conAHU.uZonTemResReq) annotation (Line(points={{
          -75,-156},{0,-156},{0,-95.2941},{60.8,-95.2941}}, color={255,127,0}));
  connect(integerConstant.y, conAHU.uZonPreResReq) annotation (Line(points={{
          -75,-156},{0,-156},{0,-136},{46,-136},{46,-106.059},{60.8,-106.059}},
        color={255,127,0}));
  connect(integerConstant1.y, conAHU.uOpeMod) annotation (Line(points={{-87,-74},
          {42,-74},{42,-84.5294},{60.8,-84.5294}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -160},{260,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{260,
            100}})));
end testConAHU;
