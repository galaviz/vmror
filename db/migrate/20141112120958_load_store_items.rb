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

  end

  def down
      Item.delete_all
  end

end
