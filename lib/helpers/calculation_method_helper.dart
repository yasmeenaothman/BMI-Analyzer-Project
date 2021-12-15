import 'dart:math';

import 'package:bmi_project/modles/bmi_status.dart';
import 'package:bmi_project/modles/user_data.dart';
import 'package:bmi_project/modules/auth_pages/complete_info/complete_info_page.dart';
import 'package:easy_localization/easy_localization.dart';

class CalculationMethodHelper{
  static final String lC = 'littleChanges'.tr();
  static final String sG = 'stillGood'.tr();
  static final String gA = 'stillGood'.tr();
  static final String bC = 'beCareful'.tr();
  static final String sB = 'soBad'.tr();
  static final String underweight = 'underWeight'.tr();
  static final String normal = 'normal'.tr();
  static final String overweight = 'overweight'.tr();
  static final String obesity = 'obesity'.tr();
  static double calculateBMIValue(UserData user,double weight,double height){
    double percentage;
    int age = DateTime.now().year - DateFormat("yyyy").parseStrict(user.dateOfBirth).year;
    if(age>=2 && age<=10){
      percentage = 0.7;
    }
    else if(age>10 && age<=20 && user.gender == Gender.male.toString()){
      percentage = 0.9;
    }
    else if(age>10 && age<=20 && user.gender == Gender.female.toString()){
      percentage = 0.8;
    }
    else if(age>20){
      percentage = 1;
    }
    return (weight/pow(height/100, 2))* percentage ;
  }
  static String calculateBMIStatus(UserData user,double weight,double height){
    String bmiStatus;
    double bmiValue = calculateBMIValue(user,weight,height);
    if(bmiValue < 18.5){
      bmiStatus = underweight;
    }
    if(bmiValue >= 18.5 && bmiValue< 25){
      bmiStatus = normal;
    }
    if(bmiValue >= 25 && bmiValue< 30){
      bmiStatus = overweight;
    }
    if(bmiValue >30){
      bmiStatus = obesity;
    }
    return bmiStatus;
  }
  static String changeStatus({BMIStatus currentStatus,List<BMIStatus> statuses,UserData userData}){
    /// reorder the code in this method
    String changeStatus ;
    double difference;
    ///current status
    double bmiValueCurrentStatus = calculateBMIValue(userData, currentStatus.weight, currentStatus.height);
    if(statuses.length>0){
      ///because the status list is reversed.
      BMIStatus beforeCurrentStatus = statuses.first;
      ///(before current)
      double bmiValueBeforeCurrentStatus = calculateBMIValue(userData,beforeCurrentStatus.weight,beforeCurrentStatus.height);
      difference = bmiValueCurrentStatus-bmiValueBeforeCurrentStatus;
    }
    else{
      difference = null;
    }
    print(' difference= $difference ');
    if(difference != null){
      if(difference<-1){
        if(currentStatus.status ==underweight){
          changeStatus = sB;
        }
        if(currentStatus.status ==normal){
          changeStatus = sB;
        }
        if(currentStatus.status ==overweight){
          changeStatus = bC;
        }
        if(currentStatus.status ==obesity){
          changeStatus = bC;
        }
      }
      else if(difference>=-1 && difference <-0.6){
        if(currentStatus.status ==underweight){
          changeStatus = sB;
        }
        if(currentStatus.status ==normal){
          changeStatus = bC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = gA;
        }
        if(currentStatus.status ==obesity){
          changeStatus = gA;
        }
      }
      else if(difference>=-0.6 && difference <-0.3){
        if(currentStatus.status ==underweight){
          changeStatus = sB;
        }
        if(currentStatus.status ==normal){
          changeStatus = bC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = sG;
        }
        if(currentStatus.status ==obesity){
          changeStatus = lC;
        }
      }
      else if(difference>=-0.3 && difference <0){
        if(currentStatus.status ==underweight){
          changeStatus = lC;
        }
        if(currentStatus.status ==normal){
          changeStatus = lC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = lC;
        }
        if(currentStatus.status ==obesity){
          changeStatus = lC;
        }
      }
      else if(difference>=0 && difference <0.3){
        if(currentStatus.status ==underweight){
          changeStatus = lC;
        }
        if(currentStatus.status ==normal){
          changeStatus = lC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = lC;
        }
        if(currentStatus.status ==obesity){
          changeStatus = bC;
        }
      }
      else if(difference>=0.3 && difference <0.6){
        if(currentStatus.status ==underweight){
          changeStatus = sG;
        }
        if(currentStatus.status ==normal){
          changeStatus = bC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = bC;
        }
        if(currentStatus.status ==obesity){
          changeStatus = sB;
        }
      }
      else if(difference>=0.6 && difference <1){
        if(currentStatus.status ==underweight){
          changeStatus = gA;
        }
        if(currentStatus.status ==normal){
          changeStatus = bC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = sB;
        }
        if(currentStatus.status ==obesity){
          changeStatus = sB;
        }
      }
      else if(difference>=1){
        if(currentStatus.status ==underweight){
          changeStatus = gA;
        }
        if(currentStatus.status ==normal){
          changeStatus = bC;
        }
        if(currentStatus.status ==overweight){
          changeStatus = sB;
        }
        if(currentStatus.status ==obesity){
          changeStatus = sB;
        }
      }
    }
    else{
      changeStatus = '';
    }
    print('changeStatus $changeStatus');
    return changeStatus;
  }
}