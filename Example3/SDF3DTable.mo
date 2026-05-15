within CCC_test.Example3;
model SDF3DTable "Interpolate diode characteristics using the NDTable block"
  extends Modelica.Icons.Example;

  SDF.NDTable diode(
    dataset="/condenser_heat",
    dataUnit="W",
    scaleUnits={"K","K",""},
    nin=3,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating_24kwh.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear,
    data=SDF.Functions.readTableData(
        diode.filename,
        diode.dataset,
        diode.dataUnit,
        diode.scaleUnits),
    readFromFile=true)
    annotation (Placement(transformation(extent={{18,-8},{38,12}})));
  Modelica.Blocks.Sources.Ramp out_temp(
    duration=43200,
    height=0,
    offset=55,
    startTime=21600)
    annotation (Placement(transformation(extent={{-94,72},{-74,92}})));
  Modelica.Blocks.Sources.Ramp rela_speed(
    duration=43200,
    startTime=21600,
    offset=1,
    height=0)
    annotation (Placement(transformation(extent={{-78,-58},{-58,-38}})));
  Modelica.Blocks.Sources.Ramp amb_temp(
    height=50,
    duration=43200,
    offset=-8,
    startTime=21600)
    annotation (Placement(transformation(extent={{-96,-8},{-76,12}})));
equation
  connect(amb_temp.y, diode.u[2])
    annotation (Line(points={{-75,2},{16,2}}, color={0,0,127}));
  connect(out_temp.y, diode.u[1]) annotation (Line(points={{-73,82},{-29.5,82},
          {-29.5,1.33333},{16,1.33333}}, color={0,0,127}));
  connect(rela_speed.y, diode.u[3]) annotation (Line(points={{-57,-48},{-24.5,
          -48},{-24.5,2.66667},{16,2.66667}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end SDF3DTable;
