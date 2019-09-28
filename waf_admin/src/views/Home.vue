<template>
  <div id="app">
    <el-menu router="true" :default-active="this.$router.path" class="el-menu-demo" mode="horizontal" @select="handleSelect" background-color=rgb(255,255,255)>
      <!-- <el-menu-item @click="drawer = true"><i class="el-icon-s-operation"></i>控制面板</el-menu-item> -->
      <el-menu-item index="/" ><i class="el-icon-s-operation"></i>控制面板</el-menu-item>
      <el-menu-item index="/about" ><i class="el-icon-s-custom"></i>关于我们</el-menu-item>
      <el-menu-item @click="onLogout" style=""><i class="el-icon-switch-button"></i>登出</el-menu-item>
        <el-link type="info" style="position: relative; right: -32%; top: 20%;font-size: 30px"><i class="el-icon-user"></i>{{username}}</el-link>
    </el-menu>
    <el-container style="height: 900px; border: 1px solid #eee">
      <el-aside width="10%" style="background-color: rgb(255,255,255);">
        <el-menu :default-openeds="['1', '3']">
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >waf总开关</el-button>
            <el-switch
              style=""
              v-model="value2"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=waf_status()
              >
            </el-switch>
          </el-menu-item-group>


          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >URL白名单</el-button>
            <el-switch
              style="display: "
              v-model="value3"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=url_whitelist()>
            </el-switch>
          </el-menu-item-group>

          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >URL过滤</el-button>
            <el-switch
              style="display: "
              v-model="value4"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=url_filter()>
            </el-switch>
          </el-menu-item-group>


          <br></br>
          <el-menu-item-group>  
              <el-button type="primary" plain size="small" style="width:100px" @click.native="GoIpControl()">ip黑名单</el-button>
            <el-switch
              style="display: "
              v-model="value5"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=ip_blacklist()>
            </el-switch>
          </el-menu-item-group>

          <br></br>
          <el-menu-item-group>
              <el-button type="primary" plain size="small" style="width:100px" >ip白名单</el-button>
            <el-switch
              style="display: "
              v-model="value11"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=ip_whitelist()>
            </el-switch>
          </el-menu-item-group>


          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >GET过滤</el-button>
            <el-switch
              style="display: "
              v-model="value6"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=get_args_check()>
            </el-switch>
          </el-menu-item-group>


          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >POST过滤</el-button>
            <el-switch
              style="display: "
              v-model="value7"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=post_args_check()>
            </el-switch>
          </el-menu-item-group>

          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >Cookie过滤</el-button>
            <el-switch
              style="display: "
              v-model="value8"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=cookie_safe_check()>
            </el-switch>
          </el-menu-item-group>

          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >UA过滤</el-button>
            <el-switch
              style="display: "
              v-model="value9"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=ua_safe_check()>
            </el-switch>
          </el-menu-item-group>

          <br></br>
          <el-menu-item-group>
            <el-button type="primary" plain size="small" style="width:100px" >CC攻击防御</el-button>
            <el-switch
              style="display: "
              v-model="value10"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text=""
              inactive-text=""
              @change=cc_defense()>
            </el-switch>
          </el-menu-item-group>
        </el-menu>
      </el-aside>

      <el-main style="position: relative; top: 0%">
        <img style="width:20%" src="../assets/logo.png">
 
        <h1 >欢迎你～ {{username}}</h1>
        <el-card class="box-card" style="width: 50%; height:30% ;position: relative; left: 25% ">
        <div slot="header" class="clearfix">
          <span>服务器状态检测</span>
          <!-- <el-button style="float: right; padding: 3px 0" type="text"></el-button> -->
        </div>
        <div v-for="o in 4" :key="o" class="text item">
          {{'待添加 ' + o }}
        </div>
</el-card>
      </el-main>
    </el-container>


  </div>
</template>

<script>
  import axios from "axios"
  import config from '@/config'

  export default {
    name : "Home",
    created(){
       this.GET_DATA();
     },
     watch:{
  "$route":function(to,from){
      //from 对象中包含当前地址
      //to 对象中包含目标地址
      //其实还有一个next参数的，这个参数是控制路由是否跳转的，如果没写，可以不用写next()来代表允许路由跳转，如果写了就必须写next(),否则路由是不会生效的。
      
    }
  },
    data () {
      return {
        drawer: false,
        direction: 'ltr',
        username: localStorage.getItem('username'),
        // value2: Common.value2,
        value2: false,
        value3: false,
        value4: false,
        value5: false,
        value6: false,
        value7: false,
        value8: false,
        value9: false,
        value10:false,
        value11:false,
        formInline: {
          ip: '',
          type: ''
            }
        }
    },
    methods: {
       GET_DATA(){
         this.$axios.get(config.switch_URL).then(res => {
           var result1 = res.data;

            if (result1.waf_status == "true")
            {
              this.value2 = true
            }
            else if (result1.waf_status == "false")
            {
              this.value2= false
            }
           if (result1.url_whitelist == "true")
           {
             this.value3 = true
           }
           else if (result1.url_whitelist == "false")
           {
             this.value3= false
           }
           if (result1.url_filter == "true")
           {
             this.value4 = true
           }
           else if (result1.url_filter == "false")
           {
             this.value4= false
           }
           if (result1.ip_blacklist == "true")
           {
             this.value5 = true
           }
           else if (result1.ip_blacklist == "false")
           {
             this.value5 = false
           }
           if (result1.ip_whitelist == "true")
           {
             this.value11 = true
           }
           else if (result1.ip_whitelist == "false")
           {
             this.value11 = false
           }
           if (result1.get_args_check == "true")
           {
             this.value6 = true
           }
           else if (result1.get_args_check == "false")
           {
             this.value6 = false
           }
           if (result1.post_args_check == "true")
           {
             this.value7 = true
           }
           else if (result1.post_args_check == "false")
           {
             this.value7 = false
           }
           if (result1.cookie_safe_check == "true")
           {
             this.value8 = true
           }
           else if (result1.cookie_safe_check == "false")
           {
             this.value8 = false
           }
           if (result1.ua_safe_check == "true")
           {
             this.value9 = true
           }
           else if (result1.ua_safe_check == "false")
           {
             this.value9 = false
           }
           if (result1.cc_defense == "true")
           {
             this.value10 = true
           }
           else if (result1.cc_defense == "false")
           {
             this.value10 = false
           }
         })
       },

      waf_status () {
        // Common.value2 = this.value2
        var control1 = {moudle:"waf_status", status: this.value2}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control1)
        ).then(res => {
          var res1 = res.data;
          this.$message({
            message: res1,
            type: 'success'
          });
        });
      },

      url_whitelist(){
         var control2 = {moudle:"url_whitelist", status: this.value3}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control2)
        ).then(res => {
          var res2 = res.data;
          this.$message({
            message: res2,
            type: 'success'
          });
        });
      },

      url_filter(){
        var control3 = {moudle:"url_filter", status: this.value4}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control3)
        ).then(res => {
          var res3 = res.data;
          this.$message({
            message: res3,
            type: 'success'
          });
        });
      },

      ip_blacklist(){
        var control4 = {moudle:"ip_blacklist", status: this.value5}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control4)
        ).then(res => {
          var res4 = res.data;
          this.$message({
            message: res4,
            type: 'success'
          });
        });
      },

      get_args_check(){
        var control5 = {moudle:"get_args_check", status: this.value6}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control5)
        ).then(res => {
          var res5 = res.data;
          this.$message({
            message: res5,
            type: 'success'
          });
        });
      },

      post_args_check(){
        var control6 = {moudle:"post_args_check", status: this.value7}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control6)
        ).then(res => {
          var res6 = res.data;
          this.$message({
            message: res6,
            type: 'success'
          });
        });
      },

      cookie_safe_check(){
        var control7 = {moudle:"cookie_safe_check", status: this.value8}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control7)
        ).then(res => {
          var res7 = res.data;
          this.$message({
            message: res7,
            type: 'success'
          });
        });
      },

      ua_safe_check(){
        var control8 = {moudle:"ua_safe_check", status: this.value9}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control8)
        ).then(res => {
          var res8 = res.data;
          this.$message({
            message: res8,
            type: 'success'
          });
        });
        },

      cc_defense(){
        var control9 = {moudle:"cc_defense", status: this.value10}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control9)
        ).then(res => {
          var res9 = res.data;
          this.$message({
            message: res9,
            type: 'success'
          });
        });

      },

      ip_whitelist(){
        var control10 = {moudle:"ip_whitelist", status: this.value11}
        this.$axios.post(config.switch_URL,this.$qs.stringify(control10)
        ).then(res => {
          var res10 = res.data;
          this.$message({
            message: res10,
            type: 'success'
          });
        });
      },
      GoIpControl(){
           this.$router.replace({path: '/ip'})
           //this.$router.push('/')
      },

      GoBackHome(){
          this.$router.replace({path: '/'})
      },
       onLogout: function(){
          localStorage.removeItem('token')
          localStorage.removeItem('username')
          this.$router.replace({
                                path: '/login',
                            })
      }
  }
}


</script>


<style>
  #app {
    font-family: Helvetica, sans-serif;
    text-align: center;
  }
  .el-header {
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
  }

  .el-aside {
    color: #333;
  }


</style>