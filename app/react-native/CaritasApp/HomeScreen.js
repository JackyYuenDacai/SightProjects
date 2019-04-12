
import React, {Component} from 'react';
import {FlatList, Button, Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Welcome'
  };
  
  HomeScreen(){

  }
  drawSeperator(){
    return(<View style={{height: 50, width: 2, backgroundColor: 'black'}}/>);
  }
  _renderItem = ({item})=>(
    <Text style={{fontSize: 20, textAlign: 'center'}}>{item.num}</Text>
  );
  _keyExtractor = (item, index) => item.id;
  render() {
    const {navigate} = this.props.navigation;
    let data=[];
    for (let i = 0; i < 100; i++) {
        data.push({key: i, num: i});
        }
    return (
        <View style={{flex:1}}>
            <Button
                title="Go to Jane's profile"
                onPress={() => navigate('Profile', {name: 'Jane'})}
            />
            <FlatList   
             
                data={data}
                ItemSeparatorComponent={this.drawSeperator}
                horizontal={true}
                keyExtractor={this._keyExtractor}
                renderItem={({item})=>(
                    <Text style={{fontSize: 20, textAlign: 'center'}}>{item.num}</Text>
                  )}
            />
        </View>
    );
  }
}
export default HomeScreen;