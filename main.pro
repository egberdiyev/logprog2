class cinema(
    id: integer,
    name: string,
    address: string,
    phone: string,
    seats: integer
).

class movie(
    id: integer,
    title: string,
    year: integer,
    director: string,
    genre: string
).

class show(
    cinemaId: integer,
    movieId: integer,
    date: string,
    time: string,
    revenue: integer
).

domains
    genre = string.

predicates
    cinema_address_by_genre(genre, string).
    count_cinemas(integer).
    average_seats(float).
    cinema_revenue(integer, integer).
    popular_cinema(integer, integer).
    addresses_of_cinemas(list[string]).
    addresses_by_director_genre(string, genre, list[string]).
    average_seats_in_cinemas(float).
    popular_cinemas(integer, list[integer]).
    total_revenue_for_cinema(integer, integer).

clauses
    cinema(1, "City Cinemas", "123 Main St.", "555-1234", 200).
    cinema(2, "Plex Cinemas", "456 Elm St.", "555-5678", 300).
    cinema(3, "Mega Cinemas", "789 Maple St.", "555-9012", 250).
    cinema(4, "Starlight Cinemas", "987 Oak St.", "555-3456", 150).
    cinema(5, "Sunset Cinemas", "654 Pine St.", "555-7890", 180).
    cinema(6, "Cineplex", "321 Cedar St.", "555-2345", 220).
    cinema(7, "Grand Cinemas", "567 Walnut St.", "555-6789", 280).
    cinema(8, "Royal Cinemas", "890 Birch St.", "555-9012", 190).
    cinema(9, "Silver Screen Cinemas", "432 Spruce St.", "555-3456", 210).
    cinema(10, "Cinema Paradiso", "876 Oak St.", "555-7890", 230).
    cinema(11, "Marquee Cinemas", "543 Pine St.", "555-2345", 260).
    cinema(12, "Cinema City", "987 Cedar St.", "555-6789", 320).
    cinema(13, "Hollywood Cinemas", "210 Walnut St.", "555-9012", 240).
    cinema(14, "Premiere Cinemas", "543 Birch St.", "555-3456", 280).
    cinema(15, "Cinema Magic", "876 Spruce St.", "555-7890", 200).

    movie(1, "The Matrix", 1999, "The Wachowskis", "sci-fi").
    movie(2, "The Godfather", 1972, "Francis Ford Coppola", "crime").
    movie(3, "The Shawshank Redemption", 1994, "Frank Darabont", "drama").
    movie(4, "Inception", 2010, "Christopher Nolan", "sci-fi").
    movie(5, "Pulp Fiction", 1994, "Quentin Tarantino", "crime").
    movie(6, "The Dark Knight", 2008, "Christopher Nolan", "action").
    movie(7, "Fight Club", 1999, "David Fincher", "drama").
    movie(8, "Goodfellas", 1990, "Martin Scorsese", "crime").
    movie(9, "The Lord of the Rings: The Fellowship of the Ring", 2001, "Peter Jackson", "fantasy").
    movie(10, "The Shawshank Redemption", 1994, "Frank Darabont", "drama").
    movie(11, "The Godfather: Part II", 1974, "Francis Ford Coppola", "crime").
    movie(12, "The Dark Knight Rises", 2012, "Christopher Nolan", "action").
    movie(13, "The Silence of the Lambs", 1991, "Jonathan Demme", "thriller").
    movie(14, "The Departed", 2006, "Martin Scorsese", "crime").
    movie(15, "Forrest Gump", 1994, "Robert Zemeckis", "drama").

    show(2, 1, "2023-05-09", "15:30", 150).
    show(2, 3, "2023-05-09", "18:00", 180).
    show(3, 2, "2023-05-09", "13:00", 200).
    show(3, 4, "2023-05-09", "16:30", 120).
    show(4, 3, "2023-05-09", "14:30", 150).
    show(4, 5, "2023-05-09", "17:00", 180).
    show(5, 4, "2023-05-09", "15:30", 200).
    show(5, 6, "2023-05-09", "18:00", 150).
    show(6, 5, "2023-05-09", "16:00", 180).
    show(6, 7, "2023-05-09", "19:30", 220).
    show(7, 6, "2023-05-09", "17:30", 250).
    show(7, 8, "2023-05-09", "20:00", 200).
    show(8, 7, "2023-05-09", "18:30", 230).
    show(8, 9, "2023-05-09", "21:00", 150).
    show(9, 8, "2023-05-09", "19:00", 180).
    show(9, 10, "2023-05-09", "21:30", 200).
    show(10, 9, "2023-05-09", "19:30", 230).
    show(10, 11, "2023-05-09", "22:00", 150).
    show(11, 10, "2023-05-09", "20:00", 180).
    show(11, 12, "2023-05-09", "22:30", 200).
    show(12, 11, "2023-05-09", "20:30", 230).
    show(12, 13, "2023-05-09", "23:00", 150).
    show(13, 12, "2023-05-09", "21:00", 180).
    show(13, 14, "2023-05-09", "23:30", 200).
    show(14, 13, "2023-05-09", "21:30", 230).
    show(14, 15, "2023-05-09", "00:00", 150).
    show(15, 14, "2023-05-09", "22:00", 180).
    show(15, 1, "2023-05-09", "00:30", 200).

    % Rule: Address of a cinema showing a movie of a certain genre
    cinema_address_by_genre(Genre, Address) :-
        cinema(CinemaId, _, Address, _, _),
        show(CinemaId, MovieId, _, _, _),
        movie(MovieId, _, _, _, Genre).

    % Rule: Count the number of cinemas
    count_cinemas(Count) :-
        findall(_, cinema(_, _, _, _, _), Cinemas),
        length(Cinemas, Count).

    % Rule: Calculate the average number of seats in all cinemas
    average_seats(Average) :-
        findall(Seats, cinema(_, _, _, _, Seats), SeatsList),
        sum_list(SeatsList, TotalSeats),
        count_cinemas(Count),
        Average is TotalSeats / Count.

    % Rule: Calculate the total revenue for a specific cinema
    cinema_revenue(CinemaId, TotalRevenue) :-
        findall(Revenue, show(CinemaId, _, _, _, Revenue), Revenues),
        sum_list(Revenues, TotalRevenue).

    % Rule: Check if a cinema is popular (total revenue greater than a threshold)
    popular_cinema(CinemaId, Threshold) :-
        cinema_revenue(CinemaId, TotalRevenue),
        TotalRevenue > Threshold.

    % Query: Addresses of all cinemas
    addresses_of_cinemas(CinemaAddresses) :-
        findall(Address, cinema(_, _, Address, _, _), CinemaAddresses).

    % Query: Addresses of cinemas showing a film of a certain director (of a certain genre)
    addresses_by_director_genre(Director, Genre, Addresses) :-
        findall(Address, (cinema_address_by_genre(Genre, Address), movie(_, _, _, Director, _)), Addresses).

    % Query: Average number of seats in all cinemas
    average_seats_in_cinemas(Average) :-
        average_seats(Average).

    % Query: Popular cinemas (total revenue greater than a threshold)
    popular_cinemas(Threshold, PopularCinemas) :-
        findall(CinemaId, popular_cinema(CinemaId, Threshold), PopularCinemas).

    % Query: Total revenue for a specific cinema
    total_revenue_for_cinema(CinemaId, TotalRevenue) :-
        cinema_revenue(CinemaId, TotalRevenue).
