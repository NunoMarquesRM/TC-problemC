open Printf

(*Leitura dos inputs*)
let read_input() =

    let rec charlist x acc i =
        if i == ( String.length x )
        then
            List.rev acc
        else
            charlist x ( x.[i] :: acc ) ( i + 1 )
    in

    (*Leitura da palavra*)
    let str = charlist ( Scanf.sscanf( read_line () ) "%s " (fun x -> x ) ^ "#" ) [] 0 in
    (*Leitura do estado inicial*)
    let inicial = Scanf.sscanf ( read_line () ) "%d " (fun a -> a ) in
    (*Leitura da cardinalidade do conjunto dos estados finais*)
    let aux1 = Scanf.sscanf ( read_line () ) "%d " (fun a -> a ) in

    (* Lista Estados finais *)
    let rec f1 i acc =
        if i == 0
        then
            acc
        else
            let state = Scanf.sscanf ( read_line () ) "%d " (fun a -> a ) in
            f1 ( i - 1 ) ( state :: acc )
    in
    let finais = f1 aux1 [] in

    (* Gramatica *)
    let aux2 = Scanf.sscanf ( read_line () ) "%d " ( fun a -> a ) in

    let rec f2 i acc =
        if i == 0
        then
            acc
        else
            let rule = Scanf.sscanf ( read_line () ) "%d %c %c %c %d" ( fun a b c d e -> ( a, b, c, d, e ) ) in
            f2 ( i - 1 ) ( rule :: acc )
    in
    let gramatica = f2 aux2 [] in

    ( str, inicial, finais, gramatica )


(* A funcao find_move vai dar match da variável "gs" que representa as opcoes no geral.
   No caso de ser nao vazia --> Se o estado for igual e a letra for a pretendida a funcao devolve,
   caso nao seja --> proxima iteracao.

   No caso de ser vazia --> A funcao ira enviar "dummy data" para quando fizer o lookup na tabela,
   devolvemos a dummy data para demonstrar que nao existe o que a funcao quer.
    *)
let rec find_move gs state letter =
    match gs with
        | ( i, x, _, _, _ ) as a :: gs ->
            if i == state && letter == x
            then
                a
            else
                find_move gs state letter
        | _ -> ( -1, 'a', 'a', 'a', -1 )

(* A funcao replace ira dar match da lista (que neste caso representa a palavra).
   Se a lista nao for vazia --> retorna a palavra normal, depois substitui a letra
   e concatena o que falta por ex (substituir o step 2 por b):

   teoria   
   t :: eoria                   step 0
   t :: e :: oria               step 1
   t :: e :: (o) :: ria         step 2  
   t :: e :: b :: ria

*)
let rec replace lst lt i step =
    match lst with
        | a :: ls ->
            if step == i
            then
                lt :: ls
            else
                a :: ( replace ls lt i ( step + 1 ) )
        | _ -> lst

(* A funcao find ira descobrir a letra que nos queremos mudar.
   por ex na palavra "teoria", se quisermos a 3a posicao usamos o find para descobrir
   que a letra em questao e a letra --> r*)
let rec find lst step i =
    match lst with
        | a :: ls ->
            if step == i
            then
                a
            else
                find ls ( step + 1 ) i 
        | _ -> '0'

(* A funcao f ira verificar se o step e inferior a 200.
   Caso seja superior a funcao imprime DON\'T KNOW , porque passou do limite e nao sabe a solucao.
   Caso seja inferior a 200, a funcao:

        - Sim --> A funcao fara um lookup no find_move para escolher o estado seguinte.
                  Se o estado seguinte for -1, nao existe transicao na nossa gramatica, logo
                  ira ser impressa a solucao "NO" e a informacao.

        - Nao --> E estado final?
                  Nao
                  Direcao cabeca e para a direita:
                    Sim - Vai para a proxima iteracao, somando 1 ao index da cabeca
                    Nao - Vai pra a proxima iteracao, subtraindo 1 ao index da cabeca
                  
                  Sim --> Apresenta a solucao "YES" e imprime a informacao
        *)
let rec f ls fs gs state step head =
    if step < 200
    then (
        let _, _, l, d, state = find_move gs state (find ls 0 head) in
        if state == -1
        then (
            printf "NO\n";
            List.iter (fun x -> printf "%c" x ) ls;
            printf "\n";
            printf "%d\n" step
        )
        else (
            if not ( List.mem state fs )
            then (
                if d == 'R'
                then
                    f ( replace ls l head 0 ) fs gs state (step + 1) (head + 1)
                else
                    f ( replace ls l head 0 ) fs gs state (step + 1) (head - 1)
            )
            else (
                printf "YES\n";
                List.iter (fun x -> printf "%c" x ) ( replace ls l head 0 );
                printf "\n";
                printf "%d\n" (step + 1)
            )
        )
    )
    else 
        printf "DON\'T KNOW\n"


let () =
    let s, i, fi, g = read_input () in
    f s fi g 1 0 0