//RFIDPage

import React, {Component} from 'react';
import {FlatList, Button, Platform, StyleSheet, Text, View, Animated, Image, Easing, ScrollView} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
//import {SharedElement} from 'react-native-motion';

const styles = StyleSheet.create({
    ColScrollViewStyle:{
        flex:1,flexDirection: 'column'
    },
    ColNameStyle:{
        fontSize:20
    },
    ColButtonStyle:{
        fontWeight:'bold'
    },
    scrollViewStyle:{
        backgroundColor:'white',
        flex:1 , flexDirection:'row'
    }
});

export default class RFIDPage extends React.Component{
    static ColNum = 0;
    static ColData = [];
    RFIDPage(){
        
        this.ColData.push({id:0,Name:'Test',IconPath:'...'});
    }
    popCol(id){
        this.ColData.push({id:id,Name:'Name',IconPath:'...'});
    }
    rmCol(id){

    }
    static navigationOptions = {
        title: 'RFID Page'
      };
    onColSubmitPressed(id){
        this.rmCol(id);
    }
    renderAllCol(){
        let allCol = [];
        
        for(let i = 0; i< Object.keys(this.ColData).length;i++){
            allCol.push(
                <Animated.View ref= {String(this.ColData[i].id)}>
                    <ScrollView 
                        horizontal={false}
                        style={styles.ColScrollViewStyle}
                        pagingEnabled={false}>
                        <Image styles={styles.ColIconStyle}/>
                        <Text styles={styles.ColNameStyle}>{this.ColData[i].Name}</Text>
                        <Button styles={styles.ColButtonStyle} 
                            onPress={this.onColSubmitPressed(this.ColData[i].id).bind(this)}>Submit</Button>
                    </ScrollView>
                </Animated.View>
            );
        }
    }
    render(){
        const {navigate} = this.props.navigation;
        this.popCol(0);
        return(<View>
            <ScrollView ref = {"scrollView"}
                style={styles.scrollViewStyle}
                horizontal={true}
                showHorizontalScrollIndicator = {false}
                pagingEnabled={false}>
                {this.renderAllCol().bind(this)}
            </ScrollView>
        </View>);
        }
}