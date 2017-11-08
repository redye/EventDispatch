/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TouchableWithoutFeedback,
  NativeModules
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

/**
 * 可以直接在这里导入原生 Module，更好的方法是
 * 将原生 Module 集中管理，这里将这些 Module 都绑定到一个全局变量 app 里面了
*/
// const EventHandler = NativeModules.EventHandler;

export default class App extends Component {

  _onPress = () => {
    console.log('改变导航的标题');
    
    // 可以关联某个页面
    app.EventHandler.handleEvent({
      "RootViewController": "你是我的小呀小苹果"
    });
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        
        <TouchableWithoutFeedback onPress={this._onPress}>
          <View style={styles.button}>
            <Text style={styles.welcome}>点我改变导航标题</Text>
          </View>
        </TouchableWithoutFeedback>
    
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  button: {
    margin: 20,
    backgroundColor: '#FF0'
  }
});
