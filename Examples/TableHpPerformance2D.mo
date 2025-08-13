within CCC_test.Examples;
model TableHpPerformance2D
  "Interpolate diode characteristics using the NDTable block"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(
    tableOnFile=true,                                table=[-999,0.0,1; 0.0,0.0,
        1; 1,2,10],
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/lg_heat_pump_heating_cop.txt"),
                    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{16,-8},{36,12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0.0,0.0; 21600,1;
        43200,0; 64800,1; 86400,0.0],                   extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-38,34},{-18,54}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0.0,0.5; 21600,0.5; 43200,1; 64800,1; 86400,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-50,-48},{-30,-28}})));
  Modelica.Blocks.Sources.Constant TSet(final k=273.15 + 45)
                                                            annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-54,16})));
  Modelica.Blocks.Sources.Constant TSet1(final k=273.15 + 15)
                                                            annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={14,-68})));
equation
  connect(TSet1.y, combiTable2Ds.u2) annotation (Line(points={{22.8,-68},{26,
          -68},{26,-12},{14,-12},{14,-4}}, color={0,0,127}));
  connect(TSet.y, combiTable2Ds.u1) annotation (Line(points={{-45.2,16},{4,16},
          {4,8},{14,8}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end TableHpPerformance2D;
