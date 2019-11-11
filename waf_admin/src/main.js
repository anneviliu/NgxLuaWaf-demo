// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
<<<<<<< HEAD
import VueRouter from 'vue-router';
=======
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import qs from 'qs'
import axios from "axios"
import Global from '../static/config/global'
<<<<<<< HEAD
import Home from './views/Home.vue'
=======
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf

Vue.prototype.GLOBAL = Global;
Vue.prototype.$axios = axios;
Vue.prototype.$qs = qs; 
Vue.use(ElementUI)
<<<<<<< HEAD
Vue.use(VueRouter);

Vue.config.productionTip = false

/* eslint-disable no-new */


=======
Vue.config.productionTip = false

/* eslint-disable no-new */
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
new Vue({
  render: h => h(App),
  router: router,
}).$mount('#app')
