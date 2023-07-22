import 'dart:io';

List<String> customer_names = ['customer1', 'customer2', 'customer3'];
List<String> customer_password = ['cus123', 'cus123', 'cus123'];

List<String> manager_names = ['manager1', 'manager2', 'manager3'];
List<String> manager_password = ['man123', 'man@123', 'man@123'];

List dishes = [
  {"name": "biryani", "price": 200},
  {"name": "qorma", "price": 200}
];

List customer_orders = [];
List feedback = [
  {"customer_name": '', "rating": ''}
];
// global user_name and password
String? global_user_name = '';
String? global_password = '';
// login verificataion status
String? login_verified = 'N';
// management options variable
String? man_options = '';
// key for login user to exit the program
String? program_exit = 'N';
void main() {
// login data

// program start variable if true then program remains continue
  var program_start = true;
// check login type if user is customer or management
  var login_type;
  var mang_options;

  print(customer_names.contains('customer1'));

  while (program_start == true) {
    print('Welcome to Restaurant System... Please login with your account');
    print('Please Press 1 for management account login');
    print('Please Press 2 for customer account login');
    print('Please Press any other key for exit');

    login_type = stdin.readLineSync();

    if (login_type == "1") // management login
    {
      print('welcome management');
      print('please enter your user name');
      global_user_name = stdin.readLineSync();
      print('please enter your password');
      global_password = stdin.readLineSync();
      management_login(global_user_name, global_password);

// if login_verified = Y , management options shown
      if (login_verified == 'Y') {
// program runs until user change program_exit variable = 'Y'
        while (program_exit == 'N') {
          print('Press 1 to Add Dishes');
          print('Press 2 to Delete Dishes');
          print('Press 3 to Update Dishes');
          print('Press 4 to View Dishes');

          print('Press X to exit');
          // user select choice to do operation work
          mang_options = stdin.readLineSync();
          // To add dishes
          if (mang_options == "1") {
            print('Please enter dish name');
            var dish_name = stdin.readLineSync();
            print('Please enter dish price');
            var dish_price = stdin.readLineSync();
            dishes.add({"name": dish_name, "price": dish_price});
            print('----------Your dishes List----------');
            print(dishes);
            print('-------------------------------------');
          }
          // To delete dishes

          else if (mang_options == "2") {
            print('Please enter dish name to remove');
            var dish_to_remove = stdin.readLineSync();
            dishes.removeWhere((item) => item['name'] == dish_to_remove);

            print('----------Your dishes List----------');
            print(dishes);
            print('-------------------------------------');
          } else if (mang_options == "4") {
            print('----------Your dishes List----------');
            print(dishes);
            print('-------------------------------------');
          }
          // to update dishes
          else if (mang_options == "3") {
            print('Pleae enter dish name to edit');
            var dish_to_search = stdin.readLineSync();
            print('Please enter dish new name');
            var dish_new_name = stdin.readLineSync();
            print('Please enter dish new price');
            var dish_new_price = stdin.readLineSync();
            for (var i = 0; i < dishes.length; i++) {
              print(dishes[i]);
              if (dishes[i]["name"] == dish_to_search) {
                dishes[i]["name"] = dish_new_name;
                dishes[i]["price"] = dish_new_price;
                print(dishes);
              }
            }
          } else if (mang_options == 'X') {
            program_exit = 'Y';
          }
        }
      }

      break;
    } // customer login
    else if (login_type == "2") {
      print('welcome customer');
      print('please enter your user name');
      global_user_name = stdin.readLineSync();
      print('please enter your password');
      global_password = stdin.readLineSync();
      customer_login(global_user_name, global_password);

      if (login_verified == 'Y') {
        while (program_exit == 'N') {
          print('Press 1 to see dishes');
          print('Press 2 to order dishes');
          print('Press 3 to edit your order');
          print('Press 4 for feedback');
          print('Press X for exit');

          mang_options = stdin.readLineSync();
          // to see the dishes
          if (mang_options == "1") {
            print('dishes detail');

            for (var i = 0; i < dishes.length; i++) {
              print(
                  '(${i + 1}) ${dishes[i]["name"]} price is ${dishes[i]["price"]}');
            }
          }
          // to orders dishes
          else if (mang_options == "2") {
            for (var i = 0; i < dishes.length; i++) {
              print(
                  'Press(${i + 1}) for ${dishes[i]["name"]} price is ${dishes[i]["price"]}');
            }

            var dish_select = int.parse(stdin.readLineSync()!);
            if (dish_select != 0) {
              var order_dish = dishes[dish_select - 1]["name"];
              var order_dish_price = dishes[dish_select - 1]["price"];
              customer_orders.add({
                "order_no": customer_orders.length + 1,
                "order_dish": order_dish,
                "order_price": order_dish_price
              });
              print('---------- Your order Details ----------');
              print(customer_orders);
              print('----------------------------------------');
            }
          }
          // to edit order
          else if (mang_options == "3") {
            print('Pleae order no to edit');
            var order_to_search = int.parse(stdin.readLineSync()!);

            for (var i = 0; i < customer_orders.length; i++) {
              if (customer_orders[i]["order_no"] == order_to_search) {
                print('your order details');
                print(customer_orders[i]);
                print('select dish to update your order');
                for (var j = 0; j < dishes.length; j++) {
                  print(
                      'Press ${j + 1} for ${dishes[j]["name"]}, price is ${dishes[j]["price"]} ');
                }
                var dish_to_update = int.parse(stdin.readLineSync()!);
                customer_orders[i]["order_no"] = order_to_search;
                customer_orders[i]["order_dish"] =
                    dishes[dish_to_update - 1]["name"];
                customer_orders[i]["order_price"] =
                    dishes[dish_to_update - 1]["price"];
                print('your new order is ');
                print(customer_orders[i]);
              }

// see dishes to customer
            }
          }
//for feedback
          else if (mang_options == "4") {
            print('Please enter your feedback rating from 1 to 5');
            var feedback_rating = stdin.readLineSync();
            feedback.add({
              "customer_name": "${global_user_name}",
              "rating": feedback_rating
            });
            print(feedback);
          }
          // exit
          else if (mang_options == 'X') {
            program_exit = 'Y';
          }
        }
      }

      // exit program
    } else {
      print('Exited');
      program_start = false;
    }
  }
}

// customer login verification

customer_login(global_user_name, global_password) {
  if (customer_names.contains(global_user_name) &&
      customer_password.contains(global_password)) {
    print('Welcome ${global_user_name} you are logged in ');
    login_verified = 'Y';
  } else {
    print('$global_user_name');
    print('$global_password');
    print('Invalid user name and password');
    login_verified = 'N';
  }
}

// management login verification

management_login(global_user_name, global_password) {
  if (manager_names.contains(global_user_name) &&
      manager_password.contains(global_password)) {
    print('Welcome ${global_user_name} you are logged in ');
    login_verified = 'Y';
  } else {
    print('$global_user_name');
    print('$global_password');
    print('Invalid user name and password');
    login_verified = 'N';
  }
}
