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


export default class Emiiter extends Component {

  constructor(props) {
    super(props);
  }

  _onPress = () => {
    console.log('改变上个页面的标题');
    
    DeviceEventEmitter.emit("TitleWillChangEmitter", {
        title: '短发短发姑娘'
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
            <Text style={styles.welcome}>点我发送通知</Text>
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
