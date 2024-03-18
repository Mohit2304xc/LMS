import 'package:dummy1/Controller/Course/CourseController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Model/CategoryModel.dart';
import 'package:dummy1/Widgets/Course/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/CSFundamental',
      page: () => FutureBuilder<CourseModel>(
        future: CourseController.instance.fetchCourseById('8'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return CourseDetail(course: snapshot.data!);
          } else {
            return const Text('No data available');
          }
        },
      ),
    ),
    GetPage(
        name: '/deploywebsite',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('17'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
        name: '/AITools',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('1'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
        name: '/CorporateEmail',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('7'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
        name: '/DigitalMarketing',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('14'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
      name: '/Excel',
      page: () => FutureBuilder<CourseModel>(
        future: CourseController.instance.fetchCourseById('16'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return CourseDetail(course: snapshot.data!);
          } else {
            return const Text('No data available');
          }
        },
      ),
    ),
    GetPage(
      name: '/JavaInterview',
      page: () => FutureBuilder<CourseModel>(
        future: CourseController.instance.fetchCourseById('12'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return CourseDetail(course: snapshot.data!);
          } else {
            return const Text('No data available');
          }
        },
      ),
    ),
    GetPage(
        name: '/Javascript',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('15'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
        name: '/LearnCoding',
        page: () => FutureBuilder<CourseModel>(
          future: CourseController.instance.fetchCourseById('11'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return CourseDetail(course: snapshot.data!);
            } else {
              return const Text('No data available');
            }
          },
        ),
    ),
    GetPage(
      name: '/LinkedIn',
      page: () => FutureBuilder<CourseModel>(
        future: CourseController.instance.fetchCourseById('13'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.white,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return CourseDetail(course: snapshot.data!);
          } else {
            return const Text('No data available');
          }
        },
      ),
    ),
  ];
}

class DummyData {
  /*static final List<BannerModel> banners = [
    BannerModel(
        imageURL:
            'assets/images/featured/CS-Fundamental-Interview-Question-1.png',
        targetScreen: '/CSFundamental',
        active: true),
    BannerModel(
        imageURL:
            'assets/images/featured/Deploying-Your-website-For-Free-1.png',
        targetScreen: '/deploywebsite',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/AI-Tools-bbb.png',
        targetScreen: '/AITools',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/Corporate-email-1.png',
        targetScreen: '/CorporateEmail',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/Digital-Marketing-1.png',
        targetScreen: '/DigitalMarketing',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/Excel-For-Professionals-1.png',
        targetScreen: '/Excel',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/JAVA-Interview-Questions.png',
        targetScreen: '/JavaInterview',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/JAVASCRIPT-1.png',
        targetScreen: '/Javascript',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/Learn-Coding-1.png',
        targetScreen: '/LearnCoding',
        active: true),
    BannerModel(
        imageURL: 'assets/images/featured/paid/LinkedIn-cheet-Sheet.png',
        targetScreen: '/LinkedIn',
        active: true),
  ];*/

  /// 1 => SEO
  /// 2 => Cloud Computing
  /// 3 => Web Development
  /// 4 => Front end development
  /// 5 => Back end Development
  /// 6 => Programming
  static final List<CourseModel> courses = [
    CourseModel(
        id: '1',
        price: 30,
        title: 'AI TOOLS',
        thumbnail: 'assets/images/cloud/AI-Tools-bbb.png',
        salePrice: 15,
        categoryId: '2',
        description: "Introducing the future of innovation"
            "AI"
            "Tools\n – your digital sidekick for unparalleled productivity! Harness"
            'the power of artificial intelligence with our cutting-edge'
            'suite of tools that seamlessly blend science and artistry.'
            'Unleash your creativity as our AI-powered design assistant'
            'crafts stunning visuals, while'
            'our data wizards analyze information faster than the blink of'
            'an eye. Dive into the realm of intuitive decision'
            '-making with predictive analytics, and let AI supercharge'
            'your workflow.'
            'AI Tools isn’t just a product; it’s a revolution in your toolkit'
            '. Embrace the future today, where innovation meets imagination'
            'and precision meets playfulness. Elevate your projects, supercharge'
            'your ideas, and embrace the limitless possibilities of AI Tools!',
        isFeatured: false),
    CourseModel(
        id: '2',
        price: 15,
        title: 'API',
        thumbnail: 'assets/images/Webdevelopment/API-bb.png',
        salePrice: 10,
        categoryId: '3',
        description:
            "Introducing the API Overview: Your Gateway to Seamless Integration!"
            "Unlock the power of connectivity with our API Overview – the key to streamlined data exchange and unparalleled functionality. Say goodbye to siloed systems and hello to a world of possibilities.\n"
            "With our API Overview, you’ll effortlessly bridge the gap between your applications, enabling them to communicate seamlessly. It’s the digital handshake that sparks innovation and transforms your operations.\n"
            "Experience the simplicity of integration as you harness the potential of our API Overview. Whether you’re a tech aficionado or a novice, our user-friendly interface ensures a smooth journey towards enhanced productivity and efficiency.\n"
            "Don’t miss out on this opportunity to revolutionize your digital landscape. Embrace the API Overview and watch your possibilities unfold!\n",
        isFeatured: true),
    CourseModel(
        id: '3',
        price: 30,
        title: 'AWS',
        thumbnail: 'assets/images/Webdevelopment/aws.png',
        salePrice: 15,
        categoryId: '3',
        isFeatured: false),
    CourseModel(
        id: '4',
        price: 30,
        title: 'BOOTSTRAP',
        thumbnail: 'assets/images/Webdevelopment/Bootstrap-1.png',
        salePrice: 15,
        categoryId: '3',
        description:
            "Introducing Bootstrap, the design wizard’s secret weapon! Picture a magic toolbox brimming with style and functionality, that’s Bootstrap for you. This web framework sprinkles your projects with a dash of elegance and a pinch of responsive brilliance. It’s like having a personal design sorcerer at your fingertips, conjuring up sleek and captivating websites with ease."
            "Bootstrap’s enchanting grid system ensures your content dances gracefully across screens of all sizes, while its treasure trove of pre-designed components saves you from the tedious incantations of custom coding. From spellbinding typography to captivating forms, Bootstrap has your back."
            "But wait, there’s more! With Bootstrap’s versatile assortment of themes and CSS magic, you can wave your creative wand and transform your web creations into true digital masterpieces. Say goodbye to web design woes and embrace the enchantment of Bootstrap today!",
        isFeatured: true),
    CourseModel(
      id: '5',
      price: 20,
      title: 'C++',
      thumbnail: 'assets/images/Webdevelopment/C++/C.png',
      salePrice: 15,
      categoryId: '3',
      description:
          "Introducing C++ – the versatile programming language that powers countless applications across the digital landscape. C++ is a high-performance, general-purpose language known for its speed and efficiency. Whether you’re developing software, games, or system-level applications, C++ offers the power and flexibility to meet your needs."
          "With its rich set of libraries and support for both procedural and object-oriented programming paradigms, C++ empowers developers to create robust and scalable solutions. Its syntax is designed for ease of use and readability, making it accessible for both beginners and experienced programmers alike."
          "C++ is the go-to choice for those seeking high-performance computing, real-time systems, and resource-constrained environments. Join the ranks of developers who rely on C++ to build cutting-edge software solutions that push the boundaries of what’s possible. Explore the world of C++ and unlock a world of programming potential.",
      images: [
        "assets/images/Webdevelopment/C++/Screenshot-2023-09-14-164136.png",
        "assets/images/Webdevelopment/C++/Screenshot-2023-09-14-164153.png"
      ],
      isFeatured: true,
    ),
    CourseModel(
        id: '6',
        price: 30,
        title: 'COMPLETE SQL BASICS TO ADVANCE GUIDE',
        thumbnail: 'assets/images/Programming/sql-basic-to-advance.png',
        salePrice: 25,
        categoryId: '6',
        description:
            "Unlock the power of data with our “Complete SQL Basics To Advance Guide”! Dive into the world of structured query language and transform your data-handling skills from novice to pro. This comprehensive guide is your ticket to mastering SQL, whether you’re a curious beginner or a seasoned data enthusiast."
            "With easy-to-follow explanations and hands-on examples, you’ll journey through the fundamentals of SQL and seamlessly progress to advanced techniques. Learn how to harness the magic of databases, wield SQL queries like a wizard, and command data like never before. Whether you dream of becoming a data analyst, engineer, or simply want to supercharge your data management skills, this guide is your ultimate companion. Unleash your inner data maestro and conquer SQL with finesse today!",
        isFeatured: false),
    CourseModel(
        id: '7',
        price: 30,
        title: 'CORPORATE EMAILS',
        thumbnail: 'assets/images/cloud/Corporate-email-1.png',
        salePrice: 15,
        categoryId: '2',
        description:
            "Introducing Corporate Emails: Elevate your communication game to new heights! "
            "Say goodbye to the cluttered chaos of personal inboxes and step into the world of sleek and organized corporate emails. Our cutting-edge platform offers a seamless blend of professionalism and efficiency, designed to streamline your business communication."
            "With features like robust security, customizable branding, and effortless integration, Corporate Emails empowers your team to connect, collaborate, and conquer tasks like never before. Say hello to crystal-clear correspondence, schedule sync-ups with ease, and harness the power of a unified inbox."
            "Experience the future of business communication. Choose Corporate Emails and redefine the way you connect with the world. Elevate, collaborate, and communicate, all in one place. Welcome to the future of your inbox!",
        isFeatured: true),
    CourseModel(
        id: '8',
        price: 30,
        title: 'CS FUNDAMENTALS INTERVIEW QUESTIONS',
        salePrice: 0,
        thumbnail:
            'assets/images/featured/CS-Fundamental-Interview-Question-1.png',
        categoryId: '2',
        description:
            "Unlock your success in computer science interviews with our comprehensive PDF guide! Dive into essential CS fundamentals and master the most frequently asked interview questions. Equip yourself with the knowledge and confidence to land your dream tech job.",
        isFeatured: true),
    CourseModel(
        id: '9',
        price: 15,
        title: 'CSS',
        salePrice: 8,
        thumbnail: 'assets/images/cloud/CSS-3.png',
        categoryId: '2',
        description:
            "Introducing the Elegance Enhancer: CSS, your passport to the captivating world of web design! Imagine a virtual tailor for your websites, crafting pixel-perfect outfits with style and finesse. CSS, or Cascading Style Sheets, is the magic wand that brings life to your digital canvas. It’s the art of arranging colors, fonts, and layouts to create a symphony of visual harmony that dances gracefully across screens of all sizes. Whether you’re a web wizard or a coding novice, CSS empowers you to sculpt your online dreams into breathtaking reality. It’s the paintbrush to your website’s masterpiece, the spotlight to your content’s star, and the thread that weaves elegance into every corner of your online kingdom. Embrace CSS, and let your web creations turn heads and steal hearts!",
        isFeatured: false),
    CourseModel(
        id: '10',
        price: 10,
        title: 'CSS VOL-2',
        salePrice: 5,
        thumbnail: 'assets/images/cloud/CSS-VOL-2.png',
        categoryId: '2',
        description: "Introducing the Magic Weaver of Web Design: CSS!"
            "Imagine having the power to transform bland web pages into stunning visual masterpieces with just a sprinkle of code. That’s the enchantment of Cascading Style Sheets, or CSS!"
            "With CSS, you wield the brush that paints the digital canvas, effortlessly sculpting fonts, colors, and layouts to create captivating user experiences. Say goodbye to the dull and mundane; CSS lets you sculpt the very soul of your website, making it sing with personality and pizzazz."
            "Whether you’re a coding wizard or a design novice, CSS is your trusty wand, granting you the ability to craft responsive and stylish websites that captivate your audience. Unleash your creativity, wave that CSS wand, and watch your digital dreams come to life!",
        isFeatured: true),
    CourseModel(
        id: '11',
        price: 30,
        title: 'LEARN CODING',
        salePrice: 15,
        thumbnail: 'assets/images/Backend Development/Learn-Coding-1.png',
        categoryId: '5',
        description:
            "Unlock the digital realm’s secrets with “Learn Coding,” your gateway to a world of limitless possibilities! This innovative learning platform is your passport to mastering the language of the future. Dive into a captivating journey where lines of code transform into bridges to creativity, problem-solving, and endless opportunities."
            "With interactive modules and engaging challenges, “Learn Coding” makes the complex seem simple. From beginner to coding maestro, our user-friendly interface caters to all skill levels. Embrace the power to craft websites, design apps, and sculpt software with finesse."
            "Ignite your imagination, sculpt your dreams, and embark on a quest to redefine the digital landscape – all with “Learn Coding” by your side. Discover the magic of coding, and let your genius shine!",
        isFeatured: true),
    CourseModel(
        id: '12',
        price: 15,
        title: 'Java Interview Question',
        thumbnail: 'assets/images/featured/paid/JAVA-Interview-Questions.png',
        salePrice: 10,
        categoryId: '6',
        description:
            "“Unlock Your Java Success with Our Comprehensive Interview Question PDF!"
            "Are you preparing for a Java programming interview and looking for the perfect resource to boost your confidence and knowledge? Look no further! Our Java Interview Question PDF is a must-have for any aspiring Java developer."
            "Inside this carefully crafted PDF, you’ll find a curated selection of Java interview questions designed to test your skills and help you excel in your job interviews. Whether you’re a beginner or an experienced programmer, these questions cover a wide range of topics, including core Java concepts, object-oriented programming, data structures, algorithms, and more.\n"
            "Why Choose Our Java Interview Question PDF?\n"
            "1. Expertly crafted questions: Our questions are compiled by Java experts with years of industry experience, ensuring relevance and quality."
            "Comprehensive\n 2. Coverage: We cover a broad spectrum of Java topics, from basics to advanced, so you can be fully prepared for any interview.\n"
            "3. Detailed answers: Each question is accompanied by detailed explanations and solutions to help you understand the concepts thoroughly.\n"
            "4. Practice makes perfect: With these questions at your fingertips, you can practice and refine your Java skills, increasing your chances of landing your dream job.\n"
            "5. Convenient PDF format: Access your interview prep material anytime, anywhere, and on any device.\n"
            "Don’t miss this opportunity to supercharge your Java interview preparation. Invest in our Java Interview Question PDF today and embark on your journey to Java excellence!",
        isFeatured: true),
    CourseModel(
        id: '13',
        price: 30,
        title: 'Linked Cheat-Sheet',
        thumbnail: 'assets/images/featured/paid/LinkedIn-cheet-Sheet.png',
        salePrice: 15,
        categoryId: '5',
        description:
            "Introducing the LinkedIn Cheat Sheet – your passport to professional success in a digital world! This compact marvel is your secret weapon for navigating the labyrinth of LinkedIn with finesse. Packed with insider tips and tricks, it’s your shortcut to crafting an irresistible profile, expanding your network, and landing dream opportunities."
            "Unlock the power of personalized connections, learn to ace endorsements, and dazzle with standout content strategies. Whether you’re a networking novice or a seasoned pro, this cheat sheet is your turbocharged guide to making meaningful connections, showcasing your skills, and propelling your career to new heights."
            "Don’t get lost in the digital jungle; let the LinkedIn Cheat Sheet be your compass to success. Get ready to stand out, get noticed, and get ahead – all in the palm of your hand. Your professional destiny awaits!",
        isFeatured: true),
    CourseModel(
        id: '14',
        price: 15,
        title: 'Digital Marketing',
        thumbnail: 'assets/images/featured/paid/Digital-Marketing-1.png',
        salePrice: 10,
        categoryId: '1',
        images: [
          "assets/images/SEO/Digital Marketing extra images/Screenshot-2023-09-16-135301 (1).jpg",
          "assets/images/SEO/Digital Marketing extra images/Screenshot-2023-09-16-135322 (1).jpg"
        ],
        description:
            "Step into the boundless realm of Digital Marketing and watch your brand’s story unfold in vibrant pixels! This dynamic landscape is where art meets algorithm, weaving compelling narratives that resonate with the online world. Harness the power of SEO to climb the towering peaks of search rankings, dance through the social media jungles with viral-worthy content, and surf the waves of email campaigns that catch attention like a summer swell. Unleash precision-targeted ads that shoot like arrows, hitting the bulls-eye of your target audience. Digital Marketing is the enchanted tapestry where creativity, strategy, and technology converge, painting success across the digital canvas. Welcome to the future of marketing, where the possibilities are as infinite as the internet itself!",
        isFeatured: true),
    CourseModel(
        id: '15',
        price: 30,
        title: 'JavaScript',
        thumbnail: 'assets/images/Backend Development/JAVASCRIPT-1.png',
        salePrice: 15,
        categoryId: '5',
        description:
            "JavaScript, the wizard of web development, is your key to breathing life into static websites! With its enchanting power, this dynamic scripting language empowers developers to conjure up interactive, spellbinding user experiences. Unleash the magic of JavaScript to seamlessly validate forms, animate elements, and create dazzling web applications that captivate your audience. Its versatility knows no bounds – from crafting sleek, responsive designs to harnessing the might of APIs, JavaScript is the spellbook you need for crafting digital wonders. Join the ranks of web sorcerers and wield JavaScript to turn your visions into reality. Embrace the future of web development – it’s written in JavaScript!",
        isFeatured: true),
    CourseModel(
        id: '16',
        price: 30,
        title: 'Excel For Professionals',
        thumbnail: 'assets/images/featured/paid/Excel-For-Professionals-1.png',
        salePrice: 15,
        categoryId: '5',
        description:
            "Unlock the full potential of Excel with ‘Excel for Professionals,’ your passport to spreadsheet mastery. Elevate your data manipulation game and transform into a spreadsheet sorcerer with this comprehensive guide. Dive deep into advanced functions, data analysis, and automation techniques that will make your colleagues wonder if you have a secret Excel wand. From pivot tables that dance with your data to complex formulas that solve problems with a flick of the wrist, this book is your enchanted scroll. Whether you’re a financial wizard, data analyst, or project manager, ‘Excel for Professionals’ will empower you to wield Excel like never before. Be the Excel hero your office deserves!",
        isFeatured: true),
    CourseModel(
        id: '17',
        price: 30,
        title: 'Deploying Your Website For Free',
        thumbnail:
            'assets/images/featured/Deploying-Your-website-For-Free-1.png',
        salePrice: 0,
        categoryId: '3',
        images: [
          "assets/images/Backend Development/Deploywebsite extra images/Screenshot-2023-09-14-164924.jpg",
          "assets/images/Backend Development/Deploywebsite extra images/Screenshot-2023-09-14-164949.jpg"
        ],
        description:
            "Introducing our revolutionary service: “Deploy Your Website for Free!” With our user-friendly platform, you can effortlessly take your website live without breaking the bank. Say goodbye to expensive hosting fees and complex setups."
            "In just a few clicks, you can deploy your website to the world, reaching your audience in no time. We offer reliable and secure hosting, ensuring your site stays up and running 24/7. Plus, our intuitive interface makes managing your web content a breeze."
            "Whether you’re a seasoned web developer or a newbie, our free deployment service caters to all. Don’t wait any longer – unlock the potential of your online presence today, without spending a dime. Join us and experience the future of web deployment, where your website is just a click away from the world!",
        isFeatured: true),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1',
        image: 'assets/images/categories/download.jpeg',
        name: 'SEO',
        ),
    CategoryModel(
        id: '2',
        image: 'assets/images/categories/download.png',
        name: 'Cloud Computing',
        ),
    CategoryModel(
        id: '3',
        image: 'assets/images/categories/download (1).jpeg',
        name: 'Web Development',
        ),
    CategoryModel(
        id: '4',
        image: 'assets/images/categories/download (1).png',
        name: 'Front Development',
        ),
    CategoryModel(
        id: '5',
        image: 'assets/images/categories/download (4).jpeg',
        name: 'Back Development',
        ),
    CategoryModel(
        id: '6',
        image: 'assets/images/categories/download (3).jpeg',
        name: 'Programming',
        ),
  ];
}
