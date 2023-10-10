within CCC_test.Examples;
model testTankHx
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        MediumWater,                          nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={52,10})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumWater,
    m_flow=0.575,
    T=303.15,                                       nPorts=1)
    annotation (Placement(transformation(extent={{-56,8},{-36,28}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = MediumWater, m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{-14,10},{6,30}})));
  Buildings.Fluid.Storage.BaseClasses.IndirectTankHeatExchanger
                                        indTanHex(
    redeclare final package MediumTan = Medium,
    redeclare final package MediumHex = MediumHex,
    final nSeg=nSegHex,
    final CHex=CHex,
    final volHexFlu=volHexFlu,
    final Q_flow_nominal=Q_flow_nominal,
    final TTan_nominal=TTan_nominal,
    final THex_nominal=THex_nominal,
    final r_nominal=r_nominal,
    final dExtHex=dExtHex,
    final dp_nominal=dpHex_nominal,
    final m_flow_nominal=mHex_flow_nominal,
    final energyDynamics=energyDynamicsHex,
    final energyDynamicsSolid=energyDynamicsHexSolid,
    final computeFlowResistance=computeFlowResistance,
    from_dp=from_dp,
    final linearizeFlowResistance=linearizeFlowResistance,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversalHex,
    final m_flow_small=1e-4*abs(mHex_flow_nominal))
    "Heat exchanger inside the tank"
     annotation (Placement(
        transformation(
        extent={{-10,-15},{10,15}},
        rotation=180,
        origin={37,68})));
equation
  connect(boundary1.ports[1], temperature.port_a)
    annotation (Line(points={{-36,18},{-26,18},{-26,20},{-14,20}},
                                                 color={0,127,255}));
  connect(temperature.port_b, boundary.ports[1]) annotation (Line(points={{6,20},{
          24,20},{24,10},{42,10}},  color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end testTankHx;
