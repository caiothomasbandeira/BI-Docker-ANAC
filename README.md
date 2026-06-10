# Projeto de BI - Data Warehouse de Aviação Civil (ANAC)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=Power%20BI&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

Este repositório contém a infraestrutura completa, os scripts de Engenharia de Dados (ETL) e a documentação para o Projeto Final da disciplina de Business Intelligence. O projeto constrói um Data Warehouse do zero utilizando dados abertos da Agência Nacional de Aviação Civil (ANAC), orquestrado via Docker, processado no PostgreSQL e visualizado no Power BI.

## Índice

- [1. Tema Escolhido](#1-tema-escolhido)
- [2. Explicação do Problema de Negócio](#2-explicação-do-problema-de-negócio)
- [3. Modelo Dimensional](#3-modelo-dimensional)
- [4. Desafios Enfrentados](#4-desafios-enfrentados)
- [5. Fonte dos Dados](#5-fonte-dos-dados)
- [6. Credenciais e Acessos](#6-credenciais-e-acessos)
- [7. Como Executar o Projeto](#7-como-executar-o-projeto)

---

## 1. Tema Escolhido
**Aviação Civil Brasileira:** Análise de voos, rotas, volume de passageiros e movimentação de cargas aéreas no Brasil entre os anos de 2023, 2024 e 2025.

## 2. Explicação do Problema de Negócio
O setor aéreo é um dos motores da economia e da logística nacional, caracterizado por alta complexidade operacional e margens de lucro estreitas. O objetivo deste projeto é fornecer uma camada analítica (Dashboard) para que gestores de companhias aéreas ou órgãos reguladores possam responder a perguntas estratégicas, tais como:
* Qual é a eficiência das rotas atuais (assentos oferecidos vs. passageiros pagos)?
* Quais companhias aéreas dominam o mercado nacional e internacional?
* Qual é a sazonalidade do setor (meses de pico de voos e passageiros)?
* Como se comporta o transporte de cargas (pagas vs. grátis) em relação ao volume de passageiros?
* Qual a proporção de voos domésticos comparados a voos internacionais ao longo do tempo?

## 3. Modelo Dimensional
O Data Warehouse foi modelado seguindo a metodologia **Star Schema** (Modelo Estrela), garantindo performance e facilidade para a criação da camada semântica no Power BI.

* **Tabela Fato:** `fato_voos` (Granularidade: Registro mensal consolidado de voos por rota, empresa e aeroportos).
* **Dimensões (6 no total):**
  1. `dim_tempo`: Dimensão avançada de calendário (Ano, Mês, Trimestre, Semestre).
  2. `dim_empresa`: Dados das companhias aéreas (Sigla, Nome, Nacionalidade).
  3. `dim_aeroporto` *(Role-Playing Dimension)*: Atua simultaneamente como Aeroporto de Origem e Aeroporto de Destino.
  4. `dim_natureza`: Classificação da natureza do voo (Doméstica, Internacional, Regional).
  5. `dim_grupo_voo`: Categoria do voo (Regular, Não Regular, Fretamento).
  6. `dim_rota`: Agrupamento simplificado da origem e destino para análises macro.

## 4. Desafios Enfrentados
Durante o desenvolvimento da arquitetura e da engenharia de dados, superamos os seguintes desafios técnicos:
1. **Bloqueio de Firewall Governamental (WAF):** A tentativa inicial de automatizar o download dos CSVs via script Shell (dentro do `Dockerfile`) foi bloqueada pelo sistema de segurança do site `gov.br`, que identificou o *curl* como um robô (`Request Rejected`). **Solução:** Baixar os arquivos e mapeá-los para dentro do contêiner utilizando *Docker Volumes*, garantindo resiliência e velocidade na subida do banco.
2. **Conflito de Quebra de Linha (CRLF vs LF):** Os scripts `.sh` criados no Windows impediam a inicialização do contêiner Linux do PostgreSQL (erro `bad interpreter: No such file or directory / ^M`). **Solução:** Normalização das quebras de linha para `LF` e implementação do arquivo `.gitattributes` para blindar o repositório contra formatações do Windows.
3. **Limpeza e Padronização de Dados:** A base bruta continha formatos numéricos em padrão brasileiro (vírgulas) e strings inconsistentes. **Solução:** Criação de funções auxiliares em SQL (`to_numeric_br`, `to_integer_br`) para higienização dos dados durante a carga para o Data Warehouse.

---

## 5. Fonte dos Dados

Os dados foram extraídos do portal oficial da Agência Nacional de Aviação Civil (ANAC). 
> **Atenção:** Para o pipeline de dados deste projeto, **utilizamos exclusivamente as bases de "Dados Estáticos"**. Os links dos "Microdados" foram mapeados e listados abaixo apenas para fins de documentação, mapeamento e referência futura.

### Bases Utilizadas no Projeto (Dados Estáticos)
* [Dados Estáticos - Ano 2023](https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2023)
* [Dados Estáticos - Ano 2024](https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2024)
* [Dados Estáticos - Ano 2025](https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2025)

<details>
<summary><b>Clique aqui para expandir a lista de Microdados (Apenas Referência)</b></summary>

**Dataset Principal:** [Microdados ANAC](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/microdados)

* **2023:** [Mês 01](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-01.zip) | [Mês 02](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-02.zip) | [Mês 03](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-03.zip) | [Mês 04](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-04.zip) | [Mês 05](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-05.zip) | [Mês 06](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-06.zip) | [Mês 07](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-07.zip) | [Mês 08](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-08.zip) | [Mês 09](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-09.zip) | [Mês 10](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-10.zip) | [Mês 11](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-11.zip) | [Mês 12](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-12.zip)
* **2024:** [Mês 01](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-01.zip) | [Mês 02](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-02.zip) | [Mês 03](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-03.zip) | [Mês 04](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-04.zip) | [Mês 05](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-05.zip) | [Mês 06](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-06.zip) | [Mês 07](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-07.zip) | [Mês 08](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-08.zip) | [Mês 09](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-09.zip) | [Mês 10](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-10.zip) | [Mês 11](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-11.zip) | [Mês 12](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-12.zip)
* **2025:** [Mês 01](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-01.zip) | [Mês 02](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-02.zip) | [Mês 03](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-03.zip) | [Mês 04](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-04.zip) | [Mês 05](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-05.zip) | [Mês 06](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-06.zip) | [Mês 07](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-07.zip) | [Mês 08](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-08.zip) | [Mês 09](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-09.zip) | [Mês 10](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-10.zip) | [Mês 11](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-11.zip) | [Mês 12](https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-12.zip)
</details>

---

## 6. Credenciais e Acessos

Os contêineres Docker expõem os serviços nas portas padrão locais. Utilize as tabelas abaixo para configurar e acessar cada ambiente:

### Servidor de Banco de Dados (PostgreSQL)
| Parâmetro | Valor |
| :--- | :--- |
| **Host** | `localhost` |
| **Porta** | `5432` |
| **Database** | `bi_db` |
| **Usuário** | `bi_user` |
| **Senha** | `bi_password` |

### Gerenciador do Banco (pgAdmin - Login Web)
| Parâmetro | Valor |
| :--- | :--- |
| **Acesso Web** | http://localhost:5050 |
| **Email (Login)** | `admin@example.com` |
| **Senha** | `admin` |

### Conexão do Servidor Postgres dentro do pgAdmin
| Parâmetro | Campo no pgAdmin | Valor |
| :--- | :--- | :--- |
| **Name** | General > Name | `bi_postgres` |
| **Host** | Connection > Host name/address | `postgres` |
| **Porta** | Connection > Port | `5432` |
| **Database** | Connection > Maintenance database | `bi_db` |
| **Usuário** | Connection > Username | `bi_user` |
| **Senha** | Connection > Password | `bi_password` |

---

## 7. Como Executar o Projeto

Siga a sequência abaixo para levantar a infraestrutura, carregar os dados e construir as Views analíticas.

### Pré-requisitos
* **Docker Desktop** e **Docker Compose** instalados e em execução.
* **Git** instalado para controle de versão.
* **Power BI Desktop** instalado para visualização do dashboard.
* **Arquivos de Dados:** Os arquivos CSV estáticos devem ser baixados e armazenados previamente no diretório da raiz do projeto seguindo a estrutura abaixo:
  ```text
  proj-final-bi/
  └── data/
      └── dados_estatico/
          ├── 2023.csv
          ├── 2024.csv
          └── 2025.csv
  ```

---

### Passo a Passo para Inicialização

#### Passo 1: Subir a Infraestrutura Docker
Abra o terminal na raiz do projeto (`proj-final-bi`) e execute o comando para construir as imagens e iniciar os serviços em segundo plano:
```bash
docker compose up -d --build
```
> *Nota: Aguarde alguns segundos após a execução. O terminal indicará o status de sucesso quando os contêineres estiverem marcados como `Healthy` e `Started`.*

#### Passo 2: Registrar o Banco de Dados no pgAdmin
1. Abra o seu navegador web e acesse o endereço de gerenciamento: `http://localhost:5050`
2. Realize o login utilizando as credenciais administrativas:
   * **Email:** `admin@example.com`
   * **Senha:** `admin`
3. No painel esquerdo, clique com o botão direito em **Servers** > **Register** > **Server...**
4. Preencha os campos obrigatórios utilizando as informações detalhadas na terceira tabela da Seção 6 (Aba General: `bi_postgres` | Aba Connection: `postgres`, `bi_user`, `bi_password`).

#### Passo 3: Executar a Carga de Dados e Modelagem (ETL)
Os scripts SQL locais são mapeados automaticamente por volumes para dentro do ambiente do pgAdmin.
1. No menu do pgAdmin, expanda o servidor registrado e clique com o botão direito sobre o banco de dados `bi_db`.
2. Selecione a opção **Query Tool** para abrir o editor de comandos.
3. Clique no ícone de pasta (Open File) para navegar até o diretório de armazenamento interno: `/var/lib/pgadmin/storage/admin_example_com`
4. Abra e execute os scripts `.sql` individualmente, seguindo estritamente a ordem numérica sequencial dos arquivos (ex: `01_dw.sql`, `02_tables.sql`, `03_import_estaticos.sql`... até o último script de criação das views). 
5. Este processo consolidará o carregamento das tabelas fato, dimensões e a estrutura final do Data Mart.

#### Passo 4: Conectar e Consumir no Power BI
1. Inicie o software do **Power BI Desktop** e abra o arquivo do seu projeto ou crie um novo relatório vazio.
2. Na aba inicial, clique em **Obter Dados** > **Mais...** > **Banco de Dados** > **Banco de Dados PostgreSQL** e clique em Conectar.
3. Na primeira janela de configuração (**Banco de dados PostgreSQL**), preencha os parâmetros de rede:
   * **Servidor:** `localhost`
   * **Banco de Dados:** `bi_db`
   * **Modo de Conectividade de Dados:** Recomendamos selecionar **Importar** (para garantir melhor performance e habilitar todas as funções DAX avançadas no seu Data Warehouse). Clique em **OK**.
4. Na janela seguinte de autenticação, siga os passos com atenção:
   * Na barra lateral esquerda, clique na aba **Banco de Dados** (não use a opção "Windows" ou "Conta da Microsoft").
   * **Nome do usuário:** `bi_user`
   * **Senha:** `bi_password`
   * **Selecione o nível no qual essas configurações serão aplicadas:** No menu suspenso que aparece (geralmente na parte inferior ou superior da tela), selecione a opção específica do banco: `localhost;bi_db`. Isso garante que as credenciais fiquem salvas apenas para este projeto.
   * Clique em **Salvar** / **Conectar**.
5. No navegador de tabelas do Power BI que se abrirá, selecione e carregue **apenas as Views analíticas** criadas dentro do schema do Data Mart:
   ```text
   datamart.view_kpi
   datamart.view_month
   datamart.view_per_company
   datamart.view_routes
   
> **Regra de Arquitetura:** Para preservar a integridade do modelo dimensional estabelecido, nunca importe as tabelas cruas ou os schemas internos de transformação (`repositorio` ou `dw`) diretamente para o ambiente do Power BI. O consumo deve ser feito exclusivamente através das Views disponibilizadas no `datamart`.
