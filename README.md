# Kamca

## Details:

<details><summary>This repository was created as a means to create the Kamca app, which was part of a Cakrawala University's asiggnment to me as a student, particularly in the program of Mobile Computing; lead by the lecturer Proffesor Aldrich Sancho Sapata Negara.</summary>

<details>
  <summary>Log In.</summary>


  ### Kamca Kats image as the background:

    ```
        @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
        final rectangleWidth = size.width * 0.8;
        final rectangleHeight = size.height * 0.5; 
        final inputFontSize = 10.0;
        final buttonFontSize = 10.0;

        return Scaffold(
        body: Stack(
            children: [
            // background image fills the screen
            Container(
                decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/KamcaKats.png'),
                    fit: BoxFit.cover,
                ),
                ),
            ),
    ```
#### Note: the final seen at the top is meant for other sections of the project. Kamca Kats image is also responsive to many different device sizes.

### Kamca Logo:

    ```
    Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/KamcaLogo.png',
                            width: rectangleWidth * 0.5, height: rectangleHeight * 0.5),
                      ),
                    ),
                  ),
                ),
    ```
#### Note: This is made custom for log in page only, and was not an asset made for other pages. 

### Main Liquid Glass Container where all log in UI/UX is put in:

    ```
    Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: size.width * 1,
                        height: size.height * 0.55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 126, 145, 134).withOpacity(0.02),
                              const Color.fromARGB(255, 169, 193, 184).withOpacity(0.02),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
    ```
#### Note: This is made responsive to make sure it will always have the width of the entire screen alongside a height that covers 55% of any devices.

### Decorative Liguid Glass Container seen at the top:

    ```
    child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: rectangleHeight * 0.069,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 34, 60, 42).withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.35),
                                    width: 1.5,
                                  ),
                                ),
                              ),
    ```
#### Note: An important decor piece made to make sure that the main liquid glass container look like it has cat ears, cats being the main animal mascot(s) for Kamca's brand, second being snakes.

### Username Field:

    ```
    const SizedBox(height: 24),
    Padding(
    padding: EdgeInsets.zero,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 16,
                offset: const Offset(0, 6),
                ),
            ],
            ),
            child: SizedBox(
            width: rectangleWidth * 1,
            height: 35,
            child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 93, 93, 93), fontSize: inputFontSize),
                decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(color: const Color.fromARGB(179, 82, 82, 82), fontSize: inputFontSize),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                ),
                ),
            ),
            ),
        ),
    ```
#### Note: Where users will be putting their usernames in.

### Password Field:

    ```
    const SizedBox(height: 16),
    Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
            BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 10),
            ),
        ],
        ),
        child: SizedBox(
        width: rectangleWidth * 1,
        height: 35,
        child: TextField(
            obscureText: true,
            style: TextStyle(color: const Color.fromARGB(255, 93, 93, 93), fontSize: inputFontSize),
            decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: const Color.fromARGB(179, 88, 88, 88), fontSize: inputFontSize),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
            ),
            ),
        ),
        ),
    ),
    ```
#### Note: Same concept as 'Username Field', the core difference is that this has the line 'obscureText: true,' which is meant to turn text into dots for privacy and security reasons.

### Sign In Button:

    ```
    const SizedBox(height: 24),
    SizedBox(
        width: rectangleWidth * 0.85,
        height: 25,
        child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 220, 192, 187),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            ),
            textStyle: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w600),
        ),
        child: const Text(
            'Sign In',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        ),
    ),
    ```
#### Note: Does not have any funtionality yet, currently just have a UI indicator when someone has clicked it.

### Decorative "Or" seperator:

    ```
    const SizedBox(height: 16),
    Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Container(
            height: 1.0,
            width: rectangleWidth * 0.4,
            color: const Color.fromARGB(179, 255, 255, 255),
            ),
            const SizedBox(width: 10),
            const Text(
            'Or',
            style: TextStyle(
                color: Color.fromARGB(179, 255, 255, 255),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
            ),
            ),
            const SizedBox(width: 10),
            Container(
            height: 1.0,
            width: rectangleWidth * 0.4,
            color: const Color.fromARGB(179, 255, 255, 255),
            ),
        ],
        ),
    ),
    ```
#### Note: Does not have any funtionality beyond seperating sign in are with alternative sign in area, it uses rectangles with partically no height to create the illusion of it being a line.

### Asset Component for Alternative Sign In:

    ```
    Widget socialIcon(String assetPath, {double size = 48}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
    ```
#### Note: Does not have any funtionality yet, it is just used to stylize the alternative sign in icons.

### Asset Component for Alternative Sign In:

    ```
    const SizedBox(height: 18),
    Wrap(
        alignment: WrapAlignment.center,
        spacing: 23,
        runSpacing: 12,
        children: [
        socialIcon('assets/KamcaApple.png', size: 50),
        socialIcon('assets/KamcaGmail.png', size: 50),
        socialIcon('assets/KamcaInstagram.png', size: 50),
        socialIcon('assets/KamcaWhatsapp.png', size: 50),
        ],
    ),
    const SizedBox(height: 18),
    ```
#### Note: Does not have any funtionality yet, it is currently just icons.

### Container of "Create new account":

    ```
    Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: Container(
        width: size.width * 1,
        height: size.height * 0.06,
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
            padding: const EdgeInsets.only(bottom: 7),
            width: size.width * 1,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 34, 60, 42).withOpacity(0.3),
                border: Border.all(color: Colors.white.withOpacity(0.28), width: 1.2),
            ),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text.rich(
                TextSpan(
                    text: 'Need an Account? ',
                    style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    ),
                    children: [
                    TextSpan(
                        text: 'Create one here.',
                        style: const TextStyle(
                        color: Color.fromARGB(255, 187, 239, 211),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        ),
                    ),
                    ],
                ),
                textAlign: TextAlign.center,
                ),
            ),
            ),
        ),
        ),
    ),
    ),
    ```
#### Note: Does not have any funtionality yet, it is currently just container and text that sits at the bottom of the screen.

</details>
</details>