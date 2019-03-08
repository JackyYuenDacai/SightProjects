'use strict'
import React, {Component} from 'react';
import {Button,Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
class ThirdScreen extends React.Component {
  static navigationOptions = {
    title: 'Fist'
  };
  render() {
    const {navigate} = this.props.navigation;
    return (
      <Button
        title="Go to Jane's profile"
        onPress={() => navigate('Profile', {name: 'Jane'})}
      />
    );
  }
}
export default ThirdScreen;