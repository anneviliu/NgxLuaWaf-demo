import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const router = new Router({
    routes: [
        {
            path: '/',
            name: 'Home',
            component: () => import('@/views/Home.vue'),
            meta: {
                isLogin: true
              }
        },

        {
            path: '/login',
            name: 'login',
            component: () => import('@/views/Login.vue'),
            meta: {
                isLogin: false
              }
        },

        {
            path: '/register',
            name: 'register',
            component: () => import('@/views/Register.vue'),
            meta: {
                isLogin: false
              }
        },

        {
            path: '/ip',
            name: 'IpOpreation',
            component: () => import('@/views/IpOpreation.vue'),
            meta: {
                isLogin: true
              }
        },

        {
            path: '/about',
            name: 'about',
            component: () => import('@/views/about.vue'),
            meta: {
                isLogin: true
              }
        },

    ]
})

router.beforeEach((to, from, next) => {
    let token = localStorage.getItem('token')

    if (!token || token == null) {
        // Not login
        if(to.name !== 'login' && to.name !== 'register'){
            next({
                name: 'login',
                query: {
                    'redirectTo': to.path,
                    'error' : 1
                }
            })
        }
        next()
    }else{
        // Is login
        if(to.name === 'login' || to.name === 'register'){
            next({
                name: 'home'
            })
        }
        next()
    }

})


export default router