-- Crear la base de datos y conectarse
CREATE DATABASE universe;
\c universe

-- Tabla galaxy (6 filas)
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT FALSE,
    age_in_millions_of_years NUMERIC(10,2),
    type VARCHAR(50) CHECK (type IN ('spiral', 'elliptical', 'irregular', 'lenticular')),
    distance_from_earth_ly NUMERIC(15,2)
);

-- Tabla star (6 filas)
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    galaxy_id INTEGER NOT NULL REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT FALSE,
    is_spherical BOOLEAN DEFAULT TRUE,
    age_in_millions_of_years NUMERIC(10,2),
    spectral_type VARCHAR(10) CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
    distance_from_earth_ly NUMERIC(15,2)
);

-- Tabla planet (12 filas)
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    star_id INTEGER NOT NULL REFERENCES star(star_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT FALSE,
    is_spherical BOOLEAN DEFAULT TRUE,
    age_in_millions_of_years NUMERIC(10,2),
    type VARCHAR(50) CHECK (type IN ('terrestrial', 'gas_giant', 'ice_giant', 'dwarf')),
    distance_from_earth_ly NUMERIC(15,2)
);

-- Tabla moon (20 filas)
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    planet_id INTEGER NOT NULL REFERENCES planet(planet_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT FALSE,
    is_spherical BOOLEAN DEFAULT TRUE,
    diameter_in_km NUMERIC(10,2),
    distance_from_earth_ly NUMERIC(15,2)
);

-- Tabla adicional: asteroid (3 filas)
CREATE TABLE asteroid (
    asteroid_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    diameter_in_km NUMERIC(10,2),
    type VARCHAR(50) CHECK (type IN ('C-type', 'S-type', 'M-type')),
    distance_from_earth_ly NUMERIC(15,2)
);

-- Insertar datos en galaxy (6 filas)
INSERT INTO galaxy (name, description, has_life, age_in_millions_of_years, type, distance_from_earth_ly) VALUES
('Vía Láctea', 'Nuestra galaxia espiral', TRUE, 13600, 'spiral', 0),
('Andrómeda', 'Galaxia espiral más cercana', FALSE, 10000, 'spiral', 2537000),
('Triángulo', 'Miembro del Grupo Local', FALSE, 3000, 'spiral', 3000000),
('Messier 87', 'Galaxia elíptica gigante', FALSE, 13200, 'elliptical', 53000000),
('Centaurus A', 'Galaxia con banda de polvo', FALSE, 12000, 'lenticular', 13000000),
('NGC 1300', 'Galaxia espiral barrada', FALSE, 8800, 'spiral', 61000000);

-- Insertar datos en star (6 filas)
INSERT INTO star (galaxy_id, name, description, has_life, age_in_millions_of_years, spectral_type, distance_from_earth_ly) VALUES
(1, 'Sol', 'Nuestra estrella', TRUE, 4600, 'G', 0),
(1, 'Sirio', 'Estrella más brillante del cielo', FALSE, 230, 'A', 8.6),
(1, 'Proxima Centauri', 'Estrella más cercana', FALSE, 4800, 'M', 4.24),
(2, 'Alpheratz', 'Estrella en Andrómeda', FALSE, 70, 'B', 97),
(1, 'Betelgeuse', 'Supergigante roja', FALSE, 8, 'M', 640),
(1, 'Vega', 'Estrella en Lira', FALSE, 455, 'A', 25);

-- Insertar datos en planet (12 filas)
INSERT INTO planet (star_id, name, description, has_life, type, distance_from_earth_ly) VALUES
(1, 'Tierra', 'Planeta azul con vida', TRUE, 'terrestrial', 0),
(1, 'Marte', 'Planeta rojo', FALSE, 'terrestrial', 0),
(1, 'Júpiter', 'Gigante gaseoso', FALSE, 'gas_giant', 0),
(1, 'Saturno', 'Planeta con anillos', FALSE, 'gas_giant', 0),
(1, 'Venus', 'Planeta infernal', FALSE, 'terrestrial', 0),
(1, 'Urano', 'Gigante de hielo', FALSE, 'ice_giant', 0),
(1, 'Neptuno', 'Planeta azul profundo', FALSE, 'ice_giant', 0),
(3, 'Próxima b', 'Exoplaneta en zona habitable', TRUE, 'terrestrial', 4.24),
(2, 'Sirio b', 'Enana blanca', FALSE, 'dwarf', 8.6),
(4, 'Andrómeda b', 'Exoplaneta gigante', FALSE, 'gas_giant', 2537000),
(6, 'Vega b', 'Planeta hipotético', FALSE, 'terrestrial', 25),
(5, 'Betelgeuse c', 'Planeta de supergigante', FALSE, 'gas_giant', 640);

-- Insertar datos en moon (20 filas)
INSERT INTO moon (planet_id, name, description, is_spherical, diameter_in_km, distance_from_earth_ly) VALUES
(1, 'Luna', 'Nuestro satélite natural', TRUE, 3474, 0),
(3, 'Ío', 'Luna volcánica de Júpiter', TRUE, 3643, 0),
(3, 'Europa', 'Con océano subterráneo', TRUE, 3121, 0),
(3, 'Ganímedes', 'Luna más grande del sistema solar', TRUE, 5268, 0),
(3, 'Calisto', 'Superficie muy craterizada', TRUE, 4820, 0),
(4, 'Mimas', 'Parece la Estrella de la Muerte', TRUE, 396, 0),
(4, 'Encélado', 'Con géiseres de agua', TRUE, 504, 0),
(4, 'Tetis', 'Con gran valle de Ithaca Chasma', TRUE, 1062, 0),
(4, 'Dione', 'Tiene tenue atmósfera de oxígeno', TRUE, 1122, 0),
(4, 'Rea', 'Segunda luna más grande de Saturno', TRUE, 1527, 0),
(4, 'Titán', 'Con atmósfera densa y lagos', TRUE, 5149, 0),
(4, 'Jápeto', 'Con dos caras distintas', TRUE, 1468, 0),
(6, 'Miranda', 'Con terreno caótico', TRUE, 471, 0),
(6, 'Ariel', 'Luna más brillante de Urano', TRUE, 1157, 0),
(6, 'Umbriel', 'Luna oscura de Urano', TRUE, 1169, 0),
(6, 'Titania', 'Luna más grande de Urano', TRUE, 1576, 0),
(6, 'Oberón', 'Con antiguos cráteres', TRUE, 1522, 0),
(7, 'Tritón', 'Con géiseres de nitrógeno', TRUE, 2706, 0),
(7, 'Nereida', 'Órbita muy excéntrica', TRUE, 340, 0),
(8, 'Próxima b-I', 'Luna hipotética', TRUE, 1500, 4.24);

-- Insertar datos en asteroid (3 filas)
INSERT INTO asteroid (name, description, diameter_in_km, type, distance_from_earth_ly) VALUES
('Ceres', 'Planeta enano en el cinturón de asteroides', 939, 'C-type', 0),
('Vesta', 'Segundo asteroide más masivo', 525, 'V-type', 0),
('Psyche', 'Asteroide metálico rico en metales', 226, 'M-type', 0);

-- Verificar conteo de filas
SELECT 'galaxy' AS table, COUNT(*) AS rows FROM galaxy UNION ALL
SELECT 'star', COUNT(*) FROM star UNION ALL
SELECT 'planet', COUNT(*) FROM planet UNION ALL
SELECT 'moon', COUNT(*) FROM moon UNION ALL
SELECT 'asteroid', COUNT(*) FROM asteroid;

