# 🚗 Oficina Mecânica - Sistema de Gerenciamento

## 📌 Descrição do Projeto

Este projeto consiste no desenvolvimento de um banco de dados relacional para gerenciamento de uma oficina mecânica de automóveis. O sistema permite controlar clientes, veículos, ordens de serviço, mecânicos, especialidades, serviços e peças.

## 🎯 Objetivo

Criar uma solução completa para gerenciamento de oficina, permitindo:
- Cadastro de clientes e seus veículos
- Controle de ordens de serviço
- Gestão de mecânicos e suas especialidades
- Controle de estoque de peças
- Emissão de relatórios gerenciais

## 📊 Modelo Lógico

### Entidades Principais:
- **Cliente**: Donos dos veículos
- **Veículo**: Automóveis que serão reparados
- **Ordem de Serviço (OS)**: Documento que registra os serviços
- **Mecânico**: Profissionais da oficina
- **Especialidade**: Áreas de atuação dos mecânicos
- **Serviço**: Tipos de serviços disponíveis
- **Peça**: Componentes que podem ser trocados

### Relacionamentos:
- Um cliente pode ter vários veículos (1:N)
- Um veículo pode ter várias OS (1:N)
- Uma OS pode ter vários serviços (N:N)
- Uma OS pode usar várias peças (N:N)
- Um mecânico pode ter várias especialidades (N:N)

## 🛠️ Tecnologias Utilizadas

- **MySQL** - Sistema de Gerenciamento de Banco de Dados
- **MySQL Workbench** - Modelagem e execução de queries
- **Git & GitHub** - Versionamento e hospedagem

## 📁 Estrutura do Projeto
### Diagrama ER Reproduzido

![Diagrama ER do Banco de Dados da Oficina Mecânica](images/EER%20Diagram_Oficina.png)


## 🔍 Queries Implementadas

| Cláusula | Descrição | Exemplo de Pergunta |
|----------|-----------|---------------------|
| SELECT simples | Recuperação básica | Listar todos os clientes |
| WHERE | Filtros | Veículos com > 50.000 km |
| Atributos derivados | Cálculos | Valor total do estoque |
| ORDER BY | Ordenação | Serviços mais caros primeiro |
| HAVING | Filtro em grupos | Clientes com + de 2 veículos |
| JOINs complexos | Múltiplas tabelas | Detalhamento completo da OS |

## 📈 Principais Consultas

1. **Total gasto por cliente** - Ranking de clientes por valor gasto
2. **Serviços mais executados** - Análise de serviços populares
3. **Peças mais utilizadas** - Controle de saída de peças
4. **Mecânicos por especialidade** - Gestão de equipe
5. **Ordens de serviço detalhadas** - Visão completa do atendimento

## 🚀 Como Executar

1. Clone o repositório
2. Execute o script `schema.sql` no MySQL
3. Execute o script `inserts.sql` para dados de exemplo
4. Execute `queries.sql` para testar as consultas

## 📊 Exemplo de Resultados

### Top 5 Clientes por Gasto:
| Cliente | Total Ordens | Total Gasto |
|---------|--------------|-------------|
| João Silva | 2 | R$ 1.130,00 |
| Carlos Oliveira | 1 | R$ 980,00 |

## 👨‍💻 Autor

Desenvolvido como projeto de banco de dados para gerenciamento de oficina mecânica.

## 📅 Status do Projeto

✅ Concluído - Banco de dados implementado com todas as funcionalidades propostas.
