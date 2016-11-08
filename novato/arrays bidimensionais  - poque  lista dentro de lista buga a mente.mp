# Arrays bidimensionais  - poque  lista dentro de lista buga a mente

Muitas vezes desenvolvedores se perdem quando há muitos dados recolhidos, fazendo com que em determinadas situações apareçam os chamados arrays bidimensionais, que são nada mais e nada menos que listas representadas como matrizes, tendo linhas e colunas.

Mas eu pessoalmente não gosto muito de tratar esse conceito, como muitas vezes desenvolvedores veem de linguagem de baixo nível como o C, acabam tendo essa visao mais matemática das coisas e se esquecem que com PHP tudo são flores, nessa caso, tudo são **arrays associativos**.

Arrays associativos são listas com chave de outro tipo, distinto de inteiro, como conhecemos em array de outras linguagens, na prática o array:

	[
		0 => 'Leonardo',
		1 => 20,
		2 => 'leonardo-i@outlook.com'
	]
	
Se tranformaria em uma representação do objeto, com chaves mais apropriadas, como:

	[
		'nome' => 'Leonardo',
		'idade' => 20,
		'email' => 'leonardo-i@outlook.com'
	]

Assim já podemos perceber que grande parte do problema já foi solucionada, pois agora podemos identificar nossos elementos por nome e não mais por um número em sequência. Outra coisa bastante esquecida pela maioria dos desenvolvedores é a estrutura `foreach` (desconhecida para desenvolvedores de C), onde teremos a mesma função do `for`, só que muito mais simples. 

Vamos ao exemplo, primeiro tenho dois arquivos, um com um array bidimensional associativo, e outro com um array bidimensional normal:

**array-normal.php**

	<?php
	$list = array(
	    array('Leonardo', 20, 'leonardo-i@outlook.com'),
	    array('Joao',     12, 'joao@outlook.com'),
	    array('Manoel',   45, 'manoel@outlook.com'),
	    array('Jose',     30, 'jose@outlook.com')
	);
	?>
	
**array-associativo.php**

	<?php
	$list = array(
	    array('nome' => 'Leonardo', 'idade' => 20, 'email' => 'leonardo-i@outlook.com'),
	    array('nome' => 'Joao',     'idade' => 12, 'email' => 'joao@outlook.com'),
	    array('nome' => 'Manoel',   'idade' => 45, 'email' => 'manoel@outlook.com'),
	    array('nome' => 'Jose',     'idade' => 30, 'email' => 'jose@outlook.com')
	);
	?>

	


Tendo o arquivo **for01.php** usando `for` e arrays bidimensionais normais:

	<?php

	include 'array-normal.php';

	for ($i=0; $i < count($list); $i++) {
	    echo "<p>Nome: {$list[$i][0]}</p>";
	    echo "<p>Idade: {$list[$i][1]}</p>";
	    echo "<p>Email: {$list[$i][2]}</p>";
	    echo "<hr>";
	}
	
Agora o arquivo **foreach01.php** com mesmo código usando `foreach` :

	<?php

	include 'array-normal.php';

	foreach ($list as $item) {
	    echo "<p>Nome: {$item[0]}</p>";
	    echo "<p>Idade: {$item[1]}</p>";
	    echo "<p>Email: {$item[2]}</p>";
	    echo "<hr>";
	}
	
Ficou melhor né? Mas e se usarmos **arrays associativos**?

**for02.php** - com array associativo:


	<?php

		include 'array-associativo.php';

		for ($i=0; $i < count($list); $i++) {
		    echo "<p>Nome: {$list[$i]['nome']}</p>";
		    echo "<p>Idade: {$list[$i]['idade']}</p>";
		    echo "<p>Email: {$list[$i]['email']}</p>";
		    echo "<hr>";
		}
	
Ficou mais legível, não é mesmo? É mesmo! 

**foreach02.php** - na sua versão final (a melhor forma de se fazer)

	<?php

	include 'array-associativo.php';

	foreach ($list as $item) {
	    echo "<p>Nome: {$item['nome']}</p>";
	    echo "<p>Idade: {$item['idade']}</p>";
	    echo "<p>Email: {$item['email']}</p>";
	    echo "<hr>";
	}

Acho que assim qualquer um entende, não é mesmo? É mesmo!

Chego ao final desse artigo, desculpem se ficou algo simples, mas tive dificuldade em entender a dúvida, pois array bidimensional é algo simples, mas entendo que para iniciantes pode ser complicado, então no artigo foquei em como você ve o array  e como deixa-lo mais 'endentivel'.

Qualquer dúvida, suguestão, crítica, ou algo a mais, favor comentar na publicação do Facebook ou WhatsApp, ou então abrir um Issue no repositório ou se preferir contatar no email leonardo-i@outlook.com.

P.S.: sem tempo para a revisão, então perdoem erros de português, se tiver.
