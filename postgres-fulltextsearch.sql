CREATE TEXT SEARCH DICTIONARY ispell_ru (template = ispell,dictfile = ru_ru,afffile = ru_ru,stopwords = russian);
CREATE TEXT SEARCH CONFIGURATION ru (COPY = russian);
ALTER TEXT SEARCH CONFIGURATION ru ALTER MAPPING FOR word, hword, hword_part WITH ispell_ru, russian_stem;
SET default_text_search_config = 'ru';

