within CCC_test.Ireland_Detached;
package Solar_Thermal_System_1
  model Basic_Test
    Buildings.Fluid.SolarCollectors.ASHRAE93 solCol(
      redeclare package Medium = Buildings.Media.Water,
      azi=0,
      til=0.5235987755983,
      rho=0.2,
      nColType=Buildings.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      sysConfig=Buildings.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      per=Buildings.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_GuangdongFSPTY95())
      annotation (Placement(transformation(extent={{-36,10},{-16,30}})));

    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-86,52},{-46,92}}), iconTransformation(
            extent={{-290,-10},{-270,10}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          "C:/Users/User/OneDrive/Documents/School/Thesis/Weather_Data/IRL_Dublin.039690_IWEC.mos")
      annotation (Placement(transformation(extent={{-132,64},{-112,84}})));
    Buildings.Fluid.Sources.Boundary_pT bou(
      redeclare package Medium = Buildings.Media.Water,
      use_p_in=true,
      T=283.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-90,-16},{-70,4}})));
    Modelica.Blocks.Sources.Sine sine(
      f=3/86400,
      amplitude=-solCol.dp_nominal,
      offset=1E5) "Pressure source"
      annotation (Placement(transformation(extent={{-140,-18},{-120,2}})));
    Buildings.Fluid.Sources.Boundary_pT bou1(
      redeclare package Medium = Buildings.Media.Water,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{54,-8},{34,12}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
        Medium = Buildings.Media.Water)
      annotation (Placement(transformation(extent={{-62,-14},{-42,6}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package
        Medium = Buildings.Media.Water)
      annotation (Placement(transformation(extent={{0,10},{20,30}})));
  equation
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-112,74},{-90,74},{-90,72},{-66,72}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(weaBus, solCol.weaBus) annotation (Line(
        points={{-66,72},{-66,29.6},{-36,29.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sine.y, bou.p_in) annotation (Line(points={{-119,-8},{-100,-8},{
            -100,2},{-92,2}}, color={0,0,127}));
    connect(bou.ports[1], temperature.port_a) annotation (Line(points={{-70,
            -6},{-70,-4},{-62,-4}}, color={0,127,255}));
    connect(temperature.port_b, solCol.port_a) annotation (Line(points={{-42,
            -4},{-36,-4},{-36,6},{-38,6},{-38,10},{-40,10},{-40,20},{-36,20}},
          color={0,127,255}));
    connect(solCol.port_b, temperature1.port_a)
      annotation (Line(points={{-16,20},{0,20}}, color={0,127,255}));
    connect(temperature1.port_b, bou1.ports[1]) annotation (Line(points={{20,
            20},{28,20},{28,2},{34,2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Basic_Test;
end Solar_Thermal_System_1;
