// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picture_app/consts/app_text_style.dart';
import 'package:picture_app/consts/endpoints.dart';

import 'package:picture_app/dto/picture_entity.dart';

class DetailsScreen extends StatelessWidget {
  final PictureEntity picture;

  const DetailsScreen({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height;
    final double itemWidth = size.width;

    String? name = picture.name;
    String? description = picture.description;
    //date
    String? dateCreation = picture.dateCreate;
    var parsedDate = DateTime.parse(dateCreation!);
    var day = parsedDate.day;
    var year = parsedDate.year;
    var month = DateFormat('MMMM').format(DateTime(0, parsedDate.month));

    String? user = picture.user;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: itemHeight * 0.35,
            width: itemWidth,
            child: FadeInImage(
              image: NetworkImage(picture.image.getUrl()),
              placeholder: const AssetImage(Endpoint.placeholderImage),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name != null)
                  Text(
                    name,
                    style: AppStyles.nameTextStyle,
                  ),
                SizedBox(height: itemHeight * 0.008),
                const Text(
                  'user',
                  style: AppStyles.userTextStyle,
                ),
                SizedBox(height: itemHeight * 0.026),
                Text(
                  description ?? 'description',
                  style: AppStyles.descriptionTextStyle,
                ),
                SizedBox(height: itemHeight * 0.017),
                const Text('#tags'),
                SizedBox(height: itemHeight * 0.024),
                Text(
                  '$day $month $year ',
                  style: AppStyles.dateTextStyle,
                ),
                SizedBox(height: itemHeight * 0.008),
                const Row(
                  children: [
                    Text(
                      'Views: ',
                      style: AppStyles.viewsTextStyle,
                    ),
                    Text(
                      '999+',
                      style: AppStyles.countViewsTextStyle,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
