import { AppRegistry } from 'react-native';
import App from './App';



/**
 * 控制台打印语句可能会极大地拖累JavaScript线程
 */
if (!__DEV__) {
    console = {
      info: () => {},
      log: () => {},
      warn: () => {},
      error: () => {},
    };
}

import './app/NativeModule';


AppRegistry.registerComponent('EventDispatch', () => App);
