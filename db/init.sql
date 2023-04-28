SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `auctiondb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `auctiondb`;

-- DROP TABLE IF EXISTS `users`;
-- CREATE TABLE `users` (
--   `id` bigint(20) NOT NULL AUTO_INCREMENT,
--   `name` varchar(255) DEFAULT NULL,
--   PRIMARY KEY (`id`)
-- ) 
CREATE TABLE `bids` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED DEFAULT NULL,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `bidAmount` float DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `bids`
--

INSERT INTO `bids` (`id`, `product_id`, `user_id`, `bidAmount`, `date`) VALUES
(1, 1, 1, 0.1, '2023-02-03 10:00:00'),
(2, 2, 1, 0.1, '2023-02-04 00:00:00'),
(3, 3, 1, 0.1, '2023-02-03 13:00:00'),
(4, 4, 1, 0.1, '2023-02-03 23:00:00'),
(5, 5, 1, 0.1, '2023-02-03 07:00:00'),
(6, 6, 1, 0.1, '2023-02-04 02:00:00'),
(7, 7, 1, 0.1, '2023-02-04 02:00:00'),
(8, 8, 1, 0.1, '2023-02-04 05:55:00'),
(9, 9, 1, 0.1, '2023-02-04 03:12:00'),
(10, 10, 1, 0.1, '2023-02-03 22:00:00'),
(11, 11, 1, 0.1, '2023-02-03 19:00:00'),
(12, 12, 1, 0.1, '2023-02-03 17:08:00'),
(13, 13, 1, 0.1, '2023-02-03 15:20:00');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  `categoryImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `category`, `options`, `categoryImage`) VALUES
(1, 'Electronics', '(smartphones, laptops, tablets, etc.)', '/categories/Electronics.png'),
(2, 'Fashion', '(clothing, shoes, accessories, etc.)', '/categories/Fashion.png'),
(3, 'Home & Garden', '(furniture, home décor, appliances, etc.)', '/categories/Home & Garden.png'),
(4, 'Collectibles', '(sports memorabilia, stamps, coins, etc.)', '/categories/Collectibles.png'),
(5, 'Art', '(paintings, sculptures, prints, etc.)', '/categories/Art.png'),
(6, 'Jewelry', '(diamonds, gold, silver, etc.)', '/categories/Jewelry.png'),
(7, 'Antiques', '(vintage furniture, pottery, glassware, etc.)', '/categories/Antiques.png'),
(8, 'Automotive', '(cars, motorcycles, boats, etc.)', '/categories/Automotive.png'),
(9, 'Books', '(rare books, first editions, etc.)', '/categories/Books.png'),
(10, 'Music', '(vinyl records, CDs, etc.)', '/categories/Music.png'),
(11, 'Sporting Goods', '(golf clubs, bicycles, etc.', '/categories/Sporting Goods.png'),
(12, 'Tools', '(power tools, hand tools, etc.)', '/categories/Tools.png'),
(13, 'Toys & Hobbies', '(action figures, models, etc.)', '/categories/Toys & Hobbies.png'),
(14, 'Travel', '(airline tickets, vacation packages, etc.)', '/categories/Travel.png');

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int(11) UNSIGNED NOT NULL,
  `owner_id` int(11) UNSIGNED DEFAULT NULL,
  `productName` varchar(27) DEFAULT NULL,
  `category_id` int(11) UNSIGNED DEFAULT NULL,
  `productDescription` varchar(255) DEFAULT NULL,
  `productImage` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `owner_id`, `productName`, `category_id`, `productDescription`, `productImage`, `date`) VALUES
(1, 1, 'Phone', 1, 'OnePlus Nord N200 5G', '/products/phone.jpg', '2023-02-03 10:00:00'),
(2, 1, 'Custom Air Force 1', 2, 'Splatter Nike Swoosh - AF1 - Custom AF1 -Custom Nike - Custom shoes - Personalized Air force - Painted AF1    ', '/products/shoes.avif', '2023-02-04 00:00:00'),
(3, 1, 'Coin', 4, 'Passion for history, taste for aesthetics and fairness - this is our vision of numismatics', '/products/coin.jpg', '2023-02-03 13:00:00'),
(4, 1, 'The Art of War By Sun Tzu', 9, 'Meticulously written with old takes on an otherwise contentious topic like war, written to highlight the multi-dimensional implications of its central topic, The Art of War is a book meant for all levels of readers regardless of whether they are beginners', '/products/book.jpg', '2023-02-03 23:00:00'),
(5, 1, 'Earrings', 6, 'Siren Wire Earrings 18 ct Gold Vermeil & Green Onyx', '/products/earrings.webp', '2023-02-03 07:00:00'),
(6, 1, 'NFT', 4, 'Bored Ape Yacht Club #8817', '/products/nft.png', '2023-02-04 02:00:00'),
(7, 1, 'SuperMan Figure', 13, 'Showcase Series 1 Superman Action Figure', '/products/superman.jpg', '2023-02-04 02:00:00'),
(8, 1, 'Bicycle', 8, 'In an effort to make bicycling accessible to more would-be riders, John Kemp Starley—the same man behind the Ariel penny farthing—created the Rover in 1885 in Coventry, England. ', '/products/bicycle.jpg', '2023-02-04 05:55:00'),
(9, 1, 'Samsung Galaxy Watch 5', 1, 'amsung Galaxy Watch 5 specifications: 1.4-inch SAMOLED screen | One UI 4.5 based on Android Wear 3.5 | Exynos W920 chipset | 1.5GB RAM | 16GB internal storage | Bluetooth 5.2 | 410mAh battery', '/products/smartwatch.jpg', '2023-02-04 03:12:00'),
(10, 1, 'Art piece', 5, 'Tamatina Modern Art Canvas Painting|Moon with The Leaves|Abstract Art|Size-13X11 Inches.X366', '/products/art.jpg', '2023-02-03 22:00:00'),
(11, 1, 'Hugo Lorris Gloves', 11, 'SIGNED HUGO LLORIS GOALKEEPER GLOVE DISPLAY FRAMED - TOTTENHAM HOTSPUR ICON', '/products/gloves.jpg', '2023-02-03 19:00:00'),
(12, 1, 'Good Rockin\' Tonight', 10, 'Good Rockin\' Tonight - The Old Town Records Story 1952-1962 ', '/products/cd.jpg', '2023-02-03 17:08:00'),
(13, 1, 'Phil Foden', 11, 'SIGNED PHIL FODEN GLOVE DISPLAY FRAMED - MAN CITY ICON', '/products/foden.webp', '2023-02-03 15:20:00');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `balance` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `balance`) VALUES
(1, 'Gayle Ward MD', 'Misty.Abernathy@hotmail.com', 'YFQ33ihuZjVn9mt', 7973530),
(2, 'Virgil Brekke', 'Jerrell.Price@gmail.com', '9O3gVgD2RjlSiYJ', 4329460),
(3, 'William Bechtelar', 'Terrill16@yahoo.com', 'HasYY2dE3RiGQAV', 3228500),
(4, 'Stanley Parisian', 'Emanuel_Rau76@hotmail.com', 'Fbq0SGwqqW9OwiO', 5399710),
(5, 'Tricia Rutherford', 'Julianne_Rowe93@hotmail.com', 'JrCOpMxhL9iWvxt', 5028750),
(6, 'Lucille Gutkowski', 'Jaren_Hansen75@yahoo.com', '_4IchXtLzG5CpKa', 4834450),
(7, 'Connie Kuphal', 'Gretchen.Kris87@yahoo.com', 'aWSqgX_w37OYwBW', 2256590),
(8, 'Kimberly Rowe', 'Delpha_Johnston@gmail.com', 'JwpJxymvBW5o8Rk', 7693950),
(9, 'Darrell Nitzsche', 'Delphia_Lakin@gmail.com', 'SMhbCQIA30QMUtU', 4816690),
(10, 'Jimmie O\'Conner', 'Golda78@hotmail.com', 'EOGD0wwej_CO00o', 3257880),
(11, 'Kyle Powlowski', 'Darryl.Zulauf70@gmail.com', 'Itiw3RTactMAizg', 3965920),
(12, 'Brett Harris', 'Marge78@hotmail.com', 'Zz2ofcK196Ha56_', 3602920),
(13, 'Horace Hammes IV', 'Elijah.Hoeger31@hotmail.com', 'IQMpZsdgnT9djvM', 8242590),
(14, 'Edna Goyette', 'Manuela74@gmail.com', 'X9BJEu220QRI5PB', 9712490),
(15, 'Abel Veum', 'Garrison42@gmail.com', 'tET2woUygY5g3DG', 7913010),
(16, 'Gilbert Metz', 'Bryana60@yahoo.com', '_y2TgCLLwx7ZpQW', 4868170),
(17, 'Nelson Wolff', 'Etha.Schuppe@hotmail.com', 'Yy8qqbInWM9yiJf', 9782860),
(18, 'Percy Block', 'Alessandra27@gmail.com', 'Duw9vqRvLmbAqPd', 1984400),
(19, 'Alicia Veum', 'Darwin66@gmail.com', 'b8zz8232r9huas0', 4556110),
(20, 'Mario Mayert', 'Ewell59@yahoo.com', '0Ohqw0kpQagizuX', 9185750),
(21, 'Natasha Stracke I', 'Ford18@hotmail.com', 'j1AQ7UAbQPnml9E', 9461100),
(22, 'Sarah Tromp', 'Joaquin68@gmail.com', 'lZlnS7vpzdr6aCG', 5513880),
(23, 'Brett Roob DVM', 'Oma_Bahringer14@yahoo.com', 'd4o8fW_ncKw2HPu', 9278290),
(24, 'Peter Johnston', 'Maurice.Cruickshank61@hotmail.', 'dgysLdjRNLv2KQr', 2637040),
(25, 'Edwin Sauer', 'Abdiel_Schamberger@hotmail.com', 'gRtIz2GL4XXPmpX', 3938160),
(26, 'Miss Jeanette Beier', 'Quincy.Kovacek@hotmail.com', '5DfzJy7wus4lmKi', 1446450),
(27, 'Lucille Cartwright', 'Kade41@gmail.com', 'WINvMpUxjD0Aujg', 4419700),
(28, 'Clyde Nader', 'Raquel_Stamm@yahoo.com', 'hOwr4ll_piB_59L', 1302230),
(29, 'Taylor Kirlin', 'Markus_Upton39@hotmail.com', 'yZiH2ZhM_MCwHr3', 7200620),
(30, 'Miss Antonio DuBuque', 'Baron25@yahoo.com', 'S_BhXZkR3UfYBuY', 9331030),
(31, 'Gwendolyn Funk', 'Theresa.Bailey0@gmail.com', 'ATvyJKFvF0btiVH', 6909370),
(32, 'Brittany Bayer III', 'Stephany96@gmail.com', '8K9l0ppVO_i6m35', 2437550),
(33, 'Jerome Moen', 'Kelley.Rogahn35@yahoo.com', 'GJvbVpCQtO73KDU', 5098100),
(34, 'Ora Pouros I', 'Friedrich35@hotmail.com', 'tUKSA_5t2_y_U29', 4595690),
(35, 'Leticia Jaskolski', 'Merl51@hotmail.com', 'OHaTXTBWW5rAnN7', 2228860),
(36, 'Blanche Cummings', 'Ellie.Langosh@yahoo.com', 'PM2RMQARisCfbWJ', 6748930),
(37, 'Spencer Kreiger', 'Tatyana55@yahoo.com', 'Em319UzECT3VUqf', 8570020),
(38, 'Sabrina Beier', 'Vida_Stracke95@hotmail.com', 'HdRFQpMF5JElfuE', 3271090),
(39, 'Kerry Considine', 'Grover.Zemlak@hotmail.com', 'Mxu46Hsc7Vk5Qsf', 2132400),
(40, 'Ruben Gerlach', 'Megane.Abbott@hotmail.com', 'rG5uwHoQoMYftDn', 8655200),
(41, 'Patricia Marquardt', 'Casper26@hotmail.com', 'zVnEfMlnylFvPJF', 1207640),
(42, 'Kristy Monahan', 'Manley.Bergstrom81@hotmail.com', '9K2f93emXP5ZoqK', 9828510),
(43, 'Terrance Hirthe', 'Lily54@hotmail.com', 'jmITgdmnvb0XzFl', 8049060),
(44, 'Jeffery Kautzer DVM', 'Vicente15@yahoo.com', 'ZMmQgxXT1cy32wj', 5298640),
(45, 'Michelle Halvorson', 'Americo.Lindgren@yahoo.com', 's3V0j3h2Rb2VVSL', 3070530),
(46, 'Miss Brian Bins', 'Vivianne85@hotmail.com', 'IHNswbwwTbh0CEq', 6373010),
(47, 'Ricardo Schroeder', 'Colby50@hotmail.com', 'bWdqj3MupCIVUk5', 2082570),
(48, 'Scott Hills', 'Dorris.Green32@gmail.com', 'nQNO0iuXg_neRjy', 5265960),
(49, 'Bernard Bayer', 'Elias.Heller74@yahoo.com', '1wewzt54IT8GlK6', 3168540),
(50, 'Jasmine Osinski', 'Morgan19@gmail.com', 'uBSHWPtjbsNai42', 8057050),
(51, 'Kristy Powlowski', 'Adam24@yahoo.com', 'Wyo3bLVNEO20Mse', 4445980),
(52, 'Julie Treutel', 'Daniella69@gmail.com', 'PPvf1fnSzvYOUii', 7534280),
(53, 'Lee Johnston', 'Simone_Champlin@gmail.com', 'PIBIwKdynI5rS3T', 4458280),
(54, 'Leo Mohr DDS', 'Cordelia44@gmail.com', 'OQgRvVgZsrNryhI', 8826000),
(55, 'Joy Vandervort', 'Maximillia49@hotmail.com', 's5LB_ZpE6pWDoHH', 3049070),
(56, 'Leona Ebert', 'Velma42@yahoo.com', '9405x39fgbdYh2v', 2819270),
(57, 'Jeff Cummings', 'Jayden_Bernier@hotmail.com', 'bXEmwP5cHWyWrgg', 3462530),
(58, 'Mr. Charlene Von', 'Cyrus_Mohr@hotmail.com', 'MMlUaBzxCXbv9NY', 6702740),
(59, 'Mr. Brent Kling', 'Edyth.Schinner32@yahoo.com', 'iw299HEOfNimEk0', 6310930),
(60, 'Mrs. Christine Raynor', 'Aliya_Lang@gmail.com', 'WNpzs7PW1n8sv5w', 5012380),
(61, 'Donna Kirlin', 'Reagan9@hotmail.com', 'zm5DwvxidFUHsgN', 1346720),
(62, 'Helen VonRueden', 'Berry.Kovacek@yahoo.com', 'KJUCOq4MmhJbROm', 9608170),
(63, 'Dan Borer', 'Garret.Bednar@hotmail.com', '9kfVwZO_5Ibp5Te', 1947990),
(64, 'Ramona Reichert', 'Kylee_Littel26@gmail.com', 'FbhpqhpeIy5Lqej', 8182090),
(65, 'Tabitha Bergnaum', 'Loyal94@hotmail.com', 'qD8sYBTbiIPhp1G', 5688590),
(66, 'Ms. Leslie Smith', 'Carmel96@hotmail.com', 'tFJ4h_ROcBPYm1t', 1326970),
(67, 'Susan Torphy', 'Carmine.Torphy@yahoo.com', 'xxPOMe3hEq8JzwL', 4614780),
(68, 'Bobby Schuster IV', 'Marisol_Gleichner@yahoo.com', 'evcirkWnniuGDM3', 9469960),
(69, 'Kelly Quitzon', 'Tabitha_Dickinson@hotmail.com', 'fbGsw6uw1FefcRw', 4453420),
(70, 'Jermaine Schmidt', 'Eleanora_Erdman97@hotmail.com', 'MKPdsdHFIxlY2WG', 9759000),
(71, 'Traci Von', 'Samir17@hotmail.com', '8mrrqrLRC18d7XC', 6739740),
(72, 'Jo Yost', 'Joe49@gmail.com', 'CBeLZ2NYBwd8VX2', 5698490),
(73, 'Dr. Jose Reichel', 'Melyna.Aufderhar@yahoo.com', 'g_8khcPoPKelQyu', 7763580),
(74, 'Kristy Fadel', 'Emory.Russel79@hotmail.com', 'nQhtAYqnblnsNgY', 2450940),
(75, 'Javier O\'Connell', 'Vernie.Considine@gmail.com', '9WyL8m0WSue6gGp', 8593730),
(76, 'Angelina Funk', 'Mina58@gmail.com', 'I4KKg4qXK9qFNBS', 5340470),
(77, 'Violet Erdman', 'Marlon98@yahoo.com', 'M2kS1IaKy4d2_UX', 8280360),
(78, 'Sherry McClure', 'Tomas.Lehner98@gmail.com', 'R2rZBqeWlDzRMMn', 2462120),
(79, 'Bill Kautzer', 'George.Feil@hotmail.com', 'KGwgv3gYlbSuu0k', 1053160),
(80, 'Michele Quitzon', 'Vicky_Corwin@gmail.com', '3evEktpQsG1d8sv', 5937400),
(81, 'Dr. Wilbur Barrows', 'Delta.Jones17@hotmail.com', 'tFIcgpkyErzh0wL', 3094320),
(82, 'Connie Hand', 'Ora_Schroeder@yahoo.com', 'wBLtHT1SXCdNQwz', 8651550),
(83, 'Mabel Tremblay', 'Danny53@hotmail.com', 'WRfBBrgU3pscWPv', 8097180),
(84, 'Arthur Ernser', 'Sienna_Hamill@gmail.com', 'tcsAehUuccdW0po', 8537670),
(85, 'Leslie Cassin', 'Audra.Rohan@yahoo.com', 'Ua9sWXtAWaux2uj', 6187750),
(86, 'Charles Mills', 'Ronaldo.Zulauf@hotmail.com', 'fBeHOJCS8vKmIcS', 3540120),
(87, 'Domingo Kunze', 'Demario.Christiansen75@yahoo.c', 'OKNGLEtVhcEH9pY', 6482130),
(88, 'Dr. Mitchell Casper', 'Lyda78@yahoo.com', 'Jhrm0i4oVlzWmb8', 7250980),
(89, 'Evelyn Crona', 'Mitchell91@yahoo.com', 'OfwcSnKtMH35gF0', 3030120),
(90, 'Miss Ian Johnston', 'Audreanne21@hotmail.com', '9swHsBPCkxdWAbV', 1524260),
(91, 'Kellie Parisian', 'Mac66@yahoo.com', 'pOmMpnwjoeKtLZq', 6275910),
(92, 'Meghan Schoen', 'Leanne_Hayes9@hotmail.com', 'B8oagJrIkTr6UHk', 1196120),
(93, 'Dr. Violet Hartmann', 'Gust_Erdman@hotmail.com', 'fLUymm8BckDGi2k', 4185830),
(94, 'Bonnie Feil', 'Adam_Gorczany69@gmail.com', 'hVETJs5wnT7UOs9', 7703730),
(95, 'Cathy Hand', 'Briana_Feil75@gmail.com', 'SXdVv3PALYAjImb', 6417800),
(96, 'Rodney Gibson', 'Harvey21@gmail.com', 'hG85a2RedBc9tin', 6000520),
(97, 'Jo Daniel', 'Peggie0@yahoo.com', '_x2bvivNswmgFlp', 9799320),
(98, 'Jonathon Grant', 'Katherine35@yahoo.com', 'rufQEuo3Me4I5k4', 9073340),
(99, 'Ms. Tomas Keeling', 'Chasity45@gmail.com', 'B0WNlwxx7SG6Zk5', 4836090),
(100, 'Mr. Harvey Zemlak', 'Thomas_Schaefer@gmail.com', 'pUUzQVA9qAuZHKL', 9719790);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
