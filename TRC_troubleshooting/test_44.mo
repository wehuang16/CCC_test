within CCC_test.TRC_troubleshooting;
package test_44
  model HeatPump "Example for the reversible heat pump model."
   extends Modelica.Icons.Example;

    replaceable package Medium_sin = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    replaceable package Medium_sou = AixLib.Media.Water
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    AixLib.Fluid.Sources.MassFlowSource_T                sourceSideMassFlowSource(
      use_T_in=true,
      m_flow=1,
      nPorts=1,
      redeclare package Medium = Medium_sou,
      T=275.15) "Ideal mass flow source at the inlet of the source side"
                annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

    AixLib.Fluid.Sources.Boundary_pT                  sourceSideFixedBoundary(
                                                                           nPorts=
         1, redeclare package Medium = Medium_sou)
            "Fixed boundary at the outlet of the source side"
            annotation (Placement(transformation(extent={{-11,11},{11,-11}},
          rotation=0,
          origin={-81,3})));
    Modelica.Blocks.Sources.Ramp TsuSourceRamp(
      duration=500,
      startTime=500,
      height=25,
      offset=278)
      "Ramp signal for the temperature input of the source side's ideal mass flow source"
      annotation (Placement(transformation(extent={{-94,-90},{-74,-70}})));
    Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={2,-76})));
    CCC_test.TRC_troubleshooting.test_44.HeatPumpAixlibModel heatPump(
      refIneFre_constant=1,
      useBusConnectorOnly=true,
      CEva=100,
      GEvaOut=5,
      CCon=100,
      GConOut=5,
      dpEva_nominal=0,
      dpCon_nominal=0,
      VCon=0.4,
      use_conCap=false,
      redeclare package Medium_con = Medium_sin,
      redeclare package Medium_eva = Medium_sou,
      use_refIne=false,
      use_rev=true,
      redeclare model PerDataMainHP =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (dataTable=
              AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
      redeclare model PerDataRevHP =
          AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (smoothness=
              Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
              AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
      VEva=0.04,
      use_evaCap=false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      mFlow_conNominal=0.5,
      mFlow_evaNominal=0.5,
      use_autoCalc=false,
      TAmbEva_nominal=273.15,
      TAmbCon_nominal=288.15,
      TCon_start=303.15) annotation (Placement(transformation(
          extent={{-24,-29},{24,29}},
          rotation=270,
          origin={2,-21})));

    Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=1800,
        startValue=true)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-4,84})));

    AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
       m_flow_nominal=heatPump.m1_flow_nominal,
       tau=1,
       initType=Modelica.Blocks.Types.Init.InitialState,
       tauHeaTra=1200,
       allowFlowReversal=heatPump.allowFlowReversalCon,
       transferHeat=false,
      redeclare package Medium =  Medium_sin,
       T_start=303.15,
       TAmb=291.15) "Temperature at sink inlet" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={54,-64})));
    Modelica.Blocks.Logical.Hysteresis hysHeating(
      pre_y_start=true,
      uLow=273.15 + 30,
      uHigh=273.15 + 35)
      annotation (Placement(transformation(extent={{66,58},{56,68}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={7,29})));
    Modelica.Blocks.Sources.Sine sine(
      f=1/3600,
      amplitude=3000,
      offset=3000)
      annotation (Placement(transformation(extent={{76,26},{84,34}})));
    AixLib.Fluid.Movers.SpeedControlled_y pumSou(
      redeclare  AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
       allowFlowReversal=true,
       addPowerToMedium=false,
      redeclare package Medium =  Medium_sin,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
      "Fan or pump at source side of HP" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={50,12})));

    AixLib.Fluid.MixingVolumes.MixingVolume Room(
      nPorts=2,
       use_C_flow=false,
       m_flow_nominal=heatPump.m1_flow_nominal,
       V=5,
       allowFlowReversal=true,
      redeclare package Medium = Medium_sin,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
      "Volume of Condenser" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={86,-20})));

    Modelica.Blocks.Sources.Constant nIn(k=100/3040)
                                                annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={50,34})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
      "Heat flow rate of the condenser" annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=270,
          origin={86,6})));
    Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={92,20})));
    Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},
          origin={45,63},
          rotation=180)));
    AixLib.Fluid.Sources.Boundary_pT   sinkSideFixedBoundary(      nPorts=1,
        redeclare package Medium = Medium_sin)
      "Fixed boundary at the outlet of the sink side" annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={88,-64})));
    Modelica.Blocks.Sources.Constant iceFac( k=1)
      "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
          transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-66,38})));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
      annotation (Placement(transformation(extent={{24,48},{14,58}})));
    Modelica.Blocks.Logical.Hysteresis hysCooling(
      pre_y_start=false,
      uLow=273.15 + 15,
      uHigh=273.15 + 19)
      annotation (Placement(transformation(extent={{58,40},{48,50}})));
    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
      annotation (Placement(transformation(extent={{-34,22},{-4,56}}),
          iconTransformation(extent={{-22,30},{-4,56}})));
  equation

    connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
          points={{-34,-70},{-24,-70},{-24,-45},{-12.5,-45}}, color={0,127,255}));
    connect(Room.heatPort, heatFlowRateCon.port)
      annotation (Line(points={{86,-10},{86,0}},        color={191,0,0}));
    connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,24.8}},
                        color={0,0,127}));
    connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{86,12},{86,
            14},{92,14},{92,15.6}},   color={0,0,127}));
    connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1])
      annotation (Line(points={{-12.5,3},{-70,3}}, color={0,127,255}));
    connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{16.5,-45},
            {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
    connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-19},{76,
            12},{60,12}},    color={0,127,255}));
    connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,12},{28,
            12},{28,3},{16.5,3}}, color={0,127,255}));
    connect(senTAct.T, hysHeating.u) annotation (Line(points={{54,-53},{54,-54},{
            54,-54},{54,-54},{54,-8},{70,-8},{70,63},{67,63}}, color={0,0,127}));
    connect(hysHeating.y, not2.u)
      annotation (Line(points={{55.5,63},{51,63}}, color={255,0,255}));
    connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
          points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
    connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
            -64},{66,-21},{76,-21}}, color={0,127,255}));
    connect(TsuSourceRamp.y, sourceSideMassFlowSource.T_in) annotation (Line(
          points={{-73,-80},{-66,-80},{-66,-66},{-56,-66}}, color={0,0,127},
          smooth=Smooth.None));
    connect(logicalSwitch.u1, not2.y) annotation (Line(points={{25,57},{36,57},{
            36,63},{39.5,63}}, color={255,0,255}));
    connect(hysCooling.y, logicalSwitch.u3) annotation (Line(points={{47.5,45},{
            36,45},{36,49},{25,49}}, color={255,0,255}));
    connect(senTAct.T, hysCooling.u) annotation (Line(points={{54,-53},{54,-54},{
            54,-54},{54,-54},{54,-54},{54,-54},{54,-8},{70,-8},{70,45},{59,45}},
          color={0,0,127}));
    connect(booleanStep.y, logicalSwitch.u2) annotation (Line(points={{-4,77.4},{
            -4,66},{32,66},{32,53},{25,53}}, color={255,0,255}));
    connect(logicalSwitch.y, booleanToReal.u)
      annotation (Line(points={{13.5,53},{7,53},{7,35}}, color={255,0,255}));
    connect(booleanStep.y, sigBus1.modeSet) annotation (Line(points={{-4,77.4},{-10,
            77.4},{-10,39.085},{-18.925,39.085}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(iceFac.y, sigBus1.iceFacMea) annotation (Line(points={{-57.2,38},{-34,
            38},{-34,39.085},{-18.925,39.085}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(booleanToReal.y, sigBus1.nSet) annotation (Line(points={{7,23.5},{
            -18.925,23.5},{-18.925,39.085}},
                                     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus1, heatPump.sigBus) annotation (Line(
        points={{-19,39},{-19,16},{-10,16},{-10,2.76},{-7.425,2.76}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(pumSou.y, nIn.y)
      annotation (Line(points={{50,24},{50,29.6}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(Tolerance=1e-6, StopTime=3600),
  __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos"
          "Simulate and plot"),
      Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Simple test set-up for the HeatPumpDetailed model. The heat pump is
  turned on and off while the source temperature increases linearly.
  Outputs are the electric power consumption of the heat pump and the
  supply temperature.
</p>
<p>
  Besides using the default simple table data, the user should also
  test tabulated data from <a href=
  \"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or
  polynomial functions.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"),
      __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
      Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
  end HeatPump;

  model HeatPumpAixlibModel
    "Grey-box model for reversible heat pumps using a black-box to simulate the refrigeration cycle"
    extends
      CCC_test.TRC_troubleshooting.test_44.PartialReversibleVapourCompressionMachine(
      use_rev=true,
      machineType=true,
      redeclare CCC_test.TRC_troubleshooting.test_44.InnerCycle_HeatPump
        innerCycle(
        use_rev=use_rev,
        scalingFactor=scalingFactor,
        redeclare model PerDataMainHP = PerDataMainHP,
        redeclare model PerDataRevHP = PerDataRevHP));

    replaceable model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
    "Performance data of a heat pump in main operation mode"
      annotation (choicesAllMatching=true);
    replaceable model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
    "Performance data of a heat pump in reversible operation mode"
      annotation (Dialog(enable=use_rev),choicesAllMatching=true);

    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This generic grey-box heat pump model uses empirical data to model
  the refrigerant cycle. The modelling of system inertias and heat
  losses allow the simulation of transient states.
</p>
<p>
  Resulting in the choosen model structure, several configurations are
  possible:
</p>
<ol>
  <li>Compressor type: on/off or inverter controlled
  </li>
  <li>Reversible heat pump / only heating
  </li>
  <li>Source/Sink: Any combination of mediums is possible
  </li>
  <li>Generik: Losses and inertias can be switched on or off.
  </li>
</ol>
<h4>
  Concept
</h4>
<p>
  Using a signal bus as a connector, this heat pump model can be easily
  combined with the new <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">HeatPumpSystem</a>
  or several control or safety blocks from <a href=
  \"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>.
  The relevant data is aggregated. In order to control both chillers
  and heat pumps, both flow and return temperature are aggregated. The
  mode signal chooses the type of the heat pump operation. As a result,
  this model can also be used as a chiller:
</p>
<ul>
  <li>mode = true: Heating
  </li>
  <li>mode = false: Chilling
  </li>
</ul>
<p>
  To model both on/off and inverter controlled heat pumps, the
  compressor speed is normalizd to a relative value between 0 and 1.
</p>
<p>
  Possible icing of the evaporator is modelled with an input value
  between 0 and 1.
</p>
<p>
  The model structure is as follows. To understand each submodel,
  please have a look at the corresponding model information:
</p>
<ol>
  <li>
    <a href=
    \"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle\">InnerCycle</a>
    (Black Box): Here, the user can use between several input models or
    just easily create his own, modular black box model. Please look at
    the model description for more info.
  </li>
  <li>Inertia: A n-order element is used to model system inertias (mass
  and thermal) of components inside the refrigerant cycle (compressor,
  pipes, expansion valve)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">
    HeatExchanger</a>: This new model also enable modelling of thermal
    interias and heat losses in a heat exchanger. Please look at the
    model description for more info.
  </li>
</ol>
<h4>
  Parametrization
</h4>
<p>
  To simplify the parametrization of the evaporator and condenser
  volumes and nominal mass flows there exists an option of automatic
  estimation based on the nominal usable heating power of the HeatPump.
  This function uses a linear correlation of these parameters, which
  was established from the linear regression of more than 20 data sets
  of water-to-water heat pumps from different manufacturers (e.g.
  Carrier, Trane, Lennox) ranging from about 25kW to 1MW nominal power.
  The linear regressions with coefficients of determination above 91%
  give a good approximation of these parameters. Nevertheless,
  estimates for machines outside the given range should be checked for
  plausibility during simulation.
</p>
<h4>
  Assumptions
</h4>
<p>
  Several assumptions where made in order to model the heat pump. For a
  detailed description see the corresponding model.
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    Performance data 2D</a>: In order to model inverter controlled heat
    pumps, the compressor speed is scaled <b>linearly</b>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    Performance data 2D</a>: Reduced evaporator power as a result of
    icing. The icing factor is multiplied with the evaporator power.
  </li>
  <li>
    <b>Inertia</b>: The default value of the n-th order element is set
    to 3. This follows comparisons with experimental data. Previous
    heat pump models are using n = 1 as a default. However, it was
    pointed out that a higher order element fits a real heat pump
    better in.
  </li>
  <li>
    <b>Scaling factor</b>: A scaling facor is implemented for scaling
    of the heat pump power and capacity. The factor scales the
    parameters V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a
    result, the heat pump can supply more heat with the COP staying
    nearly constant. However, one has to make sure that the supplied
    pressure difference or mass flow is also scaled with this factor,
    as the nominal values do not increase said mass flow.
  </li>
</ol>
<h4>
  Known Limitations
</h4>
<ul>
  <li>The n-th order element has a big influence on computational time.
  Reducing the order or disabling it completly will decrease
  computational time.
  </li>
  <li>Reversing the mode: A normal 4-way-exchange valve suffers from
  heat losses and irreversibilities due to switching from one mode to
  another. Theses losses are not taken into account.
  </li>
</ul>
</html>"));
  end HeatPumpAixlibModel;

  partial model PartialReversibleVapourCompressionMachine
    "Grey-box model for reversible heat pumps and chillers using a black-box to simulate the refrigeration cycle"
    extends CCC_test.TRC_troubleshooting.test_44.PartialFourPortInterface(
      redeclare package Medium1 = Medium_con,
      redeclare package Medium2 = Medium_eva,
      m1_flow_nominal=mFlow_conNominal_final,
      m2_flow_nominal=mFlow_evaNominal_final,
      allowFlowReversal1=allowFlowReversalCon,
      allowFlowReversal2=allowFlowReversalEva,
      m1_flow_small=1E-4*abs(mFlow_conNominal_final),
      m2_flow_small=1E-4*abs(mFlow_evaNominal_final),
      show_T=show_TPort);

  //General
    replaceable package Medium_con =
      Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
      annotation (Dialog(tab = "Condenser"),choicesAllMatching=true);
    replaceable package Medium_eva =
      Modelica.Media.Interfaces.PartialMedium "Medium at source side"
      annotation (Dialog(tab = "Evaporator"),choicesAllMatching=true);
    replaceable CCC_test.TRC_troubleshooting.test_44.PartialInnerCycle innerCycle
      "Blackbox model of refrigerant cycle of a vapour compression machine"
      annotation (Placement(transformation(
          extent={{-27,-26},{27,26}},
          rotation=90,
          origin={0,-1})));
      //constrainedby CCC_test.TRC_troubleshooting.test_44.PartialInnerCycle

    parameter Boolean use_rev=true "Is the vapour compression machine reversible?"   annotation(choices(checkBox=true), Dialog(descriptionLabel=true));
    parameter Boolean use_autoCalc=false
      "Enable automatic estimation of volumes and mass flows?"
      annotation(choices(checkBox=true), Dialog(descriptionLabel=true));
    parameter Modelica.Units.SI.Power Q_useNominal=0
      "Nominal usable heat flow of the vapour compression machine (HP: Heating; Chiller: Cooling)"
      annotation (Dialog(enable=use_autoCalc));
    parameter Real scalingFactor=1 "Scaling-factor of vapour compression machine";
    parameter Boolean use_refIne=true
      "Consider the inertia of the refrigerant cycle"
      annotation(choices(checkBox=true), Dialog(
          group="Refrigerant inertia"));
    parameter Modelica.Units.SI.Frequency refIneFre_constant
      "Cut off frequency for inertia of refrigerant cycle" annotation (Dialog(
          enable=use_refIne, group="Refrigerant inertia"), Evaluate=true);
    parameter Integer nthOrder=3 "Order of refrigerant cycle interia" annotation (Dialog(enable=
            use_refIne, group="Refrigerant inertia"));
    parameter Boolean useBusConnectorOnly = false "Set true to use bus connector for modeSet, nSet and iceFac input"
      annotation(choices(checkBox=true), Dialog(group="Input Connectors"));

  //Condenser
    parameter Modelica.Units.SI.MassFlowRate mFlow_conNominal
      "Manual input of the nominal mass flow rate (if not automatically calculated)"
      annotation (Dialog(
        group="Parameters",
        tab="Condenser",
        enable=not use_autoCalc), Evaluate=true);
    parameter Modelica.Units.SI.Volume VCon
      "Manual input of the condenser volume (if not automatically calculated)"
      annotation (Evaluate=true, Dialog(
        group="Parameters",
        tab="Condenser",
        enable=not use_autoCalc));
    parameter Modelica.Units.SI.PressureDifference dpCon_nominal
      "Pressure drop at nominal mass flow rate" annotation (Dialog(group=
            "Flow resistance", tab="Condenser"), Evaluate=true);
    parameter Real deltaM_con=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Condenser", group="Flow resistance"));
    parameter Boolean use_conCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Condenser"),
                                            choices(checkBox=true));
    parameter Modelica.Units.SI.HeatCapacity CCon
      "Heat capacity of Condenser (= cp*m). If you want to neglace the dry mass of the condenser, you can set this value to zero"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Condenser",
        enable=use_conCap));
    parameter Modelica.Units.SI.ThermalConductance GConOut=0
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection. If you want to simulate a condenser with additional dry mass but without external heat losses, set the value to zero"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Condenser",
        enable=use_conCap));
    parameter Modelica.Units.SI.ThermalConductance GConIns=0
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Condenser",
        enable=use_conCap));
  //Evaporator
    parameter Modelica.Units.SI.MassFlowRate mFlow_evaNominal
      "Manual input of the nominal mass flow rate (if not automatically calculated)"
      annotation (Dialog(
        group="Parameters",
        tab="Evaporator",
        enable=not use_autoCalc), Evaluate=true);
    parameter Modelica.Units.SI.Volume VEva
      "Manual input of the evaporator volume (if not automatically calculated)"
      annotation (Evaluate=true, Dialog(
        group="Parameters",
        tab="Evaporator",
        enable=not use_autoCalc));
    parameter Modelica.Units.SI.PressureDifference dpEva_nominal
      "Pressure drop at nominal mass flow rate" annotation (Dialog(group=
            "Flow resistance", tab="Evaporator"), Evaluate=true);
    parameter Real deltaM_eva=0.1
      "Fraction of nominal mass flow rate where transition to turbulent occurs"
      annotation (Dialog(tab="Evaporator", group="Flow resistance"));
    parameter Boolean use_evaCap=true
      "If heat losses at capacitor side are considered or not"
      annotation (Dialog(group="Heat Losses", tab="Evaporator"),
                                            choices(checkBox=true));
    parameter Modelica.Units.SI.HeatCapacity CEva
      "Heat capacity of Evaporator (= cp*m). If you want to neglace the dry mass of the evaporator, you can set this value to zero"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.Units.SI.ThermalConductance GEvaOut=0
      "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection. If you want to simulate a evaporator with additional dry mass but without external heat losses, set the value to zero"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Evaporator",
        enable=use_evaCap));
    parameter Modelica.Units.SI.ThermalConductance GEvaIns=0
      "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
      annotation (Evaluate=true, Dialog(
        group="Heat Losses",
        tab="Evaporator",
        enable=use_evaCap));
  //Assumptions
    parameter Modelica.Units.SI.Time tauSenT=1
      "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"));
    parameter Boolean transferHeat=true
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Assumptions", group="Temperature sensors"),choices(checkBox=true));
    parameter Boolean allowFlowReversalEva=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Evaporator", tab="Assumptions"));
    parameter Boolean allowFlowReversalCon=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Dialog(group="Condenser", tab="Assumptions"));
    parameter Modelica.Units.SI.Time tauHeaTraEva=1200
      "Time constant for heat transfer in temperature sensors in evaporator, default 20 minutes"
      annotation (Dialog(
        tab="Assumptions",
        group="Temperature sensors",
        enable=transferHeat), Evaluate=true);
    parameter Modelica.Units.SI.Temperature TAmbEva_nominal=273.15
      "Fixed ambient temperature for heat transfer of sensors at the evaporator side"
      annotation (Dialog(
        tab="Assumptions",
        group="Temperature sensors",
        enable=transferHeat));
    parameter Modelica.Units.SI.Time tauHeaTraCon=1200
      "Time constant for heat transfer in temperature sensors in condenser, default 20 minutes"
      annotation (Dialog(
        tab="Assumptions",
        group="Temperature sensors",
        enable=transferHeat), Evaluate=true);
    parameter Modelica.Units.SI.Temperature TAmbCon_nominal=291.15
      "Fixed ambient temperature for heat transfer of sensors at the condenser side"
      annotation (Dialog(
        tab="Assumptions",
        group="Temperature sensors",
        enable=transferHeat));

  //Initialization
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Initialization", group="Parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pCon_start=
        Medium_con.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.Temperature TCon_start=Medium_con.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Units.SI.Temperature TConCap_start=Medium_con.T_default
      "Initial temperature of heat capacity of condenser" annotation (Dialog(
        tab="Initialization",
        group="Condenser",
        enable=use_conCap));
    parameter Modelica.Media.Interfaces.Types.MassFraction XCon_start[Medium_con.nX]=
       Medium_con.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Condenser"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pEva_start=
        Medium_eva.p_default "Start value of pressure"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Media.Interfaces.Types.Temperature TEva_start=Medium_eva.T_default
      "Start value of temperature"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Modelica.Units.SI.Temperature TEvaCap_start=Medium_eva.T_default
      "Initial temperature of heat capacity at evaporator" annotation (Dialog(
        tab="Initialization",
        group="Evaporator",
        enable=use_evaCap));
    parameter Modelica.Media.Interfaces.Types.MassFraction XEva_start[Medium_eva.nX]=
       Medium_eva.X_default "Start value of mass fractions m_i/m"
      annotation (Evaluate=true,Dialog(tab="Initialization", group="Evaporator"));
    parameter Real x_start[nthOrder]=zeros(nthOrder)
      "Initial or guess values of states"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia", enable=use_refIne));
    parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Initialization", group="Refrigerant inertia",enable=initType ==
            Init.InitialOutput and use_refIne));
  //Dynamics
    parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of mass balance: dynamic (3 initialization options) or steady state (only affects fluid-models)"
      annotation (Dialog(tab="Dynamics", group="Equation"));
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance: dynamic (3 initialization options) or steady state (only affects fluid-models)"
      annotation (Dialog(tab="Dynamics", group="Equation"));
  //Advanced
    parameter Boolean machineType "=true if heat pump; =false if chiller"
      annotation (Dialog(tab="Advanced", group="General machine information"));
    parameter Boolean show_TPort=false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));
    parameter Boolean from_dp=false
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    constant Boolean homotopyInitialization=false "= true, use homotopy method"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));
    parameter Boolean linearized=false
      "= true, use linear relation between m_flow and dp for any flow rate"
      annotation (Dialog(tab="Advanced", group="Flow resistance"));

    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity con(
      redeclare package Medium =  Medium_con,
       allowFlowReversal=allowFlowReversalCon,
       m_flow_small=1E-4*abs(mFlow_conNominal_final),
       show_T=show_TPort,
       deltaM=deltaM_con,
       T_start=TCon_start,
       p_start=pCon_start,
       use_cap=use_conCap,
       X_start=XCon_start,
       from_dp=from_dp,
       homotopyInitialization=homotopyInitialization,
       energyDynamics=energyDynamics,
       is_con=true,
       V=VCon_final*scalingFactor,
       C=CCon*scalingFactor,
       TCap_start=TConCap_start,
       GOut=GConOut*scalingFactor,
       m_flow_nominal=mFlow_conNominal_final*scalingFactor,
       dp_nominal=dpCon_nominal*scalingFactor,
       GInn=GConIns*scalingFactor) "Heat exchanger model for the condenser"
      annotation (Placement(transformation(extent={{-16,78},{16,110}})));
    AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity eva(
      redeclare package Medium =  Medium_eva,
       deltaM=deltaM_eva,
       use_cap=use_evaCap,
       allowFlowReversal=allowFlowReversalEva,
       m_flow_small=1E-4*abs(mFlow_evaNominal_final),
       show_T=show_TPort,
       T_start=TEva_start,
       p_start=pEva_start,
       X_start=XEva_start,
       from_dp=from_dp,
       homotopyInitialization=homotopyInitialization,
       energyDynamics=energyDynamics,
       is_con=false,
       V=VEva_final*scalingFactor,
       C=CEva*scalingFactor,
       m_flow_nominal=mFlow_evaNominal_final*scalingFactor,
       dp_nominal=dpEva_nominal*scalingFactor,
       TCap_start=TEvaCap_start,
       GOut=GEvaOut*scalingFactor,
       GInn=GEvaIns*scalingFactor) "Heat exchanger model for the evaporator"
      annotation (Placement(transformation(extent={{16,-70},{-16,-102}})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneEva(
       initType=initType,
       normalized=true,
       n=nthOrder,
       f=refIneFre_constant,
       x_start=x_start,
       y_start=yRefIne_start)     if use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={-14,-52})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetCon
                                                                if not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={16,58})));
    Modelica.Blocks.Continuous.CriticalDamping heatFlowIneCon(
       initType=initType,
       normalized=true,
       n=nthOrder,
       f=refIneFre_constant,
       x_start=x_start,
       y_start=yRefIne_start)     if use_refIne
      "This n-th order block represents the inertia of the refrigerant cycle and delays the heat flow"
      annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-16,58})));
    Modelica.Blocks.Routing.RealPassThrough realPassThroughnSetEva if not use_refIne
      "Use default nSet value" annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={16,-52})));
    Modelica.Blocks.Interfaces.RealInput iceFac_in if not useBusConnectorOnly
      "Input signal for icing factor" annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={-76,-136})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutEva
   if use_evaCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-32,-110})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempOutCon
   if use_conCap "Foreces heat losses according to ambient temperature"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-52,114})));

    Modelica.Blocks.Interfaces.RealInput nSet if not useBusConnectorOnly
      "Input signal speed for compressor relative between 0 and 1" annotation (Placement(
          transformation(extent={{-132,4},{-100,36}})));
    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
        Placement(transformation(extent={{-120,-60},{-90,-26}}),
          iconTransformation(extent={{-108,-52},{-90,-26}})));

    Modelica.Blocks.Interfaces.RealInput T_amb_eva( unit="K",
        displayUnit="degC") if use_evaCap and not useBusConnectorOnly
      "Ambient temperature on the evaporator side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-100})));
    Modelica.Blocks.Interfaces.RealInput T_amb_con( unit="K",
        displayUnit="degC") if use_conCap and not useBusConnectorOnly
      "Ambient temperature on the condenser side"
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=180,
          origin={110,100})));

    Modelica.Blocks.Interfaces.BooleanInput modeSet if not useBusConnectorOnly
       and use_rev
      "Set value of operation mode"
      annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));

    AixLib.Fluid.Sensors.TemperatureTwoPort senT_a2(
      redeclare package Medium =  Medium_eva,
       allowFlowReversal=allowFlowReversalEva,
       m_flow_small=1E-4*mFlow_evaNominal_final,
       initType=initType,
       T_start=TEva_start,
       transferHeat=transferHeat,
       TAmb=TAmbEva_nominal,
       tauHeaTra=tauHeaTraEva,
       tau=tauSenT,
       m_flow_nominal=mFlow_evaNominal_final*scalingFactor)
      "Temperature at sink inlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={38,-86})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senT_b2(
      redeclare package Medium =  Medium_eva,
       allowFlowReversal=allowFlowReversalEva,
       m_flow_small=1E-4*mFlow_evaNominal_final,
       initType=initType,
       T_start=TEva_start,
       transferHeat=transferHeat,
       TAmb=TAmbEva_nominal,
       tauHeaTra=tauHeaTraEva,
       tau=tauSenT,
       m_flow_nominal=mFlow_evaNominal_final*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-52,-86})));
    AixLib.Fluid.Sensors.MassFlowRate mFlow_eva(redeclare package Medium =
          Medium_eva,  allowFlowReversal=allowFlowReversalEva)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={72,-60},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    AixLib.Fluid.Sensors.TemperatureTwoPort senT_b1(
       initType=initType,
       transferHeat=transferHeat,
       TAmb=TAmbCon_nominal,
      redeclare package Medium =  Medium_con,
       allowFlowReversal=allowFlowReversalCon,
       m_flow_small=1E-4*mFlow_conNominal_final,
       T_start=TCon_start,
       tau=tauSenT,
       tauHeaTra=tauHeaTraCon,
       m_flow_nominal=mFlow_conNominal_final*scalingFactor)
      "Temperature at sink outlet" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={38,92})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senT_a1(
       initType=initType,
       transferHeat=transferHeat,
      redeclare package Medium =  Medium_con,
       allowFlowReversal=allowFlowReversalCon,
       m_flow_small=1E-4*mFlow_conNominal_final,
       T_start=TCon_start,
       TAmb=TAmbCon_nominal,
       tau=tauSenT,
       m_flow_nominal=mFlow_conNominal_final*scalingFactor,
       tauHeaTra=tauHeaTraCon) "Temperature at sink inlet" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=0,
          origin={-34,90})));
    AixLib.Fluid.Sensors.MassFlowRate mFlow_con( allowFlowReversal=
          allowFlowReversalEva, redeclare package Medium =  Medium_con)
      "Mass flow sensor at the evaporator" annotation (Placement(transformation(
          origin={-76,60},
          extent={{-10,10},{10,-10}},
          rotation=0)));

    //Automatic calculation of mass flow rates and volumes of the evaporator and condenser using linear regressions from data sheets of heat pumps and chillers (water to water)

    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold( threshold=
          Modelica.Constants.eps)
      "Use default nSet value" annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={-66,-28})));

    parameter Modelica.Units.SI.MassFlowRate autoCalc_mFlow_min=0.3
      "Realistic mass flow minimum for simulation plausibility";
    parameter Modelica.Units.SI.Volume autoCalc_Vmin=0.003
      "Realistic volume minimum for simulation plausibility";

    parameter Modelica.Units.SI.MassFlowRate autoCalc_mFlow_eva=if machineType
         then max(0.00004*Q_useNominal - 0.3177, autoCalc_mFlow_min) else max(
        0.00005*Q_useNominal - 0.5662, autoCalc_mFlow_min);
    parameter Modelica.Units.SI.MassFlowRate autoCalc_mFlow_con=if machineType
         then max(0.00004*Q_useNominal - 0.6162, autoCalc_mFlow_min) else max(
        0.00005*Q_useNominal + 0.3161, autoCalc_mFlow_min);
    parameter Modelica.Units.SI.MassFlowRate mFlow_evaNominal_final=if
        use_autoCalc then autoCalc_mFlow_eva else mFlow_evaNominal;
    parameter Modelica.Units.SI.MassFlowRate mFlow_conNominal_final=if
        use_autoCalc then autoCalc_mFlow_con else mFlow_conNominal;
    parameter Modelica.Units.SI.Volume autoCalc_VEva=if machineType then max(
        0.0000001*Q_useNominal - 0.0075, autoCalc_Vmin) else max(0.0000001*
        Q_useNominal - 0.0066, autoCalc_Vmin);
    parameter Modelica.Units.SI.Volume autoCalc_VCon=if machineType then max(
        0.0000001*Q_useNominal - 0.0094, autoCalc_Vmin) else max(0.0000002*
        Q_useNominal - 0.0084, autoCalc_Vmin);
    parameter Modelica.Units.SI.Volume VEva_final=if use_autoCalc then
        autoCalc_VEva else VEva;
    parameter Modelica.Units.SI.Volume VCon_final=if use_autoCalc then
        autoCalc_VCon else VCon;

  equation
    //Control and feedback for the auto-calculation of condenser and evaporator data
    assert(not use_autoCalc or (use_autoCalc and Q_useNominal>0), "Can't auto-calculate evaporator and condenser data without a given nominal power flow (Q_useNominal)!",
    level = AssertionLevel.error);
    assert(not use_autoCalc or (autoCalc_mFlow_eva>autoCalc_mFlow_min and autoCalc_mFlow_eva<90),
    "Given nominal power (Q_useNominal) for auto-calculation of evaporator and condenser data is outside the range of data sheets considered. Please control the auto-calculated mass flows!",
    level = AssertionLevel.warning);
    assert(not use_autoCalc or (autoCalc_VEva>autoCalc_Vmin and autoCalc_VEva<0.43),
    "Given nominal power (Q_useNominal) for auto-calculation of evaporator and condenser data is outside the range of data sheets considered. Please control the auto-calculated volumes!",
    level = AssertionLevel.warning);

    connect(senT_a1.T, sigBus.TConInMea) annotation (Line(points={{-34,79},{-34,40},
            {-76,40},{-76,-42.915},{-104.925,-42.915}},     color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b1.T, sigBus.TConOutMea) annotation (Line(points={{38,81},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_a2.T, sigBus.TEvaInMea) annotation (Line(points={{38,-75},{38,-36},
            {-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(senT_b2.T, sigBus.TEvaOutMea) annotation (Line(points={{-52,-75},{-52,
            -42.915},{-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_eva.m_flow, sigBus.m_flowEvaMea) annotation (Line(points={{72,-49},
            {72,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(mFlow_con.m_flow, sigBus.m_flowConMea) annotation (Line(points={{-76,49},
            {-76,-42.915},{-104.925,-42.915}},     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(innerCycle.QEva, realPassThroughnSetEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{16,-38},{16,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QEva, heatFlowIneEva.u) annotation (Line(
        points={{-1.77636e-15,-30.7},{-1.77636e-15,-38},{-14,-38},{-14,-44.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, heatFlowIneCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{1.77636e-15,30},{0,30},{0,40},{-16,40},{-16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.QCon, realPassThroughnSetCon.u) annotation (Line(
        points={{1.77636e-15,28.7},{0,28.7},{0,40},{16,40},{16,50.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(innerCycle.sigBus, sigBus) annotation (Line(
        points={{-26.78,-0.73},{-54,-0.73},{-54,-43},{-105,-43}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(innerCycle.Pel, sigBus.PelMea) annotation (Line(points={{28.73,-0.865},
            {38,-0.865},{38,-36},{-52,-36},{-52,-42.915},{-104.925,-42.915}},
                                                                          color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    connect(modeSet, sigBus.modeSet) annotation (Line(points={{-116,-20},{-76,-20},
            {-76,-42.915},{-104.925,-42.915}},
                                          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(nSet,sigBus.nSet)  annotation (Line(points={{-116,20},{-76,20},{-76,-42.915},
            {-104.925,-42.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(iceFac_in, sigBus.iceFacMea) annotation (Line(points={{-76,-136},{-76,
            -42.915},{-104.925,-42.915}},
                                 color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(T_amb_con, varTempOutCon.T) annotation (Line(
        points={{110,100},{80,100},{80,126},{-76,126},{-76,114},{-61.6,114}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(varTempOutCon.port, con.port_out) annotation (Line(
        points={{-44,114},{0,114},{0,110}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(T_amb_eva, varTempOutEva.T) annotation (Line(
        points={{110,-100},{80,-100},{80,-120},{-48,-120},{-48,-110},{-41.6,-110}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(eva.port_out, varTempOutEva.port) annotation (Line(
        points={{0,-102},{0,-110},{-24,-110}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(port_b2, port_b2) annotation (Line(points={{-100,-60},{-100,-60}},
                   color={0,127,255}));
    connect(realPassThroughnSetCon.y, con.QFlow_in) annotation (Line(
        points={{16,64.6},{16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(heatFlowIneCon.y, con.QFlow_in) annotation (Line(
        points={{-16,64.6},{-16,77.04},{0,77.04}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realPassThroughnSetEva.y, eva.QFlow_in) annotation (Line(points={{16,-58.6},
            {16,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(heatFlowIneEva.y, eva.QFlow_in) annotation (Line(points={{-14,-58.6},{
            -14,-69.04},{0,-69.04}}, color={0,0,127}));
    connect(senT_a2.port_b, eva.port_a)
      annotation (Line(points={{28,-86},{16,-86}}, color={0,127,255}));
    connect(senT_b2.port_a, eva.port_b)
      annotation (Line(points={{-42,-86},{-16,-86}}, color={0,127,255}));
    connect(senT_b2.port_b, port_b2) annotation (Line(points={{-62,-86},{-62,-60},
            {-100,-60}}, color={0,127,255}));
    connect(mFlow_eva.port_a, port_a2)
      annotation (Line(points={{82,-60},{100,-60}}, color={0,127,255}));
    connect(mFlow_eva.port_b, senT_a2.port_a) annotation (Line(points={{62,-60},{58,
            -60},{58,-86},{48,-86}}, color={0,127,255}));
    connect(con.port_a, senT_a1.port_b)
      annotation (Line(points={{-16,94},{-20,94},{-20,90},{-24,90}},
                                                   color={0,127,255}));
    connect(senT_a1.port_a, mFlow_con.port_b) annotation (Line(points={{-44,90},{-56,
            90},{-56,60},{-66,60}},     color={0,127,255}));
    connect(port_a1, mFlow_con.port_a)
      annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
    connect(con.port_b, senT_b1.port_a)
      annotation (Line(points={{16,94},{22,94},{22,92},{28,92}},
                                                 color={0,127,255}));
    connect(port_b1, senT_b1.port_b) annotation (Line(points={{100,60},{72,60},{72,
            92},{48,92}}, color={0,127,255}));
    connect(greaterThreshold.y, sigBus.onOffMea) annotation (Line(points={{-59.4,-28},
            {-56,-28},{-56,-42.915},{-104.925,-42.915}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(varTempOutCon.T, sigBus.TConAmbMea) annotation (Line(
        points={{-61.6,114},{-76,114},{-76,-42.915},{-104.925,-42.915}},
        color={0,0,127},
        pattern=LinePattern.Dash), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(varTempOutEva.T, sigBus.TEvaAmbMea) annotation (Line(
        points={{-41.6,-110},{-76,-110},{-76,-42.915},{-104.925,-42.915}},
        color={0,0,127},
        pattern=LinePattern.Dash), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(greaterThreshold.u, sigBus.nSet) annotation (Line(points={{-73.2,-28},
            {-76,-28},{-76,-42.915},{-104.925,-42.915}},color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
          Rectangle(
            extent={{-16,83},{16,-83}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,-64},
            rotation=90),
          Rectangle(
            extent={{-17,83},{17,-83}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0},
            origin={1,61},
            rotation=90),
          Text(
            extent={{-76,6},{74,-36}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name
"),       Line(
            points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-3,-60},
            rotation=-90),
          Line(
            points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
            color={0,0,0},
            smooth=Smooth.None,
            origin={-5,56},
            rotation=-90),
          Rectangle(
            extent={{-82,42},{84,-46}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,60},{88,60}}, color={28,108,200}),
          Line(points={{-88,-60},{88,-60}}, color={28,108,200}),
      Line(
      origin={-75.5,-80.333},
      points={{43.5,8.3333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,-11.667},{27.5,-21.667},{13.5,-23.667},
                {11.5,-31.667}},
        smooth=Smooth.Bezier,
        visible=use_evaCap),
          Polygon(
            points={{-70,-122},{-68,-108},{-58,-114},{-70,-122}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_evaCap),
      Line( origin={40.5,93.667},
            points={{39.5,6.333},{37.5,0.3333},{25.5,-1.667},{33.5,-9.667},{17.5,
                -11.667},{27.5,-21.667},{13.5,-23.667},{11.5,-27.667}},
            smooth=Smooth.Bezier,
            visible=use_conCap),
          Polygon(
            points={{86,110},{84,96},{74,102},{86,110}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0},
            visible=use_conCap),
          Line(
            points={{-42,72},{34,72}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-38,0},{38,0}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5,
            origin={0,-74},
            rotation=180)}),                Diagram(coordinateSystem(extent={{-100,
              -120},{100,120}})),
      Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This partial model for a generic grey-box vapour compression machine
  (heat pump or chiller) uses empirical data to model the refrigerant
  cycle. The modelling of system inertias and heat losses allow the
  simulation of transient states.
</p>
<p>
  Resulting in the choosen model structure, several configurations are
  possible:
</p>
<ol>
  <li>Compressor type: on/off or inverter controlled
  </li>
  <li>Reversible operation / only main operation
  </li>
  <li>Source/Sink: Any combination of mediums is possible
  </li>
  <li>Generik: Losses and inertias can be switched on or off.
  </li>
</ol>
<h4>
  Concept
</h4>
<p>
  Using a signal bus as a connector, this model working as a heat pump
  can be easily combined with several control or safety blocks from
  <a href=
  \"modelica://AixLib.Controls.HeatPump\">AixLib.Controls.HeatPump</a>.
  The relevant data is aggregated. In order to control both chillers
  and heat pumps, both flow and return temperature are aggregated. The
  mode signal chooses the operation type of the vapour compression
  machine:
</p>
<ul>
  <li>mode = true: Main operation mode (heat pump: heating; chiller:
  cooling)
  </li>
  <li>mode = false: Reversible operation mode (heat pump: cooling;
  chiller: heating)
  </li>
</ul>
<p>
  To model both on/off and inverter controlled vapour compression
  machines, the compressor speed is normalizd to a relative value
  between 0 and 1.
</p>
<p>
  Possible icing of the evaporator is modelled with an input value
  between 0 and 1.
</p>
<p>
  The model structure is as follows. To understand each submodel,
  please have a look at the corresponding model information:
</p>
<ol>
  <li>
    <a href=
    \"AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle_HeatPump\">InnerCycle</a>
    (Black Box): Here, the user can use between several input models or
    just easily create his own, modular black box model. Please look at
    the model description for more info.
  </li>
  <li>Inertia: A n-order element is used to model system inertias (mass
  and thermal) of components inside the refrigerant cycle (compressor,
  pipes, expansion valve)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatExchangers.EvaporatorCondenserWithCapacity\">
    HeatExchanger</a>: This new model also enable modelling of thermal
    interias and heat losses in a heat exchanger. Please look at the
    model description for more info.
  </li>
</ol>
<h4>
  Parametrization
</h4>
<p>
  To simplify the parametrization of the evaporator and condenser
  volumes and nominal mass flows there exists an option of automatic
  estimation based on the nominal usable power of the vapour
  compression machine. This function uses a linear correlation of these
  parameters, which was established from the linear regression of more
  than 20 data sets of water-to-water heat pumps from different
  manufacturers (e.g. Carrier, Trane, Lennox) ranging from about 25kW
  to 1MW nominal power. The linear regressions with coefficients of
  determination above 91% give a good approximation of these
  parameters. Nevertheless, estimates for machines outside the given
  range should be checked for plausibility during simulation.
</p>
<h4>
  Assumptions
</h4>
<p>
  Several assumptions where made in order to model the vapour
  compression machine. For a detailed description see the corresponding
  model.
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    Performance data 2D</a>: In order to model inverter controlled
    machines, the compressor speed is scaled <b>linearly</b>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    Performance data 2D</a>: Reduced evaporator power as a result of
    icing. The icing factor is multiplied with the evaporator power.
  </li>
  <li>
    <b>Inertia</b>: The default value of the n-th order element is set
    to 3. This follows comparisons with experimental data. Previous
    heat pump models are using n = 1 as a default. However, it was
    pointed out that a higher order element fits a real heat pump
    better in
  </li>
  <li>
    <b>Scaling factor</b>: A scaling facor is implemented for scaling
    of the thermal power and capacity. The factor scales the parameters
    V, m_flow_nominal, C, GIns, GOut and dp_nominal. As a result, the
    vapour compression machine can supply more heat with the COP
    staying nearly constant. However, one has to make sure that the
    supplied pressure difference or mass flow is also scaled with this
    factor, as the nominal values do not increase said mass flow.
  </li>
</ol>
<h4>
  Known Limitations
</h4>
<ul>
  <li>The n-th order element has a big influence on computational time.
  Reducing the order or disabling it completly will decrease
  computational time.
  </li>
  <li>Reversing the mode: A normal 4-way-exchange valve suffers from
  heat losses and irreversibilities due to switching from one mode to
  another. Theses losses are not taken into account.
  </li>
</ul>
</html>"));
  end PartialReversibleVapourCompressionMachine;

  partial model PartialFourPortInterface
    "Partial model with four ports and declaration of quantities that are used by many models"
    extends CCC_test.TRC_troubleshooting.test_44.PartialFourPort;
    parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium1.MassFlowRate m1_flow_small(min=0) = 1E-4*abs(m1_flow_nominal)
      "Small mass flow rate for regularization of zero flow"
      annotation(Dialog(tab = "Advanced"));
    parameter Medium2.MassFlowRate m2_flow_small(min=0) = 1E-4*abs(m2_flow_nominal)
      "Small mass flow rate for regularization of zero flow"
      annotation(Dialog(tab = "Advanced"));
    // Diagnostics
    parameter Boolean show_T = false
      "= true, if actual temperature at port is computed"
      annotation (
        Dialog(tab="Advanced", group="Diagnostics"),
        HideResult=true);

    Medium1.MassFlowRate m1_flow = port_a1.m_flow
      "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
    Modelica.Units.SI.PressureDifference dp1(displayUnit="Pa") = port_a1.p - port_b1.p
      "Pressure difference between port_a1 and port_b1";

    Medium2.MassFlowRate m2_flow = port_a2.m_flow
      "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
    Modelica.Units.SI.PressureDifference dp2(displayUnit="Pa") = port_a2.p - port_b2.p
      "Pressure difference between port_a2 and port_b2";

    Medium1.ThermodynamicState sta_a1=
      if allowFlowReversal1 then
        Medium1.setState_phX(port_a1.p,
                            noEvent(actualStream(port_a1.h_outflow)),
                            noEvent(actualStream(port_a1.Xi_outflow)))
      else
        Medium1.setState_phX(port_a1.p,
                            inStream(port_a1.h_outflow),
                            inStream(port_a1.Xi_outflow))
        if show_T "Medium properties in port_a1";
    Medium1.ThermodynamicState sta_b1=
      if allowFlowReversal1 then
        Medium1.setState_phX(port_b1.p,
                            noEvent(actualStream(port_b1.h_outflow)),
                            noEvent(actualStream(port_b1.Xi_outflow)))
      else
        Medium1.setState_phX(port_b1.p,
                            port_b1.h_outflow,
                            port_b1.Xi_outflow)
         if show_T "Medium properties in port_b1";

    Medium2.ThermodynamicState sta_a2=
      if allowFlowReversal2 then
        Medium2.setState_phX(port_a2.p,
                            noEvent(actualStream(port_a2.h_outflow)),
                            noEvent(actualStream(port_a2.Xi_outflow)))
      else
        Medium2.setState_phX(port_a2.p,
                            inStream(port_a2.h_outflow),
                            inStream(port_a2.Xi_outflow))
        if show_T "Medium properties in port_a2";
    Medium2.ThermodynamicState sta_b2=
      if allowFlowReversal2 then
        Medium2.setState_phX(port_b2.p,
                            noEvent(actualStream(port_b2.h_outflow)),
                            noEvent(actualStream(port_b2.Xi_outflow)))
      else
        Medium2.setState_phX(port_b2.p,
                            port_b2.h_outflow,
                            port_b2.Xi_outflow)
         if show_T "Medium properties in port_b2";

    Medium1.ThermodynamicState state_a1_inflow=
      Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow))
      "state for medium inflowing through port_a1";
    Medium1.ThermodynamicState state_b1_inflow=
      Medium1.setState_phX(port_b1.p, inStream(port_b1.h_outflow), inStream(port_b1.Xi_outflow))
      "state for medium inflowing through port_b1";
    Medium2.ThermodynamicState state_a2_inflow=
      Medium2.setState_phX(port_a2.p, inStream(port_a2.h_outflow), inStream(port_a2.Xi_outflow))
      "state for medium inflowing through port_a2";
    Medium2.ThermodynamicState state_b2_inflow=
      Medium2.setState_phX(port_b2.p, inStream(port_b2.h_outflow), inStream(port_b2.Xi_outflow))
      "state for medium inflowing through port_b2";

    annotation (
    preferredView="info",
      Documentation(info="<html>
<p>
This component defines the interface for models with four fluid ports
and two fluid streams.
It is similar to
<a href=\"modelica://AixLib.Fluid.Interfaces.PartialTwoPortInterface\">
AixLib.Fluid.Interfaces.PartialTwoPortInterface</a>,
but it has four ports instead of two.
</p>
<p>
The model is used by other models in this package that add heat transfer,
mass transfer and pressure drop equations.
</p>
</html>",   revisions="<html>
<ul>
<li>
September 22, 2023, by Michael Wetter:<br/>
Improved documentation.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1796\">IBPSA, #1796</a>.
</li>
<li>
February 3, 2022, by Michael Wetter:<br/>
If <code>allowFlowReversal==false</code>, removed <code>noEvent()</code> declaration
for <code>sta_a</code> and for <code>sta_b</code> because the variable is either
already used with <code>inStream()</code> in the computation of <code>state_*_inflow</code>,
or the result of a variable of the model that already may generate an event.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1578\">IBPSA, #1578</a>.
</li>
<li>
February 2, 2022, by Hongxiang Fu:<br/>
If <code>allowFlowReversal==false</code>, replaced <code>actualStream()</code>
with <code>inStream()</code> for <code>sta_a</code> and
removed <code>actualStream()</code> for <code>sta_b</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1578\">IBPSA, #1578</a>.
</li>
<li>
March 30, 2021, by Michael Wetter:<br/>
Added annotation <code>HideResult=true</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1459\">IBPSA, #1459</a>.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Moved computation of pressure drop to variable assignment so that
the model won't mix graphical with textual modeling if used as a base
class for a graphically implemented model.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Removed start values for mass flow rate and pressure difference
to simplify the parameter window.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/552\">#552</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
November 13, 2013 by Michael Wetter:<br/>
Removed assignment of <code>min</code> and <code>max</code>
attributes of port mass flow rates, as this is already
done in the base class.
</li>
<li>
November 12, 2013 by Michael Wetter:<br/>
Removed <code>import Modelica.Constants;</code> statement.
</li>
<li>
November 11, 2013 by Michael Wetter:<br/>
Removed the parameter <code>homotopyInitialization</code>
as it is no longer used in this model.
</li>
<li>
November 10, 2013 by Michael Wetter:<br/>
In the computation of <code>sta_a1</code>,
<code>sta_a2</code>, <code>sta_b1</code> and <code>sta_b2</code>,
removed the branch that uses the homotopy operator.
The rational is that these variables are conditionally enables (because
of <code>... if show_T</code>). Therefore, the Modelica Language Specification
does not allow for these variables to be used in any equation. Hence,
the use of the homotopy operator is not needed here.
</li>
<li>
October 10, 2013 by Michael Wetter:<br/>
Added <code>noEvent</code> to the computation of the states at the port.
This is correct, because the states are only used for reporting, but not
to compute any other variable.
Use of the states to compute other variables would violate the Modelica
language, as conditionally removed variables must not be used in any equation.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed the computation of <code>V_flow</code> and removed the parameter
<code>show_V_flow</code>.
The reason is that the computation of <code>V_flow</code> required
the use of <code>sta_a</code> (to compute the density),
but <code>sta_a</code> is also a variable that is conditionally
enabled. However, this was not correct Modelica syntax as conditional variables
can only be used in a <code>connect</code>
statement, not in an assignment. Dymola 2014 FD01 beta3 is checking
for this incorrect syntax. Hence, <code>V_flow</code> was removed as its
conditional implementation would require a rather cumbersome implementation
that uses a new connector that carries the state of the medium.
</li>
<li>
April 26, 2013 by Marco Bonvini:<br/>
Moved the definitions of <code>dp1</code> and <code>dp2</code> because they cause some problem with PyFMI.
</li>
<li>
March 27, 2012 by Michael Wetter:<br/>
Replaced the erroneous function call <code>Medium.density</code> with
<code>Medium1.density</code> and <code>Medium2.density</code>.
Changed condition to remove <code>sta_a1</code> and <code>sta_a2</code> to also
compute the states at the inlet port if <code>show_V_flow=true</code>.
The previous implementation resulted in a translation error
if <code>show_V_flow=true</code>, but worked correctly otherwise
because the erroneous function call is removed if  <code>show_V_flow=false</code>.
</li>
<li>
March 27, 2011 by Michael Wetter:<br/>
Added <code>homotopy</code> operator.
</li>
<li>
March 21, 2010 by Michael Wetter:<br/>
Changed pressure start value from <code>system.p_start</code>
to <code>Medium.p_default</code> since HVAC models may have water and
air, which are typically at different pressures.
</li>
<li>
September 19, 2008 by Michael Wetter:<br/>
Added equations for the mass balance of extra species flow,
i.e., <code>C</code> and <code>mC_flow</code>.
</li>
<li>
April 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end PartialFourPortInterface;

  partial model PartialFourPort "Partial model with four ports"

    replaceable package Medium1 =
      Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
        annotation (choices(
          choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
          choice(redeclare package Medium = AixLib.Media.Water "Water"),
          choice(redeclare package Medium =
              AixLib.Media.Antifreeze.PropyleneGlycolWater (
            property_T=293.15,
            X_a=0.40)
            "Propylene glycol water, 40% mass fraction")));
    replaceable package Medium2 =
      Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
        annotation (choices(
          choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
          choice(redeclare package Medium = AixLib.Media.Water "Water"),
          choice(redeclare package Medium =
              AixLib.Media.Antifreeze.PropyleneGlycolWater (
            property_T=293.15,
            X_a=0.40)
            "Propylene glycol water, 40% mass fraction")));

    parameter Boolean allowFlowReversal1 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);
    parameter Boolean allowFlowReversal2 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                       redeclare package Medium =  Medium1,
                       m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                       h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                       redeclare package Medium =  Medium1,
                       m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                       h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{110,50},{90,70}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                       redeclare package Medium =  Medium2,
                       m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                       h_outflow(start = Medium2.h_default, nominal = Medium2.h_default))
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                       redeclare package Medium =  Medium2,
                       m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                       h_outflow(start = Medium2.h_default, nominal = Medium2.h_default))
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{-90,-70},{-110,-50}})));

    annotation (
      preferredView="info",
      Documentation(info="<html>
<p>
This model defines an interface for components with four ports.
The parameters <code>allowFlowReversal1</code> and
<code>allowFlowReversal2</code> may be used by models that extend
this model to treat flow reversal.
</p>
<p>
This model is identical to
<a href=\"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">
Modelica.Fluid.Interfaces.PartialTwoPort</a>, except for the
fowllowing:
</p>
<ol>
<li>it has four ports, and
</li>
<li>
the parameters <code>port_a_exposesState</code>,
<code>port_b_exposesState</code> and
<code>showDesignFlowDirection</code>
are not implemented.
</li>
</ol>
</html>",   revisions="<html>
<ul>
<li>
April 6, 2020, by Filip Jorissen:<br/>
Added arrows to the icon indicating the intended flow direction
when <code>allowFlowReversal=false</code>.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1336\">#1336</a>.
</li>
<li>
January 18, 2019, by Jianjun Hu:<br/>
Limited the media choice.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
</li>
<li>
July 8, 2018, by Filip Jorissen:<br/>
Added nominal value of <code>h_outflow</code> in <code>FluidPorts</code>.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/977\">#977</a>.
</li>
<li>
November 12, 2015, by Michael Wetter:<br/>
Renamed model from <code>FourPort</code> to
<code>PartialFourPort</code>.
Removed parameters
<code>h_outflow_a1_start</code>,
<code>h_outflow_b1_start</code>,
<code>h_outflow_a2_start</code> and
<code>h_outflow_b2_start</code>.
This is for issue
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/299\">#299</a>.
</li>
<li>
October 30, 2015, by Matthis Thorade:<br/>
Added <code>partial</code> keyword to model declaration.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Changed medium declaration in ports to be final.
</li>
<li>
October 3, 2014, by Michael Wetter:<br/>
Changed assignment of nominal value to avoid in OpenModelica the warning
alias set with different nominal values.
</li>
<li>
November 12, 2013, by Michael Wetter:<br/>
Removed <code>import Modelica.Constants</code> statement.
</li>
<li>
September 26, 2013 by Michael Wetter:<br/>
Added missing <code>each</code> keyword in declaration of nominal value for
<code>Xi_outflow</code>.
</li>
<li>
September 17, 2010 by Michael Wetter:<br/>
Fixed bug: The start value for <code>port_b1.h_outflow</code>
was set to <code>h_outflow_b2_start</code> instead of <code>h_outflow_b1_start</code>.
</li>
<li>
February 26, 2010 by Michael Wetter:<br/>
Added start values for outflowing enthalpy because they
are often iteration variables in nonlinear equation systems.
</li>
</ul>
</html>"),
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
        Text(
            extent={{-151,147},{149,107}},
            textColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255},
            textString="%name"),
        Polygon(
            points={{-5,10},{25,10},{-5,-10},{-5,10}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=not allowFlowReversal1,
            origin={75,50},
            rotation=360),
        Polygon(
            points={{10,10},{-20,-10},{10,-10},{10,10}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=not allowFlowReversal2,
            origin={-79,-50},
            rotation=360)}));
  end PartialFourPort;

  model InnerCycle_HeatPump
    "Blackbox model of refrigerant cycle of a heat pump"
    extends CCC_test.TRC_troubleshooting.test_44.PartialInnerCycle;

    replaceable model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
      "Replaceable model for performance data of a heat pump in main operation mode"
      annotation (choicesAllMatching=true);
      //constrainedby
      //AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData

    replaceable model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
      "Replaceable model for performance data of a heat pump in reversible operation mode"
      annotation (Dialog(enable=use_rev),choicesAllMatching=true);
      //constrainedby
      //AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData

    PerDataMainHP PerformanceDataHPHeating
    annotation (Placement(transformation(
    extent={{7,20},{61,76}},  rotation=0)));
    PerDataRevHP PerformanceDataHPCooling if use_rev
    annotation (Placement(transformation(extent={{-27,-28},{27,28}},
    rotation=0,origin={-34,48})));
    Modelica.Blocks.Math.Gain gainEva( k=-1)
      "Negate QEva to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={-56,-6})));
    Modelica.Blocks.Math.Gain gainCon( k=-1) if use_rev
      "Negate QCon to match definition of heat flow direction" annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={58,-20})));

  equation

    connect(PerformanceDataHPHeating.QCon, switchQCon.u1)
      annotation (Line(points={{12.4,17.2},{12.4,-4},{68,-4}}, color={0,0,127}));
    connect(PerformanceDataHPHeating.Pel, switchPel.u1) annotation (Line(
          points={{34,17.2},{34,-30},{8,-30},{8,-68}}, color={0,0,127}));
    connect(PerformanceDataHPCooling.Pel, switchPel.u3) annotation (
        Line(
        points={{-34,17.2},{-34,-30},{-8,-30},{-8,-68}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataHPCooling.QEva, switchQEva.u3) annotation (
        Line(
        points={{-12.4,17.2},{-12.4,-22},{-68,-22}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZero.y, switchPel.u3)
      annotation (Line(points={{-59,-68},{-34,-68},{-34,-68},{-8,-68}},
                                                    color={0,0,127}));
    connect(constZero.y, switchQEva.u3) annotation (Line(points={{-59,-68},{-52,-68},
            {-52,-22},{-68,-22}},      color={0,0,127},
        pattern=LinePattern.Dash));
    connect(constZero.y, switchQCon.u3) annotation (Line(points={{-59,-68},{-52,-68},
            {-52,-38},{68,-38},{68,-20}},      color={0,0,127},
        pattern=LinePattern.Dash));
    connect(gainEva.y, switchQEva.u1)
      annotation (Line(points={{-60.4,-6},{-68,-6}}, color={0,0,127}));
    connect(switchQCon.u3, gainCon.y) annotation (Line(
        points={{68,-20},{62.4,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataHPCooling.QCon, gainCon.u) annotation (Line(
        points={{-55.6,17.2},{-55.6,2},{-24,2},{-24,-20},{53.2,-20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(PerformanceDataHPHeating.QEva, gainEva.u) annotation (Line(points={{55.6,
            17.2},{55.6,-6},{-51.2,-6}},       color={0,0,127}));
    connect(sigBus, PerformanceDataHPCooling.sigBus) annotation (Line(
        points={{0,102},{0,86},{-33.73,86},{-33.73,77.12}},
        color={255,204,51},
        thickness=0.5));
    connect(sigBus, PerformanceDataHPHeating.sigBus) annotation (Line(
        points={{0,102},{0,86},{34.27,86},{34.27,77.12}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-24,88},{22,44}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-16,82},{20,74}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-18,52},{20,58}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{-98,40},{-60,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{60,40},{98,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,40},{-80,68},{-24,68}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{22,66},{80,66},{80,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-28},{78,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-70},{62,-70},{20,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,-26},{-80,-68},{-20,-68}},
            color={28,108,200},
            thickness=0.5),
          Text(
            extent={{-30,28},{30,-28}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="%name",
            origin={0,-8},
            rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This black box model represents the refrigerant cycle of a heat pump.
  Used in AixLib.Fluid.HeatPumps.HeatPump, this model serves the
  simulation of a reversible heat pump. Thus, data both of chillers and
  heat pumps can be used to calculate the three relevant values
  <span style=\"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span>. The <span style=
  \"font-family: Courier New;\">mode</span> of the heat pump is used to
  switch between the performance data of the chiller and the heat pump.
</p>
<p>
  The user can choose between different types of performance data or
  implement a new black-box model by extending from the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.ReversibleHeatPump_PerformanceData.BaseClasses.PartialPerformanceData\">
  partial</a> model.
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">
    LookUpTableND</a>: Use SDF-data tables to model invertercontroller
    heat pumps or include other dependencies (ambient temperature etc.)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">
    PolynomalApproach</a>: Use a function based approach to calculate
    the ouputs. Different functions are already implemented.
  </li>
</ul>
</html>"));
  end InnerCycle_HeatPump;

  partial model PartialInnerCycle
    "Blackbox model of refrigerant cycle of a vapour compression machine (heat pump or chiller)"

    parameter Boolean use_rev=true "True if the vapour compression machine is reversible";
    parameter Real scalingFactor=1 "Scaling factor of vapour compression machine";

    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
        Placement(transformation(extent={{-18,86},{18,118}}), iconTransformation(
            extent={{-16,88},{18,118}})));
    Modelica.Blocks.Sources.Constant constZero( k=0) if not use_rev
      "If no heating is used, the switches may still be connected"
      annotation (Placement(transformation(extent={{-80,-78},{-60,-58}})));
    Modelica.Blocks.Interfaces.RealOutput QCon(unit="W", displayUnit="kW") "Heat Flow to condenser"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput QEva(unit="W", displayUnit="kW") "Heat flow from evaporator"
      annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
    AixLib.Utilities.Logical.SmoothSwitch switchQEva(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{-70,-24},{-90,-4}})));
    AixLib.Utilities.Logical.SmoothSwitch switchQCon(
      y(unit="W", displayUnit="kW"),
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"))
      "If mode is false, Condenser becomes Evaporator and vice versa"
      annotation (Placement(transformation(extent={{70,-22},{90,-2}})));
    Modelica.Blocks.Interfaces.RealOutput Pel(unit="W", displayUnit="kW")
      "Electrical power consumed by compressor" annotation (Placement(
          transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=-90,
          origin={0.5,-110.5})));

    AixLib.Utilities.Logical.SmoothSwitch switchPel(
      u1(unit="W", displayUnit="kW"),
      u3(unit="W", displayUnit="kW"),
      y(unit="W", displayUnit="kW"))
      "Whether to use cooling or heating power consumption" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-80})));

  equation
    assert(
      use_rev or (use_rev == false and sigBus.modeSet == true),
      "Can't turn to reversible operation mode on irreversible vapour compression machine",
      level=AssertionLevel.error);

    connect(switchQEva.y, QEva) annotation (Line(points={{-91,-14},{-94,-14},{-94,
            0},{-110,0}}, color={0,0,127}));
    connect(switchPel.y, Pel) annotation (Line(points={{-2.22045e-15,-91},{
            -2.22045e-15,-110.5},{0.5,-110.5}},
                                   color={0,0,127}));
    connect(sigBus.modeSet,  switchPel.u2) annotation (Line(
        points={{0.09,102.08},{0.09,-68},{2.22045e-15,-68}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));

    connect(switchQCon.y, QCon) annotation (Line(points={{91,-12},{94,-12},{94,0},
            {110,0}}, color={0,0,127}));
    connect(sigBus.modeSet, switchQEva.u2) annotation (Line(
        points={{0.09,102.08},{-64,102.08},{-64,-14},{-68,-14}},
        color={255,204,51},
        thickness=0.5));
    connect(sigBus.modeSet, switchQCon.u2) annotation (Line(
        points={{0.09,102.08},{64,102.08},{64,-12},{68,-12}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-24,88},{22,44}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-16,82},{20,74}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-18,52},{20,58}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{-98,40},{-60,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{-20,-60},{-20,-70},{-20,-80},{20,-60},{20,-80},{-20,-60}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-122,34},{-66,34},{-82,10},{-66,-22},{-120,-22}},
            color={28,108,200},
            thickness=0.5),
          Rectangle(
            extent={{60,40},{98,-28}},
            lineColor={28,108,200},
            lineThickness=0.5),
          Line(
            points={{120,34},{64,34},{80,10},{64,-22},{118,-22}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,40},{-80,68},{-24,68}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{22,66},{80,66},{80,40}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-28},{78,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{78,-70},{62,-70},{20,-70}},
            color={28,108,200},
            thickness=0.5),
          Line(
            points={{-80,-26},{-80,-68},{-20,-68}},
            color={28,108,200},
            thickness=0.5),
          Text(
            extent={{-30,28},{30,-28}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="%name",
            origin={0,-8},
            rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the vapour compression machine
    partial model (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This black box model represents the refrigerant cycle of a vapour
  compression machine. Used in AixLib.Fluid.HeatPumps.HeatPump and
  AixLib.Fluid.Chiller.Chiller, this model serves the simulation of a
  reversible vapour compression machine. Thus, data both of chillers
  and heat pumps can be used to calculate the three relevant values
  <span style=\"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span>. The <span style=
  \"font-family: Courier New;\">mode</span> of the machine is used to
  switch between the performance data of the chiller and the heat pump.
</p>
<p>
  The user can choose between different types of performance data or
  implement a new black-box model by extending from the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData\">
  partial</a> model.
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D\">
    LookUpTable2D</a>: Use 2D-data based on the DIN EN 14511
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTableND\">
    LookUpTableND</a>: Use SDF-data tables to model invertercontroller
    heat pumps or chillers or include other dependencies (ambient
    temperature etc.)
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.PolynomalApproach\">
    PolynomalApproach</a>: Use a function based approach to calculate
    the ouputs. Different functions are already implemented.
  </li>
</ul>
</html>"));
  end PartialInnerCycle;
end test_44;
