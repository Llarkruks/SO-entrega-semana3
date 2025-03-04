#include <stdio.h>

#include <stdlib.h>

#include <mysql/mysql.h>



void query_players_played_with(MYSQL *conn, const char *player) {

	char query[256];

	snprintf(query, sizeof(query),

			 "SELECT DISTINCT P1.Player AS Jugador_Con_Quien_Jugue "

			 "FROM Participation P1 "

			 "JOIN Participation P2 ON P1.Game = P2.Game "

			 "WHERE P2.Player = '%s' AND P1.Player <> P2.Player;", player);

	if (mysql_query(conn, query)) {

		fprintf(stderr, "Error al ejecutar la consulta: %s\n", mysql_error(conn));

		return;

	}

	

	MYSQL_RES *result = mysql_store_result(conn);

	if (!result) {

		fprintf(stderr, "Error al obtener el resultado: %s\n", mysql_error(conn));

		return;

	}

	MYSQL_ROW row;

	printf("Jugadores con los que %s ha jugado:\n", player);

	while ((row = mysql_fetch_row(result))) {

		printf("- %s\n", row[0]);

	}

	

	mysql_free_result(result);

}



int main() {

	MYSQL *conn = mysql_init(NULL);

	if (!conn) {

		fprintf(stderr, "Error al inicializar MySQL\n");

		return EXIT_FAILURE;

	}

	// Conectar a la base de datos

	if (!mysql_real_connect(conn, "localhost", "root", "tu_contraseña", "game", 0, NULL, 0)) {

		fprintf(stderr, "Error al conectar a la base de datos: %s\n", mysql_error(conn));

		mysql_close(conn);

		return EXIT_FAILURE;

	}

	

	// Pedir el nombre del jugador

	char player[50];

	printf("Ingrese el nombre del jugador: ");

	scanf("%49s", player);

	

	// Ejecutar la consulta

	query_players_played_with(conn, player);

	mysql_close(conn);

	

	return EXIT_SUCCESS;

}