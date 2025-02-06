import 'package:flutter/material.dart';
import 'package:okuur/routes/profile/components/settings_push_button.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

Widget profileLoadingBox(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 12),
      Row(
        children: [
          const ShimmerBox(
            width: 82,
            height: 82,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              children: [
                ShimmerBox(
                  height: 10,
                ),
                SizedBox(height: 12),
                ShimmerBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          settingsPush(context)
        ],
      ),
      const SizedBox(height: 12),
      const ShimmerBox(height: 28),
      const SizedBox(height: 12,),
      const Row(
        children: [
          ShimmerBox(
            width: 98,
            height: 58,
          ),
          SizedBox(width: 12),
          ShimmerBox(
            width: 98,
            height: 58,
          ),
          SizedBox(width: 12),
          ShimmerBox(
            width: 98,
            height: 58,
          ),
        ],
      ),
      const SizedBox(height: 18),
      const ShimmerBox(
        height: 32,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      const SizedBox(height: 12),
      const ShimmerBox(
        height: 112,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      const SizedBox(height: 12),
      const ShimmerBox(
        height: 112,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      const SizedBox(height: 64,)
    ],
  );
}