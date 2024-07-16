within CCC_test.obsolete;
model MultiHeatPumpTankSystem_test1

              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
   parameter Real num_heat_pump=1
    "number of heat pumps";

       parameter Modelica.Units.SI.MassFlowRate mEva_flow_nominal=1.293
    "Heat pump nominal mass flow rate in evaporator";
     parameter Modelica.Units.SI.Temperature WaterHeaterTankSetpoint=273.15+48
    "Water Heater Tank Setpoint";
      parameter Modelica.Units.SI.TemperatureDifference WaterHeaterTankSetpointDelta=3
    "Water Heater Tank Setpoint Delta";
parameter Modelica.Units.SI.Power QHp_flow_nominal=1743.5
    "Heat pump nominal heat flow";
      parameter Modelica.Units.SI.MassFlowRate  mCon_flow_nominal=0.575;
//parameter Modelica.Units.SI.PressureDifference  dp_nominal=1000;
  IBPSA.Fluid.HeatPumps.ModularReversible.AirToWaterTableData2D heaPum(
    redeclare package MediumCon = MediumWater,
    redeclare package MediumEva = MediumAir,
    allowDifferentDeviceIdentifiers=true,
    use_intSafCtr=false,
    dpCon_nominal(displayUnit="Pa") = 2000,
    dpEva_nominal(displayUnit="Pa") = 200,
    QHea_flow_nominal=QHp_flow_nominal*num_heat_pump,
    TConHea_nominal=328.15,
    TEvaHea_nominal=278.15,
    TConCoo_nominal=290.15,
    TEvaCoo_nominal=303.15,
    datTabHea=CCC.Fluid.HeatPumps.Data.SanCO2_heat_pump_heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    redeclare
      IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar(
      use_minOnTime=true,
      minOnTime=300,
      use_minOffTime=true,
      minOffTime=300,
      use_maxCycRat=true)) "Reversible heat pump based on 2D table data"
    annotation (Placement(transformation(extent={{-28,-2},{-48,18}})));
  Modelica.Blocks.Sources.BooleanConstant conPumAlwOn(final k=true)
    "Let the pumps always run, due to inertia of the heat pump" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-4})));
  Modelica.Blocks.Math.BooleanToReal booToReaPumEva(realTrue=heaPum.mEva_flow_nominal,
      y(start=0))
    "Pump signal" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-142,-56})));
  IBPSA.Fluid.Movers.Preconfigured.FlowControlled_m_flow pumHeaPumSou(
    addPowerToMedium=false,
    dp_nominal=HeatPumpGroup1.heaPum1.dpEva_nominal,
    redeclare package Medium = MediumAir,
    m_flow_start=4*mEva_flow_nominal,
    m_flow_nominal=4*mEva_flow_nominal,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Pump for heat pump source side" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-54})));
  IBPSA.Fluid.Sources.Boundary_pT sin(nPorts=1, redeclare package Medium =
        MediumAir)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{96,-78},{76,-58}})));
  IBPSA.Fluid.Sources.Boundary_pT sou(
    use_T_in=true,
    redeclare package Medium = MediumAir,
    T=281.15,
    nPorts=1) "Fluid source on source side"
    annotation (Placement(transformation(extent={{-74,-102},{-54,-82}})));
  Modelica.Blocks.Sources.BooleanConstant
                                TAirSouSte1
                        "Air source temperature step for cooling phase"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={12,56})));
  Modelica.Blocks.Interfaces.RealInput OAT "outdoor air temeprature"
    annotation (Placement(transformation(extent={{-140,-106},{-100,-66}}),
        iconTransformation(extent={{-140,-106},{-100,-66}})));
  IBPSA.Fluid.Movers.Preconfigured.FlowControlled_m_flow mov1(
    addPowerToMedium=false,
    redeclare package Medium = MediumWater,
    m_flow_start=mCon_flow_nominal,
    m_flow_nominal=mCon_flow_nominal,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Pump for heat pump water side" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,48})));
  Modelica.Blocks.Interfaces.RealInput OccupantHotWaterUsageFlow
    annotation (Placement(transformation(extent={{-140,2},{-100,42}}),
        iconTransformation(extent={{-140,2},{-100,42}})));
  Modelica.Blocks.Interfaces.RealInput CityWaterTemperature
    annotation (Placement(transformation(extent={{-140,-54},{-100,-14}}),
        iconTransformation(extent={{-140,-54},{-100,-14}})));
  Modelica.Blocks.Interfaces.RealInput HeatPumSupplyTempSetpoint
    annotation (Placement(transformation(extent={{-140,62},{-100,102}}),
        iconTransformation(extent={{-140,62},{-100,102}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumSupWatTem(redeclare package
      Medium = MediumWater, m_flow_nominal=mCon_flow_nominal)
    "HeatPumpSupplyWaterTemperature"
    annotation (Placement(transformation(extent={{-34,72},{-14,92}})));
  Modelica.Blocks.Sources.Constant const(final k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-230,82})));
  Modelica.Blocks.Sources.Constant const1(final k=1)
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={122,-10})));
  Modelica.Blocks.Interfaces.IntegerInput thermostat_at_layer annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={186,-170}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={18,-120})));
  Modelica.Blocks.Interfaces.IntegerInput thermostat_at_tank annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={288,-164}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={78,-122})));
  CCC.Controls.FmuPatch fmuPatch
    annotation (Placement(transformation(extent={{-208,-64},{-188,-44}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumRetWatTem(redeclare package
      Medium = MediumWater, m_flow_nominal=mCon_flow_nominal)
    "HeatPumpReturnWaterTemperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,14})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumRetAirTem(redeclare package
      Medium = MediumAir, m_flow_nominal=mEva_flow_nominal)
    "HeatPumpSupplyWaterTemperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-40})));
  IBPSA.Fluid.Sources.Boundary_pT sin1(nPorts=1, redeclare package Medium =
        MediumWater)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{56,68},{36,88}})));
  Modelica.Blocks.Sources.Constant const2(final k=0.5)
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,58})));
  IBPSA.Fluid.Sources.Boundary_pT sin2(
    T=323.15,
    nPorts=1,
    redeclare package Medium = MediumWater)
              "Fluid sink on source side"
    annotation (Placement(transformation(extent={{66,20},{46,40}})));
  Modelica.Blocks.Math.Gain gain(k=4)
    annotation (Placement(transformation(extent={{-94,-74},{-74,-54}})));
equation
assert(WaterHeaterTankSetpointDelta >0,
    "WaterHeaterTankSetpointDelta must be positive.");
    assert(HeatPumSupplyTempSetpoint >= WaterHeaterTankSetpoint + WaterHeaterTankSetpointDelta+3,
    "HeatPumSupplyTempSetpoint must be at least 3 Kelvin higher than WaterHeaterTankSetpoint + WaterHeaterTankSetpointDelta.");
  connect(conPumAlwOn.y,booToReaPumEva. u) annotation (Line(points={{-69,-4},{
          -66,-4},{-66,-50},{-96,-50},{-96,-56},{-154,-56}},
                                                color={255,0,255}));
  connect(heaPum.port_a2,pumHeaPumSou. port_b) annotation (Line(
        points={{-48,2},{-56,2},{-56,-32},{-30,-32},{-30,-44}},
                                                 color={0,127,255}));
  connect(sou.ports[1],pumHeaPumSou. port_a) annotation (Line(points={{-54,-92},
          {-30,-92},{-30,-64}},   color={0,127,255}));
  connect(TAirSouSte1.y, heaPum.hea) annotation (Line(points={{1,56},{-20,56},{-20,
          5.9},{-26.9,5.9}},                   color={255,0,255}));
  connect(sou.T_in, OAT) annotation (Line(points={{-76,-88},{-138,-88},{-138,
          -86},{-120,-86}},
                       color={0,0,127}));
  connect(mov1.port_a, heaPum.port_b1)
    annotation (Line(points={{-48,38},{-48,24},{-56,24},{-56,14},{-48,14}},
                                                          color={0,127,255}));
  connect(mov1.port_b, HeaPumSupWatTem.port_a)
    annotation (Line(points={{-48,58},{-48,82},{-34,82}}, color={0,127,255}));
  connect(heaPum.port_a1, HeaPumRetWatTem.port_b)
    annotation (Line(points={{-28,14},{-8,14}}, color={0,127,255}));
  connect(heaPum.port_b2, HeaPumRetAirTem.port_a)
    annotation (Line(points={{-28,2},{70,2},{70,-30}}, color={0,127,255}));
  connect(HeaPumRetAirTem.port_b, sin.ports[1])
    annotation (Line(points={{70,-50},{70,-68},{76,-68}}, color={0,127,255}));
  connect(const1.y, heaPum.ySet) annotation (Line(points={{133,-10},{138,-10},{138,
          -12},{148,-12},{148,9.9},{-26.9,9.9}}, color={0,0,127}));
  connect(HeaPumSupWatTem.port_b, sin1.ports[1]) annotation (Line(points={{-14,82},
          {28,82},{28,78},{36,78}}, color={0,127,255}));
  connect(const2.y, mov1.m_flow_in) annotation (Line(points={{-79,58},{-68,58},{
          -68,48},{-60,48}}, color={0,0,127}));
  connect(sin2.ports[1], HeaPumRetWatTem.port_a) annotation (Line(points={{46,30},
          {16,30},{16,14},{12,14}}, color={0,127,255}));
  connect(gain.y, pumHeaPumSou.m_flow_in) annotation (Line(points={{-73,-64},{
          -52,-64},{-52,-54},{-42,-54}}, color={0,0,127}));
  connect(gain.u, booToReaPumEva.y) annotation (Line(points={{-96,-64},{-96,-78},
          {-70,-78},{-70,-52},{-98,-52},{-98,-56},{-131,-56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiHeatPumpTankSystem_test1;
