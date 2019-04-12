import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
import HomeScreen from './HomeScreen';
import ProfileScreen from './Profile';
import ThirdPage from './ThirdPage';
import RFIDPage from './RFIDPage';
import ManPage from './ManPage';
const MainNavigator = createStackNavigator({
  Home:{screen:RFIDPage},
  ManPage:{screen:ManPage}
});

export default MainNavigator;