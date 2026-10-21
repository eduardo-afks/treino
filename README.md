# DUDU FITNESS — versão integrada ao Supabase

## Conteúdo
- `index.html`, `styles.css`, `app.js`: aplicação responsiva.
- `supabase-config.js`: URL e chave pública do projeto Supabase. A chave publishable é própria para o frontend; nunca coloque uma chave `secret`/`service_role` aqui.
- `supabase/schema.sql`: tabela e políticas de segurança.

## Antes de publicar
1. No Supabase, execute `supabase/schema.sql` no SQL Editor (se já executou o mesmo esquema com sucesso, não precisa repetir).
2. Em Authentication / URL Configuration, configure a Site URL para a URL do GitHub Pages que será usada. Adicione também a URL de redirecionamento, se aplicável.
3. Em Authentication / Providers, mantenha Email habilitado. Por padrão, pode ser exigida confirmação por e-mail.
4. Envie os arquivos do projeto ao repositório e habilite GitHub Pages.
5. Abra o site publicado, crie uma conta com seu e-mail e senha e entre.
6. Teste registrar pesos/repetições e concluir um treino; depois confira a tela Evolução.

## Como funciona
- As sessões concluídas são gravadas na tabela `public.workout_sessions`, vinculadas ao usuário autenticado.
- As políticas RLS restringem leitura, inclusão, atualização e exclusão ao dono do registro.
- Os rascunhos ainda ficam no armazenamento local do navegador até o treino ser concluído.
- A chave `sb_publishable_...` pode estar no frontend, desde que RLS esteja ativo. Nunca use `sb_secret_...` ou `service_role` no site.
- O Supabase JS é carregado por CDN, então o site precisa de conexão com a internet.

## Limitações / revisão
- O site foi preparado para a estrutura de banco descrita em `supabase/schema.sql`; teste a primeira gravação depois de publicar.
- Os dados ficam na nuvem por conta autenticada. Para trocar de aparelho, basta entrar com a mesma conta.
- Os GIFs são links externos e podem mudar ou ficar indisponíveis.
- O exercício “Tríceps na polia com barra W” está sem GIF porque o link fornecido anteriormente era para barra reta, não W.
- O exercício de supino inclinado foi mantido com 6 séries de aquecimento conforme informado na conversa; confirme se era isso mesmo antes de usar.


## Correção de tela em branco / GitHub Pages
Esta versão corrige um problema que escondia todo o elemento `main` quando o usuário ainda não estava autenticado. O formulário de login agora deve aparecer. Ao enviar para o GitHub Pages, envie os arquivos que estão dentro desta pasta diretamente para a raiz da branch configurada: `index.html`, `styles.css`, `app.js`, `supabase-config.js` e a pasta `supabase`. Não envie apenas o ZIP e não deixe `index.html` enterrado dentro de uma subpasta.


## GIFs demonstrativos nos exercícios
Os GIFs dos exercícios agora são exibidos e animados diretamente dentro de cada cartão, entre o nome do exercício e as séries/repetições. Eles vêm de URLs externas; se um servidor bloquear a exibição, o cartão mostra uma mensagem com link para abrir a demonstração.


## Login simplificado por nome
A tela aceita somente `eduardo` e usa autenticação anônima do Supabase para gravar sessões com as políticas RLS atuais. No painel Supabase, habilite Authentication > Sign In / Providers > Anonymous Sign-Ins. **Atenção:** digitar apenas um nome não é autenticação segura; qualquer pessoa que conheça o nome poderá entrar. A sessão anônima fica vinculada ao navegador/dispositivo e não é recuperável por e-mail.
