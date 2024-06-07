within CCC_test.StanfordHybrid;
model hybrid_2024_controller_new_06072024
  "has cold and hot pcm charging based on schedule"
  Modelica.Blocks.Interfaces.BooleanOutput CP1
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanOutput HP
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
  Modelica.Blocks.Tables.CombiTable1Ds ModeDefinitions(
    table=[0,1,1,0,0,1,0,273.15 + 20; 1,1,0,1,1,0,1,273.15 + 55; 2,1,0,0,0,1,0,
        273.15 + 48; 3,1,0,1,0,0,1,273.15 + 48; 4,1,0,1,0,0,1,273.15 + 55; 5,0,
        1,1,1,0,1,273.15 + 8; 6,0,1,0,0,1,0,273.15 + 11; 7,0,1,1,0,0,1,273.15
         + 11; 8,0,1,1,0,0,1,273.15 + 8; 9,1,1,1,0,0,1,273.15 + 48; 10,1,1,1,0,
        0,1,273.15 + 11],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=off/closed, 1=on/open. Column numbers in table: 1=input, 2=valA1, 3=valA2, 4=valA4, 5=valA5, 6=CP, 7=HP. Column numbers for use: 1=valA1, 2=valA2, 3=valA4, 4=valA45 5=CP, 6=HP"
    annotation (Placement(transformation(extent={{44,-146},{64,-126}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean4
    annotation (Placement(transformation(extent={{74,-70},{94,-50}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean5
    annotation (Placement(transformation(extent={{74,-110},{94,-90}})));
  Modelica.Blocks.Interfaces.RealOutput valA1
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput valA2
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput valA4
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput valA5
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput    scheduleInput
    "0 =TES Charging, 1 = TES Discharging, 2 = Disable"
    annotation (Placement(transformation(extent={{-182,80},{-142,120}})));
  Modelica.Blocks.Interfaces.RealInput SOChotPCM annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-160,-120})));
  Modelica.Blocks.Interfaces.RealOutput HPset
    annotation (Placement(transformation(extent={{100,-150},{120,-130}})));
  Modelica.Blocks.Interfaces.IntegerInput FCUmode
    "-1 = cooling, 0 = off, 1 = heating"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput SOCcoldPCM annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-160,-160})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  CCC.Controls.modular_SOC_Manager modular_SOC_Manager1(numTES=numTES)
    annotation (Placement(transformation(extent={{-116,-154},{-96,-138}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(
    table=[0.0,0,1; 0,0,-0.5; 1,0.5,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-52,-160},{-28,-136}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal[numTES]
    annotation (Placement(transformation(extent={{-86,-156},{-66,-136}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds1(
    table=[0,-1,0,1; 0,10,0,9; 1,10,1,3; 2,7,5,9; 3,6,0,2],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-72,32},{-52,52}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds2(table=[0,-0.5,0,0.5,1; 1,
        1,1,1,1; 2,4,4,2,2; 3,3,3,3,3; 5,5,5,5,5; 6,8,8,6,6; 7,7,7,7,7; 9,9,9,9,
        9; 10,10,10,10,10])
    annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
  parameter Integer numTES=2;
equation
  connect(HP, realToBoolean5.y)
    annotation (Line(points={{110,-100},{95,-100}}, color={255,0,255}));
  connect(CP1, realToBoolean4.y)
    annotation (Line(points={{110,-60},{95,-60}}, color={255,0,255}));
  connect(ModeDefinitions.y[5], realToBoolean4.u) annotation (Line(points={{65,-136},
          {70,-136},{70,-108},{64,-108},{64,-60},{72,-60}},
                                          color={0,0,127}));
  connect(ModeDefinitions.y[6], realToBoolean5.u) annotation (Line(points={{65,-136},
          {70,-136},{70,-108},{64,-108},{64,-100},{72,-100}},
                                            color={0,0,127}));
  connect(ModeDefinitions.y[1], valA1) annotation (Line(points={{65,-136},{70,
          -136},{70,-108},{64,-108},{64,100},{110,100}},
                             color={0,0,127}));
  connect(ModeDefinitions.y[2], valA2)
    annotation (Line(points={{65,-136},{70,-136},{70,-108},{64,-108},{64,60},{
          110,60}},                              color={0,0,127}));
  connect(ModeDefinitions.y[3],valA4)  annotation (Line(points={{65,-136},{70,
          -136},{70,-108},{64,-108},{64,20},{110,20}},
                           color={0,0,127}));
  connect(ModeDefinitions.y[4],valA5)  annotation (Line(points={{65,-136},{70,
          -136},{70,-108},{64,-108},{64,-20},{110,-20}},
                               color={0,0,127}));
  connect(HPset, HPset)
    annotation (Line(points={{110,-140},{110,-140}}, color={0,0,127}));
  connect(FCUmode, integerToReal1.u)
    annotation (Line(points={{-160,0},{-122,0}}, color={255,127,0}));
  connect(ModeDefinitions.y[7], HPset) annotation (Line(points={{65,-136},{94,
          -136},{94,-140},{110,-140}}, color={0,0,127}));
  connect(SOChotPCM, modular_SOC_Manager1.SOC_val[1]) annotation (Line(points={{-160,
          -120},{-132,-120},{-132,-146.675},{-118.3,-146.675}},       color={0,
          0,127}));
  connect(SOCcoldPCM, modular_SOC_Manager1.SOC_val[2]) annotation (Line(points={{-160,
          -160},{-132,-160},{-132,-145.525},{-118.3,-145.525}},        color={0,
          0,127}));
  connect(modular_SOC_Manager1.SOC_bool, booleanToReal.u) annotation (Line(
        points={{-93.9,-145.9},{-90.85,-145.9},{-90.85,-146},{-88,-146}}, color=
         {255,0,255}));
  connect(booleanToReal[1].y, combiTable2Ds.u1) annotation (Line(points={{-65,
          -146},{-54.4,-146},{-54.4,-140.8}}, color={0,0,127}));
  connect(booleanToReal[2].y, combiTable2Ds.u2) annotation (Line(points={{-65,
          -146},{-60,-146},{-60,-155.2},{-54.4,-155.2}}, color={0,0,127}));
  connect(scheduleInput, combiTable2Ds1.u1) annotation (Line(points={{-162,100},
          {-82,100},{-82,48},{-74,48}}, color={0,0,127}));
  connect(integerToReal1.y, combiTable2Ds1.u2) annotation (Line(points={{-99,0},
          {-82,0},{-82,36},{-74,36}}, color={0,0,127}));
  connect(combiTable2Ds1.y, combiTable2Ds2.u1) annotation (Line(points={{-51,42},
          {-20,42},{-20,-30},{-12,-30}}, color={0,0,127}));
  connect(combiTable2Ds.y, combiTable2Ds2.u2) annotation (Line(points={{-26.8,
          -148},{-20,-148},{-20,-42},{-12,-42}}, color={0,0,127}));
  connect(combiTable2Ds2.y, ModeDefinitions.u) annotation (Line(points={{11,-36},
          {32,-36},{32,-136},{42,-136}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{100,
            120}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{
            100,120}})),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
</html>"));
end hybrid_2024_controller_new_06072024;
