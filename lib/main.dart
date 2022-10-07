import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),//stateful widget para podermos interagir
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Variáveis
  //Cores da bandeira do Brasil
  Color _azulBandeira = Color(0xFF002776);
  Color _amareloBandeira = Color(0xFFffdf00);
  Color  _verdeBandeira = Color(0xFF009c3b);

  //tamanhos de fontes, paddings e ícones
  double _tamanhoTextoCampoDeTexto = 25.0;
  double _tamanhoFonteTextoInfo = 30.0;
  double _tamanhoFonteTextoSwitch = 20.0;
  double _tamanhoFonteBotao = 20.0;
  double _paddingBotao = 30.0;
  double _paddingScrollView = 30.0;
  double _tamanhoIcone = 100.00;
  double _tamanhoIconeCaixadeTexto = 33.33;
  double _alturaContainerBotao = 50.00;

  //texto no final
  String _textInfo = "";

  //controller
  TextEditingController _rendaController = TextEditingController();
  TextEditingController _filhosController = TextEditingController();

  //chave do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //switch
  bool acionadoVacina = false;

  void toggleVacina(bool value){
    if(acionadoVacina == false)
    {
      setState(() {
        acionadoVacina = true;
      });
    }
    else
    {
      setState(() {
        acionadoVacina = false;
      });
    }
  }

  bool acionadoSolteira = false;

  void toggleSolteira(bool value){
    if(acionadoSolteira == false)
    {
      setState(() {
        acionadoSolteira = true;
      });
    }
    else
    {
      setState(() {
        acionadoSolteira = false;
      });
    }
  }

  //calculo do beneficio
  void _calcularBeneficio(){
    setState(() {

      double salarioMinino = 1212;

      double totalBeneficio = 0;
      double renda = double.parse(_rendaController.text);
      int filhosEscola = int.parse(_filhosController.text);
      bool filhosVacinados = acionadoVacina;
      bool maeSolteira = acionadoSolteira;

      if(filhosEscola > 0){//se não tem filhos não tem benefício
        //se tem tres filhos na escola obrigatoriamente são 3 salarios minimos
        if(filhosEscola >= 3){
          totalBeneficio = 3 * salarioMinino;
        }
        else{ //tendo um ou dois filhos a renda da familia é o que decide
          if(renda <=  salarioMinino){
            totalBeneficio = 2.5 * salarioMinino;
          }
          else if(renda <= 2 * salarioMinino){
            totalBeneficio = 1.5 * salarioMinino;
          }
          else{
            totalBeneficio = 0;
          }
        }
        if(!filhosVacinados){
          totalBeneficio = 0;
        }
        if(maeSolteira){
          totalBeneficio += 600;
        }
      }

      if(totalBeneficio != 0){
        _textInfo = totalBeneficio.toString();
        _textInfo += " reais";
      }
      else{
        _textInfo = "Voce não tem direito ao benefício";
      }
    });
  }

  //Função para reiniciar aplicativo
  void _resetFields(){
    setState(() {
      _formKey = GlobalKey<FormState>();
      _rendaController.text = "";
      _filhosController.text = "";
      acionadoSolteira = false;
      acionadoVacina = false;
      _textInfo = "Informe seus dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de benefício", style: TextStyle(color: _verdeBandeira)),
        centerTitle: true,
        backgroundColor: _amareloBandeira,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Reiniciar',
          onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: _verdeBandeira,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_paddingScrollView, 0.0, _paddingScrollView, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.groups, size: _tamanhoIcone, color: _azulBandeira),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: TextFormField(
                  keyboardType: TextInputType.number, //aciona o teclado numérico
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money, size: _tamanhoIconeCaixadeTexto, color: _azulBandeira),
                    labelText: "Qual a renda total da família?",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: _tamanhoTextoCampoDeTexto
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _tamanhoTextoCampoDeTexto
                  ),
                  controller: _rendaController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "Insira a renda";
                    }
                    if(double.parse(value.toString()) < 0){
                      return "Digite um valor válido";
                    }
                    if(double.parse(value.toString()) == null){
                      return "Digite um valor válido";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: TextFormField(
                  keyboardType: TextInputType.number, //aciona o teclado numérico
                  decoration: InputDecoration(//rotulo do campo de texto
                    icon: Icon(Icons.school, size: _tamanhoIconeCaixadeTexto, color: _azulBandeira),
                    labelText: "Quantos filhos estão na escola?",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: _tamanhoTextoCampoDeTexto
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _tamanhoTextoCampoDeTexto
                  ),
                  controller: _filhosController,
                  validator: (value){
                    if(value.toString().isEmpty){
                      return "Insira a quantidade";
                    }
                    if(double.parse(value.toString()) < 0){
                      return "Digite um valor válido";
                    }
                    if(double.parse(value.toString()) == null){
                      return "Digite um valor válido";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: Text(
                  "Seus filhos estão vacinados?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.00
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Switch(
                onChanged: toggleVacina,
                value: acionadoVacina,
                activeColor: _azulBandeira,
                activeTrackColor: _amareloBandeira,
                inactiveThumbColor: _azulBandeira,
                inactiveTrackColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  "A família é chefiada por mãe solteira?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.00
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Switch(
                onChanged: toggleSolteira,
                value: acionadoSolteira,
                activeColor: _azulBandeira,
                activeTrackColor: _amareloBandeira,
                inactiveThumbColor: _azulBandeira,
                inactiveTrackColor: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingBotao, bottom: _paddingBotao),
                child: Container(
                  height: _alturaContainerBotao,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    ),
                    child: Text('Calcular benefício',
                      style: TextStyle(
                        fontSize: _tamanhoFonteBotao,
                        color: _verdeBandeira,
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){ //se meu formulário estiver validado
                        _calcularBeneficio();
                      }
                    },
                  ),
                ),
              ),
              Text(
                "$_textInfo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _tamanhoFonteTextoInfo,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ) ,
      ),
    );
  }
}
