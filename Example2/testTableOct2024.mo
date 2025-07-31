within CCC_test.Example2;
model testTableOct2024
  Modelica.Blocks.Sources.CombiTimeTable MassFieldData(
    tableOnFile=true,
    timeScale(displayUnit="s"),
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/MassFieldData/ckAValidationOct24Jan25.txt"),
    columns=2:17)                                                                                                                                                                                                         annotation (
    Placement(transformation(origin={104,82},  extent = {{-200, -70}, {-180, -50}}, rotation=0)));

  Buildings.Controls.OBC.CDL.Reals.Multiply mul1
    annotation (Placement(transformation(extent={{-4,10},{16,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.01)
    annotation (Placement(transformation(extent={{-102,-42},{-82,-22}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter thermal_power(k=1/1000)
    annotation (Placement(transformation(extent={{82,12},{102,32}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter electrical_power(k=1/
        1000) annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve(delta=1800)
    annotation (Placement(transformation(extent={{140,16},{160,36}})));
equation
  connect(MassFieldData.y[3], mul1.u1) annotation (Line(points={{-75,22},{-16,
          22},{-16,26},{-6,26}}, color={0,0,127}));
  connect(MassFieldData.y[1], mul1.u2) annotation (Line(points={{-75,22},{-16,
          22},{-16,14},{-6,14}}, color={0,0,127}));
  connect(mul1.y, thermal_power.u) annotation (Line(points={{18,20},{72,20},{72,
          22},{80,22}}, color={0,0,127}));
  connect(MassFieldData.y[3], electrical_power.u) annotation (Line(points={{-75,
          22},{-16,22},{-16,-40},{68,-40}}, color={0,0,127}));
  connect(thermal_power.y, movAve.u) annotation (Line(points={{104,22},{128,22},
          {128,26},{138,26}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2592000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testTableOct2024;
