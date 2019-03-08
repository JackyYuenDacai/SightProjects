//ManPage

import React, {Component} from 'react';
import {FlatList, Button, Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
export default class ManPage extends React.Component{
    static navigationOptions = {
        title: 'Manuel Page'
      };
    render(){
        const {navigate} = this.props.navigation;
        return(<View>
        </View>);
    }
}