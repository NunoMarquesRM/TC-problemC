# problemC
Course unit: Computational Theory (CT) - Problem C in ocaml

Resolution of Problem C in ocaml

## Problema

O objectivo deste exercício é a implementação do processo de execução de máquinas de Turing. Vamos limitar-nos neste exercício ao caso das execuções que terminam em tempo razoável. Uma execução é razoável quando termina em menos do que 200 passos.  

## Input

O input introduz o valor inicial da fita e a definiçaão da máquina de Turing M = (Q, Γ, Σ, δ, s, ], F).  
Para simplificar o formato dos dados de entrada admitiremos aqui que o conjunto dos estados Q é sempre da forma {1 . . . n} (n inteiro), que Σ = {a, . . . , z}, que Γ = {], A, B, . . . , Z} ∪ Σ e que o estado inicial é o estado 1.  

Na primeira linha é introduzida a palavra por reconhecer. Esta palavra só é constituida por carácter do alfabeto Σ tem por comprimento máximo 50 caracteres.  
Nas linhas restantes são introduzidos os dados necessários à definição completa da máquina de Turing M.  
Assim M = (Q, Γ, Σ, δ, s, ], F) é introduzida por:  
• uma linha com o inteiro n, especificando o conjunto Q = {1 . . . n};  
• uma linha com o numero nf (cardinalidade do conjunto F dos estados finais);  
• uma linha com nf inteiros distintos (separados por um espa¸co) que formam o conjunto dos estados finais;  
• uma linha com o número m de transições (a cardinalidade de δ));  
• m linhas em que cada uma delas introduz uma transição sob a forma de i a b d j, i sendo o inteiro representando o estado de partida da transição, a o carácter no rótulo da transição, b o carácter por escrever na fita, d ∈ {L, R} a direcção do movimento da cabeça de leitura/ecrita e j o inteiro que representa o estado de chegada.  

## Output

Dois casos: ou a execução decorreu e terminou em menos do que 200 passos (≤ 200) ou não:  

1. No primeiro caso o input é constituido por três linhas. Seja (s, α, β) a configuração final. Se s é final então a primeira linha contém a palavra YES, senão a palavra NO. A segunda linha apresenta o conteúdo da fita, ou seja esta linha apresenta a palavra αβ. Relembramos que e é a palavra vazia e como tal é o elemento neutro da concatenação. A terceira linha apresenta um inteiro. Este inteiro é o número total de passos que a execução necessitou para terminar.  
2. No segundo caso a resposta deve ser uma ´unica linha com o conteúdo: DON’T KNOW  

## Sample Input

aaabbb  
5  
1  
5  
10  
1 a X R 2  
1 Y Y R 4  
2 a a R 2  
2 b Y L 3  
2 Y Y R 2  
3 a a L 3  
3 X X R 1  
3 Y Y L 3  
4 Y Y R 4  
4 # # R 5  

## Sample Output
YES  
XXXYYY#  
25  
