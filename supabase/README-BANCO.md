# Dudu Fitness — preparando banco de dados em nuvem

## Importante: GitHub não é um banco de dados
Como este projeto é HTML/CSS/JavaScript estático, o GitHub Pages pode hospedar o site, mas não permite que o navegador grave diretamente em um arquivo `.db` ou `.json` dentro do repositório. Isso também seria inseguro e não sincronizaria alterações corretamente entre dispositivos.

A opção recomendada para esta versão é **Supabase (PostgreSQL hospedado)**. O site se conecta pela API HTTPS e o banco fica separado do repositório.

## Arquivos incluídos
- `supabase/schema.sql`: cria a tabela de sessões e políticas de segurança (RLS).
- `supabase-config.example.js`: modelo de configuração, sem credenciais reais.

## Configuração
1. Crie um projeto no Supabase.
2. Abra **SQL Editor**, cole o conteúdo de `supabase/schema.sql` e execute.
3. Em **Project Settings / API** (a nomenclatura pode variar), copie a URL do projeto e a chave pública `publishable` ou `anon`.
4. Copie `supabase-config.example.js` para `supabase-config.js` e preencha a URL e a chave pública.
5. Configure autenticação no Supabase e habilite um método de login. O esquema usa `auth.uid()` e políticas RLS: sem autenticação, o usuário não conseguirá ler/gravar sessões.
6. Não publique nem compartilhe a chave `service_role`. Ela nunca deve estar no JavaScript do navegador.
7. Hospede os arquivos do site no GitHub Pages ou em outra hospedagem estática usando HTTPS.

## Estado atual
O site fornecido anteriormente ainda grava no `localStorage`; os arquivos acima preparam o banco e a configuração, mas **não conectam automaticamente a aplicação ao Supabase**. A integração do front-end deve ser feita como próximo passo, depois de decidir como será o login. Isso evita fingir que os dados já estão sendo sincronizados.

## Modelo de dados
Cada linha em `workout_sessions` guarda:
- usuário dono do registro;
- dia da rotina e foco do treino;
- data/hora de conclusão;
- exercícios, séries, pesos e repetições em JSONB.

## Antes de usar como definitivo
- Conectar o login e a sessão do Supabase no site.
- Trocar a leitura/gravação local pela API do banco (ou definir sincronização entre os dois).
- Testar políticas RLS com dois usuários diferentes.
- Fazer backup periódico e testar restauração.
