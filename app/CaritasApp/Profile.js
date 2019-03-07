'use strict'
import React, {Component} from 'react';
import {Button,Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
class ProfileScreen extends React.Component {
  static navigationOptions = {
    title: 'Profile'
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
export default ProfileScreen;