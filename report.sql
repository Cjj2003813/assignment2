/*
 Navicat Premium Data Transfer

 Source Server         : locaihost
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : report

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 10/03/2025 23:20:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', NULL, 'Admin');

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(0) NOT NULL,
  `user_id` int(0) NOT NULL,
  `user_type` int(0) NOT NULL,
  `report_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_teacher_auth`(`teacher_id`) USING BTREE,
  INDEX `ref_report_auth`(`report_id`) USING BTREE,
  INDEX `ref_user_auth`(`user_id`) USING BTREE,
  CONSTRAINT `ref_report_auth` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ref_teacher_auth` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES (1, 5, 1, 3, 18);
INSERT INTO `authority` VALUES (7, 3, 3, 3, 15);

-- ----------------------------
-- Table structure for laboratory
-- ----------------------------
DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE `laboratory`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(0) DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `about` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_teacher`(`teacher_id`) USING BTREE,
  CONSTRAINT `ref_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of laboratory
-- ----------------------------
INSERT INTO `laboratory` VALUES (1, 2, 'AI', 'aaaaa417', 'demo');
INSERT INTO `laboratory` VALUES (2, 3, 'Embedded', NULL, NULL);
INSERT INTO `laboratory` VALUES (3, NULL, 'Yang', 'dddddd', 'ddddd');
INSERT INTO `laboratory` VALUES (11, NULL, 'dfghfgdhhfdg', 'fghfghhgf', 'fdghfdgh');

-- ----------------------------
-- Table structure for motification
-- ----------------------------
DROP TABLE IF EXISTS `motification`;
CREATE TABLE `motification`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id_mo` int(0) NOT NULL,
  `user_type_mo` int(0) NOT NULL,
  `generate_time_mo` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `title_mo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_mo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `read_mo` int(0) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of motification
-- ----------------------------
INSERT INTO `motification` VALUES (1, 1, 3, '2018-12-06 00:43:32', '您收到一篇新的周报推荐', '杨柏林给您分享了一篇周报，请在分享周报中查阅', -1);
INSERT INTO `motification` VALUES (4, 3, 3, '2018-12-07 00:15:21', '您收到一篇新的周报推荐', '王慧燕给您分享了一篇周报，请在分享周报中查阅', -1);

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `this_week` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `bug_meet` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `next_week` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `student_id` int(0) NOT NULL,
  `pv` int(0) DEFAULT 0,
  `score` int(0) DEFAULT NULL,
  `reply` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `submit_time` timestamp(0) DEFAULT NULL,
  `reply_time` timestamp(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_student`(`student_id`) USING BTREE,
  INDEX `title_index`(`title`) USING BTREE,
  CONSTRAINT `ref_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (15, 'Weekly report of ss - November 5', '<div>&nbsp;  &nbsp;  &nbsp;  &nbsp; Computer vision is to use various imaging systems instead of visual organs as input sensitive means, and the computer replaces the brain to complete processing and interpretation. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  &nbsp;  The ultimate goal of computer vision research is to enable computers to observe and understand the world through vision like people, and have the ability to adapt to the environment independently. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  &nbsp;  The intermediate goal of the effort, before reaching the final goal, is to build a visual system that can perform certain tasks with some degree of intelligence based on visual sensitivity and feedback. For example, an important application area of computer vision is the visual navigation of autonomous vehicles, and there is no system that can recognize and understand any environment and complete autonomous navigation like a conditional human. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  &nbsp;  In the computer vision system, the computer plays the role of replacing the human brain, but it does not mean that the computer must complete the visual information processing in the way of human vision. Computer vision can and should process visual information according to the characteristics of computer systems. Therefore, using computer information processing method to study the mechanism of human vision and establish the computational theory of human vision is also a very important and interesting research field. This area of research is called computational vision. Computational vision can be considered as a research area in computer vision. </div>', '&nbsp;  &nbsp;  1. Learned Mr. Andrew Ng\'s micro professional course \"Deep Learning Engineer\" &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; Part 3: Structured Machine Learning Project <span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; Week 2: Machine Learning (ML) Strategies (2) <br></span>&nbsp; &nbsp;  2. I learned two lessons about Li Feifei\'s computer vision. &nbsp;  &nbsp; 3, run a small classification model <span>&nbsp; &nbsp; </span></span>', '&nbsp; 1, continue to learn Mr. Andrew Ng\'s micro professional courses <span>&nbsp; &nbsp;  2, and find some small Demo, see some source code </span><span>&nbsp; &nbsp;  3, <span> Learn machine learning content </span></span>', 1, 0, 86, 'So-so, so-so, so-so, so-so, so-so, so-so', '2018-12-05 19:15:04', '2018-12-06 18:07:50');
INSERT INTO `report` VALUES (16, 'Weekly report of ss - November 5', '<div>1.&nbsp;  &nbsp;  &nbsp; Complete the basic learning of JSP. </div><div><br></div><div>2.&nbsp;  &nbsp;  &nbsp; Continue the final review. </div><div><br></div><div>3.&nbsp;  &nbsp;  &nbsp; A beginner\'s study of javascript projects. < / div > < div > < br > < / div > < div > this week concluded: < / div > < div > < br > < / div > < div > & have spent &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; I don\'t feel in a good state this week, for one thing, it is approaching the end of the semester and I am worried about the final exam. Second, I feel that my mental condition this week is not too optimistic, perhaps because I did not adjust well. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp; There is also a small javascript project that follows Teacher Li\'s video, feeling that a dynamic web page needs to add a lot of things, such as Ajax, javascript, XML, Dom and so on. Some things understand a little, some words do not understand, in fact, I feel that the final exam is very annoying, and now I have to take a lot of time to deal with the final exam. What are the points, what are the test points, nothing except the English teacher said a little bit about the scope of the test, the scope of the other subjects is everything we\'ve studied this semester. I feel like I have to do it on my own. Just like discretization, there are so many definitions down the side, remembering definitions is like remembering English words, much older, and now reviewing discretization is like previewing discretization. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  I can\'t help it. The final is there, the assignment is there like I still have to eat, Just do it. Living a meaningful life requires energy and physical strength anyway. </div>', '<div>1.&nbsp;  &nbsp;  &nbsp; Complete the basic learning of JSP. </div><div><br></div><div>2.&nbsp;  &nbsp;  &nbsp; Continue the final review. </div><div><br></div><div>3.&nbsp;  &nbsp;  &nbsp; A beginner\'s study of javascript projects. < / div > < div > < br > < / div > < div > this week concluded: < / div > < div > < br > < / div > < div > & have spent &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; I don\'t feel in a good state this week, for one thing, it is approaching the end of the semester and I am worried about the final exam. Second, I feel that my mental condition this week is not too optimistic, perhaps because I did not adjust well. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp; There is also a small javascript project that follows Teacher Li\'s video, feeling that a dynamic web page needs to add a lot of things, such as Ajax, javascript, XML, Dom and so on. Some things understand a little, some words do not understand, in fact, I feel that the final exam is very annoying, and now I have to take a lot of time to deal with the final exam. What are the points, what are the test points, nothing except the English teacher said a little bit about the scope of the test, the scope of the other subjects is everything we\'ve studied this semester. I feel like I have to do it on my own. Just like discretization, there are so many definitions down the side, remembering definitions is like remembering English words, much older, and now reviewing discretization is like previewing discretization. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  I can\'t help it. The final is there, the assignment is there like I still have to eat, Just do it. Living a meaningful life requires energy and physical strength anyway. </div>', '<div>1.&nbsp;  &nbsp;  &nbsp; Complete the basic learning of JSP. </div><div><br></div><div>2.&nbsp;  &nbsp;  &nbsp; Continue the final review. </div><div><br></div><div>3.&nbsp;  &nbsp;  &nbsp; A beginner\'s study of javascript projects. < / div > < div > < br > < / div > < div > this week concluded: < / div > < div > < br > < / div > < div > & have spent &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; I don\'t feel in a good state this week, for one thing, it is approaching the end of the semester and I am worried about the final exam. Second, I feel that my mental condition this week is not too optimistic, perhaps because I did not adjust well. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp; There is also a small javascript project that follows Teacher Li\'s video, feeling that a dynamic web page needs to add a lot of things, such as Ajax, javascript, XML, Dom and so on. Some things understand a little, some words do not understand, in fact, I feel that the final exam is very annoying, and now I have to take a lot of time to deal with the final exam. What are the points, what are the test points, nothing except the English teacher said a little bit about the scope of the test, the scope of the other subjects is everything we\'ve studied this semester. I feel like I have to do it on my own. Just like discretization, there are so many definitions down the side, remembering definitions is like remembering English words, much older, and now reviewing discretization is like previewing discretization. </div><div><br></div><div>&nbsp;  &nbsp;  &nbsp;  I can\'t help it. The final is there, the assignment is there like I still have to eat, Just do it. Living a meaningful life requires energy and physical strength anyway. </div>', 1, 0, NULL, NULL, '2018-12-05 19:16:01', NULL);
INSERT INTO `report` VALUES (18, 'Weekly report of sss - November 5', 'I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar </u></b>', 'I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I am a packet of sugar I\'m a bag of sugar. I\'m a bag of sugar. I\'m a bag of sugar', 'I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar I\'m a packet of sugar', 3, 0, 100, 'Well done. The teacher thinks very highly of you', '2018-12-05 21:25:10', '2018-12-05 21:26:38');
INSERT INTO `report` VALUES (19, 'Weekly report of sss - November 6', '<h1> This is a weekly newspaper with a style </h1><h3> This is a weekly newspaper with a style </b><br><i> This is a weekly newspaper with a style </b><br>< u> This is a weekly newspaper with a style </i><br>< br>< br> This is a weekly newspaper with a style < BR > This is a weekly newspaper with a style < BR > This is a weekly newspaper with a style < BR > This is a weekly newspaper with a style < BR It\'s a weekly newspaper with a style <br><a href=\"http://baidu.com\" target=\"_blank\" rel=\"nofollow\"> It\'s a weekly newspaper with a style </a><br> It\'s a link <br>', 'Ah greatly ten but issued', 'Spread and develop', 2, 0, 96, 'sss', '2018-12-06 17:56:48', '2018-12-06 23:07:45');
INSERT INTO `report` VALUES (20, 'Weekly report of sss - November 6', '< h2 > < b > < I > < u > is said to be in the writing of long teacher will notice my weekly < br > < br > < / u > < / I > < / b > < / h2 >', 'Nothing difficult ah, is too good < br > < img SRC = \"http://img.027cgb.com/612107/201871411545849481.gif\" > < br >', 'Next week is just another good week. <br><img src=\"http://img.027cgb.com/612107/201711513421988336.jpg\"><br>', 1, 0, 0, 'Memes in a weekly newspaper? Zero on the final exam', '2018-12-06 18:04:16', '2018-12-06 18:06:43');
INSERT INTO `report` VALUES (21, 'Weekly report of ss - November 6', 'I\'m serious this week', 'xinded&nbsp;', 'xinded&nbsp; <br><br><img src=\"http://img.027cgb.com/612107/201711513421988336.jpg\"><br>', 2, 0, NULL, NULL, '2018-12-06 21:49:06', NULL);
INSERT INTO `report` VALUES (22, 'Weekly report of sss - November 6', 'What did I do this week', '', '', 2, 0, NULL, NULL, '2018-12-06 22:12:46', NULL);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `sex` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `telephone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `mail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `teacher_id` int(0) DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_unique`(`username`) USING BTREE,
  INDEX `ref_teacher_id`(`teacher_id`) USING BTREE,
  CONSTRAINT `ref_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '1', '17816875157', 'chwangteng@126.com', NULL, 'aa', 3, '18020100027', '100027');
INSERT INTO `student` VALUES (2, '-1', '13616852042', 'haiyinchen@126.com', NULL, 'bb（别删）', 3, '18020100028', '100028');
INSERT INTO `student` VALUES (3, '1', '17195818118', 'yibaotang@126.com', NULL, 'cc', 4, '18020100029', '100029');
INSERT INTO `student` VALUES (5, NULL, NULL, NULL, NULL, '用来删的1', 3, NULL, NULL);
INSERT INTO `student` VALUES (7, NULL, NULL, NULL, NULL, '用来补全信息的1', 3, NULL, NULL);
INSERT INTO `student` VALUES (8, '-1', '110', '', NULL, '用来补全信息的2', 3, NULL, NULL);
INSERT INTO `student` VALUES (9, '1', '1212', '12312312', NULL, '测试的新增', 3, '18020100099', '100099');
INSERT INTO `student` VALUES (11, '-1', '11111111', '111111111111', NULL, '测试的学生', 15, '1234567890', '567890');
INSERT INTO `student` VALUES (14, '-1', '12348456132489', '123@example.com', NULL, 'demo', 2, '1234567894563213', '563213');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `is_supervisor` int(0) NOT NULL DEFAULT -1,
  `about` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sex` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `telephone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `mail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `lab_id` int(0) DEFAULT NULL,
  `deadline` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'Sun2200',
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `ref_lab`(`lab_id`) USING BTREE,
  CONSTRAINT `ref_lab` FOREIGN KEY (`lab_id`) REFERENCES `laboratory` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (2, 1, 'Hello', 'Male', '17816875157', 'jindfdfdfddfdfdf', NULL, 'Wang', 1, 'Sun2200', '18020100027', '100027');
INSERT INTO `teacher` VALUES (3, -1, '115', 'Female', '17195818118', 'cedfdfdfd.cn', NULL, 'Wang W', 1, 'Sun2200', '18020100028', '100028');
INSERT INTO `teacher` VALUES (4, -1, 'HI', 'Female', '17818273681', 'zdfdfdfddfdcn', NULL, 'df', 1, 'Sun2200', '18020100029', '100029');
INSERT INTO `teacher` VALUES (5, -1, '', 'Male', '13616852222', '@dfdfdfdffdf.cn', NULL, 'Yang', 3, 'Sun2200', '18020100030', '100030');
INSERT INTO `teacher` VALUES (7, -1, '345345435345', 'Female', '345345345', '345345345', NULL, 'Lao', 11, 'Sun2200', '34545345345', '345345');
INSERT INTO `teacher` VALUES (8, -1, '345345345', 'Female', '345435453', '345345', NULL, '345435435', 11, 'Sun2200', '345345345', '345345');
INSERT INTO `teacher` VALUES (9, -1, '22222', 'Female', '2222222222222', '222222222222222222', NULL, '22222222222', 11, 'Sun2200', '2222222222222222', '222222');
INSERT INTO `teacher` VALUES (10, -1, '546456546', 'Male', '456546', '456456', NULL, 'llllllllllllll', 11, 'Sun2200', '7645654', '645654');
INSERT INTO `teacher` VALUES (12, 1, '测试测试测试测试测试', 'Female', '12121212121212', '21212121211121212', NULL, '测试测试', 11, 'Sun2200', '1212121212121212', '121212');
INSERT INTO `teacher` VALUES (14, -1, '5464545645', 'Male', '456456456456', '456456456456', NULL, '456456456', 2, 'Sun2200', '546456456456456456', '456456');
INSERT INTO `teacher` VALUES (15, -1, '11111111111111111', 'Male', '1111111111111', '111111111111111', NULL, '测试的姓名', 11, 'Sun2200', '1234567890', '567890');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `age` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '测试用户名', '测试密码', 24);

SET FOREIGN_KEY_CHECKS = 1;
