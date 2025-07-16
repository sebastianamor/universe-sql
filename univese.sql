-- Crear la base de datos y conectarse
-- Crear la base de datos
CREATE DATABASE universe;
\c universe

-- Crear tabla: galaxy
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  age_in_millions_of_years INT NOT NULL,
  has_life BOOLEAN NOT NULL,
  galaxy_types TEXT NOT NULL
);

-- Crear tabla: star
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  age_in_millions_of_years INT NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL
);

-- Crear tabla: planet
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  has_life BOOLEAN NOT NULL,
  distance_from_earth NUMERIC NOT NULL,
  planet_types TEXT NOT NULL,
  star_id INT REFERENCES star(star_id) NOT NULL
);

-- Crear tabla: moon
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  is_spherical BOOLEAN NOT NULL,
  planet_id INT REFERENCES planet(planet_id) NOT NULL
);

-- Crear tabla adicional: observation
CREATE TABLE observation (
  observation_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT NOT NULL,
  discovered_in_year INT NOT NULL,
  verified BOOLEAN NOT NULL
);

-- Insertar datos en galaxy (6 filas)
INSERT INTO galaxy (name, description, age_in_millions_of_years, has_life, galaxy_types) VALUES
('Milky Way', 'Our home galaxy', 13600, TRUE, 'Spiral'),
('Andromeda', 'Nearest major galaxy', 10000, FALSE, 'Spiral'),
('Sombrero', 'Bright core and large bulge', 9000, FALSE, 'Elliptical'),
('Whirlpool', 'Face-on spiral', 8000, FALSE, 'Spiral'),
('Triangulum', 'Third-largest in Local Group', 9200, FALSE, 'Spiral'),
('Messier 87', 'Supermassive black hole', 12000, FALSE, 'Elliptical');

-- Insertar datos en star (6 filas)
INSERT INTO star (name, description, age_in_millions_of_years, is_spherical, galaxy_id) VALUES
('Sun', 'Central star of the Solar System', 4600, TRUE, 1),
('Alpha Centauri', 'Closest star system', 6000, TRUE, 1),
('Betelgeuse', 'Red supergiant', 8000, TRUE, 1),
('Sirius', 'Brightest star in the night sky', 200, TRUE, 1),
('Rigel', 'Blue supergiant', 10000, TRUE, 1),
('Vega', 'Bright star in Lyra', 455, TRUE, 1);

-- Insertar datos en planet (12 filas)
INSERT INTO planet (name, has_life, distance_from_earth, planet_types, star_id) VALUES
('Earth', TRUE, 0, 'Terrestrial', 1),
('Mars', FALSE, 0.0005, 'Terrestrial', 1),
('Venus', FALSE, 0.0003, 'Terrestrial', 1),
('Jupiter', FALSE, 0.0008, 'Gas Giant', 1),
('Saturn', FALSE, 0.0012, 'Gas Giant', 1),
('Proxima b', TRUE, 4.24, 'Terrestrial', 2),
('Alpha b', FALSE, 4.37, 'Rocky', 2),
('Gliese 581g', TRUE, 20.3, 'Super Earth', 2),
('Kepler-22b', FALSE, 600, 'Neptune-like', 3),
('HD 209458 b', FALSE, 150, 'Hot Jupiter', 4),
('TrES-2b', FALSE, 750, 'Gas Giant', 5),
('Vega b', FALSE, 25, 'Ice Giant', 6);

-- Insertar datos en moon (20 filas)
INSERT INTO moon (name, description, is_spherical, planet_id) VALUES
('Moon', 'Earth''s moon', TRUE, 1),
('Phobos', 'Moon of Mars', FALSE, 2),
('Deimos', 'Smaller moon of Mars', FALSE, 2),
('Io', 'Volcanically active', TRUE, 4),
('Europa', 'Icy surface', TRUE, 4),
('Ganymede', 'Largest moon in Solar System', TRUE, 4),
('Callisto', 'Heavily cratered', TRUE, 4),
('Titan', 'Thick atmosphere', TRUE, 5),
('Enceladus', 'Ice geysers', TRUE, 5),
('Mimas', 'Cratered surface', TRUE, 5),
('Triton', 'Retrograde orbit', TRUE, 6),
('Charon', 'Pluto''s largest moon', TRUE, 3),
('LunaX', 'Fictional moon', FALSE, 7),
('Xeno', 'Sci-fi moon', FALSE, 8),
('Hades', 'Dark surface', FALSE, 9),
('Zara', 'Strange magnetic field', TRUE, 10),
('Orcus', 'Ice-covered', TRUE, 11),
('Borealis', 'Moon of Vega b', FALSE, 12),
('Galatea', 'Small and irregular', FALSE, 12),
('Thalassa', 'Inner moon of Neptune', TRUE, 12);

-- Insertar datos en observation (3 filas)
INSERT INTO observation (name, description, discovered_in_year, verified) VALUES
('Hubble Deep Field', 'Deepest visible-light image of the universe', 1995, TRUE),
('TRAPPIST-1 discovery', 'Exoplanet system with 7 Earth-sized planets', 2017, TRUE),
('Dark Galaxy ZXX', 'A galaxy with almost no stars', 2020, FALSE);
