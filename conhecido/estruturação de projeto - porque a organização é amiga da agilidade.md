# Estruturação de projeto: porque a organização é amiga da agilidade

Nesse breve artigo falarei sobre a estrutura de diretórios e arquivos em um projeto, como saber qual a melhor forma de organizar, nomes de diretórios e arquivos padrões, entre outros. 

Se você for usuário de algum framework provavelmente você não terá problemas com isso, pois frameworks já possuem uma estrutura de projeto bem organizada, lhe dizendo onde colocar qualquer tipo de arquivo. Mas como fazer para criar uma própria estrutura?

A primeira coisa seria criarmos os arquivos e pastas que qualquer projeto digno deve ter, que são:
####Arquivos
- *composer.json* - definição de descrição do projeto e suas dependências.
- *.htacess* - configuração de quais diretórios o usuário terá acesso direto.

####Diretórios
- *tests* - onde ficam os testes automatizados do sistema.
- *vendor* - pasta do composer, onde ficam o autoload e dependências.
- *public* - ficam os arquivos que o usuário terá acesso direto, os arquivos de visão, javascript, css, entre outros.
- *source* - aqui vai toda a lógica da sua aplicação, seja os diretórios das camadas (se usar um modelo de camadas) ou outros.

A segunda coisa a levar em consideração é o padrão de projeto e arquitetura usada no projeto, se teremos camadas então é melhor ter um diretório para cada camada, dentro da pasta source, ou seja, separar melhor as classes do padrão em diretórios distintos.

Para finalizar esse pequeno artigo, como desenvolvedor Java, C# e outros, sinto-me na obrigação de passar dicas que ajudam na identificação de arquivos, etc, como:

- Arquivos de classes tendo o mesmo nome da classe e com iniciais MAIUSCÚLAS.
- Arquivos de PHP estruturado com nome em MINUSCÚLO.
- Use namespaces, também coloque o arquivo de classe dentro do diretório do seu respectivo namespace, por exemplo a classe Cliente, com namespace Imobiliaria\Gerencia, ficaria no diretório /source/Imobiliaria/Gerencia/Cliente.php.

E é praticamente isso, lógico que podemos ampliar mais e organizar mais ainda nosso projeto, porém essa é a forma padrão dos projetos atuais. 

Qualquer dúvida, suguestão, crítica, ou algo a mais, favor comentar na publicação do Facebook ou WhatsApp, ou então abrir um Issue no repositório ou se preferir contatar no email leonardo-i@outlook.com.