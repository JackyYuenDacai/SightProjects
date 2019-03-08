//RFIDPage

import React, {Component} from 'react';
import {FlatList, Button, Platform, StyleSheet, Text, View} from 'react-native';
import {createStackNavigator, createAppContainer} from 'react-navigation';
import {SharedElement} from 'react-native-motion';

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
        ColData.push({id:0,Name:'Test',IconPath:'...'});
    }
    popCol(id){
        ColData.push({id:id,Name:'Name',IconPath:'...'});
    }
    rmCol(id){

    }
    static navigationOptions = {
        title: 'RFID Page'
      };
    onColSubmitPressed(id){

    }
    renderAllCol(){
        let allCol = [];
        for(let i = 0; i< ColData.length;i++){
            allCol.push(
                <Animated.View ref= {String(ColData[i].id)}>
                    <ScrollView 
                        horizontal={false}
                        style={styles.ColScrollViewStyle}
                        pagingEnabled={false}>
                        <Image styles={styles.ColIconStyle}/>
                        <Text styles={styles.ColNameStyle}>{ColData[i].Name}</Text>
                        <Button styles={styles.ColButtonStyle} 
                            onPress={onColSubmitPressed(ColData[i].id)}>Submit</Button>
                    </ScrollView>
                </Animated.View>
            );
        }
    }
    render(){
        return(<View>
            <ScrollView ref = {"scrollView"}
                style={styles.scrollViewStyle}
                horizontal={true}
                showHorizontalScrollIndicator = {false}
                pagingEnabled={false}>
                {this.renderAllCol()}
            </ScrollView>
        </View>);
        }
}