import { AppRegistry } from 'react-native';


import './app/NativeModule';

import App from './App';
import SendEvent from './app/pages/SendEvent';
import ReceiveEvent from './app/pages/ReceiveEvent';
import Emitter from  './app/pages/Emitter';



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


AppRegistry.registerComponent('EventDispatch', () => App);
AppRegistry.registerComponent('SendEvent', () => SendEvent);
AppRegistry.registerComponent('ReceiveEvent', () => ReceiveEvent);
AppRegistry.registerComponent('Emitter', () => Emitter);
