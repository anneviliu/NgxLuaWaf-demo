import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)


const router = new Router({
    routes: [
        {
            path: '/',
            name: 'Home',
            component: () => import('@/views/Home.vue')
        },

        {
            path: '/login',
            name: 'login',
            component: () => import('@/views/Login.vue')
        },

        {
            path: '/register',
            name: 'register',
            component: () => import('@/views/Register.vue')
        },

        {
            path: '/ip',
            name: 'IpOpreation',
            component: () => import('@/views/IpOpreation.vue')
        },

        {
          path: '/about',
          name: 'about',
          component: () => import('@/views/about.vue')
      },

    ]
})

router.beforeEach((to, from, next) => {
    let token = localStorage.getItem('token')
    let username =localStorage.getItem('username')
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
    }
    else if(token === btoa(username))
    {
        // Is login
        if(to.name === 'login' || to.name === 'register'){
            next({
                name: 'Home'
            })
        }
        next()
    }

})

export default router