let tokenize code =
  let rec explode string =
    if String.length string = 0 then []
    else [String.sub string 0 1] @
         explode (String.sub string 1 ((String.length string) - 1))
  in
  let specialChars =
    [
      "["; "]"; "-"; "+"; "*"; "/"; "("; ")"
    ]
  in
  let nonSpecialHelper = function
    | "" -> []
    | str -> [str]
  in
  let rec tokenizeHelper = function
    | [],currentItem, tokens ->
      tokens @ (nonSpecialHelper currentItem)
    | " "::lst, currentItem, tokens ->
      tokenizeHelper(
        lst,"",
        tokens @ nonSpecialHelper currentItem)
    | item::lst, currentItem, tokens ->
      if List.mem item specialChars then
        tokenizeHelper(
          lst, "",
          tokens @ nonSpecialHelper currentItem @ [item])
      else
        tokenizeHelper(lst, currentItem ^ item,tokens)
  in
  tokenizeHelper(explode code, "", [])

type ast =
  | Imm of int  (* immediate value *)
  | Arg of int  (* reference to n-th argument *)
  | Add of (ast * ast) (* add first to second *)
  | Sub of (ast * ast) (* subtract second from first *)
  | Mul of (ast * ast) (* multiply first by second *)
  | Div of (ast * ast) (* divide first by second *)

exception CompilerError of string

module type COMPILER =
sig
  val pass1: string -> ast
  val pass2: ast -> ast
  val codeGen: ast -> string list
  val compile: string -> string list
end

module Compiler : COMPILER =
struct
  let pass1 code =
    let is_number s = s.[0] >= '0' && s.[0] <= '9' in
    let rec arg_list code n = match code with
        "]" :: code -> (code, [])
      | var :: code ->
        let (code, args) = arg_list code (n + 1) in
        (code, (var, n) :: args)
      | _ -> raise (CompilerError "arg list expected") in
    let (code, symbols) = arg_list (List.tl (tokenize code)) 0 in
    let rec expression code =
      let (code, e1) = term code in expression_rest code e1
    and expression_rest code e1 = match code with
      | "+" :: code ->
        let (code, e2) = term code in expression_rest code (Add(e1, e2))
      | "-" :: code ->
        let (code, e2) = term code in expression_rest code (Sub(e1, e2))
      | _ -> (code, e1)
    and term code = let (code, e1) = factor code in term_rest code e1
    and term_rest code e1 = match code with
      | "*" :: code ->
        let (code, e2) = factor code in term_rest code (Mul(e1, e2))
      | "/" :: code ->
        let (code, e2) = factor code in term_rest code (Div(e1, e2))
      | _ -> (code, e1)
    and factor code = match code with
      | "(" :: code -> let (code, e) = expression code in (List.tl code, e)
      | x :: code ->
        if is_number x then (code, Imm(int_of_string x))
        else (code, Arg(List.assoc x symbols))
      | _ -> raise (CompilerError "syntax error") in
    expression code |> snd

  let rec pass2 = function
      Imm(_) | Arg(_) as x -> x
    | Add(x, y) -> let a = pass2 x and b = pass2 y in
      begin match (a, b) with
          (Imm(x), Imm(y)) -> Imm(x + y)
        | _ -> Add(a, b)
      end
    | Sub(x, y) -> let a = pass2 x and b = pass2 y in
      begin match (a, b) with
          (Imm(x), Imm(y)) -> Imm(x - y)
        | _ -> Sub(a, b)
      end
    | Mul(x, y) -> let a = pass2 x and b = pass2 y in
      begin match (a, b) with
          (Imm(x), Imm(y)) -> Imm(x * y)
        | _ -> Mul(a, b)
      end
    | Div(x, y) -> let a = pass2 x and b = pass2 y in
      begin match (a, b) with
          (Imm(x), Imm(y)) -> Imm(x / y)
        | _ -> Div(a, b)
      end

  let rec codeGen = function
      Imm(x) -> [Printf.sprintf "IM %d" x]
    | Arg(x) -> [Printf.sprintf "AR %d" x]
    | Add(x, y) -> (codeGen x) @ ["PU"] @ (codeGen y) @ ["SW"; "PO"; "AD"]
    | Sub(x, y) -> (codeGen x) @ ["PU"] @ (codeGen y) @ ["SW"; "PO"; "SU"]
    | Mul(x, y) -> (codeGen x) @ ["PU"] @ (codeGen y) @ ["SW"; "PO"; "MU"]
    | Div(x, y) -> (codeGen x) @ ["PU"] @ (codeGen y) @ ["SW"; "PO"; "DI"]

  let compile code =
    codeGen(pass2(pass1 code))
end

let rec simualte : string list * int list -> int =
  let stack = Stack.create () in
  let r0 = ref 0 in
  let r1 = ref 0 in
  function
  | ([],argumets) -> !r0
  | ("SU"::lst,argumets) ->
    r0 := !r0 - !r1;
    simualte(lst,argumets)
  | ("DI"::lst,argumets) ->
    r0 := !r0 / !r1;
    simualte(lst,argumets)
  | ("MU"::lst,argumets) ->
    r0 := !r0 * !r1;
    simualte(lst,argumets)
  | ("AD"::lst,argumets) ->
    r0 := !r0 + !r1;
    simualte(lst,argumets)
  | ("PU"::lst,argumets) ->
    Stack.push !r0 stack;
    simualte(lst,argumets)
  | ("PO"::lst,argumets) ->
    r0 := (Stack.pop stack);
    simualte(lst,argumets)
  | ("SW"::lst,argumets) ->
    let tmp = !r0 in
    r0 := !r1;
    r1 := tmp;
    simualte(lst,argumets)
  | (op::lst,argumets) ->
    let op_code = String.sub op 0 2 in
    let value =
      int_of_string
        (String.sub op 3 ((String.length op) - 3))
    in
    match op_code with
    | "IM" ->
      r0 := value;
      simualte(lst,argumets)
    | "AR" ->
      r0 := List.nth argumets value;
      simualte(lst,argumets)
    | _ -> raise (CompilerError "bad assembly")
