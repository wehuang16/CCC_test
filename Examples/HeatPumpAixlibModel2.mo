within CCC_test.Examples;
model HeatPumpAixlibModel2
  "Grey-box model for reversible heat pumps using a black-box to simulate the refrigeration cycle"
  extends CCC_test.Examples.PartialReversibleVapourCompressionMachine2(
  use_rev=true,
  redeclare AixLib.Fluid.HeatPumps.BaseClasses.InnerCycle_HeatPump innerCycle(
      final use_rev=use_rev,
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

  annotation (Icon(coordinateSystem(extent={{-100,-120},{100,120}})),
                                          Diagram(coordinateSystem(extent={{-100,
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
</html>", info="<html>
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
end HeatPumpAixlibModel2;
