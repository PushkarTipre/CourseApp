import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> quizData;
  final String? quizPdf;
  final String lessonName;

  const QuizScreen(
      {Key? key,
      required this.quizData,
      this.quizPdf,
      required this.lessonName})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late List<int?> _selectedAnswers;
  late List<bool?> _answerResults;
  bool _quizSubmitted = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize selected answers and result tracking
    _selectedAnswers = List.filled(widget.quizData.length, null);
    _answerResults = List.filled(widget.quizData.length, null);

    // Setup smooth animation for quiz elements
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuart,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectAnswer(int questionIndex, int answerKey) {
    if (!_quizSubmitted) {
      HapticFeedback.lightImpact();
      setState(() {
        _selectedAnswers[questionIndex] = answerKey;
      });
    }
  }

  void _submitQuiz() {
    // Check if all questions are answered
    if (_selectedAnswers.contains(null)) {
      _showCustomSnackBar(context,
          'Please answer all questions before submitting.', Colors.orange);
      return;
    }

    // Calculate answer results
    setState(() {
      for (int i = 0; i < widget.quizData.length; i++) {
        final correctAnswer = widget.quizData[i]['correct_answer'];
        _answerResults[i] = _selectedAnswers[i] == correctAnswer;
      }
      _quizSubmitted = true;
    });

    // Show results with a beautiful custom dialog
    _showResultsDialog();
  }

  void _showResultsDialog() {
    final score = _calculateScore();
    final totalQuestions = widget.quizData.length;
    final percentage = (score / totalQuestions) * 100;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FadeTransition(
        opacity: _animation,
        child: ScaleTransition(
          scale: _animation,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Quiz Results',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated score display
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 0, end: score.toDouble()),
                  builder: (context, value, child) => Text(
                    'Score: ${value.toInt()} / $totalQuestions',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: _getScoreColor(percentage),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Percentage: ${percentage.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage < 50) return Colors.red;
    if (percentage < 75) return Colors.orange;
    return Colors.green;
  }

  void _showInstructionsDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Instructions',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the quiz! Here are the instructions:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '1. Select the correct answer for each question.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '2. Once you have answered all questions, click the "Submit Quiz" button.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '3. Your score and feedback will be displayed.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Text(
                'Got it',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showCustomSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  int _calculateScore() {
    return _answerResults.where((result) => result == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.lessonName} Quiz',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            letterSpacing: 1.2,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade500,
                Colors.deepPurple.shade700,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade300.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.7),
              ),
              onPressed: () {
                _showInstructionsDialog();
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade100,
              Colors.deepPurple.shade200,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics:
                      const BouncingScrollPhysics(), // Smooth scroll behavior
                  padding: EdgeInsets.all(16.w),
                  itemCount: widget.quizData.length,
                  itemBuilder: (context, questionIndex) {
                    final question = widget.quizData[questionIndex];
                    final answers = question['answers'] as List<dynamic>;
                    final correctAnswer = question['correct_answer'];
                    final selectedAnswer = _selectedAnswers[questionIndex];

                    return AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) => Transform.scale(
                              scale: _animation.value,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Text(
                                        'Question ${questionIndex + 1}',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Text(
                                        question['question'].toString(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    ...List.generate(answers.length,
                                        (answerIndex) {
                                      final answerText = answers[answerIndex];
                                      final isSelected =
                                          selectedAnswer == answerIndex;
                                      final isCorrectAnswer =
                                          correctAnswer == answerIndex;

                                      // Determine the background color and border color
                                      Color backgroundColor =
                                          Colors.grey.shade100;
                                      Color borderColor = Colors.transparent;
                                      Color textColor = Colors.black87;
                                      Icon? resultIcon;

                                      if (_quizSubmitted) {
                                        if (isCorrectAnswer) {
                                          // Always highlight the correct answer in green
                                          backgroundColor =
                                              Colors.green.shade100;
                                          borderColor = Colors.green;
                                          textColor = Colors.green.shade900;
                                          resultIcon = Icon(Icons.check_circle,
                                              color: Colors.green);
                                        }

                                        if (isSelected &&
                                            selectedAnswer != correctAnswer) {
                                          // Highlight the user's incorrect selection in red
                                          backgroundColor = Colors.red.shade100;
                                          borderColor = Colors.red;
                                          textColor = Colors.red.shade900;
                                          resultIcon = Icon(Icons.cancel,
                                              color: Colors.red);
                                        }
                                      } else if (isSelected) {
                                        // Before submission, show selection in purple
                                        backgroundColor =
                                            Colors.purple.shade100;
                                        borderColor = Colors.purple;
                                        textColor = Colors.purple;
                                      }

                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 4.h),
                                        child: InkWell(
                                          onTap: () => _selectAnswer(
                                              questionIndex, answerIndex),
                                          child: Container(
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                    color: borderColor,
                                                    width: 2)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${answerIndex + 1}. ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    answerText,
                                                    style: TextStyle(
                                                      color: textColor,
                                                    ),
                                                  ),
                                                ),
                                                if (_quizSubmitted &&
                                                    resultIcon != null)
                                                  resultIcon
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ),
                            ));
                  },
                ),
              ),

              // Rest of the code remains the same as in the previous implementation

              Padding(
                padding: EdgeInsets.all(16.w),
                child: ElevatedButton(
                  onPressed: _submitQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: Size(double.infinity, 60.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Submit Quiz',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
  SizedBox(height: 10.h),
                        ...List.generate(answers.length, (answerIndex) {
                          final answerText = answers[answerIndex];
                          final isSelected = selectedAnswer == answerIndex;
                          final isCorrectAnswer = correctAnswer == answerIndex;

                          // Determine the background color and border color
                          Color backgroundColor = Colors.grey.shade100;
                          Color borderColor = Colors.transparent;
                          Color textColor = Colors.black87;
                          Icon? resultIcon;

                          if (_quizSubmitted) {
                            if (isCorrectAnswer) {
                              // Always highlight the correct answer in green
                              backgroundColor = Colors.green.shade100;
                              borderColor = Colors.green;
                              textColor = Colors.green.shade900;
                              resultIcon =
                                  Icon(Icons.check_circle, color: Colors.green);
                            }

                            if (isSelected && selectedAnswer != correctAnswer) {
                              // Highlight the user's incorrect selection in red
                              backgroundColor = Colors.red.shade100;
                              borderColor = Colors.red;
                              textColor = Colors.red.shade900;
                              resultIcon =
                                  Icon(Icons.cancel, color: Colors.red);
                            }
                          } else if (isSelected) {
                            // Before submission, show selection in purple
                            backgroundColor = Colors.purple.shade100;
                            borderColor = Colors.purple;
                            textColor = Colors.purple;
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 4.h),
                            child: InkWell(
                              onTap: () =>
                                  _selectAnswer(questionIndex, answerIndex),
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        color: borderColor, width: 2)),
                                child: Row(
                                  children: [
                                    Text(
                                      '${answerIndex + 1}. ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        answerText,
                                        style: TextStyle(
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    if (_quizSubmitted && resultIcon != null)
                                      resultIcon
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                },
              ),
            ),


**/
