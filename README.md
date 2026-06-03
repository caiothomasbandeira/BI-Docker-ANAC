# Projeto Final de BI - Data Warehouse de Aviação Civil (ANAC)

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

Os contêineres Docker expõem os serviços nas portas padrão locais. Utilize as credenciais abaixo para acesso:

### Servidor de Banco de Dados (PostgreSQL)
| Parâmetro | Valor |
| :--- | :--- |
| **Host** | `localhost` |
| **Porta** | `5432` |
| **Database** | `bi_db` |
| **Usuário** | `bi_user` |
| **Senha** | `bi_password` |

### Gerenciador do Banco (pgAdmin)
| Parâmetro | Valor |
| :--- | :--- |
| **Acesso Web** | [http://localhost:5050](http://localhost:5050) |
| **Email (Login)** | `admin@example.com` |
| **Senha** | `admin` |

*(No pgAdmin, ao criar um novo servidor para acessar o banco, utilize os dados: Name: `bi_postgres`, Host name: `postgres`, Port: `5432`, Maintenance DB: `bi_db`, Username: `bi_user`, Password: `bi_password`)*.

---

## 7. Como Executar o Projeto

Siga a sequência abaixo para levantar a infraestrutura, carregar os dados e construir as Views analíticas.

### Pré-requisitos
* **Docker Desktop** e **Docker Compose** instalados.
* **Git** instalado.
* Os arquivos CSV estáticos baixados e armazenados no diretório `./data/dados_estatico/` na raiz do projeto (com os nomes `2023.csv`, `2024.csv`, `2025.csv`).
* **Power BI Desktop** instalado.

### Passo a Passo

**1. Subir a Infraestrutura (Docker)**
No terminal, navegue até a raiz do projeto e execute:
```bash
# Constroi a imagem e sobe os conteineres em segundo plano
docker compose up -d --build
```
Aguarde alguns segundos até que o terminal indique que os contêineres estão com o status `Healthy` e `Started`.

**2. Acessar o pgAdmin**
* Abra o navegador e acesse: `http://localhost:5050`.
* Faça login com as credenciais administrativas (`admin@example.com` / `admin`).
* Registre o servidor do PostgreSQL utilizando as credenciais listadas na seção 6.

**3. Executar os Scripts SQL (ETL e Modelagem)**
Os scripts estão mapeados automaticamente para dentro do contêiner do pgAdmin por meio de volumes.
Para executá-los, no pgAdmin:
* Clique com o botão direito no banco `bi_db` e abra a **Query Tool**.
* O caminho interno onde os scripts estão disponíveis é: `/var/lib/pgadmin/storage/admin_example_com`
* Navegue até esta pasta pelo ícone de abrir pasta na Query Tool e execute os scripts `.sql` seguindo a numeração sequencial (ex: `01_dw.sql`, `02_tables.sql`, etc.), culminando na criação do Data Mart.

**4. Conectar o Power BI**
* Abra o arquivo `.pbix` ou inicie um novo projeto no Power BI.
* Selecione **Obter Dados > Banco de Dados PostgreSQL**.
* Preencha as credenciais: Servidor `localhost`, Banco `bi_db`.
* Na aba lateral esquerda (na tela de login do Power BI), certifique-se de escolher **Banco de Dados** (Database) e insira o usuário `bi_user` e senha `bi_password`.
* **Regra Importante:** Para atender a arquitetura de BI, importe **apenas as Views** pertencentes ao schema `datamart` (ex: `datamart.view_kpi`, `datamart.view_month`), e não as tabelas cruas do schema `dw`.