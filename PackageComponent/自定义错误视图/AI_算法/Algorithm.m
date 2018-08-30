//
//  Algorithm.m
//  PackageComponent
//
//  Created by zrq on 2018/8/30.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm
/*
 折半查找（二分查找）
 */
int findKey(int *arr,int length,int key){
    int min = 0,max = length - 1,mid;
    while (min <= max) {
        mid = (min + max)/2;//计算中间值
        if(key > arr[mid]){
            min = mid + 1;
        }else if (key < arr[mid]){
            max = mid - 1;
        }else{
            return mid;
        }
    }
    return -1;
}
/*
 冒泡排序
 */
void buddleSort(int *arr,int length){
    for (int i = 0; i < length - 1; i++) {//趟数
        for (int j = 0; j < length - i - 1; j++) {//比较次数
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
/*
 选择排序
 */
void selectSort(int *arr,int length){
    for (int i = 0; i < length - 1; i++) {//趟数
        for (int j = i + 1; j < length; j++) {//比较次数
            if (arr[i] > arr[j]) {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }
}
/*
 求最大公约数
 */
int maxCommonDivisor(int a,int b){
    int max = 0;
    for (int i = 1; i<= b; i++) {
        if (a % i == 0&& b % i == 0) {
            max = i;
        }
    }
    return max;
}
/*
 交换两个数
 */
void swap1(int a,int b){
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
}
void swap0(int a,int b){
    a = a + b;
    b = a - b;
    a = a - b;
}
void swap(int a,int b){
    int temp = a;
    a = b;
    b = temp;
}
@end
