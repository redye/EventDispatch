import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TouchableWithoutFeedback,
  NativeModules,
  DeviceEventEmitter
} from 'react-native';

/**
 * 可以直接在这里导入原生 Module，更好的方法是
 * 将原生 Module 集中管理，这里将这些 Module 都绑定到一个全局变量 app 里面了
*/
// const EventHandler = NativeModules.EventHandler;

export default class SendEvent extends Component {

  constructor(props) {
    super(props);
  }

  _onPress = (event, title='小苹果') => {
    console.log('改变导航的标题');
    // 可以关联某个页面
    app.EventHandler.handleEvent({
      "JSViewController": title
    }, (response) => {
      console.log('回调结果 =====>', response);
    });
  }

  _addListener = () => {
    // 接收 JS 通知
    this.subscription = DeviceEventEmitter.addListener("TitleWillChangEmitter", (userInfo) => {
      console.log('接收到来自 JS 的通知======>', userInfo);
      this._onPress(null, userInfo.title ? userInfo.title : "小跳蛙");
    });
  }

  _removeListener = () => {
    console.log('移除监听');
    this.subscription && this.subscription.remove();
  }

  componentDidMount() {
    this._addListener();
  }

  componentWillUnmount() {
    this._removeListener();
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
