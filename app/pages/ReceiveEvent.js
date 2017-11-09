import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TouchableWithoutFeedback,
  NativeModules,
  NativeEventEmitter
} from 'react-native';

// 初始化一个订阅者
const subscription = new NativeEventEmitter(app.EventTower);

export default class ReceiveEvent extends Component {

  constructor(props) {
    super(props);

    this.state = {
      count: 0
    }
  }

  // 监听事件
  _addListener = () => {
    this.remoteEmitter = subscription.addListener('remotePushDidReceivedEmitter', (userInfo) => {
      console.log('接收到从原生发来的通知 ==>', userInfo);
      let count = this.state.count + 1;
      this.setState({
        count: count
      });
    });
  }

  // 移除监听
  _removeListener = () => {
    console.log('移除监听');
    // 移除方式有多种
    // this.remoteEmitter && this.remoteEmitter.remove();

    // subscription.removeAllListeners("remotePushDidReceivedEmitter");

    subscription.removeListener('removeListener', this.remoteEmitter);

  }


  componentDidMount() {
    this._addListener();
  }

  componentWillUnmount() {
    this._removeListener()
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        
        
        <View style={styles.button}>
          <Text style={styles.welcome}>当前次数{this.state.count}</Text>
        </View>

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
