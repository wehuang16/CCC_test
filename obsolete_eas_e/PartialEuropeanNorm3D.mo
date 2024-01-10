within CCC_test.obsolete_eas_e;
partial model PartialEuropeanNorm3D
  "Partial model with components for EuropeanNorm2D approach for heat pumps and chillers"
  parameter Modelica.Blocks.Types.Smoothness smoothness=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=
    Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation of data outside the definition range";
  parameter Boolean use_evaOut
    "=true to use evaporator outlet temperature, false for inlet";
  parameter Boolean use_conOut
    "=true to use condenser outlet temperature, false for inlet";
  Modelica.Blocks.Math.Gain                    TEvaToDegC(k=1)
    "Table input is in degC"       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,60})));
  Modelica.Blocks.Math.Gain                    TConToDegC(k=1)
    "Table input is in degC"      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,60})));

  Modelica.Blocks.Math.Product scaFacTimPel "Scale electrical power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-8})));
  Modelica.Blocks.Math.Product scaFacTimQUse_flow "Scale useful heat flow rate"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={42,-2})));
  Modelica.Blocks.Sources.Constant constScaFac
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={-80,70})));

  Modelica.Blocks.Routing.RealPassThrough
                               reaPasThrTEvaIn if not use_evaOut
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConIn if not use_conOut
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTEvaOut if use_evaOut
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConOut if use_conOut
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,90})));
  SDF.NDTable condenser_heat(
    dataset="/condenser_heat",
    dataUnit="W",
    scaleUnits={"K","K","1"},
    nin=3,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/SDF/heat_pump_performance_map.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
    data=SDF.Functions.readTableData(
        elec_power.filename,
        elec_power.dataset,
        elec_power.dataUnit,
        elec_power.scaleUnits),
    readFromFile=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={74,28})));
  SDF.NDTable elec_power(
    dataset="/elec_power",
    dataUnit="W",
    scaleUnits={"K","K","1"},
    nin=3,
    filename=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/SDF/heat_pump_performance_map.sdf"),
    interpMethod=SDF.Types.InterpolationMethod.Akima,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
    data=SDF.Functions.readTableData(
        elec_power.filename,
        elec_power.dataset,
        elec_power.dataUnit,
        elec_power.scaleUnits),
    readFromFile=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,30})));
protected
  parameter Real perDevMasFloCon
    "Deviation of nominal mass flow rate at condenser in percent";
  parameter Real perDevMasFloEva
    "Deviation of nominal mass flow rate at evaporator in percent";
  /*parameter Modelica.Blocks.Types.ExternalCombiTable2D tabIdeQUse_flow=
      Modelica.Blocks.Types.ExternalCombiTable2D(
      "NoName",
      "NoName",
      tabQUse_flow.table,
      smoothness,
      extrapolation,
      false) "External table object for nominal useful side conditions";*/
  /*parameter Modelica.Blocks.Types.ExternalCombiTable2D tabIdePEle=
      Modelica.Blocks.Types.ExternalCombiTable2D(
      "NoName",
      "NoName",
      tabPEle.table,
      smoothness,
      extrapolation,
      false) "External table object for nominal electrical power";*/
initial algorithm
  assert(perDevMasFloCon < 1,
      "The deviation of the given mCon_flow_nominal to the table data is " +
      String(perDevMasFloCon) + " %. Carefully check results,
      you are extrapolating the table data!",
    AssertionLevel.warning);
  assert(perDevMasFloEva < 1,
    "The deviation of the given mEva_flow_nominal to the table data is " +
      String(perDevMasFloEva) + " %. Carefully check results,
      you are extrapolating the table data!",
    AssertionLevel.warning);

equation
  connect(reaPasThrTConOut.y, TConToDegC.u) annotation (Line(points={{70,79},{70,
          76},{60,76},{60,72}}, color={0,0,127}));
  connect(TConToDegC.u, reaPasThrTConIn.y) annotation (Line(points={{60,72},{60,
          76},{40,76},{40,79}}, color={0,0,127}));
  connect(reaPasThrTEvaOut.y, TEvaToDegC.u) annotation (Line(points={{-22,79},{
          -22,76},{-40,76},{-40,72}},
                                  color={0,0,127}));
  connect(reaPasThrTEvaIn.y, TEvaToDegC.u) annotation (Line(points={{-50,79},{-50,
          76},{-40,76},{-40,72}}, color={0,0,127}));
  connect(constScaFac.y, scaFacTimPel.u2) annotation (Line(points={{-80,59},{
          -80,12},{-58,12},{-58,4},{-46,4}}, color={0,0,127}));
  connect(constScaFac.y, scaFacTimQUse_flow.u2) annotation (Line(points={{-80,
          59},{-82,59},{-82,10},{36,10}}, color={0,0,127}));
  connect(TEvaToDegC.y, elec_power.u[1]) annotation (Line(points={{-40,49},{-36,
          49},{-36,44},{5.33333,44},{5.33333,42}}, color={0,0,127}));
  connect(TConToDegC.y, elec_power.u[2])
    annotation (Line(points={{60,49},{60,44},{6,44},{6,42}}, color={0,0,127}));
  connect(TConToDegC.y, condenser_heat.u[2]) annotation (Line(points={{60,49},{
          60,44},{66,44},{66,46},{74,46},{74,40}}, color={0,0,127}));
  connect(TEvaToDegC.y, condenser_heat.u[1]) annotation (Line(points={{-40,49},
          {-40,40},{73.3333,40}}, color={0,0,127}));
  connect(elec_power.y, scaFacTimPel.u1)
    annotation (Line(points={{6,19},{6,4},{-34,4}}, color={0,0,127}));
  connect(condenser_heat.y, scaFacTimQUse_flow.u1) annotation (Line(points={{74,
          17},{74,10},{48,10},{48,10}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
  Partial model for equations and componenents used in both heat pump
  and chiller models using european norm data in two dimensions.
</p>
</html>", revisions="<html>
<ul><li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li></ul>
</html>"));
end PartialEuropeanNorm3D;
