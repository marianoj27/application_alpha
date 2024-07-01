final Map<String, List<String>> wordSuggestions = {
  'qué': ['es', 'significa', 'haces', 'quieres', 'día'],
  'quién': ['es', 'eres', 'fue', 'hace'],
  'cómo': ['estás', 'te', 'haces', 'se', 'es'],
  'dónde': ['está', 'queda', 'es', 'puedo', 'estás'],
  'cuándo': ['es', 'será', 'vas', 'vuelves', 'llegas'],
  'por qué': ['es', 'está', 'haces', 'razón'],
  'para qué': ['sirve', 'es', 'haces'],
  'cuál': ['es', 'funciona', 'prefieres'],
  //Más palabras y sus listas de sugerencias
  'cuánto': ['cuesta', 'es', 'tienes', 'falta'],
  'cuántos': ['son', 'tienes', 'hay'],
  'puedo': ['hacer', 'ir', 'ayudarte', 'entrar'],
  'debo': ['hacer', 'decir', 'ir'],
  'necesito': ['ayuda', 'saber', 'ir'],
  'hay': ['algún', 'una', 'que', 'posibilidad'],
  'estás': ['bien', 'ocupado', 'ahí'],
  'tienes': ['tiempo', 'algo', 'que', 'un'],
  'quieres': ['ir', 'hacer', 'comer'],
  'prefieres': ['comida', 'ir', 'hacer'],
  'puedes': ['ayudarme', 'decirme', 'hacer'],
  //Pronombres personales
  'yo': ['quiero', 'tengo', 'necesito', 'puedo', 'voy', 'estoy',],
  'tú': ['quieres', 'tienes', 'necesitas', 'puedes', 'vas', 'estás',],
  'él': ['quiere', 'tiene', 'necesita', 'puede', 'va', 'está',],
  'ella': ['quiere', 'tiene', 'necesita', 'puede', 'va', 'está',],
  'nosotros': ['queremos', 'tenemos', 'necesitamos', 'podemos', 'vamos', 'estamos',],
  'nosotras': ['queremos', 'tenemos', 'necesitamos', 'podemos', 'vamos', 'estamos', ],
  'vosotros': ['queréis', 'tenéis', 'necesitáis', 'podéis', 'vais', 'estáis',],
  'vosotras': ['queréis', 'tenéis', 'necesitáis', 'podéis', 'vais', 'estáis',],
  'ellos': ['quieren', 'tienen', 'necesitan', 'pueden', 'van', 'están', ],
  'ellas': ['quieren', 'tienen', 'necesitan', 'pueden', 'van', 'están', ],
  'usted': ['quiere', 'tiene', 'necesita', 'puede', 'va', 'está',],
  'ustedes': ['quieren', 'tienen', 'necesitan', 'pueden', 'van', 'están',],
  //
  'día': ['es'],
  'es': ['mejor', 'peor'],
  'significa': ['esto'],
  'hace': ['esto', 'eso'],
  'haces': ['esto', 'eso'],
  'hacer': ['esto', 'eso'],
  'decir': ['esto'],
  'puedo': ['hacerlo', 'encontrarlo', 'buscarlo'],
  'ir': ['ahí','luego'],

  'quiero': ['comer', 'dormir', 'bañarme', 'leer', 'viajar', 'cantar'],
  'tengo': ['hambre', 'sueño', 'sed', 'miedo', 'prisa', 'calor'],
  'necesito': ['ayuda', 'dinero', 'tiempo', 'un descanso', 'un abrazo', 'información'],
  'puedo': ['correr', 'cantar', 'bailar', 'hablar', 'nadar', 'cocinar'],
  'voy': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'estoy': ['feliz', 'triste', 'cansado', 'ocupado', 'enfermo', 'nervioso'],

  'quieres': ['comer', 'dormir', 'bañarte', 'leer', 'viajar', 'cantar'],
  'tienes': ['hambre', 'sueño', 'sed', 'miedo', 'prisa', 'calor'],
  'necesitas': ['ayuda', 'dinero', 'tiempo', 'un descanso', 'un abrazo', 'información'],
  'puedes': ['correr', 'cantar', 'bailar', 'hablar', 'nadar', 'cocinar'],
  'vas': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'estás': ['feliz', 'triste', 'cansado', 'ocupado', 'enfermo', 'nervioso'],

  'quiere': ['comer', 'dormir', 'bañarse', 'leer', 'viajar', 'cantar'],
  'tiene': ['hambre', 'sueño', 'sed', 'miedo', 'prisa', 'calor'],
  'necesita': ['ayuda', 'dinero', 'tiempo', 'un descanso', 'un abrazo', 'información'],
  'puede': ['correr', 'cantar', 'bailar', 'hablar', 'nadar', 'cocinar'],
  'va': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'está': ['feliz', 'triste', 'cansado', 'ocupado', 'enfermo', 'nervioso'],
  'va': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'está': ['feliz', 'triste', 'cansada', 'ocupada', 'enferma', 'nerviosa'],

  'queremos': ['comer', 'dormir', 'bañarnos', 'leer', 'viajar', 'cantar'],
  'tenemos': ['hambre', 'sueño', 'sed', 'miedo', 'prisa', 'calor'],
  'necesitamos': ['ayuda', 'dinero', 'tiempo', 'un descanso', 'un abrazo', 'información'],
  'podemos': ['correr', 'cantar', 'bailar', 'hablar', 'nadar', 'cocinar'],
  'vamos': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'estamos': ['felices', 'tristes', 'cansados', 'ocupados', 'enfermos', 'nerviosos','cansadas', 'ocupadas', 'enfermas', 'nerviosas'],

  'quieren': ['comer', 'dormir', 'bañarse', 'leer', 'viajar', 'cantar'],
  'tienen': ['hambre', 'sueño', 'sed', 'miedo', 'prisa', 'calor'],
  'necesitan': ['ayuda', 'dinero', 'tiempo', 'un descanso', 'un abrazo', 'información'],
  'pueden': ['correr', 'cantar', 'bailar', 'hablar', 'nadar', 'cocinar'],
  'van': ['a comer', 'a dormir', 'a trabajar', 'a estudiar', 'a salir', 'a viajar'],
  'están': ['felices', 'tristes', 'cansados', 'ocupados', 'enfermos', 'nerviosos','cansadas', 'ocupadas', 'enfermas', 'nerviosas'],
  
};

String TTS_INPUT =
    "La afasia es un trastorno del lenguaje que afecta la capacidad de una persona para comunicarse verbalmente. Por lo general, es causada por daño o lesión en áreas específicas del cerebro que controlan el lenguaje y el habla.";



