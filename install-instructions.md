## How to Run the App Locally on a Mac

1. **Install Flutter:**
   - Follow the installation guide [here](https://docs.flutter.dev/get-started/install/macos/mobile-ios).
   - When asked to install a text editor, install Visual Studio Code since it's one of the easier IDEs

2. **Install Git:**
   - Open Terminal. You can find Terminal by searching for it in Spotlight (Cmd + Space, then type "Terminal" and hit Enter).
   - Type the following command and press Enter to check if Git is already installed:
     ```bash
     git --version
     ```
   - If you see a version number, Git is already installed. If you see a message that the command is not recognized, download and install Git from
     [here](https://git-scm.com/downloads).

     *Note:* When you are setting up Flutter, you'll be asked to download XCode, and it usually comes with Git installed. Otherwise, the installation can get a little complicated, since you
     first might need to install homebrew. If you are using Git for the first time, here is a good link: https://kbroman.org/github_tutorial/pages/first_time.html

3. **Clone the Repository:**
   - In Terminal, navigate to the directory where you want to clone the repository. For example, to navigate to the Downloads you can type:
     ```bash
     cd ~/Downloads
     ```
   - Clone the repository by typing the following command and pressing Enter:
     ```bash
     git clone https://github.com/JamshedK/Flutter-Training-PI
     ```

4. **Get the Necessary Dependencies:**
   - Open Visual Studio Code.
   - Open the folder containing the code by going to `File > Open Folder` and selecting the cloned repository folder.
   - Open a new Terminal in VS Code by going to `Terminal > New Terminal`.
   - In the Terminal, type the following command and press Enter to get all the necessary dependencies:
     ```bash
     flutter pub get
     ```

5. **Run the App:**
   - In the same Terminal in VS Code, type the following command and press Enter to run the app:
     ```bash
     flutter run
     ```

