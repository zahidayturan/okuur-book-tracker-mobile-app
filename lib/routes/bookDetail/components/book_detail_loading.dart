import 'package:flutter/material.dart';
import 'package:okuur/ui/components/pop_button.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

Widget bookDetailLoadingBox(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 164,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                popButton(context),
                const SizedBox(height: 8),
                const ShimmerBox(
                    width: 100,
                    height: 20),
                const Spacer(),
                const ShimmerBox(
                    width: 180,
                    height: 32,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const ShimmerBox(
              width: 112,
              height: 164,
              borderRadius: BorderRadius.all(Radius.circular(24))),
        ],
      ),
      const SizedBox(height: 18),
      const ShimmerBox(
        height: 64,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      const SizedBox(height: 18,),
      const ShimmerBox(
        height: 47,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      const SizedBox(height: 18,),
      const ShimmerBox(
        height: 75,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      const SizedBox(height: 18,),
      const ShimmerBox(
        height: 195,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      const SizedBox(height: 18,)
    ],
  );
}