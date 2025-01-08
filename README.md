# **Andromeda Token (ADO)**

## **Descrição**

O Andromeda Token (“ADO”) é uma criptomoeda implementada no blockchain Ethereum seguindo o padrão ERC-20. Este contrato foi desenvolvido como uma introdução à criação de tokens no ecossistema Ethereum, utilizando funções básicas e seguras para transações e gerenciamento de permissões.

## Principais Funcionalidades

Transações seguras: Transferência de tokens entre carteiras.

Gestão de permissões: Aprovação e delegação de gastos para terceiros.

Compatibilidade ERC-20: Total suporte ao padrão para integração com carteiras e aplicações descentralizadas (dApps).

## Detalhes Técnicos

Nome do Token: Andromeda Coin

Símbolo: ADO

Decimais: 3

Suprimento Total: 1.000.000 ADO

## Requisitos de Ambiente

Solidity 0.8.0 ou superior.

Ferramentas de desenvolvimento Ethereum, como Remix IDE, Truffle, ou Hardhat.

Conta configurada no MetaMask para deploy e interações.

## Implementação

O contrato é dividido nas seguintes seções principais:

### 1. SafeMath

Prover operações matemáticas seguras para evitar erros como overflow e underflow.

### 2. Interface ERC20

Definir as funções padrão exigidas para um token ERC-20, como totalSupply, transfer, e approve.

### 3. Contrato AndromedaToken

Implementar a lógica do token e suas funcionalidades:

**Construtor**: Inicializa o token, definindo nome, símbolo, decimais e alocando o suprimento total para o criador.

**Transferência**: Transferência direta de tokens entre endereços.

**Aprovação**: Permitir que um terceiro gaste tokens em nome do dono.

**Transferência Delegada**: Transferir tokens utilizando permissão prévia do dono.

**Função de Fallback**: Rejeitar transações de ETH para o contrato.


## **Exemplo de Uso**

**Deploy do Contrato:**

Copie o código do contrato para o Remix IDE.

Compile usando o compilador Solidity configurado para a versão 0.4.24.

Realize o deploy utilizando sua carteira MetaMask.

**Transferência de Tokens:**

Use a função transfer para enviar tokens para outro endereço.

**Aprovação e Gasto:**

Chame approve para permitir que um terceiro gaste seus tokens.

O terceiro pode usar *transferFrom* para transferir os tokens aprovados.


### Melhorias Possíveis

Este contrato poderá vir a ser aprimorado no futuro com as seguintes funcionalidades adicionais:

**Queima de Tokens**: Permitir que os tokens sejam destruídos, reduzindo o suprimento total.

**Minting**: Adicionar mais tokens ao suprimento total.

**Taxas de Transação**: Implementar uma taxa que seja transferida para um endereço específico, como um fundo de desenvolvimento.

**Governança**: Adicionar métodos para permitir votação descentralizada.


## **Código**

O código completo está contido no arquivo ***andromeda.sol***.


**Licença**

Este projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.


## Imagens do andamento da criação do projeto e Testes poderão ser encontradas aqui na SUBPASTA *\IMAGENS*


## Contato

Para dúvidas ou sugestões, entre em contato:

Email: claudinei.d.gomes@gmail.com
GitHub: [github.com/ClaudinGomes]

