# Tree View Application

---

## Índice
1. [Introdução](#introdução)
2. [Demo e Prints](#Demo-e-Prints)
3. [Instalação](#instalação)
4. [Arquitetura](#arquitetura)
5. [Funcionalidades](#funcionalidades)
6. [Desafios Encontrados](#desafios-encontrados)
7. [Testes](#testes)
8. [Melhorias Futuras](#melhorias-futuras)
9. [Conclusão](#conclusão)
10. [Dependências](#dependências)

---

## Introdução
Os ativos são essenciais para a operação da indústria, incluindo desde equipamentos de fabricação até veículos de transporte e sistemas de geração de energia. A gestão e manutenção adequadas são cruciais para garantir que continuem operando de forma eficiente e eficaz. Uma maneira prática de visualizar a hierarquia de ativos é através de uma estrutura de árvore. Este projeto visa desenvolver uma aplicação que visualize os ativos de uma empresa usando uma estrutura de árvore.

---

## Demo e Prints


---

## Instalação
Para configurar o projeto localmente, siga os passos abaixo:

1. Clone o repositório:
    ```bash
    git clone https://github.com/Mathvdias/tractian.git
    ```
2. Navegue até o diretório do projeto:
    ```bash
    cd tractian
    ```
3. Instale as dependências:
    ```bash
    flutter pub get
    ```
4. Execute o aplicativo:
    ```bash
    flutter run
    ```

---

## Arquitetura
A aplicação foi desenvolvida seguindo uma arquitetura limpa e modular, composta por três camadas principais:

1. **Camada de Apresentação**:
    - Responsável pela interface do usuário e interação.
    - Implementada com Flutter, utilizando widgets como `ExpansionTile` para a visualização da árvore.

2. **Camada de Domínio**:
    - Contém a lógica de negócios e entidades do domínio.
    - Inclui classes para representar locais e componentes, e controladores para gerenciar o estado da aplicação usando `ValueNotifier` em vez de BLoC.


3. **Camada de Dados**:
    - Responsável pela comunicação com a API e manipulação de dados.
    - Utiliza repositórios para obter dados de locais e componentes da API fake-api.tractian.com.

### Estrutura de Pastas
- **core**: Contém classes e funções centrais utilizadas em toda a aplicação.
- **design_system_kit**: Contém componentes de interface reutilizáveis.
- **modules**: Contém os módulos da aplicação, divididos em submódulos como `components`, `home`, `locations`, e `tree`.
- **test**: Contém os testes unitários e de integração.
- **main.dart**: Ponto de entrada da aplicação.

---

## Funcionalidades
### 1. Página Inicial
- Menu para os usuários navegarem entre diferentes empresas e acessarem seus ativos.

### 2. Página de Ativos
A Árvore de Ativos é o recurso principal, oferecendo uma representação visual da hierarquia de ativos da empresa.

### Sub-Funcionalidades
#### Visualização
- Apresenta uma estrutura de árvore dinâmica exibindo componentes, ativos e locais.

#### Filtros
##### Pesquisa por Texto
- Os usuários podem procurar por componentes/ativos/locais específicos dentro da hierarquia de ativos.

##### Sensores de Energia
- Implementar um filtro para isolar sensores de energia dentro da árvore.

##### Status Crítico do Sensor
- Integrar um filtro para identificar ativos com status crítico do sensor.

---

## Desafios Encontrados
### 1. Manipulação de Dados
- **Desafio**: Garantir que a hierarquia de dados fosse corretamente representada na árvore.
- **Solução**: Implementação de lógica recursiva para mapear relações pai-filho entre locais e ativos.

### 2. Filtragem e Pesquisa
- **Desafio**: Implementar filtros que incluam componentes e seus pais, mantendo a hierarquia intacta.
- **Solução**: Uso de conjuntos (sets) para armazenar IDs de pais e garantir que todas as relações necessárias sejam exibidas.

### 3. Desempenho
- **Desafio**: Garantir um desempenho fluido ao renderizar uma grande quantidade de dados.
- **Solução**: Otimização da lógica de construção da árvore e uso eficiente de widgets do Flutter.

---

## Testes
### Tipos de Testes Implementados
1. **Testes Unitários**:
    - Garantem que funções e métodos individuais funcionem conforme esperado.
    - Exemplo: Testes para verificar a lógica de filtragem de dados.

2. **Testes de Interface (Widget Tests)**:
    - Verificam se os widgets são renderizados corretamente e interagem conforme o esperado.
    - Exemplo: Testes para garantir que a árvore de ativos expanda e contraia corretamente.

### Ferramentas Utilizadas
- **Flutter Test**: Framework de testes para aplicativos Flutter.

### Executando os Testes
Para executar os testes, utilize o comando:
```bash
flutter test
```

---

## Melhorias Futuras
1. **Integração com Autenticação**:
    - Adicionar um sistema de login para que diferentes usuários possam acessar a aplicação com credenciais específicas.

2. **Exportação de Dados**:
    - Permitir a exportação da hierarquia de ativos em formatos como CSV ou PDF.

3. **Notificações**:
    - Implementar notificações para alertar os usuários sobre mudanças no status dos ativos.

4. **Melhoria da Interface**:
    - Refinar a interface do usuário para uma experiência mais intuitiva e amigável.

---

## Conclusão
A aplicação Tree View oferece uma solução robusta para a visualização e gestão de ativos industriais, facilitando a identificação de componentes críticos e proporcionando uma visão clara da estrutura hierárquica. A implementação modular e a arquitetura limpa garantem escalabilidade e facilidade de manutenção, preparando a aplicação para futuras melhorias e expansão.

---

## Dependências
O projeto utiliza os seguintes pacotes:

- `flutter_svg: ^2.0.10+1`
- `mockito: ^5.4.4`
- `dio: ^5.4.3+1`
- `get_it: ^7.7.0`
- `multiple_result: ^5.1.0`

Para instalar todas as dependências, execute:
```bash
flutter pub get
```

---

### Contato
- **Nome**: [Seu Nome]
- **Email**: [Seu Email]
- **LinkedIn**: [Seu LinkedIn]

---

Este README foi projetado para fornecer uma visão abrangente do projeto, facilitando a instalação, compreensão da arquitetura, e destacando os principais desafios e soluções implementadas.

### Contato
- **Nome**: Matheus Vinicius da Silva Dias  
- **Email**: mattmvc56@gmail.com
- **LinkedIn**: https://www.linkedin.com/in/matheusvdias/

---

Este README foi projetado para fornecer uma visão abrangente do projeto, facilitando a instalação, compreensão da arquitetura, e destacando os principais desafios e soluções implementadas.