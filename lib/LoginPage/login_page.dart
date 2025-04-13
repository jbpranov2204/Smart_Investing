import 'package:flutter/material.dart';
import 'package:smart_investing/HomePage/home_page.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({super.key});

  @override
  _LoginPageWebState createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Color.fromARGB(
      255,
      33,
      55,
      95,
    ); // Green for finance theme
    final screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 960;

    return Scaffold(
      body: Row(
        children: [
          // Left Panel - Hero Section (Only visible on desktop)
          if (!isMobile)
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://source.unsplash.com/random/?finance,investment',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      accentColor.withOpacity(0.7),
                      BlendMode.overlay,
                    ),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to FinanceMate',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Your trusted partner for smarter investments and financial growth.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Right Panel - Login Form
          Expanded(
            flex: isMobile ? 1 : 4,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Welcome back! Manage your investments with ease.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 32),

                        // Email Field
                        _buildTextField(
                          controller: emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          icon: Icons.email_outlined,
                          accentColor: accentColor,
                        ),
                        SizedBox(height: 16),

                        // Password Field
                        _buildPasswordField(accentColor),
                        SizedBox(height: 8),

                        // Display Error Message
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        SizedBox(height: 8),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implement reset password functionality
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child:
                                isLoading
                                    ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      'Sign in',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Sign Up Link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implement sign-up functionality
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color accentColor,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: accentColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField(Color accentColor) {
    return TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock_outline, color: accentColor),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: accentColor,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
    );
  }
}
