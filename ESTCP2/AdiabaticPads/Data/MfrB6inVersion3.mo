within CCC_test.ESTCP2.AdiabaticPads.Data;
record MfrB6inVersion3 "Mfr B 6in Version 3"
  extends CCC_test.ESTCP2.AdiabaticPads.Data.Generic               (efficiency(
        v={0,1.27,1.524,1.778,2.032,2.286,2.54,2.794,3.048,3.302,3.556,35.56,
          355.6}, eta={0.831,0.753,0.737,0.719,0.701,0.687,0.681,0.661,0.649,
          0.636,0.627,0.0467659,2.63641544e-13}), pressure(v={0,1.27,1.524,
          1.778,2.032,2.286,2.54,2.794,3.048,3.302,3.556,35.56,355.6}, dp={0,
          12.442,15.17924,20.65372,24.884,32.84688,39.31672,47.03076,54.99364,
          63.95188,74.652,5363,389424}));

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>
Fan performance data.
See the documentation of
<a href=\"modelica://Buildings.Fluid.Movers.Data.Fans.Greenheck\">
Buildings.Fluid.Movers.Data.Fans.Greenheck</a>.
</p>
</html>"));
end MfrB6inVersion3;
