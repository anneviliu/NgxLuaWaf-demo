// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueRouter from 'vue-router';
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import qs from 'qs'
import axios from "axios"
import Global from '../static/config/global'
import Home from './views/Home.vue'

Vue.prototype.GLOBAL = Global;
Vue.prototype.$axios = axios;
Vue.prototype.$qs = qs; 
Vue.use(ElementUI)
Vue.use(VueRouter);

Vue.config.productionTip = false

/* eslint-disable no-new */


new Vue({
  render: h => h(App),
  router: router,
}).$mount('#app')
