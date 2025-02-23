within CCC_test.Examples;
model TableHpPerformance
  "Interpolate diode characteristics using the NDTable block"
  extends Modelica.Icons.Example;

  SDF.NDTable elec_power(
    dataset="/elec_power",
    dataUnit="W",
    scaleUnits={"K","K",""},
    nin=3,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating_v2.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
    data=SDF.Functions.readTableData(
        elec_power.filename,
        elec_power.dataset,
        elec_power.dataUnit,
        elec_power.scaleUnits),
    readFromFile=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp OAT(
    duration=4320,
    height=0,
    offset=5,
    startTime=2160)
    annotation (Placement(transformation(extent={{-84,-4},{-64,16}})));
  Modelica.Blocks.Sources.Ramp supply_water_temp(
    duration=4320,
    startTime=2160,
    offset=45,
    height=0) annotation (Placement(transformation(extent={{-86,38},{-66,58}})));
  Modelica.Blocks.Sources.Ramp speed(
    duration=4320,
    height=1,
    offset=0,
    startTime=2160)
    annotation (Placement(transformation(extent={{-78,-56},{-58,-36}})));
equation
  connect(OAT.y, elec_power.u[2]) annotation (Line(
      points={{-63,6},{-26,6},{-26,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supply_water_temp.y, elec_power.u[1]) annotation (Line(points={{-65,
          48},{-26,48},{-26,-0.666667},{-12,-0.666667}}, color={0,0,127}));
  connect(speed.y, elec_power.u[3]) annotation (Line(points={{-57,-46},{-26,-46},
          {-26,0.666667},{-12,0.666667}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end TableHpPerformance;
