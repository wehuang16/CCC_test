within CCC_test.Examples;
model TabledDiode "Interpolate diode characteristics using the NDTable block"
  extends Modelica.Icons.Example;

  SDF.NDTable diode(
    dataset="/I_f",
    dataUnit="A",
    scaleUnits={"V","K"},
    nin=2,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://SDF/Resources/Data/Examples/diode.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear,
    data=SDF.Functions.readTableData(
        diode.filename,
        diode.dataset,
        diode.dataUnit,
        diode.scaleUnits),
    readFromFile=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp temperature(
    duration=1,
    height=5,
    offset=398.15)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Ramp forwardVoltage(
    duration=1,
    startTime=0.1,
    offset=0.1,
    height=3)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
equation
  connect(temperature.y, diode.u[2]) annotation (Line(
      points={{-39,20},{-26,20},{-26,0.5},{-12,0.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(forwardVoltage.y, diode.u[1]) annotation (Line(points={{-39,-20},{-26,
          -20},{-26,-0.5},{-12,-0.5}},
                                   color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end TabledDiode;
