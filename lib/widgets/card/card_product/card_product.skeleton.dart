import 'package:flutter/material.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CardProductSkeleton extends StatelessWidget {
  CardProductSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 161,
              width: 325,
              child: SkeletonAnimation(
                shimmerColor: AppColors.red[200]!,
                borderRadius: BorderRadius.circular(20),
                shimmerDuration: 1000,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.red[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 10,
                        child: SkeletonAnimation(
                          shimmerColor: AppColors.red[200]!,
                          borderRadius: BorderRadius.circular(20),
                          shimmerDuration: 1000,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.red[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: 38,
                      height: 10,
                      child: SkeletonAnimation(
                        shimmerColor: AppColors.red[200]!,
                        borderRadius: BorderRadius.circular(20),
                        shimmerDuration: 1000,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.red[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 10,
                        child: SkeletonAnimation(
                          shimmerColor: AppColors.red[200]!,
                          borderRadius: BorderRadius.circular(20),
                          shimmerDuration: 1000,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.red[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: 38,
                      height: 10,
                      child: SkeletonAnimation(
                        shimmerColor: AppColors.red[200]!,
                        borderRadius: BorderRadius.circular(20),
                        shimmerDuration: 1000,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.red[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
