import 'package:flutter/material.dart';
import 'package:wordse_app/src/pages/tips/card_tips.dart';

class TipsPage extends StatelessWidget {

  const TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        CardTips(
            title: "Aumente seu vocabulário todos os dias", 
            message: "Tenha como objetivo aprender e dominar pelo menos uma palavra nova por dia. Por que não estudar as novas palavras acrescentada ao Dicionário de Inglês Oxford? Esse é o caminho para aprimorar seu vocabulário.", 
            color: Colors.green),
        CardTips(
            title: "Coloque seus ouvidos à prova",
            message: "Ouvir vídeos, podcasts e música podem ajudar seus ouvidos se adaptarem e adotarem o Inglês em toda a sua glória variada.",
            color: Colors.red),
        CardTips(
            title: "Repita depois de mim: Repita, repita, repita",
            message: "Não há como escapar, existem poucas maneiras mais eficazes de aprender uma língua do que repetir as frases escritas e as palavras em alto e bom som muitas, muitas e muitas vezes.",
            color: Colors.orange),
        CardTips(
            title: "Delicie-se com programas cafonas de TV",
            message: "As novelas Inglesas são bastante convincentes em suas histórias onde toda semana há um terrível assassinato ou um cônjuge trapaceiro é descoberto. As novelas não são apenas entretenimento, elas também apontam as diferentes regiões, dos melódicos dialetos de Yorkshire Dales em Emmerdale, ao dialeto exclusivo de Cockney em East Enders.",
            color: Colors.black),
        CardTips(
            title: "Seja curioso",
            message: "Questione tudo e seja sempre curioso. A língua Inglesa é cheia de exceções e, muitas vezes (na maioria das vezes) o Inglês falado resiste às rigorosas regras que o definem.",
            color: Colors.blue)
      ],
    );
  }
}
