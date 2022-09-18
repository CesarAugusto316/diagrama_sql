-- New script in postgres.
-- Date: Sep 17, 2022
-- Time: 2:44:45 PM

CREATE TABLE public.user(
  id bigserial PRIMARY KEY,
  name varchar(50) UNIQUE NOT NULL ,
  email varchar(40) UNIQUE NOT NULL ,
  password varchar(20) NOT NULL
);


-- (One to many) a user can have many channels
CREATE TABLE public.channel(
  id bigserial PRIMARY KEY,
  name varchar(50) UNIQUE,
  user_id bigint REFERENCES public.user(id),
  created_at timestamp WITH time ZONE
);


-- (One to many) a channel can have many videos
CREATE TABLE public.video(
  id bigserial PRIMARY KEY,
  name varchar(70) UNIQUE, 
  url varchar(100),
  uploaded_at timestamp WITH time ZONE,
  channel_id bigint REFERENCES public.channel(id)
);


-- A comment belong to only one user, No two users have the same comment
CREATE TABLE public.comment(
  description varchar(200), 
  created_at timestamp WITH time ZONE,
  video_id bigint REFERENCES public.video(id),
  user_id bigint REFERENCES public.user(id)
);

-- A comment belong to only one user, No two users have the same comment
CREATE TABLE public.like(
  created_at timestamp WITH time ZONE,
  video_id bigint REFERENCES public.video(id),
  user_id bigint REFERENCES public.user(id)
);

-- A comment belong to only one user, No two users have the same comment
CREATE TABLE public.subscription(
  id bigserial PRIMARY KEY,
  created_at timestamp WITH time ZONE,
  channel_id bigint REFERENCES public.channel(id),
  user_id bigint REFERENCES public.user(id)
);

CREATE TABLE public.playlist (
  name varchar(50) unique NOT NULL,
  created_at timestamp WITH time ZONE,
  video_id bigint REFERENCES public.video(id),
  position int NOT null,
  user_id bigint REFERENCES public.user(id)
);


INSERT INTO public.user(name, email, password) 
  values 
    ('Elyn', 'esaltwell0@icio.us', 'pmHkJi'),
    ('Fernande', 'fhowson2@microsoft.com', 'IO3V0BS0YY18'),
    ('Candide', 'cbate1@bloomberg.com', '69sC97P'),
    ('Alida', 'adrinkall3@blogspot.com', 'lnBeTJFz'),
    ('Jermaine', 'jhum4@istockphoto.com', 'mW13vvKKz5ex'),
    ('Amerigo', 'akachel5@cisco.com', 'wyxwqkVAbjHB'),
    ('Regina', 'rrameaux6@netscape.com', 'F9UGag'),
    ('Euell', 'ecalcut7@sourceforge.net', '2Z6wdjteAh1r');

-- Only we can insert unique values
INSERT INTO public.user(name, email, password) VALUES ('Orin', 'oguyers8@dmoz.org', 'XX7NiF5aQZ');

-- A same user can have many channels (one-to-many)
INSERT INTO public.channel(name, user_id, created_at) 
  VALUES 
    ('larnu', 1, current_timestamp),
    ('larnu-dev', 1, current_timestamp),
    ('larnu-prod', 1, current_timestamp),
    ('dross-rotzank', 2, current_timestamp),
    ('xenoverse', 3, current_timestamp),
    ('final fantasy', 3, current_timestamp),
    ('blog dross', 2, current_timestamp);

-- A same channel can have many videos
INSERT INTO public.video(name, url, channel_id, uploaded_at)
  VALUES
    ('Huel-Cruickshank', 'http://tiny.cc/mauris/morbi/non/lectus/aliquam.xml', 1, current_timestamp),
    ('Gerhold LLC', 'http://shinystat.com/nisl/ut/volutpat/sapien.js', 1, current_timestamp),
    ('Torp Group', 'https://com.com/morbi/quis/tortor/id/nulla/ultrices/aliquet.png', 2, current_timestamp),
    ('Dibbert, Becker and Ritchie', 'https://ox.ac.uk/arcu/sed/augue/aliquam/erat.html', 2, current_timestamp),
    ('Kulas-Zieme', 'http://sogou.com/cubilia/curae.js', 3, current_timestamp),
    ('Another Kulas-Zieme', 'http://sogou.com/cubilia/curae.js', 3, current_timestamp),
    ('Lockman Group', 'http://marketwatch.com/dui/nec/nisi/volutpat/eleifend/donec/ut.png', 3, current_timestamp);
