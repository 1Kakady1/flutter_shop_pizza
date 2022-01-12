import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:pizza_time/env.dart';
import 'package:pizza_time/helpers/loacation.dart';
import 'package:pizza_time/styles/colors.dart';

class CitySearch extends StatefulWidget {
  final String value;
  final void Function(MapBoxPlace value) onSetValue;
  final String? label;
  final String? hintText;
  final int? limit;
  final String? country;
  final bool? isIcon;
  final Color? color;
  final Color? iconColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final SnackBar Function(String msg)? snackbar;
  CitySearch(
      {Key? key,
      required this.value,
      required this.onSetValue,
      this.country,
      this.limit,
      this.label,
      this.scaffoldKey,
      this.snackbar,
      this.hintText,
      this.isIcon,
      this.iconColor,
      this.color})
      : super(key: key);

  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  late var _placesSearch;
  late TextEditingController _controller;
  List<MapBoxPlace> autocompleteList = [];
  bool isInit = false;
  bool isLoadGeo = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _placesSearch = PlacesSearch(
        apiKey: Env.MapboxApiKey,
        limit: widget.limit ?? 5,
        country: widget.country ?? "RU");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<MapBoxPlace>?> _getPlaces(String value) {
    Future<List<MapBoxPlace>?> searchList = _placesSearch.getPlaces(value);
    return searchList;
  }

  static String _displayStringForOption(MapBoxPlace option) =>
      option.text ?? "error name";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Autocomplete<MapBoxPlace>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.length >= 3 &&
                  widget.value != textEditingValue.text) {
                _getPlaces(textEditingValue.text).then((value) {
                  setState(() {
                    autocompleteList = value ?? [];
                  });
                });
              }

              if (textEditingValue.text == '' ||
                  widget.value == textEditingValue.text) {
                return const Iterable<MapBoxPlace>.empty();
              }
              return autocompleteList.map((item) => (item));
            },
            onSelected: (MapBoxPlace selection) {
              widget.onSetValue(selection);
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              Future.delayed(Duration.zero, () async {
                _init(fieldTextEditingController, widget.value);
              });

              return TextFormField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Please enter some text';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  icon: widget.isIcon == true
                      ? Icon(
                          Icons.map_outlined,
                          color: widget.color ?? AppColors.black,
                        )
                      : null,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(color: widget.color ?? AppColors.black),
                  errorStyle: TextStyle(color: widget.color ?? AppColors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.color ?? AppColors.black, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.color ?? AppColors.black),
                  ),
                  labelText: widget.label,
                  enabled: !isLoadGeo,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isLoadGeo = true;
                      });
                      _getAdressLoaction();
                    },
                    icon: isLoadGeo
                        ? SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.0, color: AppColors.red[200]))
                        : Icon(
                            Icons.add_location_alt_rounded,
                            color: widget.iconColor ??
                                widget.color ??
                                AppColors.black,
                          ),
                  ),
                ),
                style: TextStyle(color: widget.color ?? AppColors.black),
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<MapBoxPlace> onSelected,
                Iterable<MapBoxPlace> options) {
              final size = MediaQuery.of(context).size;
              return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      height: 300,
                      width: size.width -
                          140, // width - (margin contianer + padding container)
                      child: ListView.separated(
                        padding: EdgeInsets.all(10.0),
                        itemCount: options.length,
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.red[300],
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final MapBoxPlace option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(
                                  option.placeName ??
                                      option.text ??
                                      "error option",
                                  style:
                                      const TextStyle(color: AppColors.black)),
                            ),
                          );
                        },
                      ),
                    ),
                  ));
            }));
  }

  void _init(TextEditingController fieldTextEditingController, String value) {
    if (isInit == false) {
      fieldTextEditingController.text = value;
      setState(() {
        isInit = true;
      });
    }
  }

  Future<void> _getAdressLoaction() async {
    LocationHelper location = LocationHelper();
    await location.getCurrentLocation();
    if (location.error != "" && widget.snackbar != null) {
      ScaffoldMessenger.of(context).showSnackBar(widget
          .snackbar!("Проблемы с получением позиции. Поробуйте ручной поиск."));
    } else {
      var geoCodingService = ReverseGeoCoding(
        apiKey: Env.MapboxApiKey,
        country: widget.country ?? "RU",
        limit: widget.limit ?? 5,
      );
      try {
        await geoCodingService
            .getAddress(Location(
          lat: location.latitude,
          lng: location.longitude,
        ))
            .then((value) {
          if (value != null && value.length > 0) {
            _controller.text = value[0].placeName!;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(widget.snackbar!(
                "Проблемы с получением позиции. Поробуйте ручной поиск."));
          }
        });
        setState(() {
          isLoadGeo = false;
        });
      } catch (e) {
        if (widget.snackbar != null) {
          setState(() {
            isLoadGeo = true;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(widget.snackbar!("Error to find location user"));
        }
      }
    }
  }
}
