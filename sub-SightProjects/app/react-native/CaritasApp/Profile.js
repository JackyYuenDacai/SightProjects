
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
        title="Go to ThirdPage"
        onPress={() => navigate('ThirdPage', {name: 'Jane'})}
      />
    );
  }
}
export default ProfileScreen;