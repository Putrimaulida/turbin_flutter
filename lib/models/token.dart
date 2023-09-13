class Token {
    String token;

    Token({
        required this.token,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}