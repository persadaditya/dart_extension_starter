/*
Copyright (c) 2022 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/meal_type_dialog.dart';
import '../utils/string_case_converter.dart';
import 'counter.dart';

enum MealType {
  wet,
  dry,
}

extension MealTypeExt on MealType{

  int value(){
    switch(this){
      case MealType.wet:
        return 0;
      case MealType.dry:
        return 1;
    }
  }
}


enum Gender {
  man,
  woman
}

class MealInfo extends StatefulWidget {
  final MealType mealType;
  final Function(double) onRatioChanged;

  const MealInfo({
    super.key,
    required this.mealType,
    required this.onRatioChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return _MealInfoState();
  }
}

class _MealInfoState extends State<MealInfo> {
  final TextEditingController _controller = TextEditingController(text: '70');
  int _catWeight = 4;
  int _quantity = 70;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _title(),
        const SizedBox(height: 20),
        Image.asset('assets/${widget.mealType.name}_food.png',
            width: 100, height: 100),
      ]),
      const SizedBox(width: 20),
      Column(children: [
        Column(
          children: [
            Counter(
              baseCounter: 4,
              onCounterUpdated: (count) {
                _catWeight = count;
                widget.onRatioChanged(_quantity / _catWeight);
              },
              suffix: 'kg',
              title: 'For a cat of',
            ),
            SizedBox(
              width: 200,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'They should eat',
                      hintText: '70',
                      suffixText: 'g per day',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (newVal) {
                      _quantity = int.parse(newVal);
                      widget.onRatioChanged(_quantity / _catWeight);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: ()=> widget.mealType.infoPopup(context),
                  splashRadius: 16,
                  icon: const Icon(
                    Icons.info,
                    color: Colors.black87,
                  ),
                )
              ]),
            ),
          ],
        )
      ]),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _title() {
    final foodType = widget.mealType.name.firstLetterUppercase();

    return Text(
      '$foodType food',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget anotherWidget(){
    return Container();
  }
}
