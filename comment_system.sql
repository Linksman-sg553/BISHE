/*
 Navicat Premium Data Transfer

 Source Server         : 本地gefu1128
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : comment_system

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 02/06/2022 14:04:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_likes
-- ----------------------------
DROP TABLE IF EXISTS `article_likes`;
CREATE TABLE `article_likes`  (
  `like_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `text_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`like_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `text_id`(`text_id`) USING BTREE,
  CONSTRAINT `article_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_likes_ibfk_2` FOREIGN KEY (`text_id`) REFERENCES `articles` (`text_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_likes
-- ----------------------------
INSERT INTO `article_likes` VALUES (1, 2, 1);
INSERT INTO `article_likes` VALUES (2, 2, 3);
INSERT INTO `article_likes` VALUES (4, 2, 5);
INSERT INTO `article_likes` VALUES (5, 2, 4);
INSERT INTO `article_likes` VALUES (6, 2, 6);
INSERT INTO `article_likes` VALUES (7, 11, 6);

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `text_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `main_text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `author` int(11) NULL DEFAULT NULL,
  `part_of_main` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `part_of_sec` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tag_collection` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `anti_collection` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rate` int(11) NULL DEFAULT NULL,
  `likes` int(11) NULL DEFAULT NULL,
  `paper_id` int(11) NULL DEFAULT NULL,
  `article_status` int(11) NULL DEFAULT NULL,
  `summary` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pageviews` int(11) NULL DEFAULT NULL,
  `score` double NULL DEFAULT NULL,
  PRIMARY KEY (`text_id`) USING BTREE,
  INDEX `paper_id`(`paper_id`) USING BTREE,
  INDEX `part_of_sec`(`part_of_sec`) USING BTREE,
  INDEX `author`(`author`) USING BTREE,
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`paper_id`) REFERENCES `paper_lists` (`paper_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`part_of_sec`) REFERENCES `part_secs` (`part_sec_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `articles_ibfk_3` FOREIGN KEY (`author`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (1, '探究奥秘001', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 2, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 1, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 333, 6);
INSERT INTO `articles` VALUES (2, '哪里的奥秘？002', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 3, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 0, 2, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 37, 0);
INSERT INTO `articles` VALUES (3, '关于xxx的论文出现的几点问题003', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 4, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 1, 3, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 19, 0);
INSERT INTO `articles` VALUES (4, '这篇论文大有来头004', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 5, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 1, 4, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 7, 0);
INSERT INTO `articles` VALUES (5, '也许某航空大学也存在西点不端', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 6, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 1, 5, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 27, 0);
INSERT INTO `articles` VALUES (6, '西点大学不端', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 7, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 2, 6, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 25, 9);
INSERT INTO `articles` VALUES (7, 'xxx论文数据造假', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 8, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 0, 7, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 1, 0);
INSERT INTO `articles` VALUES (8, 'xxx论文存在大段剽窃', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 9, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 0, 7, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 0, 0);
INSERT INTO `articles` VALUES (9, '这篇文章使这个技术达到了前所未有的高度', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 10, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 0, 7, 3, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 4, 0);
INSERT INTO `articles` VALUES (20, '探讨豆豉鲮鱼是否好吃', '<h1>这是一篇文章，用来测试这个系统</h1>\n<h3>一. 第一部分测试文字</h3>\n<ul style=\"list-style-type: square;\">\n<li>玉渡黄河冰涩川</li>\n<li>将登太行雪满山</li>\n<li>闲来垂钓碧溪上</li>\n<li>我欲乘风归去</li>\n</ul>\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\n<h3>二. 第二部分测试代码</h3>\n<pre class=\"language-cpp\"><code>// file: main.go\n// author: Chen gefu\npackage main\n\nimport \"fmt\"\n\nfunc main(){\n fmt.Println(\"hello world\")\n}</code></pre>\n<p>这是一段非常标准的Golang输出你好世界</p>\n<p>怎么运行?</p>\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\n<p>就行这样</p>\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\n<p>&nbsp;</p>', '2022-05-06 18:58:21', 2, 'T', 'TS', '计算机,数据库', '文字抄袭,诚实守信', 6, 0, 10, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 5, 0);
INSERT INTO `articles` VALUES (21, '探究奥秘002', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 3, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 5, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 9, 6);
INSERT INTO `articles` VALUES (22, '探究奥秘012', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 4, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 7, 6);
INSERT INTO `articles` VALUES (23, '探究奥秘003', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 5, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 8, 6);
INSERT INTO `articles` VALUES (24, '探究奥秘004', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 6, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 16, 6);
INSERT INTO `articles` VALUES (25, '探究奥秘005', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 7, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 55, 6);
INSERT INTO `articles` VALUES (26, '探究奥秘006', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 8, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 14, 6);
INSERT INTO `articles` VALUES (27, '探究奥秘007', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 9, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 13, 6);
INSERT INTO `articles` VALUES (28, '探究奥秘008', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 10, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 13, 6);
INSERT INTO `articles` VALUES (29, '探究奥秘009', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 15, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 12, 6);
INSERT INTO `articles` VALUES (30, '探究奥秘001', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 16, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 12, 6);
INSERT INTO `articles` VALUES (31, '探究奥秘010', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 19, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 11, 6);
INSERT INTO `articles` VALUES (32, '探究奥秘011', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-04-25 21:15:54', 20, 'T', 'TP', '计算机,数据库', '文字抄袭,诚实守信', 1, 0, 1, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 10, 6);
INSERT INTO `articles` VALUES (33, '五花肉所说的并不靠谱', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-06-01 21:15:54', 17, 'T', 'TS', '猪肉,酱油', '文字抄袭,重复性研究', 1, 0, 11, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 1, 3);
INSERT INTO `articles` VALUES (34, '红烧肉的佐证', '<h1>这是一篇文章，用来测试这个系统</h1>\r\n<h3>一. 第一部分测试文字</h3>\r\n<ul style=\"list-style-type: square;\">\r\n<li>玉渡黄河冰涩川</li>\r\n<li>将登太行雪满山</li>\r\n<li>闲来垂钓碧溪上</li>\r\n<li>我欲乘风归去</li>\r\n</ul>\r\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\r\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\r\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\r\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\r\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\r\n<h3>二. 第二部分测试代码</h3>\r\n<pre class=\"language-cpp\"><code>// file: main.go\r\n// author: Chen gefu\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main(){\r\n fmt.Println(\"hello world\")\r\n}</code></pre>\r\n<p>这是一段非常标准的Golang输出你好世界</p>\r\n<p>怎么运行?</p>\r\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\r\n<p>就行这样</p>\r\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\r\n<p>&nbsp;</p>', '2022-06-01 21:15:54', 2, 'T', 'TS', '猪肉,酱油', '文字抄袭,重复性研究', 1, 0, 11, 1, '使用allegro的友人时对于env文件并不陌生。在我们设计的过程中经常使用env文件设置快捷键从而达到快速拉线的目的。但是新安装的allegro软件中会找不到env文件，因为今天自己碰到了这件事，并且网上的解决方法不明确，所以记录解决方法。 allegro软件中的env文件分为系统变量和用户变量， ...', 0, 0);
INSERT INTO `articles` VALUES (40, '红烧肉的作证001', '<h1>这是一篇文章，用来测试这个系统</h1>\n<h3>一. 第一部分测试文字</h3>\n<ul style=\"list-style-type: square;\">\n<li>玉渡黄河冰涩川</li>\n<li>将登太行雪满山</li>\n<li>闲来垂钓碧溪上</li>\n<li>我欲乘风归去</li>\n</ul>\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\n<h3>二. 第二部分测试代码</h3>\n<pre class=\"language-cpp\"><code>// file: main.go\n// author: Chen gefu\npackage main\n\nimport \"fmt\"\n\nfunc main(){\n fmt.Println(\"hello world\")\n}</code></pre>\n<p>这是一段非常标准的Golang输出你好世界</p>\n<p>怎么运行?</p>\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\n<p>就行这样</p>\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\n<p>&nbsp;</p>', '2022-06-01 09:01:39', 15, 'T', 'TS', '计算机,数据库', '文字抄袭,诚实守信', 2, 0, 11, 1, '', 1, 0);
INSERT INTO `articles` VALUES (41, '红烧肉的作证002', '<h1>这是一篇文章，用来测试这个系统</h1>\n<h3>一. 第一部分测试文字</h3>\n<ul style=\"list-style-type: square;\">\n<li>玉渡黄河冰涩川</li>\n<li>将登太行雪满山</li>\n<li>闲来垂钓碧溪上</li>\n<li>我欲乘风归去</li>\n</ul>\n<p>他所说的话，正如他所说的话。如果我们今天不吃饭的话，我们今天将不会吃饭。如果我们写了作业，我们的作业就被写了。这段代码被提交了，所以代码被提交了</p>\n<p><span style=\"background-color: #ff0000;\">这段文字是绿的背景</span></p>\n<p><span style=\"background-color: #ffffff; color: #ff00ff;\">这段文字为蓝色</span></p>\n<h2><span style=\"color: #ff00ff;\">怎么把这个字体变大？</span></h2>\n<p><span style=\"color: #ff00ff;\">哇哇哇</span></p>\n<h3>二. 第二部分测试代码</h3>\n<pre class=\"language-cpp\"><code>// file: main.go\n// author: Chen gefu\npackage main\n\nimport \"fmt\"\n\nfunc main(){\n fmt.Println(\"hello world\")\n}</code></pre>\n<p>这是一段非常标准的Golang输出你好世界</p>\n<p>怎么运行?</p>\n<h1><span style=\"color: #99cc00;\">!简单！</span></h1>\n<p>就行这样</p>\n<pre class=\"language-markup\"><code>go run main.go</code></pre>\n<p>&nbsp;</p>', '2022-06-01 09:35:13', 9, 'T', 'TS', '计算机,数据库', '文字抄袭,诚实守信', 6, 0, 11, 1, '', 0, 0);

-- ----------------------------
-- Table structure for black_articles
-- ----------------------------
DROP TABLE IF EXISTS `black_articles`;
CREATE TABLE `black_articles`  (
  `black_article_id` int(11) NULL DEFAULT NULL,
  INDEX `black_articles`(`black_article_id`) USING BTREE,
  CONSTRAINT `black_articles` FOREIGN KEY (`black_article_id`) REFERENCES `articles` (`text_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of black_articles
-- ----------------------------
INSERT INTO `black_articles` VALUES (9);

-- ----------------------------
-- Table structure for black_auths
-- ----------------------------
DROP TABLE IF EXISTS `black_auths`;
CREATE TABLE `black_auths`  (
  `black_auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `black_auth_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`black_auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of black_auths
-- ----------------------------
INSERT INTO `black_auths` VALUES (1, '金丝猴');
INSERT INTO `black_auths` VALUES (2, '金丝猴2');
INSERT INTO `black_auths` VALUES (3, '金丝猴3');
INSERT INTO `black_auths` VALUES (4, '金丝猴4');
INSERT INTO `black_auths` VALUES (5, '金丝猴5');
INSERT INTO `black_auths` VALUES (6, '金丝猴6');
INSERT INTO `black_auths` VALUES (7, '金丝猴7');
INSERT INTO `black_auths` VALUES (8, '金丝猴8');
INSERT INTO `black_auths` VALUES (9, '金丝猴9');
INSERT INTO `black_auths` VALUES (10, '金丝猴10');
INSERT INTO `black_auths` VALUES (11, '金丝猴1');

-- ----------------------------
-- Table structure for black_papers
-- ----------------------------
DROP TABLE IF EXISTS `black_papers`;
CREATE TABLE `black_papers`  (
  `black_paper_id` int(11) NOT NULL,
  PRIMARY KEY (`black_paper_id`) USING BTREE,
  CONSTRAINT `black_papers` FOREIGN KEY (`black_paper_id`) REFERENCES `paper_lists` (`paper_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of black_papers
-- ----------------------------
INSERT INTO `black_papers` VALUES (1);

-- ----------------------------
-- Table structure for black_users
-- ----------------------------
DROP TABLE IF EXISTS `black_users`;
CREATE TABLE `black_users`  (
  `black_user_id` int(11) NOT NULL,
  PRIMARY KEY (`black_user_id`) USING BTREE,
  CONSTRAINT `black_users` FOREIGN KEY (`black_user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of black_users
-- ----------------------------
INSERT INTO `black_users` VALUES (11);

-- ----------------------------
-- Table structure for comment_likes
-- ----------------------------
DROP TABLE IF EXISTS `comment_likes`;
CREATE TABLE `comment_likes`  (
  `like_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `comment_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`like_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `comment_id`(`comment_id`) USING BTREE,
  CONSTRAINT `comment_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_likes
-- ----------------------------
INSERT INTO `comment_likes` VALUES (1, 2, 1);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `publish_user` int(11) NULL DEFAULT NULL,
  `publish_article` int(11) NULL DEFAULT NULL,
  `likes` int(11) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `rate` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `publish_user`(`publish_user`) USING BTREE,
  INDEX `publish_article`(`publish_article`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`publish_user`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`publish_article`) REFERENCES `articles` (`text_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '欲渡黄河冰涩川，将登太行雪满山', 2, 1, 1, '2022-03-01 21:23:38', 6);
INSERT INTO `comments` VALUES (2, '你好', 11, 6, 0, '2022-06-01 03:26:21', 9);
INSERT INTO `comments` VALUES (16, '你好，这文章不太行', 2, 33, 0, '2022-06-01 03:26:21', 3);
INSERT INTO `comments` VALUES (17, '你好，这文章不太行', 3, 33, 0, '2022-06-01 03:26:22', 3);
INSERT INTO `comments` VALUES (18, '你好，这文章不太行', 4, 33, 0, '2022-06-01 03:26:23', 3);
INSERT INTO `comments` VALUES (19, '你好，这文章不太行', 5, 33, 0, '2022-06-01 03:26:24', 3);
INSERT INTO `comments` VALUES (20, '你好，这文章不太行', 6, 33, 0, '2022-06-01 03:26:25', 3);
INSERT INTO `comments` VALUES (21, '你好，这文章不太行', 7, 33, 0, '2022-06-01 03:26:26', 3);
INSERT INTO `comments` VALUES (22, '你好，这文章不太行', 8, 33, 0, '2022-06-01 03:26:27', 3);
INSERT INTO `comments` VALUES (23, '你好，这文章不太行', 9, 33, 0, '2022-06-01 03:26:28', 3);
INSERT INTO `comments` VALUES (24, '你好，这文章不太行', 16, 33, 0, '2022-06-01 03:26:29', 3);
INSERT INTO `comments` VALUES (25, '你好，这文章不太行', 17, 33, 0, '2022-06-01 03:26:30', 3);
INSERT INTO `comments` VALUES (26, '你好，这文章不太行', 20, 33, 0, '2022-06-01 08:36:39', 3);

-- ----------------------------
-- Table structure for double_stores
-- ----------------------------
DROP TABLE IF EXISTS `double_stores`;
CREATE TABLE `double_stores`  (
  `paper_id` int(11) NULL DEFAULT NULL,
  `text_id` int(11) NULL DEFAULT NULL,
  `post_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of double_stores
-- ----------------------------
INSERT INTO `double_stores` VALUES (11, 33, '34,40,41');

-- ----------------------------
-- Table structure for gifts
-- ----------------------------
DROP TABLE IF EXISTS `gifts`;
CREATE TABLE `gifts`  (
  `gift_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gift_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gift_value` int(11) NULL DEFAULT NULL,
  `gift_quantity` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`gift_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gifts
-- ----------------------------

-- ----------------------------
-- Table structure for informations
-- ----------------------------
DROP TABLE IF EXISTS `informations`;
CREATE TABLE `informations`  (
  `info_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `info_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `creat_time` datetime(0) NULL DEFAULT NULL,
  `checked` tinyint(11) NULL DEFAULT NULL,
  `from_user` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `informations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of informations
-- ----------------------------
INSERT INTO `informations` VALUES (1, 2, '你好，这篇文章很好', '2022-04-30 15:28:00', 1, 4);
INSERT INTO `informations` VALUES (2, 2, '你好，这里是系统', '2022-04-22 15:32:45', 1, 1);
INSERT INTO `informations` VALUES (3, 2, '你好，这篇文章好', '2022-04-20 18:24:55', 1, 4);
INSERT INTO `informations` VALUES (4, 7, '你好', '2022-06-01 03:26:21', 0, 11);
INSERT INTO `informations` VALUES (5, 4, '您的文章 红烧肉的作证003 二审结果为 符合事实', '2022-06-01 10:46:04', 0, 1);
INSERT INTO `informations` VALUES (6, 4, '您的文章 红烧肉的作证003 二审结果为 符合事实', '2022-06-01 13:53:31', 0, 1);

-- ----------------------------
-- Table structure for paper_lists
-- ----------------------------
DROP TABLE IF EXISTS `paper_lists`;
CREATE TABLE `paper_lists`  (
  `paper_id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `foreign_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `paper_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `summary` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` double NULL DEFAULT NULL,
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `categories` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `part_sec` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `part_main` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `weights` int(11) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`paper_id`) USING BTREE,
  INDEX `paper_sec`(`part_sec`) USING BTREE,
  INDEX `paper_main`(`part_main`) USING BTREE,
  CONSTRAINT `paper_main` FOREIGN KEY (`part_main`) REFERENCES `part_mains` (`part_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `paper_sec` FOREIGN KEY (`part_sec`) REFERENCES `part_secs` (`part_sec_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper_lists
-- ----------------------------
INSERT INTO `paper_lists` VALUES (1, '黑名单合理吗', 'https://element.eleme.cn/#/zh-CN/component/pagination', '溜肉段', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之... ', 1, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 18, '2022-05-05 19:46:51');
INSERT INTO `paper_lists` VALUES (2, '论文奥秘1', 'https://element.eleme.cn/#/zh-CN/component/pagination', '饿了么', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 1, '2022-05-05 19:46:55');
INSERT INTO `paper_lists` VALUES (3, '论文奥秘2', 'https://element.eleme.cn/#/zh-CN/component/pagination', '美团', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 1, '2022-05-06 19:46:59');
INSERT INTO `paper_lists` VALUES (4, '论文奥秘3', 'https://element.eleme.cn/#/zh-CN/component/pagination', '肯德基', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 1, '2022-05-01 19:47:02');
INSERT INTO `paper_lists` VALUES (5, '论文奥秘4', 'https://element.eleme.cn/#/zh-CN/component/pagination', '金拱门', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 1, '2022-05-07 19:47:06');
INSERT INTO `paper_lists` VALUES (6, '论文奥秘5', 'https://element.eleme.cn/#/zh-CN/component/pagination', '华莱士', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 1, '2022-05-15 19:47:10');
INSERT INTO `paper_lists` VALUES (7, '论文奥秘6', 'https://element.eleme.cn/#/zh-CN/component/pagination', '蜜雪冰城', '该论文旨在研究大学生考试中考场分配和座位安排的系统设计。大多数情况下,人工分配不仅费时费力,而且学生在寻找考场时会遇到很多问题。因此,该论文研究的系统有助于员工轻松生成考场布置。该系统不仅有助于查询特定班级中特定学生的考试信息,而且能在没有任何冲突的情况下为每个学生自动分配考场,为特定的考场分配特定的监考人员。除此之外,该系统还可以自动生成考场分隔及相关的报告文档,其中手动Excel表格和文书工作将根据其部门和注册号自动执行。 ', 5, '考场安排,座位安排,应用程序', 'TP311.52', 'TP', 'T', 3, '2022-05-04 19:47:13');
INSERT INTO `paper_lists` VALUES (10, '豆豉鲮鱼与午餐肉', 'www.google.com', '鲮鱼', '一切从最基本的开始。模式，是正则表达式最基本的元素，它们是一组描述字符串特征的字符。模式可以很简单，由普通的字符串组成，也可以非常复杂，往往用特殊的字符表示一个范围内的字符、重复出现，或表示上下文。例如：', 6, '罐头,鱼', 'TS311', 'TS', 'T', 6, '2022-05-17 19:47:17');

-- ----------------------------
-- Table structure for part_mains
-- ----------------------------
DROP TABLE IF EXISTS `part_mains`;
CREATE TABLE `part_mains`  (
  `part_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `part_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`part_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of part_mains
-- ----------------------------
INSERT INTO `part_mains` VALUES ('A', 'A马克思、列宁、毛泽东、邓小平理论');
INSERT INTO `part_mains` VALUES ('B', 'B哲学、宗教');
INSERT INTO `part_mains` VALUES ('C', 'C社会科学总论');
INSERT INTO `part_mains` VALUES ('D', 'D政治、法律');
INSERT INTO `part_mains` VALUES ('E', 'E军事');
INSERT INTO `part_mains` VALUES ('F', 'F经济');
INSERT INTO `part_mains` VALUES ('G', 'G文化、科学、教育、体育');
INSERT INTO `part_mains` VALUES ('H', 'H语言、文字');
INSERT INTO `part_mains` VALUES ('I', 'I文学');
INSERT INTO `part_mains` VALUES ('J', 'J 艺术');
INSERT INTO `part_mains` VALUES ('K', 'K 历史、地理');
INSERT INTO `part_mains` VALUES ('N', 'N 自然科学总论');
INSERT INTO `part_mains` VALUES ('O', 'O 数理科学和化学');
INSERT INTO `part_mains` VALUES ('P', 'P 天文学、地球科学');
INSERT INTO `part_mains` VALUES ('Q', 'Q 生物科学');
INSERT INTO `part_mains` VALUES ('R', 'R 医药、卫生');
INSERT INTO `part_mains` VALUES ('S', 'S 农业科学');
INSERT INTO `part_mains` VALUES ('T', 'T 工业技术');
INSERT INTO `part_mains` VALUES ('U', 'U 交通运输');
INSERT INTO `part_mains` VALUES ('V', 'V 航空、航天');
INSERT INTO `part_mains` VALUES ('X', 'X 环境科学、安全科学');
INSERT INTO `part_mains` VALUES ('Z', 'Z 综合性图书');

-- ----------------------------
-- Table structure for part_secs
-- ----------------------------
DROP TABLE IF EXISTS `part_secs`;
CREATE TABLE `part_secs`  (
  `part_sec_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `part_sec_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_part` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`part_sec_id`) USING BTREE,
  INDEX `parent_part`(`parent_part`) USING BTREE,
  CONSTRAINT `part_secs_ibfk_1` FOREIGN KEY (`parent_part`) REFERENCES `part_mains` (`part_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of part_secs
-- ----------------------------
INSERT INTO `part_secs` VALUES ('A1', 'A1马克思、恩格斯著作', 'A');
INSERT INTO `part_secs` VALUES ('A2', 'A2列宁著作', 'A');
INSERT INTO `part_secs` VALUES ('A3', 'A3斯大林著作', 'A');
INSERT INTO `part_secs` VALUES ('A4', 'A4毛泽东著作', 'A');
INSERT INTO `part_secs` VALUES ('A49', 'A49邓小平著作', 'A');
INSERT INTO `part_secs` VALUES ('A5', 'A5马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编', 'A');
INSERT INTO `part_secs` VALUES ('A7', 'A7马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记', 'A');
INSERT INTO `part_secs` VALUES ('A8', 'A8马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究', 'A');
INSERT INTO `part_secs` VALUES ('B0', 'B0哲学理论', 'B');
INSERT INTO `part_secs` VALUES ('B1', 'B1世界哲学', 'B');
INSERT INTO `part_secs` VALUES ('B2', 'B2中国哲学', 'B');
INSERT INTO `part_secs` VALUES ('B3', 'B3亚洲哲学', 'B');
INSERT INTO `part_secs` VALUES ('B4', 'B4非洲哲学', 'B');
INSERT INTO `part_secs` VALUES ('B5', 'B5欧洲哲学', 'B');
INSERT INTO `part_secs` VALUES ('B6', 'B6大洋州哲学', 'B');
INSERT INTO `part_secs` VALUES ('B7', 'B7美洲哲学', 'B');
INSERT INTO `part_secs` VALUES ('B80', 'B80思维科学', 'B');
INSERT INTO `part_secs` VALUES ('B81', 'B81逻辑学（论理学）', 'B');
INSERT INTO `part_secs` VALUES ('B82', 'B82伦理学（道德哲学）', 'B');
INSERT INTO `part_secs` VALUES ('B83', 'B83美学', 'B');
INSERT INTO `part_secs` VALUES ('B84', 'B84心理学', 'B');
INSERT INTO `part_secs` VALUES ('B9', 'B9宗教', 'B');
INSERT INTO `part_secs` VALUES ('C0', 'C0社会科学理论与方法论', 'C');
INSERT INTO `part_secs` VALUES ('C1', 'C1社会科学概况、现状、进展', 'C');
INSERT INTO `part_secs` VALUES ('C2', 'C2社会科学机构、团体、会议', 'C');
INSERT INTO `part_secs` VALUES ('C3', 'C3社会科学研究方法', 'C');
INSERT INTO `part_secs` VALUES ('C4', 'C4社会科学教育与普及', 'C');
INSERT INTO `part_secs` VALUES ('C5', 'C5社会科学丛书、文集、连续性出版物', 'C');
INSERT INTO `part_secs` VALUES ('C6', 'C6社会科学参考工具书', 'C');
INSERT INTO `part_secs` VALUES ('C7', 'C7社会科学文献检索工具书', 'C');
INSERT INTO `part_secs` VALUES ('C79', 'C79非书资料、视听资料', 'C');
INSERT INTO `part_secs` VALUES ('C8', 'C8统计学', 'C');
INSERT INTO `part_secs` VALUES ('C91', 'C91社会学', 'C');
INSERT INTO `part_secs` VALUES ('C92', 'C92人口学', 'C');
INSERT INTO `part_secs` VALUES ('C93', 'C93管理学', 'C');
INSERT INTO `part_secs` VALUES ('C94', 'C94系统科学', 'C');
INSERT INTO `part_secs` VALUES ('C95', 'C95民族学、文化人类学', 'C');
INSERT INTO `part_secs` VALUES ('C96', 'C96人才学', 'C');
INSERT INTO `part_secs` VALUES ('C97', 'C97劳动科学', 'C');
INSERT INTO `part_secs` VALUES ('D0', 'D0政治学、政治理论', 'D');
INSERT INTO `part_secs` VALUES ('D1', 'D1国际共产主义运动', 'D');
INSERT INTO `part_secs` VALUES ('D2', 'D2中国共产党', 'D');
INSERT INTO `part_secs` VALUES ('D33/37', 'D33/37各国共产党', 'D');
INSERT INTO `part_secs` VALUES ('D4', 'D4工人、农民、青年、妇女运动与组织', 'D');
INSERT INTO `part_secs` VALUES ('D5', 'D5世界政治', 'D');
INSERT INTO `part_secs` VALUES ('D6', 'D6中国政治', 'D');
INSERT INTO `part_secs` VALUES ('D73/77', 'D73/77各国政治', 'D');
INSERT INTO `part_secs` VALUES ('D8', 'D8外交、国际关系', 'D');
INSERT INTO `part_secs` VALUES ('D9', 'D9法律', 'D');
INSERT INTO `part_secs` VALUES ('E0', 'E0军事理论', 'E');
INSERT INTO `part_secs` VALUES ('E1', 'E1世界军事', 'E');
INSERT INTO `part_secs` VALUES ('E2', 'E2中国军事', 'E');
INSERT INTO `part_secs` VALUES ('E3/7', 'E3/7各国军事', 'E');
INSERT INTO `part_secs` VALUES ('E8', 'E8战略学、战役学、战术学', 'E');
INSERT INTO `part_secs` VALUES ('E9', 'E9军事技术', 'E');
INSERT INTO `part_secs` VALUES ('E99', 'E99军事地形学、军事地理学', 'E');
INSERT INTO `part_secs` VALUES ('F0', 'F0经济学', 'F');
INSERT INTO `part_secs` VALUES ('F1', 'F1世界各国经济概况、经济史、经济地理', 'F');
INSERT INTO `part_secs` VALUES ('F2', 'F2经济管理', 'F');
INSERT INTO `part_secs` VALUES ('F3', 'F3农业经济', 'F');
INSERT INTO `part_secs` VALUES ('F4', 'F4工业经济', 'F');
INSERT INTO `part_secs` VALUES ('F49', 'F49信息产业经济', 'F');
INSERT INTO `part_secs` VALUES ('F5', 'F5交通运输经济', 'F');
INSERT INTO `part_secs` VALUES ('F59', 'F59旅游经济', 'F');
INSERT INTO `part_secs` VALUES ('F6', 'F6邮电通信经济', 'F');
INSERT INTO `part_secs` VALUES ('F7', 'F7贸易经济', 'F');
INSERT INTO `part_secs` VALUES ('F8', 'F8财政、金融', 'F');
INSERT INTO `part_secs` VALUES ('G0', 'G0文化理论', 'G');
INSERT INTO `part_secs` VALUES ('G1', 'G1世界各国文化与文化事业', 'G');
INSERT INTO `part_secs` VALUES ('G2', 'G2信息与知识传播', 'G');
INSERT INTO `part_secs` VALUES ('G3', 'G3科学、科学研究', 'G');
INSERT INTO `part_secs` VALUES ('G4', 'G4教育', 'G');
INSERT INTO `part_secs` VALUES ('G8', 'G8体育', 'G');
INSERT INTO `part_secs` VALUES ('H0', 'H0语言学', 'H');
INSERT INTO `part_secs` VALUES ('H1', 'H1汉语', 'H');
INSERT INTO `part_secs` VALUES ('H2', 'H2中国少数民族语言', 'H');
INSERT INTO `part_secs` VALUES ('H3', 'H3常用外国语', 'H');
INSERT INTO `part_secs` VALUES ('H4', 'H4汉藏语系', 'H');
INSERT INTO `part_secs` VALUES ('H5', 'H5阿尔泰语系(突厥-蒙古-通古斯语系）', 'H');
INSERT INTO `part_secs` VALUES ('H61', 'H61南亚语系（澳斯特罗-亚细亚语系）', 'H');
INSERT INTO `part_secs` VALUES ('H62', 'H62南印语系（达罗毗荼语系、德拉维达语系）', 'H');
INSERT INTO `part_secs` VALUES ('H63', 'H63南岛语系（马来亚-玻里尼西亚语系）', 'H');
INSERT INTO `part_secs` VALUES ('H64', 'H64东北亚诸语言', 'H');
INSERT INTO `part_secs` VALUES ('H65', 'H65高加索语系（伊比利亚-高加索语系）', 'H');
INSERT INTO `part_secs` VALUES ('H66', 'H66乌拉尔语系（芬兰-乌戈尔语系）', 'H');
INSERT INTO `part_secs` VALUES ('H67', 'H67闪-含语系（阿非罗-亚细亚语系）', 'H');
INSERT INTO `part_secs` VALUES ('H7', 'H7印欧语系', 'H');
INSERT INTO `part_secs` VALUES ('H81', 'H81非洲诸语言', 'H');
INSERT INTO `part_secs` VALUES ('H83', 'H83美洲诸语言', 'H');
INSERT INTO `part_secs` VALUES ('H84', 'H84大洋州诸语言', 'H');
INSERT INTO `part_secs` VALUES ('H9', 'H9国际辅助语', 'H');
INSERT INTO `part_secs` VALUES ('I0', 'I0文学理论', 'I');
INSERT INTO `part_secs` VALUES ('I1', 'I1世界文学', 'I');
INSERT INTO `part_secs` VALUES ('I2', 'I2中国文学', 'I');
INSERT INTO `part_secs` VALUES ('I3/7', 'I3/7各国文学', 'I');
INSERT INTO `part_secs` VALUES ('J0', 'J0艺术理论', 'J');
INSERT INTO `part_secs` VALUES ('J1', 'J1世界各国艺术概况', 'J');
INSERT INTO `part_secs` VALUES ('J19', 'J19专题艺术与现代边缘艺术', 'J');
INSERT INTO `part_secs` VALUES ('J2', 'J2绘画', 'J');
INSERT INTO `part_secs` VALUES ('J29', 'J29书法、篆刻', 'J');
INSERT INTO `part_secs` VALUES ('J3', 'J3雕塑', 'J');
INSERT INTO `part_secs` VALUES ('J4', 'J4摄影艺术', 'J');
INSERT INTO `part_secs` VALUES ('J5', 'J5工艺美术', 'J');
INSERT INTO `part_secs` VALUES ('J59', 'J59建筑艺术', 'J');
INSERT INTO `part_secs` VALUES ('J6', 'J6音乐', 'J');
INSERT INTO `part_secs` VALUES ('J7', 'J7舞蹈', 'J');
INSERT INTO `part_secs` VALUES ('J8', 'J8戏剧、曲艺、杂技艺术', 'J');
INSERT INTO `part_secs` VALUES ('J9', 'J9电影、电视艺术', 'J');
INSERT INTO `part_secs` VALUES ('K0', 'K0史学理论', 'K');
INSERT INTO `part_secs` VALUES ('K1', 'K1世界史', 'K');
INSERT INTO `part_secs` VALUES ('K2', 'K2中国史', 'K');
INSERT INTO `part_secs` VALUES ('K3', 'K3亚洲史', 'K');
INSERT INTO `part_secs` VALUES ('K4', 'K4非洲史', 'K');
INSERT INTO `part_secs` VALUES ('K5', 'K5欧洲史', 'K');
INSERT INTO `part_secs` VALUES ('K6', 'K6大洋州史', 'K');
INSERT INTO `part_secs` VALUES ('K7', 'K7美洲史', 'K');
INSERT INTO `part_secs` VALUES ('K81', 'K81传记', 'K');
INSERT INTO `part_secs` VALUES ('K85', 'K85文物考古', 'K');
INSERT INTO `part_secs` VALUES ('K89', 'K89风俗习惯', 'K');
INSERT INTO `part_secs` VALUES ('N0', 'N0自然科学理论与方法论', 'N');
INSERT INTO `part_secs` VALUES ('N1', 'N1自然科学概况、现状、进展', 'N');
INSERT INTO `part_secs` VALUES ('N2', 'N2自然科学机构、团体、会议', 'N');
INSERT INTO `part_secs` VALUES ('N3', 'N3自然科学研究方法', 'N');
INSERT INTO `part_secs` VALUES ('N4', 'N4自然科学教育与普及', 'N');
INSERT INTO `part_secs` VALUES ('N5', 'N5自然科学丛书、文集、连续性出版物', 'N');
INSERT INTO `part_secs` VALUES ('N6', 'N6自然科学参考工具书', 'N');
INSERT INTO `part_secs` VALUES ('N79', 'N79非书资料、视听资料', 'N');
INSERT INTO `part_secs` VALUES ('N8', 'N8自然科学调查、考察', 'N');
INSERT INTO `part_secs` VALUES ('N91', 'N91自然研究、自然历史', 'N');
INSERT INTO `part_secs` VALUES ('N93', 'N93非线性科学', 'N');
INSERT INTO `part_secs` VALUES ('N94', 'N94系统科学', 'N');
INSERT INTO `part_secs` VALUES ('O1', 'O1数学', 'O');
INSERT INTO `part_secs` VALUES ('O3', 'O3力学', 'O');
INSERT INTO `part_secs` VALUES ('O4', 'O4物理学', 'O');
INSERT INTO `part_secs` VALUES ('O6', 'O6化学', 'O');
INSERT INTO `part_secs` VALUES ('O7', 'O7晶体学', 'O');
INSERT INTO `part_secs` VALUES ('P1', 'P1天文学', 'P');
INSERT INTO `part_secs` VALUES ('P2', 'P2测绘学', 'P');
INSERT INTO `part_secs` VALUES ('P3', 'P3地球物理学', 'P');
INSERT INTO `part_secs` VALUES ('P4', 'P4大气科学（气象学）', 'P');
INSERT INTO `part_secs` VALUES ('P5', 'P5地质学', 'P');
INSERT INTO `part_secs` VALUES ('P7', 'P7海洋学', 'P');
INSERT INTO `part_secs` VALUES ('P9', 'P9自然地理学', 'P');
INSERT INTO `part_secs` VALUES ('Q1', 'Q1普通生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q2', 'Q2细胞生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q3', 'Q3遗传学', 'Q');
INSERT INTO `part_secs` VALUES ('Q4', 'Q4生理学', 'Q');
INSERT INTO `part_secs` VALUES ('Q5', 'Q5生物化学', 'Q');
INSERT INTO `part_secs` VALUES ('Q6', 'Q6生物物理学', 'Q');
INSERT INTO `part_secs` VALUES ('Q7', 'Q7分子生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q81', 'Q81生物工程学（生物技术）', 'Q');
INSERT INTO `part_secs` VALUES ('Q89', 'Q89环境生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q91', 'Q91古生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q93', 'Q93微生物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q94', 'Q94植物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q95', 'Q95动物学', 'Q');
INSERT INTO `part_secs` VALUES ('Q96', 'Q96昆虫学', 'Q');
INSERT INTO `part_secs` VALUES ('Q98', 'Q98人类学', 'Q');
INSERT INTO `part_secs` VALUES ('R1', 'R1预防医学、卫生学', 'R');
INSERT INTO `part_secs` VALUES ('R2', 'R2中国医学', 'R');
INSERT INTO `part_secs` VALUES ('R3', 'R3基础医学', 'R');
INSERT INTO `part_secs` VALUES ('R4', 'R4临床医学', 'R');
INSERT INTO `part_secs` VALUES ('R5', 'R5内科学', 'R');
INSERT INTO `part_secs` VALUES ('R6', 'R6外科学', 'R');
INSERT INTO `part_secs` VALUES ('R71', 'R71妇产科学', 'R');
INSERT INTO `part_secs` VALUES ('R72', 'R72儿科学', 'R');
INSERT INTO `part_secs` VALUES ('R73', 'R73肿瘤学', 'R');
INSERT INTO `part_secs` VALUES ('R74', 'R74神经病学与精神病学', 'R');
INSERT INTO `part_secs` VALUES ('R75', 'R75皮肤病学与性病学', 'R');
INSERT INTO `part_secs` VALUES ('R76', 'R76耳鼻咽喉科学', 'R');
INSERT INTO `part_secs` VALUES ('R77', 'R77眼科学', 'R');
INSERT INTO `part_secs` VALUES ('R78', 'R78口腔科学', 'R');
INSERT INTO `part_secs` VALUES ('R79', 'R79外国民族医学', 'R');
INSERT INTO `part_secs` VALUES ('R8', 'R8特种医学', 'R');
INSERT INTO `part_secs` VALUES ('R9', 'R9药学', 'R');
INSERT INTO `part_secs` VALUES ('S1', 'S1农业基础科学', 'S');
INSERT INTO `part_secs` VALUES ('S2', 'S2农业工程', 'S');
INSERT INTO `part_secs` VALUES ('S3', 'S3农学（农艺学）', 'S');
INSERT INTO `part_secs` VALUES ('S4', 'S4植物保护', 'S');
INSERT INTO `part_secs` VALUES ('S5', 'S5农作物', 'S');
INSERT INTO `part_secs` VALUES ('S6', 'S6园艺', 'S');
INSERT INTO `part_secs` VALUES ('S7', 'S7林业', 'S');
INSERT INTO `part_secs` VALUES ('S8', 'S8畜牧、 动物医学、狩猎、蚕、蜂', 'S');
INSERT INTO `part_secs` VALUES ('S9', 'S9水产、渔业', 'S');
INSERT INTO `part_secs` VALUES ('TB', 'TB一般工业技术', 'T');
INSERT INTO `part_secs` VALUES ('TD', 'TD矿业工程', 'T');
INSERT INTO `part_secs` VALUES ('TE', 'TE石油、天然气工业', 'T');
INSERT INTO `part_secs` VALUES ('TF', 'TF冶金工业', 'T');
INSERT INTO `part_secs` VALUES ('TG', 'TG金属学与金属工艺', 'T');
INSERT INTO `part_secs` VALUES ('TH', 'TH机械、仪表工业', 'T');
INSERT INTO `part_secs` VALUES ('TJ', 'TJ武器工业', 'T');
INSERT INTO `part_secs` VALUES ('TK', 'TK能源与动力工程', 'T');
INSERT INTO `part_secs` VALUES ('TL', 'TL原子能技术', 'T');
INSERT INTO `part_secs` VALUES ('TM', 'TM电工技术', 'T');
INSERT INTO `part_secs` VALUES ('TN', 'TN电子技术、通信技术', 'T');
INSERT INTO `part_secs` VALUES ('TP', 'TP自动化技术、计算机技术', 'T');
INSERT INTO `part_secs` VALUES ('TQ', 'TQ化学工业', 'T');
INSERT INTO `part_secs` VALUES ('TS', 'TS轻工业、手工业、生活服务业', 'T');
INSERT INTO `part_secs` VALUES ('TU', 'TU建筑科学', 'T');
INSERT INTO `part_secs` VALUES ('TV', 'TV水利工程', 'T');
INSERT INTO `part_secs` VALUES ('U1', 'U1综合运输', 'U');
INSERT INTO `part_secs` VALUES ('U2', 'U2铁路运输', 'U');
INSERT INTO `part_secs` VALUES ('U4', 'U4公路运输', 'U');
INSERT INTO `part_secs` VALUES ('U6', 'U6水路运输', 'U');
INSERT INTO `part_secs` VALUES ('V1', 'V1航空、航天技术的研究与探索', 'V');
INSERT INTO `part_secs` VALUES ('V2', 'V2航空', 'V');
INSERT INTO `part_secs` VALUES ('V4', 'V4航天（宇宙航行）', 'V');
INSERT INTO `part_secs` VALUES ('X1', 'X1环境科学基础理论', 'X');
INSERT INTO `part_secs` VALUES ('X2', 'X2社会与环境', 'X');
INSERT INTO `part_secs` VALUES ('X3', 'X3环境保护管理', 'X');
INSERT INTO `part_secs` VALUES ('X4', 'X4灾害及其防治', 'X');
INSERT INTO `part_secs` VALUES ('X5', 'X5环境污染及其防治', 'X');
INSERT INTO `part_secs` VALUES ('X7', 'X7行业污染、废物处理与综合利用', 'X');
INSERT INTO `part_secs` VALUES ('X8', 'X8环境质量评价与环境监测', 'X');
INSERT INTO `part_secs` VALUES ('X9', 'X9安全科学', 'X');
INSERT INTO `part_secs` VALUES ('Z1', 'Z1丛书', 'Z');
INSERT INTO `part_secs` VALUES ('Z2', 'Z2百科全书、类书', 'Z');
INSERT INTO `part_secs` VALUES ('Z3', 'Z3辞典', 'Z');
INSERT INTO `part_secs` VALUES ('Z4', 'Z4论文集、全集、选集、杂著', 'Z');
INSERT INTO `part_secs` VALUES ('Z5', 'Z5年鉴、年刊', 'Z');
INSERT INTO `part_secs` VALUES ('Z6', 'Z6期刊、连续性出版物', 'Z');
INSERT INTO `part_secs` VALUES ('Z8', 'Z8图书报刊目录、文摘、索引', 'Z');
INSERT INTO `part_secs` VALUES ('[N7]', '[N7]自然科学文献检索工具', 'N');
INSERT INTO `part_secs` VALUES ('[N99]', '[N99]情报学、情报工作', 'N');
INSERT INTO `part_secs` VALUES ('[U8]', '[U8]航空运输', 'U');
INSERT INTO `part_secs` VALUES ('[V7]', '[V7]航空、航天医学', 'V');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password_login` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `true_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `verify` int(11) NOT NULL DEFAULT 0,
  `school` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `integral` int(11) NULL DEFAULT NULL,
  `identity_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `article_num` int(11) NULL DEFAULT NULL,
  `obtain_like` int(255) NULL DEFAULT NULL,
  `credit` int(255) NULL DEFAULT NULL,
  `exp` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, '小牛', 'gefu1128', '陈格夫', 6, '沈阳航空航天大学', '计算机', 'lin_ksman@163.com', '15309869044', 200, '210122199911280319', 1, 0, 300, 1300);
INSERT INTO `users` VALUES (3, '小猫', 'gefu1128', '张君号', 1, '沈阳航空航天大学', '计算机', '1111@rr.com', '15640400506', 0, '210155444477778025', 0, 0, 100, 100);
INSERT INTO `users` VALUES (4, '虎斑猫', 'password', '张一', 1, '沈阳航空航天大学', '计算机', '3333@rr.com', '15402502585', 800, '121133331111222311', 0, 2, 900, 900);
INSERT INTO `users` VALUES (5, '河豚', 'password', '张一', 1, '沈阳航空航天大学', '计算机', '3333@rr.com', '15402501234', 0, '121133331111221111', 0, 1, 100, 100);
INSERT INTO `users` VALUES (6, '金丝雀', 'password', '张二', 1, '沈阳航空航天大学', '计算机', '4444@rr.com', '15402502233', 0, '121133331111222222', 0, 1, 100, 100);
INSERT INTO `users` VALUES (7, '海豚', 'password', '张三', 1, '沈阳航空航天大学', '计算机', '5555@rr.com', '15402504421', 0, '121133331111223333', 0, 2, 100, 100);
INSERT INTO `users` VALUES (8, '荷兰猪', 'password', '张四', 1, '沈阳航空航天大学', '计算机', '6666@rr.com', '15402501235', 0, '121133331111224444', 0, 0, 100, 100);
INSERT INTO `users` VALUES (9, '豹猫', 'password', '张五', 1, '沈阳航空航天大学', '计算机', '7777@rr.com', '15402506543', 0, '121133331111225555', 0, 0, 100, 100);
INSERT INTO `users` VALUES (10, '水牛', 'password', '张六', 1, '沈阳航空航天大学', '计算机', '8888@rr.com', '15402509876', 0, '121133331111226666', 0, 0, 100, 100);
INSERT INTO `users` VALUES (11, '河马', 'password', '张七', 0, '', '', '9999@rr.com', '15402509418', 10, '121133331111227777', 0, 0, 50, 0);
INSERT INTO `users` VALUES (13, '大牛', 'password', '李大牛', 0, '', '', 'lin@163.com', '15308889999', 0, '210122199912280489', 0, 0, 100, 0);
INSERT INTO `users` VALUES (14, '纯牛奶', 'password', '大牛', 0, '', '', 'llll@163.com', '15740400809', 0, '210122199912070809', 0, 0, 100, 0);
INSERT INTO `users` VALUES (15, '高钙奶', 'password', '山姆', 1, '沈阳航空航天大学', '计算机', 'zzz@111.com', '19555602145', 510, '214567558200143582', 0, 0, 600, 500);
INSERT INTO `users` VALUES (16, '加菲猫', 'password', '凯瑞根', 1, '沈阳航空航天大学', '计算机', 'rrr@111.com', '19555605682', 10, '214567558200141015', 0, 0, 100, 0);
INSERT INTO `users` VALUES (17, '可乐', 'password', '王飞贼', 1, '沈阳航空航天大学', '计算机', 'xxx@111.com', '19555600056', 10, '214567558200141014', 0, 0, 100, 0);
INSERT INTO `users` VALUES (18, '烤冷面', 'password', '白香肠', 1, '沈阳航空航天大学', '计算机', 'ttt@111.com', '19555600053', 10, '214567558200141013', 0, 0, 100, 0);
INSERT INTO `users` VALUES (19, '炸鸡柳', 'password', '山联丰', 1, '沈阳航空航天大学', '计算机', 'ggg@111.com', '19555600052', 10, '214567558200141012', 0, 0, 100, 0);
INSERT INTO `users` VALUES (20, '雀巢咖啡', 'password', '华润', 1, '沈阳航空航天大学', '计算机', 'ppp@111.com', '19555609909', 10, '214567558200141011', 0, 0, 100, 0);

SET FOREIGN_KEY_CHECKS = 1;
