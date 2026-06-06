within CCC_test.ESTCP2.AdiabaticPads.Data;
record MfrA6inVersion1 "Mfr A 6in Version 1"
  extends CCC_test.ESTCP2.AdiabaticPads.Data.Generic               (efficiency(
        v={0,1.27,1.524,1.778,2.032,2.2352,2.5146,2.7686,3.0226,3.302,3.556,
          35.56,355.6}, eta={0.819,0.744,0.731,0.714,0.695,0.681,0.664,0.66,
          0.647,0.634,0.623,0.04973949,5.56788318e-13}), pressure(v={0,1.27,
          1.524,1.778,2.032,2.2352,2.5146,2.7686,3.0226,3.302,3.556,35.56,355.6},
        dp={0,8.7094,11.1978,13.93504,17.66764,21.1514,26.87472,30.60732,
          35.58412,41.0586,48.5238,2594,141245}));

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
end MfrA6inVersion1;
