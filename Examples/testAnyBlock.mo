within CCC_test.Examples;
model testAnyBlock
  HpModeSelectorTest hpModeSelectorTest
    annotation (Placement(transformation(extent={{-4,20},{16,40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D lookUpTable2D
    annotation (Placement(transformation(extent={{-24,-26},{-4,-6}})));
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTableND lookUpTableND
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  CCC.Fluid.HeatPumps.Aixlib_HP_3D aixlib_HP_3D(redeclare model PerDataMainHP
      = AixLib.DataBase.HeatPump.PerformanceData.LookUpTableND (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",

        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",

        dataset_QCon="/condenser_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""}), redeclare model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTableND (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",

        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",

        dataset_QCon="/evaporator_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""}))
    annotation (Placement(transformation(extent={{0,-58},{20,-38}})));

equation
  connect(booleanConstant1.y, hpModeSelectorTest.u) annotation (Line(points={{
          -39,20},{-16,20},{-16,24.6},{-6,24.6}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testAnyBlock;
