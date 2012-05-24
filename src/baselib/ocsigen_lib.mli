
(** This module contains some auxiliaries for the Ocsigenserver. In contrast to
    {!Ocsigen_lib_base}, the function may also refer to libraries other than the
    standard library.
  *)

include module type of Ocsigen_lib_base
  with type poly = Ocsigen_lib_base.poly
  and type yesnomaybe = Ocsigen_lib_base.yesnomaybe
  and type ('a, 'b) leftright = ('a, 'b) Ocsigen_lib_base.leftright
  and type 'a Clist.t = 'a Ocsigen_lib_base.Clist.t
  and type 'a Clist.node = 'a Ocsigen_lib_base.Clist.node

val make_cryptographic_safe_string : unit -> string

module String : module type of String_base

module Ip_address : sig

  type t =
    | IPv4 of int32
    | IPv6 of int64 * int64

  (* exception Invalid_ipaddress of string *)

  val parse : string -> t * (t option)
  val match_ip : t * (t option) -> t -> bool
  val network_of_ip : t -> int32 -> int64 * int64 -> t

  exception No_such_host

  val inet6_addr_loopback : t

  val get_inet_addr : string -> Unix.inet_addr Lwt.t

  (* val getnameinfo : Unix.inet_addr -> int -> string Lwt.t *)

end

module Filename : sig

  include module type of Filename

  (* val basename : string -> string *)
  (* val extension : string -> string *)
  val extension_no_directory : string -> string

end

module Url : sig
  include module type of Url_base with type t = Url_base.t
  val fixup_url_string : t -> t
  val encode : ?plus:bool -> string -> string
  val decode : ?plus:bool -> string -> string
  val make_encoded_parameters : (string * string) list -> string
  val string_of_url_path : encode:bool -> path -> uri
  val parse : t ->
    bool option * string option * int option *
      string * string list * string option *
      (string * string) list Lazy.t

end
