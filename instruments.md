# Documentação para preenchimento do objeto `instruments`:

O objeto `instruments` é um dicionário que organiza os parâmetros de controle de diferentes instrumentos e efeitos em um projeto. A única chave obrigatória é `pages`, que define como os parâmetros são organizados em páginas para navegação. As outras chaves são específicas de cada projeto, mas seguem um padrão comum: cada instrumento ou efeito tem seus próprios parâmetros, e cada parâmetro possui propriedades específicas.

### Estrutura Geral:
1. **`pages`**:
   - Organiza os parâmetros em páginas para facilitar a navegação.
   - Cada página é uma tabela de tabelas, onde cada sub-tabela contém dois elementos:
     - O primeiro elemento é o nome do instrumento ou efeito (ex: "organ", "bells", "vox_fx").
     - O segundo elemento é o nome do parâmetro a ser controlado (ex: "vol", "hpf_cutoff", "overdrive").
   - Exemplo:
     ```lua
     {
         {"organ", "vol"},
         {"bells", "vol"},
         {"vox_fx", "vol"},
         {"organ", "hpf_cutoff"}
     }
     ```

2. **Outras chaves (instrumentos/efeitos)**:
   - Cada instrumento ou efeito (ex: `organ`, `bells`, `vox_fx`, `mixer`) contém uma lista de parâmetros.
   - Cada parâmetro é uma tabela com as seguintes propriedades:
     - `level`: Valor atual do parâmetro.
     - `min`: Valor mínimo permitido.
     - `max`: Valor máximo permitido.
     - `res`: Incremento/decremento aplicado pelo encoder.
     - `send`: Destino do parâmetro (ex: "organ-out-ch", "wvtbl-hpf").
     - `transform` (opcional): Função que transforma o valor antes de enviá-lo (ex: conversão de escala).
     - `is_table` (opcional): Se `true`, indica que o valor transformado é uma tabela, não um número.
     - `path` (opcional): Caminho adicional para o destino (usado em combinação com `send`).

### Exemplo de Parâmetro:
```lua
organ = {
    vol = {
        level = 0,       -- Valor atual
        min = -100,      -- Valor mínimo
        max = 0,         -- Valor máximo
        res = 1,         -- Incremento/decremento
        send = "organ",  -- Destino
    },
    vibrato_mix = {
        level = 1,
        min = 0,
        max = 100,
        res = 1,
        send = "wvtbl-vib-mix",
        transform = function(v) return v / 100 * 2 - 1 end, -- Transformação aplicada
    },
    vibrato_range = {
        level = 3,
        min = 2.2,
        max = 8,
        res = 0.1,
        send = "wvtbl-vib",
        path = "range",
        transform = function(v) return {2, v} end, -- Transformação que retorna uma tabela
        is_table = true,
    },
}