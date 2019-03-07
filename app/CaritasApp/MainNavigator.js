import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
import HomeScreen from './HomeScreen';
import ProfileScreen from './Profile';
import ThirdPage from './ThirdPage';
const MainNavigator = createStackNavigator({
  Home: {screen: HomeScreen},
  Profile: {screen: ProfileScreen},
  ThirdPage: {screen: ThirdPage}
});

export default MainNavigator;