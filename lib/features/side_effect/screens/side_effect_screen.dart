import 'package:flutter/material.dart';

class SideEffectScreen extends StatelessWidget {
  const SideEffectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * .45,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 30,
                      // to shift little up
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFFa995ec),
                              Color(0xFF878cff),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      height: 200,
                      left: 10,
                      right: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 12),
                          color: const Color(0xFFf5f5d7),
                          child: Column(
                            children: [
                              const Text(
                                "Omega 3 , Usage and Side Effects",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 21,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Take this medication after meals or before meals ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                          "assets/images/medcin_icon.png",
                                          width: 50,
                                          height: 70),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              _buildInfoSection("title", "content"),
              _buildInfoSection("title", "content"),
              _buildInfoSection("title", "content"),
              SizedBox(height: constraints.maxHeight * .10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 56)),
                    child: const Text(
                      "Report Side Effect",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      // Hide divider line by setting shape and collapsedShape with no borders
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.transparent),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.transparent),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
