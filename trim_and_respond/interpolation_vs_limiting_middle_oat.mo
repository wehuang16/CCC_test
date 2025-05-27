within CCC_test.trim_and_respond;
model interpolation_vs_limiting_middle_oat
  hil_flexlab_model.Test1.BaseClasses1.Controls.SupplyTemperature_standardized
                                                ModelSatSetpoint(
    final samplePeriod=180,
    final TSupSetMin=284.85,
    final TSupSetMax=291.45,
    final TSupSetDes=285.95,
    final TOutMin=291.45,
    final TOutMax=294.25,
    final delTim=0,
    final numIgnReq=0,
    final triAmo=0.0833,
    final resAmo=-0.1667,
    final maxRes=-0.6667) "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{34,16},{74,56}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 22.2)
    annotation (Placement(transformation(extent={{-78,82},{-58,102}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-120,-42},{-100,-22}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=1)
    annotation (Placement(transformation(extent={{-100,-82},{-80,-62}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-82,-2},{-62,18}})));
  hil_flexlab_model.Test1.BaseClasses1.Controls.SupplyTemperature_standardized3
                                                ModelSatSetpoint1(
    final samplePeriod=180,
    final TSupSetMin=284.85,
    final TSupSetMax=291.45,
    final TSupSetDes=285.95,
    final TOutMin=291.45,
    final TOutMax=294.25,
    final delTim=0,
    final numIgnReq=0,
    final triAmo=0.0833,
    final resAmo=-0.1667,
    final maxRes=-0.6667) "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{40,-74},{80,-34}})));
  Modelica.Blocks.Sources.Constant OAT(k=273.15 + 19.7)
    annotation (Placement(transformation(extent={{-144,32},{-124,52}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse SatRequests(period=43200)
    annotation (Placement(transformation(extent={{-142,-8},{-122,12}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput standardized_CDL(unit="K",
      displayUnit="degC")
    annotation (Placement(transformation(extent={{110,34},{130,54}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput custom_logic(unit="K",
      displayUnit="degC")
    annotation (Placement(transformation(extent={{130,-58},{150,-38}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput CDL_upper(unit="K",
      displayUnit="degC")
    annotation (Placement(transformation(extent={{144,72},{164,92}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput CDL_lower(unit="K",
      displayUnit="degC")
    annotation (Placement(transformation(extent={{154,4},{174,24}})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{100,74},{120,94}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    annotation (Placement(transformation(extent={{104,2},{124,22}})));
  Modelica.Blocks.Sources.Constant const2(k=-0.5)
    annotation (Placement(transformation(extent={{76,-22},{96,-2}})));
equation
  connect(const.y,ModelSatSetpoint. TZonSetAve) annotation (Line(points={{-57,92},
          {22,92},{22,52},{30,52}},     color={0,0,127}));
  connect(booleanConstant.y,ModelSatSetpoint. uSupFan) annotation (Line(points={{-99,-32},
          {-50,-32},{-50,28},{30,28}},    color={255,0,255}));
  connect(integerConstant.y,ModelSatSetpoint. uOpeMod) annotation (Line(points={{-79,-72},
          {20,-72},{20,6},{22,6},{22,20},{30,20}},
                                                color={255,127,0}));
  connect(realToInteger.y,ModelSatSetpoint. uZonTemResReq) annotation (Line(
        points={{-61,8},{20,8},{20,36},{30,36}},  color={255,127,0}));
  connect(const.y, ModelSatSetpoint1.TZonSetAve) annotation (Line(points={{-57,92},
          {22,92},{22,22},{18,22},{18,-32},{24,-32},{24,-38},{36,-38}}, color={0,
          0,127}));
  connect(integerConstant.y, ModelSatSetpoint1.uOpeMod) annotation (Line(points={{-79,-72},
          {26,-72},{26,-70},{36,-70}},           color={255,127,0}));
  connect(booleanConstant.y, ModelSatSetpoint1.uSupFan) annotation (Line(points={{-99,-32},
          {-50,-32},{-50,28},{14,28},{14,-58},{26,-58},{26,-62},{36,-62}},
        color={255,0,255}));
  connect(realToInteger.y, ModelSatSetpoint1.uZonTemResReq) annotation (Line(
        points={{-61,8},{12,8},{12,-56},{26,-56},{26,-54},{36,-54}}, color={255,
          127,0}));
  connect(OAT.y, ModelSatSetpoint.TOut) annotation (Line(points={{-123,42},{20,42},
          {20,44},{30,44}}, color={0,0,127}));
  connect(OAT.y, ModelSatSetpoint1.TOut) annotation (Line(points={{-123,42},{16,
          42},{16,-34},{22,-34},{22,-46},{36,-46}}, color={0,0,127}));
  connect(SatRequests.y, realToInteger.u) annotation (Line(points={{-120,2},{-94,
          2},{-94,8},{-84,8}}, color={0,0,127}));
  connect(ModelSatSetpoint.TSupSet, standardized_CDL) annotation (Line(points={
          {78,36},{104,36},{104,44},{120,44}}, color={0,0,127}));
  connect(ModelSatSetpoint1.TSupSet, custom_logic) annotation (Line(points={{84,
          -54},{124,-54},{124,-48},{140,-48}}, color={0,0,127}));
  connect(ModelSatSetpoint.TSupSet, add1.u1) annotation (Line(points={{78,36},{
          94,36},{94,18},{102,18}}, color={0,0,127}));
  connect(ModelSatSetpoint.TSupSet, add2.u2) annotation (Line(points={{78,36},{
          90,36},{90,78},{98,78}}, color={0,0,127}));
  connect(const1.y, add2.u1)
    annotation (Line(points={{61,90},{98,90}}, color={0,0,127}));
  connect(const2.y, add1.u2)
    annotation (Line(points={{97,-12},{102,-12},{102,6}}, color={0,0,127}));
  connect(add1.y, CDL_lower) annotation (Line(points={{126,12},{150,12},{150,14},
          {164,14}}, color={0,0,127}));
  connect(add2.y, CDL_upper) annotation (Line(points={{122,84},{140,84},{140,82},
          {154,82}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end interpolation_vs_limiting_middle_oat;
