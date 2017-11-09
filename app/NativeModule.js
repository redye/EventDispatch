
import {
    NativeModules
} from 'react-native';

window.app = {
    EventHandler: NativeModules.EventHandler,
    EventTower: NativeModules.EventTower,
}