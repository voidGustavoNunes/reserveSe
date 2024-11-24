import 'package:flutter/material.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import '../../../dominio/usuario_restaurante.dart';
import '../menu_lateral/menu_lateral_restaurante.dart';

enum TipoElemento { mesa, banheiro, arCondicionado, janela, entrada }

class ElementoRestaurante {
  final TipoElemento tipo;
  final Offset posicao;
  final String id;

  ElementoRestaurante({
    required this.tipo,
    required this.posicao,
    required this.id,
  });

  ElementoRestaurante copyWith({Offset? posicao}) {
    return ElementoRestaurante(
      tipo: tipo,
      posicao: posicao ?? this.posicao,
      id: id,
    );
  }
}

class TelaPrincipalRestaurantes extends StatefulWidget {
  final UsuarioRestaurante restaurante;

  const TelaPrincipalRestaurantes({Key? key, required this.restaurante}) : super(key: key);

  @override
  _TelaPrincipalRestaurantesState createState() =>
      _TelaPrincipalRestaurantesState();
}

class _TelaPrincipalRestaurantesState extends State<TelaPrincipalRestaurantes>
    with SingleTickerProviderStateMixin {
  List<ElementoRestaurante> elementos = [];
  late Animation<double> _animation;
  late AnimationController _animationController;

  // Dimensões fixas para a caixa do restaurante
  double restauranteWidth = 400;
  double restauranteHeight = 500;

  // Controlador do Scaffold para abrir o Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  // Função para adicionar um novo elemento
  void adicionarElemento(TipoElemento tipo) {
    setState(() {
      elementos.add(ElementoRestaurante(
        tipo: tipo,
        posicao: Offset(50, 50), // Posição inicial dentro do restaurante
        id: DateTime.now().toString(),
      ));
    });
  }

  // Função para atualizar a posição dos elementos dentro do restaurante
  void atualizarPosicao(String id, Offset novaPosicao) {
    setState(() {
      elementos = elementos.map((elemento) {
        if (elemento.id == id) {
          // Verifica os limites do restaurante antes de atualizar
          final clampedX = novaPosicao.dx.clamp(0, restauranteWidth - 50).toDouble();
          final clampedY = novaPosicao.dy.clamp(0, restauranteHeight - 50).toDouble();
          return elemento.copyWith(posicao: Offset(clampedX, clampedY));
        }
        return elemento;
      }).toList();
    });
  }

  // Função para apagar um elemento
  void apagarElemento(String id) {
    setState(() {
      elementos.removeWhere((elemento) => elemento.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Defina a chave do Scaffold para controlar o Drawer
      key: _scaffoldKey,

      // Adicionando o menu lateral (Drawer)
      drawer: MenuLateralRestaurante(),

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Abre o Drawer
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text('Modificar Layout do Restaurante'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionBubble(
        animation: _animation,
        onPressed: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
        iconColor: Colors.blue,
        iconData: Icons.add,
        backgroundColor: Colors.white,
        items: <Widget>[
          BubbleMenu(
            title: "Mesa",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.table_chart,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {
              adicionarElemento(TipoElemento.mesa);
              _animationController.reverse();
            },
          ),
          BubbleMenu(
            title: "Banheiro",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.bathtub,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {
              adicionarElemento(TipoElemento.banheiro);
              _animationController.reverse();
            },
          ),
          BubbleMenu(
            title: "Entrada",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.home,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {
              adicionarElemento(TipoElemento.entrada);
              _animationController.reverse();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Container do restaurante com tamanho fixo
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: restauranteWidth,
                    height: restauranteHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/carpete_de_madeira.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.brown, width: 3),
                    ),
                    child: Stack(
                      children: elementos.map((elemento) {
                        return Positioned(
                          left: elemento.posicao.dx,
                          top: elemento.posicao.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                final novaPosicao = Offset(
                                  elemento.posicao.dx + details.localPosition.dx,
                                  elemento.posicao.dy + details.localPosition.dy,
                                );

                                // Corrige a posição dentro dos limites do restaurante
                                final clampedX = novaPosicao.dx.clamp(0, restauranteWidth - 50).toDouble();
                                final clampedY = novaPosicao.dy.clamp(0, restauranteHeight - 50).toDouble();

                                atualizarPosicao(elemento.id, Offset(clampedX, clampedY));
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  color: elemento.tipo == TipoElemento.mesa
                                      ? Colors.blue
                                      : elemento.tipo == TipoElemento.banheiro
                                      ? Colors.green
                                      : elemento.tipo == TipoElemento.arCondicionado
                                      ? Colors.cyan
                                      : elemento.tipo == TipoElemento.janela
                                      ? Colors.yellow
                                      : Colors.red,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      apagarElemento(elemento.id);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            // Botões de Confirmar e Cancelar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Ação de cancelar
                      setState(() {
                        elementos.clear(); // Limpar os elementos
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Alterações canceladas!')),
                      );
                    },
                    child: Text('Cancelar'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Ação de confirmar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Layout confirmado!')),
                      );
                    },
                    child: Text('Confirmar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
