within CCC_test.Examples;
model TableHpPerformance
  "Interpolate diode characteristics using the NDTable block"
  extends Modelica.Icons.Example;

  SDF.NDTable elec_power(
    dataset="/elec_power",
    dataUnit="W",
    scaleUnits={"K","K","1"},
    nin=3,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/SDF/heat_pump_performance_map.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear,
    data=SDF.Functions.readTableData(
        elec_power.filename,
        elec_power.dataset,
        elec_power.dataUnit,
        elec_power.scaleUnits),
    readFromFile=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp OAT(
    duration=1,
    height=0,
    offset=273.15 + 55)
    annotation (Placement(transformation(extent={{-70,-14},{-50,6}})));
  Modelica.Blocks.Sources.Ramp amb(
    duration=1,
    startTime=0,
    offset=273.15 - 7,
    height=0) annotation (Placement(transformation(extent={{-66,36},{-46,56}})));
  Modelica.Blocks.Sources.Ramp speed(
    duration=1,
    height=(76 - 36)/76,
    offset=36/76)
    annotation (Placement(transformation(extent={{-78,-56},{-58,-36}})));
  SDF.NDTable condenser_heat(
    dataset="/condenser_heat",
    dataUnit="W",
    scaleUnits={"K","K","1"},
    nin=3,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/SDF/heat_pump_performance_map.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear,
    data=SDF.Functions.readTableData(
        elec_power.filename,
        elec_power.dataset,
        elec_power.dataUnit,
        elec_power.scaleUnits),
    readFromFile=true)
    annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
equation
  connect(OAT.y, elec_power.u[2]) annotation (Line(
      points={{-49,-4},{-26,-4},{-26,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(amb.y, elec_power.u[1]) annotation (Line(points={{-45,46},{-26,46},{
          -26,-0.666667},{-12,-0.666667}}, color={0,0,127}));
  connect(speed.y, elec_power.u[3]) annotation (Line(points={{-57,-46},{-26,-46},
          {-26,0.666667},{-12,0.666667}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(__Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end TableHpPerformance;
