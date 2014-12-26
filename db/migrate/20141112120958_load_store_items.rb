class LoadStoreItems < ActiveRecord::Migration
  def up
    item = Item.new
    item.name = 'Cree 6w LED'
    item.watts = 6
    item.lumenes = 450
    item.vida = "25,000 hrs"
    item.precio = 129.61
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/small/s_8536.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = "La lámpara LED Cree de 6 watts provee 450 lúmenes de iluminación de energía eficiente (75 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 40 watts o una lámpara de 9 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED regulable es compatible con la mayoría de los reguladores y, adicionalmente, es muy costo-efectivo con los apagadores. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones."
    item.brand_image_url = "https://www.kiwilighting.com/media/catalog/category/Cree-LED-logo_1.jpg"
    item.save()

    item = Item.new
    item.name = 'Cree 9.5w LED'
    item.watts = 9.5
    item.lumenes = 800
    item.vida = "25,000 hrs"
    item.precio = 129.61
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/small/s_8536.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Cree de 9.5 watts provee 800 lúmenes de iluminación de energía eficiente (84 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 60 watts o una lámpara de 13 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED regulable es compatible con la mayoría de los reguladores y, adicionalmente, es muy costo-efectivo con los apagadores. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "https://www.kiwilighting.com/media/catalog/category/Cree-LED-logo_1.jpg"
    item.save()

    item = Item.new
    item.name = 'Philips 11w 19A LED'
    item.watts = 11
    item.lumenes = 830
    item.vida = "25,000 hrs"
    item.precio = 168.35
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/large/l_7734.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Philips A19 de 11 watts provee 830 lúmenes de iluminación de energía eficiente (75 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 60 watts o una lámpara de 13 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.retail-square.com/sites/default/files/philips-logo.jpg"
    item.save()

    item = Item.new
    item.name = 'Philips 7w 19A LED'
    item.watts = 7
    item.lumenes = 470
    item.vida = "25,000 hrs"
    item.precio = 168.35
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/large/l_7734.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Philips A19 de 7 watts provee 470 lúmenes de iluminación de energía eficiente (58 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 40 watts o una lámpara de 9 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.retail-square.com/sites/default/files/philips-logo.jpg"
    item.save()

    item = Item.new
    item.name = 'Philips 15w A21 LED'
    item.watts = 15
    item.lumenes = 1180
    item.vida = "25,000 hrs"
    item.precio = 415.35
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/small/s_8341.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Philips Slim Fit de 10.5 watts provee 800 lúmenes de iluminación de energía eficiente (76 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 60 watts o una lámpara de 13 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.retail-square.com/sites/default/files/philips-logo.jpg"
    item.save()

    item = Item.new
    item.name = 'Philips 10.5w SF LED'
    item.watts = 8
    item.lumenes = 470
    item.vida = "25,000 hrs"
    item.precio = 168.35
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/large/l_8593.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Philips Slim Fit de 10.5 watts provee 800 lúmenes de iluminación de energía eficiente (76 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 60 watts o una lámpara de 13 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.retail-square.com/sites/default/files/philips-logo.jpg"
    item.save()

    item = Item.new
    item.name = 'Philips 19w A21 LED'
    item.watts = 19
    item.lumenes = 1680
    item.vida = "25,000 hrs"
    item.precio = 448.50
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/small/s_8338.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED Philips A21 de 19 watts provee 1,680 lúmenes de iluminación de energía eficiente (85.3 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 100 watts o una lámpara de 25 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.retail-square.com/sites/default/files/philips-logo.jpg"
    item.save()

    item = Item.new
    item.name = 'TCP LED Dim A Lamp'
    item.watts = 10
    item.lumenes = 800
    item.vida = "25,000 hrs"
    item.precio = 162.50
    item.image_url = "http://www.energyfederation.org/common/images/productfamilies/small/s_8301.jpg"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'La lámpara LED TCP A de 10 watts provee 800 lúmenes de iluminación de energía eficiente (80 lm/w), lo cual equivale generalmente a la cantidad de luz producida por una lámpara incandescente de 60 watts o una lámpara de 13 watts de luz fluorescente compacta (CFL). Las 25,000 horas de vida eliminan la necesidad de sustituir lámparas de manera repetida (las lámparas incandescentes usualmente duran 800 a 1,000 horas, mientras las CFLs duran 6,000-10,000 horas). Esta luz LED de alta eficiencia no contiene mercurio, no emite luz UV/IR, no oscurece los colores y provee una fuente difusa de luz pareja. Este LED es regulable hasta un 10% de su nivel total de luz. Esta lámpara es omnidireccional, refiriéndose a que la luz será proyectada en todas las direcciones.'
    item.brand_image_url = "http://www.tcpi.com/images/logo.png"
    item.save()

    item = Item.new
    item.name = 'York Affinity™ YZH'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 30,667
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/Air%20Conditioners/york-affinity-CZH-air-conditioner-L-ME.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El sistema de calefacción y aire acondicionado York® Affinity™ YZH tiene un rendimiento con certificación ENERGY STAR® de hasta 18 SEER y 10.1 HSPF. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. El compresor de dos etapas provee una operación silenciosa y eficiencia. Asimismo, el sistema QuietDrive™ silencia las vibraciones. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "https://drive.google.com/file/d/0B6SL98Pn6GkhUTVSdFhaRWVxWUk/view?usp=sharing"
    item.save()

    item = Item.new
    item.name = 'York® LX Series YHJF'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 47,567
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/heat%20pumps/york-LX-series-YHJF-heat-pump-L.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El sistema de calefacción y aire acondicionado York® LX Series YHJF tiene un rendimiento con certificación ENERGY STAR® de 14.5 SEER y 8.5 HSPF. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. La tecnología avanzada MicroChannel Coil permite un alto rendimiento en menor espacio. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "http://en.wikipedia.org/wiki/Energy_Star#mediaviewer/File:Energy_Star_logo.svg"
    item.save()

    item = Item.new
    item.name = 'York® Latitude™ TCGF'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 19,227
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/heat%20pumps/york-latitude-THGF-heat-pump-L.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El sistema de calefacción y aire acondicionado York® Latitude™ THGF tiene un rendimiento con certificación ENERGY STAR® de 14.5 SEER y 8.5 HSPF. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. El control Demand Defrost permite mantener la bobina descongelada en temperaturas bajas. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "https://drive.google.com/file/d/0B6SL98Pn6GkhUTVSdFhaRWVxWUk/view?usp=sharing"
    item.save()

    item = Item.new
    item.name = 'York Affinity CZH'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 34,957
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/Air%20Conditioners/york-affinity-CZH-air-conditioner-L-ME.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El aire acondicionado York® Affinity™ CZH tiene un rendimiento de hasta 18 SEER y certificación ENERGY STAR® para mantener tu casa fría pagando menos. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. El compresor de dos etapas provee una operación silenciosa y eficiencia. Asimismo, el sistema QuietDrive™ silencia las vibraciones. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "https://drive.google.com/file/d/0B6SL98Pn6GkhUTVSdFhaRWVxWUk/view?usp=sharing"
    item.save()

    item = Item.new
    item.name = 'York LX Series YCJF'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 21,697
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/Air%20Conditioners/york-LX-Series-YCJF-air-conditioner-L.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El aire acondicionado York® LX Series YCJF tiene un rendimiento de hasta 14.5 SEER y certificación ENERGY STAR® para mantener tu casa fría pagando menos. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. La tecnología avanzada MicroChannel Coil permite un alto rendimiento en menor espacio. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "https://drive.google.com/file/d/0B6SL98Pn6GkhUTVSdFhaRWVxWUk/view?usp=sharing"
    item.save()

    item = Item.new
    item.name = 'York® Latitude™ TCG'
    item.watts = 0
    item.lumenes = 0
    item.vida = "25,000 hrs"
    item.precio = 19,357
    item.image_url = "http://www.york.com/images/Residential/Products/Residential%20Prod_Detail/Air%20Conditioners/York-latitude-TCGF-air-conditioner-L.png"
    item.disponibilidad = "14 - Enero - 2015"
    item.description = 'El aire acondicionado York® Latitude™ TCGF tiene un rendimiento de 14.5 SEER y certificación ENERGY STAR® para mantener tu casa fría pagando menos. Las excelentes garantías te permiten una alta confiabilidad con calidad inmejorable. La tecnología avanzada MicroChannel Coil permite un alto rendimiento en menor espacio. El refrigerante R-410A utilizado es amigable a la capa de ozono.'
    item.brand_image_url = "https://drive.google.com/file/d/0B6SL98Pn6GkhUTVSdFhaRWVxWUk/view?usp=sharing"
    item.save()

  end

  def down
      Item.delete_all
  end

end
