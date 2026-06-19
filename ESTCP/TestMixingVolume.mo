within CCC_test.ESTCP;
model TestMixingVolume

  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Air;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=50
    "Nominal pressure difference";
              Buildings.Fluid.MixingVolumes.MixingVolumeMoistAir
                                                         vol(
    redeclare final package Medium = Medium,
    nPorts=2,
    V=0.01,
    final m_flow_nominal=m_flow_nominal)
                           "Volume for fluid stream"
     annotation (Placement(transformation(extent={{1,20},{21,0}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    m_flow=1,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-88,10},{-68,30}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,-4})));
  Buildings.Fluid.Sensors.MassFractionTwoPort senMasFraIn(redeclare final
      package Medium = Medium, final m_flow_nominal=m_flow_nominal)
    "Inlet air water mass fraction sensor" annotation (Placement(transformation(
          origin={-36,20}, extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sensors.MassFractionTwoPort senMasFraOut(redeclare final
      package Medium = Medium, final m_flow_nominal=m_flow_nominal)
    "Outlet air water mass fraction sensor" annotation (Placement(
        transformation(origin={56,-4}, extent={{-10,-10},{10,10}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse watFlo(amplitude=0.01, period=
        60) "Water flow"
    annotation (Placement(transformation(extent={{-52,-32},{-32,-12}})));
equation
  connect(watFlo.y, vol.mWat_flow) annotation (Line(points={{-30,-22},{-14,-22},
          {-14,2},{-1,2}}, color={0,0,127}));
  connect(boundary.ports[1], senMasFraIn.port_a)
    annotation (Line(points={{-68,20},{-46,20}}, color={0,127,255}));
  connect(senMasFraIn.port_b, vol.ports[1])
    annotation (Line(points={{-26,20},{10,20}}, color={0,127,255}));
  connect(vol.ports[2], senMasFraOut.port_a) annotation (Line(points={{12,20},{
          44,20},{44,-4},{46,-4}}, color={0,127,255}));
  connect(senMasFraOut.port_b, bou.ports[1])
    annotation (Line(points={{66,-4},{78,-4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=60,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end TestMixingVolume;
