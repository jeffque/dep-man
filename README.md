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
- nome do projeto (a priori, idêntico ao do diretório, mas pode ser sobrescrito)

## Exemplo de uso no gitlab-ci

Seja o projeto:

```
project/
├── eron-project
│   └── .gitlab-ci.yml
└── minsk-project
│   └── .gitlab-ci.yml
└── .gitlab-ci.yml
```

Para se fazer o build do projeto `eron-project`, de maneira única, podemos
adicionar uma regra para isso:

```yaml
build-eron-project:
  script:
    - cd eron-project
    - echo 'hello world'
  rules:
    - if: $WHO_TO_BUILD =~ ".*,eron-project,.*" && $CI_COMMIT_TAG
```

E para gerar o `minsk-project`, de maneira semelhante, poderia fazer:

```yaml
build-minsk-project:
  script:
    - cd minsk-project
    - echo 'hello world'
  rules:
    - if: $WHO_TO_BUILD =~ ".*,minsk-project,.*" && $CI_COMMIT_TAG
```

A variável a ser empurrada é `WHO_TO_BUILD`, e cada elemento de build é
identificado por um nome único.

# Linguagem de dependência

Vide o objeto `DepManRegistry`:

```rb
DepManRegistry.register do |myNewDepManObj|
    myNewDepManObj.deps = [ 'minsk-project' ]
    myNewDepManObj.name = 'eron-project'
end
```