within CCC_test.obsolete_eas_e;
model FanCoilUnitDoubleHysteresis_old
    replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+21
    "Zone air temperature setpoint";
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating(
    uLow=zone_temp_setpoint - 1,
    uHigh=zone_temp_setpoint + 1,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{-70,28},{-50,48}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(uLow=zone_temp_setpoint
         - 1,
      uHigh=zone_temp_setpoint + 1)
    annotation (Placement(transformation(extent={{-70,-34},{-50,-14}})));
  Modelica.Blocks.Interfaces.RealInput TZon "zone air temeprature" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,14})));
  Modelica.Blocks.Interfaces.BooleanOutput RunFcuAirSide
    "true to allow air to flow through the FCU air side" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,8})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-36,28},{-16,48}})));
  Modelica.Blocks.Logical.Or  not2
    annotation (Placement(transformation(extent={{32,0},{52,20}})));
equation
  connect(TZon, hysteresisHeating.u) annotation (Line(points={{-120,14},{-82,14},
          {-82,38},{-72,38}}, color={0,0,127}));
  connect(TZon, hysteresisCooling.u) annotation (Line(points={{-120,14},{-82,14},
          {-82,-24},{-72,-24}}, color={0,0,127}));
  connect(hysteresisHeating.y, not1.u)
    annotation (Line(points={{-49,38},{-38,38}}, color={255,0,255}));
  connect(not1.y, not2.u1) annotation (Line(points={{-15,38},{20,38},{20,10},{
          30,10}}, color={255,0,255}));
  connect(hysteresisCooling.y, not2.u2) annotation (Line(points={{-49,-24},{22,
          -24},{22,2},{30,2}}, color={255,0,255}));
  connect(not2.y, RunFcuAirSide) annotation (Line(points={{53,10},{96,10},{96,8},
          {120,8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitDoubleHysteresis_old;
