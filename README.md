 A intenção aqui é selecionar as paradas baseadas em dependências de coisas
 para mandar o argumento via gitlab-ci.

# Placeholder title

A ideia é que esta gem seja usada em um monorepo. Como uma das ferramentas
de gerenciamento de jobs do gitlab-ci é através da inspeção de variáveis de CI,
e eu posso empurrar variáveis de CI via [`git push`](https://docs.gitlab.com/ee/user/project/push_options.html),
isso me fornece um controle preciso de quais projetos fazer o build de dentro
do monorepo ou não. Além de fornecer qual projeto fazer o build, ainda fornece
um mecanismo para que eu possa indicar quais são os projetos e subprojetos que
serão afetados por determinada mudança.

Para isso, é colocado em cada elemento do repositório um `dep-man-object` contendo:

- dependências diretas (lista de diretórios baseados na raiz do repo, ou arquivos)
- valor a ser colocado na variável de ambiente (precisa receber match de `[A-Za-z0-9_]+$`)

## Exemplo de uso no gitlab-ci

Seja o projeto:

```
project/
├── a
│   └── .gitlab-ci.yml
└── b
    └── .gitlab-ci.yml
```

# Linguagem de dependência