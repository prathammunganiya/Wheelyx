-- =====================================================================
-- Wheelyx Vehicle Rental and Fleet Management Platform
-- Seed Data: seed.sql
-- 20 Indian Cities, 200 Real Places, 6 Vehicle Categories, 36 Real Vehicles
-- Zero fake reviews, zero personal/student names
-- =====================================================================

USE wheelyx_vehicle_rental;

-- 1. Insert Roles
INSERT INTO roles (id, role_name, description) VALUES
(1, 'CUSTOMER', 'End-user renting vehicles for personal or business mobility'),
(2, 'OWNER', 'Vehicle owner listing fleet vehicles and managing requests'),
(3, 'ADMIN', 'System administrator governing platform operations')
ON DUPLICATE KEY UPDATE description=VALUES(description);

-- 2. Insert Seed Users
-- Passwords:
-- admin@wheelyx.com -> Admin@123
-- owner@wheelyx.com -> Owner@123
-- owner2@wheelyx.com -> Owner@123
-- customer@wheelyx.com -> Customer@123
INSERT INTO users (id, name, email, phone, password_hash, role, status) VALUES
(1, 'System Administrator', 'admin@wheelyx.com', '+919876543210', '$2a$12$lzxy4oiZeMuYxfX0.YokT.lNCmHOYwml..e5QwwIjMC8K3ZDZ.WI2', 'ADMIN', 'ACTIVE'),
(2, 'Elite Fleet Mobility', 'owner@wheelyx.com', '+919876543211', '$2a$12$tSn8VQUDF5jHe38JWeN4g.SShnVKmI3RO42mW6ulA5nVyWJ/eiFVq', 'OWNER', 'ACTIVE'),
(3, 'Apex Urban Rides', 'owner2@wheelyx.com', '+919876543212', '$2a$12$tSn8VQUDF5jHe38JWeN4g.SShnVKmI3RO42mW6ulA5nVyWJ/eiFVq', 'OWNER', 'ACTIVE'),
(4, 'Rahul Verma', 'customer@wheelyx.com', '+919876543213', '$2a$12$YYMqzE.p.gJfur.EoqiV2.0r2.xxmM4n0R2EnOr6vRMEFMBURY1nW', 'CUSTOMER', 'ACTIVE')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 3. Insert Vehicle Owners
INSERT INTO vehicle_owners (id, user_id, business_name, pan_number, bank_account, ifsc_code, is_verified) VALUES
(1, 2, 'Elite Fleet Mobility Solutions', 'AAACE1234F', '98765432101234', 'HDFC0001234', TRUE),
(2, 3, 'Apex Urban Rides Private Limited', 'BBBCF5678K', '98765432105678', 'ICIC0005678', TRUE)
ON DUPLICATE KEY UPDATE business_name=VALUES(business_name);

-- 4. Insert 6 Vehicle Categories
INSERT INTO vehicle_categories (id, category_code, category_name, description, icon_class) VALUES
(1, 'CARS', 'Cars', 'Reliable hatchbacks and comfortable sedans for daily commute and highway journeys', 'bi-car-front'),
(2, 'BIKES', 'Bikes', 'Agile commuter motorcycles and high-torque cruisers for enthusiastic riders', 'bi-bicycle'),
(3, 'PETROL_SCOOTERS', 'Petrol Scooters', 'Practical, fuel-efficient automatic gearless scooters for effortless city rides', 'bi-speedometer2'),
(4, 'EV_SCOOTERS', 'EV Scooters', 'Eco-friendly smart electric scooters featuring connected telemetry and swift pickup', 'bi-lightning-charge'),
(5, 'EV_CARS', 'EV Cars', 'State-of-the-art zero emission electric cars equipped with fast charging and modern cockpits', 'bi-battery-charging'),
(6, 'PREMIUM_VEHICLES', 'Premium Vehicles', 'Executive luxury sedans and premium SUVs engineered for unmatched prestige and comfort', 'bi-gem')
ON DUPLICATE KEY UPDATE category_name=VALUES(category_name);

-- 5. Insert 20 Real Major Indian Cities
INSERT INTO cities (id, city_name, state_name, is_active) VALUES
(1, 'Delhi', 'Delhi', TRUE),
(2, 'Mumbai', 'Maharashtra', TRUE),
(3, 'Bengaluru', 'Karnataka', TRUE),
(4, 'Hyderabad', 'Telangana', TRUE),
(5, 'Chennai', 'Tamil Nadu', TRUE),
(6, 'Kolkata', 'West Bengal', TRUE),
(7, 'Pune', 'Maharashtra', TRUE),
(8, 'Ahmedabad', 'Gujarat', TRUE),
(9, 'Jaipur', 'Rajasthan', TRUE),
(10, 'Lucknow', 'Uttar Pradesh', TRUE),
(11, 'Chandigarh', 'Chandigarh', TRUE),
(12, 'Indore', 'Madhya Pradesh', TRUE),
(13, 'Bhopal', 'Madhya Pradesh', TRUE),
(14, 'Surat', 'Gujarat', TRUE),
(15, 'Nagpur', 'Maharashtra', TRUE),
(16, 'Patna', 'Bihar', TRUE),
(17, 'Varanasi', 'Uttar Pradesh', TRUE),
(18, 'Agra', 'Uttar Pradesh', TRUE),
(19, 'Amritsar', 'Punjab', TRUE),
(20, 'Udaipur', 'Rajasthan', TRUE)
ON DUPLICATE KEY UPDATE city_name=VALUES(city_name);

-- 6. Insert 8-10 Real-World Places per City (10 per city = 200 real places)
INSERT INTO city_places (id, city_id, place_name, landmark_details, is_active) VALUES
-- Delhi (City 1)
(1, 1, 'India Gate', 'Central Delhi, Rajpath', TRUE),
(2, 1, 'Red Fort', 'Netaji Subhash Marg, Chandni Chowk', TRUE),
(3, 1, 'Qutub Minar', 'Mehrauli, South Delhi', TRUE),
(4, 1, 'Lotus Temple', 'Kalkaji, New Delhi', TRUE),
(5, 1, 'Humayun\'s Tomb', 'Mathura Road, Nizamuddin East', TRUE),
(6, 1, 'Akshardham', 'Noida Link Road, Pandav Nagar', TRUE),
(7, 1, 'Connaught Place', 'Inner Circle, Central Delhi', TRUE),
(8, 1, 'Chandni Chowk', 'Old Delhi Metro Hub', TRUE),
(9, 1, 'Gurudwara Bangla Sahib', 'Ashoka Road, Connaught Place', TRUE),
(10, 1, 'Rashtrapati Bhavan', 'President\'s Estate, Raisina Hill', TRUE),

-- Mumbai (City 2)
(11, 2, 'Gateway of India', 'Apollo Bandar, Colaba', TRUE),
(12, 2, 'Marine Drive', 'Netaji Subhash Chandra Bose Road', TRUE),
(13, 2, 'Colaba Causeway', 'Shahid Bhagat Singh Road, Colaba', TRUE),
(14, 2, 'Chhatrapati Shivaji Maharaj Terminus', 'Fort, South Mumbai', TRUE),
(15, 2, 'Elephanta Caves', 'Gharapuri Island Ferry Point', TRUE),
(16, 2, 'Siddhivinayak Temple', 'SK Bole Marg, Prabhadevi', TRUE),
(17, 2, 'Juhu Beach', 'Juhu Tara Road, Vile Parle West', TRUE),
(18, 2, 'Bandra-Worli Sea Link', 'Bandra West Toll Plaza', TRUE),
(19, 2, 'Haji Ali', 'Dargah Road, Haji Ali, Worli', TRUE),
(20, 2, 'Sanjay Gandhi National Park', 'Borivali East', TRUE),

-- Bengaluru (City 3)
(21, 3, 'Bangalore Palace', 'Vasanth Nagar', TRUE),
(22, 3, 'Lalbagh Botanical Garden', 'Mavalli, South Bengaluru', TRUE),
(23, 3, 'Cubbon Park', 'Kasturba Road, Sampangi Rama Nagara', TRUE),
(24, 3, 'Vidhana Soudha', 'Dr Ambedkar Veedhi, Sampangi Rama Nagara', TRUE),
(25, 3, 'ISKCON Temple', 'Hare Krishna Hill, Rajajinagar', TRUE),
(26, 3, 'UB City', 'Vittal Mallya Road, KG Halli', TRUE),
(27, 3, 'Bannerghatta National Park', 'Bannerghatta Main Road', TRUE),
(28, 3, 'Commercial Street', 'Tasker Town, Shivaji Nagar', TRUE),
(29, 3, 'Nandi Hills', 'Chikkaballapur Road', TRUE),
(30, 3, 'Wonderla', 'Mysore Road, Jadanahalli', TRUE),

-- Hyderabad (City 4)
(31, 4, 'Charminar', 'Char Kaman, Ghansi Bazaar', TRUE),
(32, 4, 'Golconda Fort', 'Ibrahim Bagh, Hyderabad', TRUE),
(33, 4, 'Hussain Sagar', 'Tank Bund Road', TRUE),
(34, 4, 'Salar Jung Museum', 'Salar Jung Road, Darulshifa', TRUE),
(35, 4, 'Chowmahalla Palace', 'Motigalli, Khilwat', TRUE),
(36, 4, 'Mecca Masjid', 'Near Charminar, Moghalpura', TRUE),
(37, 4, 'Necklace Road', 'Raj Bhavan Road Hub', TRUE),
(38, 4, 'Ramoji Film City', 'Anaspur Village, Hayathnagar', TRUE),
(39, 4, 'Birla Mandir', 'Hill Fort Road, Ambedkar Colony', TRUE),
(40, 4, 'Qutb Shahi Tombs', 'Ibrahim Bagh', TRUE),

-- Chennai (City 5)
(41, 5, 'Marina Beach', 'Kamarajar Salai, Triplicane', TRUE),
(42, 5, 'Kapaleeshwarar Temple', 'Vadakku Maada Veethi, Mylapore', TRUE),
(43, 5, 'Fort St. George', 'Rajaji Salai', TRUE),
(44, 5, 'Government Museum', 'Pantheon Road, Egmore', TRUE),
(45, 5, 'San Thome Basilica', 'Santhome High Road', TRUE),
(46, 5, 'Guindy National Park', 'Rangeguindy, Chennai', TRUE),
(47, 5, 'Valluvar Kottam', 'Tirumurthy Nagar, Nungambakkam', TRUE),
(48, 5, 'Elliot\'s Beach', 'Besant Nagar Promenade', TRUE),
(49, 5, 'Besant Nagar', 'Church Road Avenue', TRUE),
(50, 5, 'DakshinaChitra', 'East Coast Road, Muttukadu', TRUE),

-- Kolkata (City 6)
(51, 6, 'Victoria Memorial', 'Queens Way, Maidan', TRUE),
(52, 6, 'Howrah Bridge', 'Howrah Railway Approach', TRUE),
(53, 6, 'Indian Museum', 'Park Street Area, Chowringhee', TRUE),
(54, 6, 'St. Paul\'s Cathedral', 'Cathedral Road, Maidan', TRUE),
(55, 6, 'Park Street', 'Mother Teresa Sarani', TRUE),
(56, 6, 'Belur Math', 'Belur, Howrah', TRUE),
(57, 6, 'Dakshineswar Kali Temple', 'Mayadibasi, Dakshineswar', TRUE),
(58, 6, 'Marble Palace', 'Muktaram Babu Street, Jorasanko', TRUE),
(59, 6, 'Eco Park', 'Major Arterial Road, New Town', TRUE),
(60, 6, 'Science City', 'J.B.S Haldane Avenue, Mirania Gardens', TRUE),

-- Pune (City 7)
(61, 7, 'Shaniwar Wada', 'Shaniwar Peth', TRUE),
(62, 7, 'Aga Khan Palace', 'Pune-Nagar Road, Kalyani Nagar', TRUE),
(63, 7, 'Sinhagad Fort', 'Sinhagad Ghat Road, Thoptewadi', TRUE),
(64, 7, 'Pataleshwar Cave Temple', 'Jangali Maharaj Road, Shivajinagar', TRUE),
(65, 7, 'Dagdusheth Halwai Ganpati Temple', 'Budhwar Peth', TRUE),
(66, 7, 'Raja Dinkar Kelkar Museum', 'Kamal Kunj, Shukrawar Peth', TRUE),
(67, 7, 'Vetal Tekdi', 'Paud Road, Kothrud', TRUE),
(68, 7, 'Koregaon Park', 'North Main Road', TRUE),
(69, 7, 'Khadakwasla Dam', 'Khadakwasla Lake Road', TRUE),
(70, 7, 'Osho Garden', 'Goregaon Park Lane 1', TRUE),

-- Jaipur (City 9)
(71, 9, 'Amber Fort', 'Devisinghpura, Amer', TRUE),
(72, 9, 'Hawa Mahal', 'Hawa Mahal Rd, Badi Choupad', TRUE),
(73, 9, 'City Palace', 'Tulsi Marg, Gangori Bazaar', TRUE),
(74, 9, 'Jantar Mantar', 'Gangori Bazaar, J.D.A. Market', TRUE),
(75, 9, 'Jal Mahal', 'Amer Road, Jal Mahal', TRUE),
(76, 9, 'Nahargarh Fort', 'Krishna Nagar, Brahampuri', TRUE),
(77, 9, 'Jaigarh Fort', 'Devisinghpura, Amer', TRUE),
(78, 9, 'Albert Hall Museum', 'Ram Niwas Garden, Kailash Puri', TRUE),
(79, 9, 'Birla Mandir', 'Jawahar Lal Nehru Marg, Tilak Nagar', TRUE),
(80, 9, 'Chokhi Dhani', '12 Miles, Tonk Road, Goner Mod', TRUE),

-- Ahmedabad (City 8)
(81, 8, 'Sabarmati Ashram', 'Gandhi Smarak Sangrahalaya, Ashram Road', TRUE),
(82, 8, 'Kankaria Lake', 'Maninagar', TRUE),
(83, 8, 'Adalaj Stepwell', 'Adalaj, Gandhinagar Highway', TRUE),
(84, 8, 'Sidi Saiyyed Mosque', 'Bhadra, Ahmedabad', TRUE),
(85, 8, 'Science City', 'Science City Road, Sola', TRUE),
(86, 8, 'Sabarmati Riverfront', 'Riverfront West Promenade', TRUE),
(87, 8, 'Jhulta Minar', 'Opposite Sarangpur Water Tank', TRUE),
(88, 8, 'Auto World Vintage Car Museum', 'Dastan Estate, Kathwada', TRUE),
(89, 8, 'Law Garden', 'Netaji Road, Ellisbridge', TRUE),
(90, 8, 'Calico Museum of Textiles', 'The Retreat, Shahibag', TRUE),

-- Lucknow (City 10)
(91, 10, 'Bara Imambara', 'Machchhi Bhavan, Lucknow', TRUE),
(92, 10, 'Chota Imambara', 'Tahseen Ganj, Husainabad', TRUE),
(93, 10, 'Rumi Darwaza', 'Lajpat Nagar Colony, Machchhi Bhavan', TRUE),
(94, 10, 'British Residency', 'Mahatma Gandhi Marg, Deep Manak', TRUE),
(95, 10, 'Hazratganj', 'Main Commercial Area', TRUE),
(96, 10, 'Ambedkar Memorial Park', 'Vipul Khand, Gomti Nagar', TRUE),
(97, 10, 'Janeshwar Mishra Park', 'Gomti Nagar Extension', TRUE),
(98, 10, 'Dilkusha Kothi', 'Bibiapur, Cantonment Area', TRUE),
(99, 10, 'Husainabad Clock Tower', 'Husainabad, Lucknow', TRUE),
(100, 10, 'Gomti Riverfront', 'Vipin Khand, Gomti Nagar', TRUE),

-- Chandigarh (City 11)
(101, 11, 'Rock Garden', 'Sector 1, Chandigarh', TRUE),
(102, 11, 'Sukhna Lake', 'Sector 1 Promenade', TRUE),
(103, 11, 'Capitol Complex', 'Sector 1', TRUE),
(104, 11, 'Zakir Hussain Rose Garden', 'Jan Marg, 16B, Sector 16', TRUE),
(105, 11, 'Sector 17 Plaza', 'Sector 17 Commercial Hub', TRUE),
(106, 11, 'Government Museum and Art Gallery', 'Sector 10C', TRUE),
(107, 11, 'Japanese Garden', 'Sector 31A', TRUE),
(108, 11, 'Terraced Garden', 'Sector 33', TRUE),
(109, 11, 'Elante Mall', 'Industrial Area Phase I', TRUE),
(110, 11, 'Leisure Valley', 'Sector 10B', TRUE),

-- Indore (City 12)
(111, 12, 'Rajwada Palace', 'MG Road, Rajwada', TRUE),
(112, 12, 'Lal Bagh Palace', 'Nai Duniya, Revenue Colony', TRUE),
(113, 12, 'Sarafa Bazaar', 'Sarafa Night Food Street', TRUE),
(114, 12, 'Chappan Dukan', 'New Palasia', TRUE),
(115, 12, 'Kanch Mandir', 'Hukumchand Marg, Itwaria Bazaar', TRUE),
(116, 12, 'Annapurna Temple', 'Kranti Kriplani Nagar', TRUE),
(117, 12, 'Central Museum', 'Near GPO, Navlakha', TRUE),
(118, 12, 'Gandhi Hall', 'MG Road, Shastri Market', TRUE),
(119, 12, 'Khajrana Ganesh Temple', 'Khajrana Main Road', TRUE),
(120, 12, 'Regional Park', 'Pipliyapala Lake', TRUE),

-- Bhopal (City 13)
(121, 13, 'Upper Lake', 'Bada Talab, Shyamla Hills', TRUE),
(122, 13, 'Lower Lake', 'Chhota Talab, Jahangirabad', TRUE),
(123, 13, 'Van Vihar National Park', 'Lake View Road, Shyamla Hills', TRUE),
(124, 13, 'Taj-ul-Masajid', 'Kohefiza, Bhopal', TRUE),
(125, 13, 'State Museum', 'Shyamla Hills', TRUE),
(126, 13, 'Gauhar Mahal', 'VIP Road, Nakkar Khana, Peer Gate', TRUE),
(127, 13, 'Bharat Bhavan', 'J. Swaminathan Marg, Shamla Hills', TRUE),
(128, 13, 'Moti Masjid', 'Hawamahal Road, Peer Gate Area', TRUE),
(129, 13, 'Regional Science Centre', 'Banganga, Shyamla Hills', TRUE),
(130, 13, 'Tribal Museum', 'Shyamla Hills Road', TRUE),

-- Surat (City 14)
(131, 14, 'Dumas Beach', 'Dumas, Surat Coastal Area', TRUE),
(132, 14, 'Surat Castle', 'Rang Upvan, Nanpura', TRUE),
(133, 14, 'Dutch Garden', 'Nanpura, Surat', TRUE),
(134, 14, 'Sarthana Nature Park', 'Surat-Kamrej Highway, Sarthana Jakat Naka', TRUE),
(135, 14, 'Science Centre', 'City Light Town, Athwa', TRUE),
(136, 14, 'Gopi Talav', 'Rustampura, Surat', TRUE),
(137, 14, 'ISKCON Temple', 'Jahangirpura', TRUE),
(138, 14, 'Ambika Niketan Temple', 'Parle Point, Athwa', TRUE),
(139, 14, 'Tapi Riverfront', 'Swami Vivekananda Bridge Approach', TRUE),
(140, 14, 'VR Surat', 'Dumas Road, Magdalla', TRUE),

-- Nagpur (City 15)
(141, 15, 'Deekshabhoomi', 'South Ambazari Road, Abhyankar Nagar', TRUE),
(142, 15, 'Futala Lake', 'Futala Lake Promenade, Vayusena Nagar', TRUE),
(143, 15, 'Sitabuldi Fort', 'Sitabuldi, Nagpur', TRUE),
(144, 15, 'Maharajbagh Zoo', 'Amravati Road, Ramdaspeth', TRUE),
(145, 15, 'Raman Science Centre', 'Subhash Road, Gandhi Sagar Lake', TRUE),
(146, 15, 'Zero Mile Marker', 'Civil Lines, Wardha Road', TRUE),
(147, 15, 'Japanese Rose Garden', 'Civil Lines, Seminary Hills', TRUE),
(148, 15, 'Ambazari Lake', 'Ambazari, Nagpur', TRUE),
(149, 15, 'Seminary Hill', 'Seminary Hills Scenic Viewpoint', TRUE),
(150, 15, 'Gorewada Zoo', 'Katol Road, Gorewada', TRUE),

-- Patna (City 16)
(151, 16, 'Golghar', 'Ashok Rajpath, Near Gandhi Maidan', TRUE),
(152, 16, 'Patna Museum', 'Budh Marg, Lodipur', TRUE),
(153, 16, 'Bihar Museum', 'Jawaharlal Nehru Marg, Bailey Road', TRUE),
(154, 16, 'Gandhi Maidan', 'Fraser Road Area, Patna', TRUE),
(155, 16, 'Mahavir Mandir', 'Near Patna Junction Railway Station', TRUE),
(156, 16, 'Takht Sri Patna Sahib', 'Harmandir Gali, Patna City', TRUE),
(157, 16, 'Sanjay Gandhi Biological Park', 'Bailey Road, Rajbansi Nagar', TRUE),
(158, 16, 'Eco Park', 'Rajvanshi Nagar, Strand Road', TRUE),
(159, 16, 'Kumhrar', 'Kankarbagh Road, Kumhrar', TRUE),
(160, 16, 'Agam Kuan', 'Paharpur, Gulzarbagh', TRUE),

-- Varanasi (City 17)
(161, 17, 'Kashi Vishwanath Temple', 'Lahori Tola, Varanasi', TRUE),
(162, 17, 'Dashashwamedh Ghat', 'Dashashwamedh Ghat Road', TRUE),
(163, 17, 'Assi Ghat', 'Shivala, Varanasi', TRUE),
(164, 17, 'Manikarnika Ghat', 'Garwasi Tola, Varanasi', TRUE),
(165, 17, 'Banaras Hindu University', 'Lanka, Varanasi', TRUE),
(166, 17, 'Sankat Mochan Temple', 'Saket Nagar Colony, Durgakund', TRUE),
(167, 17, 'Bharat Mata Temple', 'Vidyapeeth Road, Cantt', TRUE),
(168, 17, 'Ganga Aarti', 'Dashashwamedh Evening Pavilion', TRUE),
(169, 17, 'Sarnath', 'Deer Park Archaeological Site', TRUE),
(170, 17, 'Ramnagar Fort', 'Ramnagar, Varanasi', TRUE),

-- Agra (City 18)
(171, 18, 'Taj Mahal', 'Dharmapuri, Forest Colony, Tajganj', TRUE),
(172, 18, 'Agra Fort', 'Agra Fort, Rakabganj', TRUE),
(173, 18, 'Mehtab Bagh', 'Nagla Devjit, Across Yamuna', TRUE),
(174, 18, 'Itmad-ud-Daulah\'s Tomb', 'Moti Bagh, Agra', TRUE),
(175, 18, 'Akbar\'s Tomb', 'Tomb of Akbar The Great Area, Sikandra', TRUE),
(176, 18, 'Jama Masjid', 'Subhash Bazaar, Kinari Bazaar', TRUE),
(177, 18, 'Moti Masjid', 'Inside Agra Fort Complex', TRUE),
(178, 18, 'Kinari Bazaar', 'Kinari Bazaar Traditional Market', TRUE),
(179, 18, 'Tomb of Mariam-uz-Zamani', 'Near Akbar Tomb, Sikandra', TRUE),
(180, 18, 'Agra Cantonment area', 'Mall Road, Agra Cantt', TRUE),

-- Amritsar (City 19)
(181, 19, 'Golden Temple', 'Golden Temple Road, Atta Mandi', TRUE),
(182, 19, 'Jallianwala Bagh', 'Golden Temple Way', TRUE),
(183, 19, 'Partition Museum', 'Town Hall, Katra Ahluwalia', TRUE),
(184, 19, 'Durgiana Temple', 'Hathi Gate, Goal Bagh', TRUE),
(185, 19, 'Gobindgarh Fort', 'Old Cantt Road, Vijay Chowk', TRUE),
(186, 19, 'Hall Bazaar', 'Hall Gate Commercial Hub', TRUE),
(187, 19, 'Heritage Street', 'Town Hall to Golden Temple Corridor', TRUE),
(188, 19, 'Maharaja Ranjit Singh Museum', 'Ram Bagh, Heritage Garden', TRUE),
(189, 19, 'Wagah Border', 'Attari-Wagah Border Checkpoint', TRUE),
(190, 19, 'Ram Bagh Palace', 'Mall Road, Amritsar', TRUE),

-- Udaipur (City 20)
(191, 20, 'City Palace', 'Old City, Udaipur', TRUE),
(192, 20, 'Lake Pichola', 'Rameshwar Ghat Waterfront', TRUE),
(193, 20, 'Jag Mandir', 'Pichola Island Complex', TRUE),
(194, 20, 'Jagdish Temple', 'RJ SH 50, Old City', TRUE),
(195, 20, 'Saheliyon-ki-Bari', 'Saheli Marg, New Fatehpura', TRUE),
(196, 20, 'Fateh Sagar Lake', 'Fateh Sagar Promenade', TRUE),
(197, 20, 'Sajjangarh Monsoon Palace', 'Monsoon Palace Hill, Kodiyat', TRUE),
(198, 20, 'Bagore Ki Haveli', 'Gangaur Ghat Marg, Old City', TRUE),
(199, 20, 'Gulab Bagh', 'Lake Palace Road, Brahmpuri', TRUE),
(200, 20, 'Vintage & Classic Car Museum', 'Gulab Bagh Road, Brahmpuri', TRUE)
ON DUPLICATE KEY UPDATE place_name=VALUES(place_name);

-- 7. Insert Exactly 36 Real Vehicles across the 6 Categories
-- Total: 36 vehicles (6 Cars, 6 Bikes, 6 Petrol Scooters, 6 EV Scooters, 6 EV Cars, 6 Premium Vehicles)
INSERT INTO vehicles (
    id, owner_id, category_id, city_id, place_id,
    brand, model_name, registration_no, fuel_type, transmission,
    seating_capacity, price_per_day, security_deposit, status,
    image_url, description, features, rental_terms, is_featured
) VALUES
-- CATEGORY 1: CARS (6 vehicles)
(1, 2, 1, 9, 72, 'Maruti', 'Maruti Swift', 'RJ14-SW-1001', 'Petrol', 'Manual', 5, 1400.00, 2000.00, 'AVAILABLE',
 'assets/images/vehicles/cars/swift.jpg',
 'Dynamic hatchback offering outstanding fuel economy, responsive handling, and comfortable seating for five travelers.',
 'Air Conditioning, Touchscreen Infotainment, Dual Airbags, ABS with EBD, Bluetooth Audio, Power Windows',
 'Valid Driving License required. Fuel policy: Same to Same. Max speed limit 100 km/h.', TRUE),

(2, 2, 1, 1, 1, 'Hyundai', 'Hyundai i20', 'DL01-IY-2002', 'Petrol', 'Manual', 5, 1600.00, 2000.00, 'AVAILABLE',
 'assets/images/vehicles/cars/hyundai_i20.jpg',
 'Premium hatchback equipped with sophisticated interior styling, digital cluster, and smooth city driving comfort.',
 '10.25-inch Touchscreen, Rear AC Vents, Wireless Charging, Steering Controls, Keyless Entry',
 'Security deposit refundable on return. Over-speeding penalty applicable above 100 km/h.', TRUE),

(3, 2, 1, 3, 23, 'Tata', 'Tata Altroz', 'KA03-TA-3003', 'Petrol', 'Manual', 5, 1500.00, 2000.00, 'AVAILABLE',
 'assets/images/vehicles/cars/tata_altroz.jpg',
 '5-star Global NCAP safety rated premium hatchback engineered with laser-welded ALFA architecture.',
 '5-Star Safety, Harman Audio System, 90-degree Door Opening, Cruise Control, Cooled Glovebox',
 'Valid original Driving License must be produced at pickup. Smoking strictly prohibited.', FALSE),

(4, 2, 1, 2, 12, 'Honda', 'Honda City', 'MH02-HC-4004', 'Petrol', 'Automatic', 5, 2400.00, 3000.00, 'AVAILABLE',
 'assets/images/vehicles/cars/honda_city.jpg',
 'The quintessential executive midsize sedan with legendary i-VTEC refinement and expansive rear legroom.',
 'Sunroof, CVT Automatic, Leatherette Seats, Honda LaneWatch, Apple CarPlay & Android Auto',
 'Toll taxes to be borne by renter. 300 km daily allowance included.', TRUE),

(5, 3, 1, 4, 33, 'Hyundai', 'Hyundai Creta', 'TS09-CR-5005', 'Diesel', 'Automatic', 5, 2900.00, 3500.00, 'AVAILABLE',
 'assets/images/vehicles/cars/Hyundai_Creta.avif',
 'Best-selling midsize SUV with dominating road presence, panoramic views, and punchy diesel efficiency.',
 'Panoramic Sunroof, Ventilated Front Seats, Drive Modes, Bose Premium Sound, Electronic Parking Brake',
 'Valid 4-wheeler license with minimum 1 year experience required.', TRUE),

(6, 3, 1, 7, 68, 'Kia', 'Kia Seltos', 'MH12-KS-6006', 'Petrol', 'Automatic', 5, 2800.00, 3500.00, 'AVAILABLE',
 'assets/images/vehicles/cars/kia_seltos.avif',
 'Tech-loaded aggressive crossover featuring connected car diagnostics and dynamic paddle shifters.',
 'Dual 10.25-inch Screens, Smart Pure Air Purifier, Head-up Display, 360 Camera, Ambient Lighting',
 'Deposit refunded within 24 hours post vehicle health check.', FALSE),

-- CATEGORY 2: BIKES (6 vehicles)
(7, 2, 2, 9, 78, 'Hero', 'Hero Splendor Plus', 'RJ14-SP-7007', 'Petrol', 'Manual', 2, 450.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/hero_splendor.jpg',
 'India\'s most dependable commuter motorcycle delivering extraordinary mileage and effortless maneuverability.',
 'i3S Technology, Tubeless Tyres, Comfortable Long Seat, Lightweight Handling, Kick & Electric Start',
 'Helmet compulsory for rider and pillion. Valid 2-wheeler license required.', TRUE),

(8, 2, 2, 11, 105, 'Bajaj', 'Bajaj Pulsar 150', 'CH01-BP-8008', 'Petrol', 'Manual', 2, 700.00, 1200.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/bajaj_pulsar.jpg',
 'Iconic sports commuter featuring muscular fuel tank styling, DTS-i engine roar, and twin disc braking.',
 '150cc DTS-i Engine, Front Disc Brake with ABS, Clip-on Handlebars, Backlit Switches, LED Tail Lamps',
 'Strict adherence to traffic laws required. Fuel provided: reserve to reserve.', TRUE),

(9, 3, 2, 5, 41, 'Yamaha', 'Yamaha FZ-FI', 'TN07-FZ-9009', 'Petrol', 'Manual', 2, 800.00, 1500.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/yamaha_fz.jpg',
 'Streetfighter motorcycle with wide radial rear tyre, agile chassis geometry, and refined fuel injection.',
 'Monocross Suspension, Single Channel ABS, Negative LCD Meter, Class D Bi-Functional Headlight',
 'Rider must wear helmet. Rash riding will result in immediate cancellation.', FALSE),

(10, 3, 2, 3, 28, 'Yamaha', 'Yamaha MT-15', 'KA04-MT-1010', 'Petrol', 'Manual', 2, 1100.00, 2000.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/Yamaha_MT.jpg',
 'The Dark Warrior featuring liquid-cooled 155cc VVA engine, inverted front forks, and assist & slipper clutch.',
 'Variable Valve Actuation (VVA), USD Telescopic Forks, Assist & Slipper Clutch, Traction Control, Dual Disc',
 'Minimum age 20 years. Security deposit mandatory before pickup.', TRUE),

(11, 3, 2, 8, 86, 'KTM', 'KTM Duke 250', 'GJ01-KD-1111', 'Petrol', 'Manual', 2, 1500.00, 2500.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/ktm_duke.avif',
 'High-octane naked sport machine with aggressive ergonomics, trellis frame, and WP APEX suspension.',
 '30 PS Power, Dual-channel Supermoto ABS, Slipper Clutch, WP Apex Suspension, LED DRLs',
 'Protective gear recommended. Track days and stunts strictly disallowed.', TRUE),

(12, 2, 2, 19, 181, 'Royal Enfield', 'Royal Enfield Classic 350', 'PB02-RE-1212', 'Petrol', 'Manual', 2, 1300.00, 2500.00, 'AVAILABLE',
 'assets/images/vehicles/bikes/royal_enfield_classic.avif',
 'Timeless heritage cruiser powered by the refined J-series counterbalanced engine with legendary thump.',
 'J-Series 349cc Engine, Dual Channel ABS, Tripper Navigation Assist, Retro Teardrop Tank, Cushioned Saddle',
 'Ideal for leisure touring. Intercity permits included.', TRUE),

-- CATEGORY 3: PETROL SCOOTERS (6 vehicles)
(13, 2, 3, 9, 73, 'Honda', 'Honda Activa 6G', 'RJ14-AC-1313', 'Petrol', 'Automatic', 2, 450.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/honda_activa_6g.jpg',
 'The benchmark family automatic scooter featuring ESP technology, silent start, and telescopic suspension.',
 'Enhanced Smart Power (eSP), Silent Start with ACG, External Fuel Lid, Telescopic Front Suspension',
 'Helmet provided upon request. City usage only.', TRUE),

(14, 2, 3, 10, 95, 'Honda', 'Honda Activa 125', 'UP32-AC-1414', 'Petrol', 'Automatic', 2, 550.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/honda_activa_125.jpg',
 'Enhanced 125cc power scooter with real-time mileage display, metal body strength, and front glovebox.',
 '125cc PGM-FI Engine, Digilog Meter, Idling Stop System, LED Headlamp, Side Stand Engine Inhibitor',
 'Valid scooter license required.', FALSE),

(15, 2, 3, 14, 136, 'Honda', 'Honda Dio', 'GJ05-HD-1515', 'Petrol', 'Automatic', 2, 500.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/honda_dio.jpg',
 'Youthful moto-scooter with sporty graphics, split grab rails, and edgy front apron dual LED headlamp.',
 'Fully Digital Meter, Sporty LED DRL & Headlight, External Fuel Cap, Combi-Brake System with Equalizer',
 'Return with same fuel level. Valid ID proof mandatory.', FALSE),

(16, 3, 3, 12, 114, 'TVS', 'TVS Jupiter 125', 'MP09-TJ-1616', 'Petrol', 'Automatic', 2, 550.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/TVS_jupiter_125.jpg',
 'Most spacious automatic scooter in class with massive 33L under-seat storage accommodating two full helmets.',
 'Front Fuel Fill, 33L Underseat Boot Space, Metal Body, Intelligo Stop-Start System, USB Phone Charger',
 'Clean return expected. Maximum weight limit 160 kg.', TRUE),

(17, 3, 3, 7, 61, 'TVS', 'TVS Ntorq 125', 'MH12-TN-1717', 'Petrol', 'Automatic', 2, 650.00, 1200.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/TVS_Ntorq_125.avif',
 'Performance scooter inspired by stealth fighter aircraft with Bluetooth SmartXonnect turn-by-turn navigation.',
 '3-Valve CVTi-REVV Engine, Bluetooth Navigation Cluster, R-Mode Race Telemetry, Stealth Cowling, Front Petal Disc',
 'No racing or stunts. Violation forfeits deposit.', TRUE),

(18, 3, 3, 2, 17, 'Yamaha', 'Yamaha Aerox 155', 'MH02-YA-1818', 'Petrol', 'Automatic', 2, 950.00, 1500.00, 'AVAILABLE',
 'assets/images/vehicles/petrol_scooters/Yamaha_Aerox 155.avif',
 'Maxi-sports scooter powered by Yamaha R15 derived liquid-cooled VVA engine with wide 14-inch wheels.',
 '155cc Liquid-Cooled VVA, 140mm Wide Rear Radial Tyre, External Fuel Fill, Front ABS, Yamaha Y-Connect',
 'For experienced riders. Long-distance riding allowed with prior notice.', TRUE),

-- CATEGORY 4: EV SCOOTERS (6 vehicles)
(19, 2, 4, 3, 26, 'Ola', 'Ola S1 Pro', 'KA05-OL-1919', 'Electric', 'Automatic', 2, 600.00, 1200.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/ola_s1_pro.jpg',
 'Flagship electric scooter boasting 120 km/h top speed, Hyper mode acceleration, and 7-inch touchscreen navigation.',
 'Hyper Mode, Touchscreen MoveOS, Built-in Speakers, Cruise Control, Proximity Keyless Unlock, 170 km True Range',
 'Portable home charger included. Return with minimum 20% state of charge.', TRUE),

(20, 2, 4, 3, 21, 'Ather', 'Ather 450X', 'KA01-AT-2020', 'Electric', 'Automatic', 2, 650.00, 1200.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/ather_450x.jpg',
 'Precision-engineered electric scooter with Warp mode, aluminum chassis, Google Maps onboard, and AutoHold.',
 'Warp Mode, Onboard Google Maps, AutoHold Hill Assist, Park Assist Reverse, IP67 Waterproof Battery',
 'Access to Ather Grid fast charging included where available.', TRUE),

(21, 2, 4, 1, 7, 'Ather', 'Ather Rizta', 'DL03-AR-2121', 'Electric', 'Automatic', 2, 600.00, 1200.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/ather_rizta.jpg',
 'Ultra-comfortable family electric scooter with largest-in-class bench seat and skid-control traction assist.',
 'DeepView Digital Dashboard, Ultra-Long Ergonomic Seat, SkidControl Traction, 34L Boot, Multi-purpose Hook',
 'Charger provided in boot. Valid driving license mandatory.', FALSE),

(22, 3, 4, 6, 55, 'TVS', 'TVS iQube', 'WB02-TI-2222', 'Electric', 'Automatic', 2, 550.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/tvs_iqube.jpg',
 'Smooth and refined urban electric scooter with quiet hub motor, Q-park assist, and crystal clear TFT cluster.',
 'SmartXonnect Telematics, Regenerative Braking, Q-Park Reverse Assist, USB Mobile Charging, Eco/Power Modes',
 'Return vehicle at designated hub with minimum 25% charge.', TRUE),

(23, 3, 4, 7, 65, 'Bajaj', 'Bajaj Chetak', 'MH14-BC-2323', 'Electric', 'Automatic', 2, 550.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/Bajaj_Chetak.avif',
 'All-metal timeless electric scooter paying homage to the Chetak heritage with modern connected tech.',
 'Solid Metal Unibody, Horseshoe LED DRL, Sequential Blinkers, Touch Controls, 115 km Certified Range',
 'Clean handling required. Helmet provided on request.', FALSE),

(24, 3, 4, 8, 81, 'Suzuki', 'Suzuki e-Access', 'GJ01-SA-2424', 'Electric', 'Automatic', 2, 550.00, 1000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/Suzuki _e-Access.avif',
 'Electric edition of India\'s beloved Access scooter offering instantaneous silent power delivery and high comfort.',
 'Silent Torque Drive, High Contrast Color Display, Underseat Luggage Lamp, Regenerative System',
 'City commute only. Minimum charge return 20%.', FALSE),

-- CATEGORY 5: EV CARS (6 vehicles)
(25, 2, 5, 1, 6, 'Tata', 'Tata Tiago EV', 'DL04-TE-2525', 'Electric', 'Automatic', 5, 1800.00, 2500.00, 'AVAILABLE',
 'assets/images/vehicles/ev_scooters/../ev_cars/tata_tiago_ev.jpg',
 'Zippy and affordable electric city hatchback with multi-mode regen and fast DC charging support.',
 'Ziptron High Voltage Tech, Multi-mode Regenerative Braking, Fully Automatic Climate Control, Harman 8 Speakers',
 'CCS2 Fast Charging compatible. Return with minimum 20% SoC.', TRUE),

(26, 2, 5, 3, 24, 'Tata', 'Tata Punch EV', 'KA05-PE-2626', 'Electric', 'Automatic', 5, 2200.00, 3000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_cars/tata_punch_ev.jpg',
 'Pure EV architecture micro-SUV with 190mm ground clearance, twin 10.25-inch cinematic displays, and frunk storage.',
 'Acti.ev Architecture, 360 Surround View Camera, Front Trunk (Frunk), Electronic Parking Brake with Auto-Hold',
 'Original DL required. Long distance charging route assistance provided.', TRUE),

(27, 2, 5, 2, 18, 'Tata', 'Tata Nexon EV', 'MH02-NE-2727', 'Electric', 'Automatic', 5, 2600.00, 3500.00, 'AVAILABLE',
 'assets/images/vehicles/ev_cars/nexon_ev.jpg',
 'India\'s top-selling electric SUV with bold digital design, Vehicle-to-Load capability, and 450 km range.',
 'Vehicle-to-Vehicle (V2V) & V2L Charging, JBL Cinematic Sound, Ventilated Leatherette Seats, Smart Digital Shifter',
 'DC Fast charging bills at public stations to be paid by renter.', TRUE),

(28, 3, 5, 4, 37, 'MG', 'MG Comet EV', 'TS07-MC-2828', 'Electric', 'Automatic', 4, 1500.00, 2000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_cars/mg_comet_ev.jpg',
 'Compact futuristic urban runabout that parks anywhere with twin 10.25-inch integrated floating widescreen.',
 'Ultra-compact Urban Footprint, Floating Dual Screens, Wireless Apple CarPlay/Android Auto, Smart Key Entry',
 'Perfect for congested city centers. AC slow charger provided in boot.', FALSE),

(29, 3, 5, 5, 48, 'MG', 'MG ZS EV', 'TN09-MZ-2929', 'Electric', 'Automatic', 5, 3200.00, 4000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_cars/MG_ZS_EV.jpg',
 'Full-size electric executive SUV with 50.3 kWh battery pack, panoramic Skyroof, and level-2 ADAS suite.',
 '50.3 kWh Prismatic Battery, Panoramic Skyroof, ADAS Level-2 Safety Suite, PM 2.5 Air Filter, i-SMART Connected',
 'Fast charger network access card supplied in vehicle glovebox.', TRUE),

(30, 3, 5, 9, 71, 'Hyundai', 'Hyundai Creta Electric', 'RJ14-CE-3030', 'Electric', 'Automatic', 5, 3400.00, 4000.00, 'AVAILABLE',
 'assets/images/vehicles/ev_cars/Hyundai_Creta_Electric.avif',
 'All-electric Creta with high-density battery module, aerodynamic active aero flaps, and silent cruising refinement.',
 'Active Air Flap Grille, Regenerative Paddle Shifters, Dual Curved Display, ADAS Suite, Ultra-Fast Charging',
 'Refundable deposit Rs 4000. Minimum 21 years age requirement.', TRUE),

-- CATEGORY 6: PREMIUM VEHICLES (6 vehicles)
(31, 2, 6, 2, 11, 'BMW', 'BMW 3 Series', 'MH01-BM-3131', 'Petrol', 'Automatic', 5, 5500.00, 10000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/BMW_3_Series.avif',
 'The definitive sports luxury sedan with 50:50 weight distribution, BMW Curved Display, and TwinPower Turbo.',
 'TwinPower Turbo Engine, BMW Curved Display with iDrive 8, Steptronic Sport Transmission, Ambient Cabin Light',
 'Minimum age 25 years. Valid credit verification and 2 IDs required. Speed capped at 120 km/h.', TRUE),

(32, 2, 6, 1, 10, 'Mercedes-Benz', 'Mercedes-Benz C-Class', 'DL01-MB-3232', 'Petrol', 'Automatic', 5, 6000.00, 10000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/Mercedes-Benz_C-Class.avif',
 'The Baby S-Class offering unrivaled opulence, 11.9-inch portrait touchscreen, and Burmester 3D Surround Sound.',
 'MBUX Portrait Touchscreen, Burmester 3D Audio, Panoramic Sliding Roof, Memory Package, Active Brake Assist',
 'Comprehensive insurance included with Rs 10000 deductible. Executive chauffeur option available.', TRUE),

(33, 3, 6, 3, 26, 'Audi', 'Audi A4', 'KA01-AU-3333', 'Petrol', 'Automatic', 5, 5200.00, 10000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/Audi _A4.jpg',
 'Progressive luxury sedan with Quattro styling cues, Audi Virtual Cockpit Plus, and piano black accents.',
 'Audi Virtual Cockpit Plus, Matrix LED Headlights, 3-Zone Deluxe Climate Control, MMI Navigation Plus with MMI Touch',
 'Rental agreement requires 2 verified ID cards and credit card hold.', TRUE),

(34, 3, 6, 4, 31, 'Volvo', 'Volvo S90', 'TS08-VS-3434', 'Petrol', 'Automatic', 5, 5800.00, 10000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/Volvo_S90.jpg',
 'Scandinavian luxury flagship sedan featuring Google built-in, Bowers & Wilkins sound, and unmatched safety.',
 'Bowers & Wilkins High Fidelity Audio, Advanced Air Purifier, Nappa Leather Upholstery, Blind Spot Info System',
 'Smoking or pets strictly prohibited. Deep cleaning charge applies otherwise.', FALSE),

(35, 2, 6, 2, 14, 'BMW', 'BMW X3', 'MH02-BX-3535', 'Diesel', 'Automatic', 5, 6500.00, 12000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/BMW_X3.jpg',
 'Versatile luxury sports activity vehicle (SAV) with intelligent xDrive all-wheel drive and adaptive suspension.',
 'xDrive All-Wheel Drive, Adaptive M Suspension, Panoramic Glass Roof, 3-Zone Climate, Gesture Control',
 'Highway toll tag (FASTag) recharged; reimbursement on vehicle handover.', TRUE),

(36, 3, 6, 1, 7, 'Mercedes-Benz', 'Mercedes-Benz GLC', 'DL02-MG-3636', 'Petrol', 'Automatic', 5, 6800.00, 12000.00, 'AVAILABLE',
 'assets/images/vehicles/premium/Mercedes-Benz_GLC.webp',
 'Dynamic luxury SUV with muscular proportions, transparent bonnet off-road camera view, and DIGITAL LIGHT.',
 'DIGITAL LIGHT with Projection, Transparent Bonnet Off-Road View, MBUX Augmented Reality, 9G-TRONIC Transmission',
 'Premium rental terms apply. White-glove concierge dispatch available.', TRUE)
ON DUPLICATE KEY UPDATE model_name=VALUES(model_name);

-- 8. Insert Simulated GPS Telemetry for Live Tracking Feature
INSERT INTO vehicle_locations (id, vehicle_id, rental_id, latitude, longitude, recorded_at, source, is_demo) VALUES
(1, 1, NULL, 26.92393600, 75.82674400, NOW(), 'SIMULATED', TRUE),
(2, 4, NULL, 18.92200000, 72.83470000, NOW(), 'SIMULATED', TRUE),
(3, 19, NULL, 12.97160000, 77.59460000, NOW(), 'SIMULATED', TRUE),
(4, 31, NULL, 19.07600000, 72.87770000, NOW(), 'SIMULATED', TRUE)
ON DUPLICATE KEY UPDATE recorded_at=VALUES(recorded_at);

-- 9. Notifications for Seed Users
INSERT INTO notifications (user_id, title, message, is_read, type) VALUES
(1, 'System Initialized', 'Welcome to the Wheelyx Admin Portal. All 36 fleet vehicles and 20 operational hubs are active.', FALSE, 'SYSTEM'),
(2, 'Fleet Operational', 'Your listed vehicles in Delhi, Jaipur, and Bengaluru are approved and ready for reservation.', FALSE, 'OWNER'),
(3, 'Fleet Operational', 'Your listed vehicles in Mumbai, Hyderabad, and Pune are approved and ready for reservation.', FALSE, 'OWNER'),
(4, 'Welcome to Wheelyx', 'Welcome to Wheelyx! Discover self-drive mobility across 20 cities. Move Your Way.', FALSE, 'CUSTOMER');

-- 10. Audit Log Initialization
INSERT INTO audit_logs (user_id, role, action, entity_type, entity_id, description, ip_address) VALUES
(1, 'ADMIN', 'SYSTEM_INIT', 'SYSTEM', 1, 'Platform seed initialization completed with 20 cities, 200 places, and 36 vehicles.', '127.0.0.1');
