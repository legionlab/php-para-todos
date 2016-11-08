#Design Patterns: porque todos queremos entender seu código

'Aportuguesando', estarei falando de padrões de projetos, técnicas de desenvolvimento que deixam seu código com padrões seguidos e conhecidos por muitos desenvolvedores, se encontra em uma pequena parte útil da grandiosa e inútil Engenharia de Software. Que tal iniciar falando quais as vantagens e desvantagens de usar um padrão de projeto? Vamos lá..

####_Vantagens_

- Todos bons desenvolvedores entenderão seu código.
- Você entenderá a maioria dos códigos bem feitos.
- Traz facilidade e maior organização o código.

####_Desvantagens_
- Complexo para iniciantes entenderem.
- Trabalhoso quando se usa para solucionar problemas pequenos.


Dada uma pequena introdução iremos entrar no gracioso mundo do **PHP**, dando exemplos de alguns padrões usando a linguagem. No início esses padrões podem soar uma certa inutilidade, mas sabendo-o aplicar em determinados problemas vocês poderão ver que seu desenvolvimento tornará muito mais fácil, rápido e legível.

____________________________

###Model-View-Controller 
	| Uma camada daqui, mais uma dali e mais outra, pois camada separa! |

Esse é sem dúvida nenhuma o padrão de projeto mais usado atualmente, principalmente quando usamos PHP, onde a maioria, se não todos, frameworks *full stacks* disponíveis para a linguagem seguem esse modelo. Ele é dividido em camadas, a primeira denominada **visão**, onde teremos apenas as interfaces da nossa aplicação, seja em HTML com PHP ou HTML com *template engine*, a terceira é chamada de **modelo**, onde  ficamos responsáveis por validar nossos objetos, tendo em vista a persistência do dado, seja em um banco de dados ou arquivo de texto, a segunda camada nomeada **controlador**, se encarrega de realizar a lógica da aplicação, chamando ações da camda modelo e exibindo as interfaces da camada visão. Vamos ao exemplo:

**index.php** - responsável apenas por chamar o controlador ou detector de rota.

	<?php

	require_once 'MyController.php';

	(new MyController)->action(); // chama metodo de controlador

**MyController.php** - nossa camada controladora, verifica se o formulário de criação foi enviado para criar uma pessoa, pega a lista com todas pessoas já criadas e por fim chama nossa camada de visão.

	<?php

	require_once 'MyModel.php';

	class MyController
	{
	    public function action()
	    {
			//Se oformulário de criar foi submetido	    
			if(isset($_GET['method']) and $_GET['method'] == 'create') {
			    try {
				//Tenta criar pessoa
				( new MyModel($_POST['name'], $_POST['age']) )->create();
			    } catch (Exception $e) {
			       //Caso ocorra um erro coloca em uma variável
				$error = $e->getMessage();
			    }
			}

			//Pega uma lista de todas pessoas
			$list = MyModel::listAll();
			//Chama camada de visão
			include 'myview.php';
	    }
	}

	?>
	
**MyModel.php** - camada de modelo, onde representamos nosso objeto, validadando seus atributos e realizando operações com a persistência.

	<?php

	session_start();// cria a sessão

	class MyModel
	{
	    private $name, $age;

	    public function __construct($name, $age)
	    {
			$this->name = $name;
			$this->age($age); // valida idade
	    }

	    // Metodo setter, para validar a idade
	    public function age($age)
	    {
			if($age > 3 and $age < 125)
			    $this->age = (int)$age;
			else
			    throw new Exception("Age is invalid");
	    }

	    public function create()
	    {
	    	//cria lista vazia, se não houver
			if(!isset($_SESSION['list']))
			    $_SESSION['list'] = array();
			//adiciona pessoa na lista
			else
			    $_SESSION['list'][] = array('name' => $this->name, 'age' => $this->age);
	    }

	    //retorna lista de pessoas
	    public static function listAll()
	    {
			return isset($_SESSION['list']) ?  $_SESSION['list'] : null;
	    }
	}

	?>

**myview.php** - arquivo de visão, onde pegamos as variáveis criadas no controlador e exibimos com HTML.

	<strong><?php echo isset($error) ? $error : '' ?></strong>

	<form action="index.php?method=create" method="post">
	    <label>Name: <input type="text" name="name"></label>
	    <label>Age: <input type="text" name="age"></label>

	    <input type="submit" value="Create">
	</form>

	<?php
	if(isset($list)) {
	    echo '<ul>';
	    foreach ($list as $item)
		echo '<li>' . $item['name'] . " | " . $item['age'] . '</li>';
	    echo '</ul>';
	}
	?>
_____________________
###Front Controller 
	| Definindo os caminhos da requisição.. |
	
Esse padrão na realidade é aplicável somente a um arquivo de código, e pode ser implementado junto com qualquer outro padrão, ele apenas é responsável por receber uma requisição e convocar a rota daquela requisição. Usado como núcleo central de muitos frameworks, onde ele carrega as dependências daquela rota e a chama.

**index.php** - apenas chama o nosso FrontController, exibindo seu retorno.

	<?php

	require_once 'FrontController.php';

	echo (new FrontController())->route();

**FrontController.php** - nesse caso, verifica se a rota é o login ou não, então retorna uma string dizendo se foi feito ou não o login.

	<?php

	class FrontController
	{
	    public function route()
	    {
		if(!isset($_GET['page']) or $_GET['page'] == 'login')
		    return 'Vamos fazer o login ae chapa';
		else
		    return 'Já fez o login né?';
	    }
	}

	?>

_____________________
###Factory 

	| Separando a criação em etapas |
	
Nesse padrão separamos nosso objeto de uma classe para fabricação dele, que se torna responsável por criar e retornar uma nova instância do objeto. A utilidade disso vem em classes maiores, onde você pode dividir o objeto em sub-objetos na classe *factory* para ir colocando valores em um grupo de atributos invés de colocar um por um ou todos no construtor. Em códigos maiores, você ás vezes precisará trocar o nome do objeto, com o Factory, você não precisaria ir em todas criações de instância do objeto em seu código e mudar isso, essa operaçao seria feita apenas na Factory do objeto.

**index.php** - nesse caso cria dosi objetos usando a Factory do mesmo, após isso carrega cada um na Factory, passando dados para o objeto.

	<?php

	require_once 'MyFactory.php';

	$obj1 = MyFactory::create();
	MyFactory::load($obj1);
	MyFactory::person('Leonardo', 20);
	$obj1->email("example@outlook.com");

	$obj2 = MyFactory::create();
	MyFactory::load($obj2);
	MyFactory::person('Jose', 45);
	$obj2->email("example@gmail.com");

	var_dump($obj1, $obj2);
	
**MyFactory.php** - responsável por criarum objeto, eu expandi esse padrão para esse artigo, colocando um metodo para carregar um objeto nessa fábrica e alterar um grupo de atributos do mesmo.

	<?php

	require_once 'MyObject.php';

	abstract class MyFactory
	{
	    private static $object;

	    public static function create()
	    {
			return new MyObject();
	    }

	    public static function load($object)
	    {
			self::$object = $object instanceof MyObject ? $object : null;
	    }

	    public static function person($name, $age)
	    {
			if(self::$object != null) {
			    self::$object->name($name);
			    self::$object->age($age);
			}
	    }

	}

	?>

**MyObject.php** - objeto a ser representado na fábrica, onde temos apenas os atributos e *getters* e *setters* do mesmo (meus  *getters* e *setters* são diferentes, acho mais legível :p)

	<?php

	class MyObject
	{
	    private $name, $age, $email;

	    public function name($name = '@')
	    {
			if($name === '@')
			    return $this->name;
			else
			    $this->name = $name;
			return $this;
	    }

	    public function age($age = '@')
	    {
			if($age === '@')
			    return $this->age;
			else
			    $this->age = $age;
			return $this;
	    }

	    public function email($email = '@')
	    {
			if($email === '@')
			    return $this->email;
			else
			    $this->email = $email;
			return $this;
	    }
	}

	?>
_____________________
###Singleton 

	| Só um objeto existirá entre nós   |

Quando você tem um objeto que deve possuir apenas uma instância em toda sua rota você deve usar esse padrão, com ele você garante que esse ambiente se torne uma realidade. Sendo útil quando se tem por exemplo um carrinho de compras:

**index.php** - cria uma instância, armazena em uma variável, altera atriutos dessa instância e verifica se tanto a instância da variável quanto a do Singleton foram modificadas, na realidade são a mesma intância.

	<?php

	require_once 'MySingleton.php';
	$instance = MySingleton::instance();

	//instancia vazia, pois foi criada agora
	var_dump($instance);

	$instance
	    ->userid(12)
	    ->password('mypasswordstring');

	// true, pois a instancia do singleton foi alterada enquanto
	// mudamos a variável $instance
	var_dump($instance === MySingleton::instance());

	var_dump(MySingleton::instance());
	
**MySingleton.php** - responsável por gerenciar a única instância do objeto,  os métodos mágicos (__*) estão vazios para bloquear a criação de novas intâncias.

	<?php

	require_once 'MyObject.php';

	class MySingleton
	{
	    private static $instance = null;

	    public static function instance()
	    {
			if (self::$instance === null)
			    self::$instance = new MyObject();

			return self::$instance;
	    }

	    private function __construct() { }

	    private function __clone() { }

	    private function __wakeup() { }
	}
	
**MyObject.php** - mais um objeto simples, com atributos, *getters* e *setters*.

	<?php

	class MyObject
	{
	    private $userid, $password;

	    public function userid($userid = '@')
	    {
		if($userid === '@')
		    return $this->userid;
		else
		    $this->userid = $userid;
		return $this;
	    }

	    public function password($password = '@')
	    {
		if($password === '@')
		    return $this->password;
		else
		    $this->password = $password;
		return $this;
	    }
	}
	
_____________________
###Strategy 

	| Chega de imundar o código com if, else if e else   |
	
Cria famílias de algoritmos, onde cada algoritmo se torna uma classe atributo de  um objeto, ao definir esse atributo classe definimos qual fluxo nosso objeto irá seguir, útil em situações como métodos de pagamentos e outros. No exemplo veremos a definição de conta de adição ou subtração.

**index.php** - cria um objeto com atributos e mostra como é  a saída dele quando definidos o fluxo com soma ou subtração.

	<?php
	require_once 'MyObject.php';

	$calc = new MyObject();
	$calc->number1 =  10;
	$calc->number2 = 3;

	$calc->type(new Sum());
	var_dump($calc->calculate()); // calculo da soma

	$calc->type(new Subtract());
	var_dump($calc->calculate()); // calculo da subtração

**MyObject.php** - objeto com atributos, tendo o método para definir o fluxo e outro para pegar a saída desse fluxo.

	<?php

	require 'MyOutputs.php';

	class MyObject
	{
	    private $output;
	    public $number1, $number2;

	    public function type(ICalculate $type)
	    {
			$this->output = $type;
	    }

	    public function calculate()
	    {
			return $this->output->calculate($this->number1, $this->number2);
	    }
	}
	
**MyOutputs.php** - arquivo que armazena as classes atributo e sua ação.

	<?php

	require_once 'ICalculate.php';

	class Subtract implements ICalculate
	{
	    public function calculate($n1, $n2)
	    {
			return $n1 - $n2;
	    }
	}

	class Sum implements ICalculate
	{
	    public function calculate($n1, $n2)
	    {
			return $n1 + $n2;
	    }
	}

**ICalculate.php** - Interface para fornecer o contrato com nossas classes atributo.

	<?php
	interface ICalculate
	{
	    public function calculate($n1, $n2);
	}


___________________
___________________

E chegamos ao final desse artigo, tentei trazer os 5 padrões de projetos que acho mais úteis, espero que tenha ampliado o conhecimento de quem estiver lendo. 

Qualquer dúvida, suguestão, crítica, ou algo a mais, favor comentar na publicação do Facebook ou WhatsApp, ou então abrir um Issue no repositório ou se preferir contatar no email leonardo-i@outlook.com.

P.S.: sem tempo para a revisão, então perdoem erros de português, se tiver.
