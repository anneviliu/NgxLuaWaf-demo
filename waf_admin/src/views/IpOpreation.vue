<template>
  <div id="app">
   <el-menu router="true" :default-active="this.$router.path" class="el-menu-demo" mode="horizontal" @select="handleSelect" background-color=rgb(255,255,255)>
      <el-menu-item index="/" ><i class="el-icon-s-operation"></i>控制面板</el-menu-item>
      <el-menu-item index="/about" ><i class="el-icon-s-custom"></i>关于我们</el-menu-item>
      <el-menu-item @click="onLogout" style=""><i class="el-icon-switch-button"></i>登出</el-menu-item>
    </el-menu>

    <el-container style="height: 100%; border: 0px solid #eee">
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
      <el-main>
        <img style="width:20%" src="../assets/logo.png">
<br></br>
<br></br>
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="ip" @keyup.enter.native="submit">
            <el-input v-model="formInline.ip" placeholder="ip"></el-input>
          </el-form-item>
          <el-form-item label="type" @keyup.enter.native="submit">
            <el-select v-model="formInline.type" placeholder="type">
              <el-option label="ip_blacklist" value="ip_blacklist"></el-option>
              <el-option label="ip_whitelist" value="ip_whitelist"></el-option>
            </el-select>
          </el-form-item>

            <el-form-item>
                <template>
                <el-button :plain="true" @click.native="submit">submit</el-button>
                </template>

            </el-form-item>
        </el-form>
<template>
  <el-table
    :data="tabledata"
    style="width: 50%;position: relative; left: 29%">
    <el-table-column
      label="时间"
      width="180">
      <template slot-scope="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{ scope.row.date }}</span>
      </template> 
    </el-table-column>

    <el-table-column
      label="ip"
      width="180">
      <template slot-scope="scope">
        <span style="margin-left: 10px">{{ scope.row.ip }}</span>
      </template> 
    </el-table-column>
<el-table-column label="类型">
  <template slot-scope="scope">
        <span style="margin-left: 10px">{{ scope.row.status }}</span>
      </template> 
    </el-table-column>

    <el-table-column label="操作">
      <template slot-scope="scope">
        <!-- <el-button
          size="mini"
          @click="handleEdit(scope.$index, scope.row)">编辑</el-button> -->
        <el-button
          size="mini"
          type="danger"
          @click="remove(scope.$index)">删除</el-button>
      </template>
    </el-table-column>

    
  </el-table>
</template>
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
       this.GET_table_data()
     },
    data () {
      return {
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
            },
            tabledata:[],
        }
    },
    methods: {
      GET_table_data(){
         var data = []
         var table_data = {type:'get_iplist'}
        this.$axios.post(config.iplist_api,this.$qs.stringify(table_data)
        ).then(res => {
          for (let i = 0; i < res.data.ip.length; i++) {
                var obj = {}
                obj.date = res.data.time
                obj.ip = res.data.ip[i]
                obj.status = res.data.type
                data[i] = obj
            }
           this.tabledata = data
      });
      },
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

      submit: function () {
        var sub = {ip:this.formInline.ip, type: this.formInline.type}
        this.$axios.post(config.ip_baseURL,this.$qs.stringify(sub)
        ).then(res => {
          var result = res.data;
          this.$message({
            message: result,
            type: 'success'
          });
          this.GET_table_data()
        });
      },
      remove: function (index) {
         var ip = this.tabledata[index].ip
         var type = this.tabledata[index].status + "_remove"
         var sub = {ip:ip, type: type}
        this.$axios.post(config.ip_baseURL,this.$qs.stringify(sub)
        ).then(res => {
          var result = res.data;
          this.$message({
            message: result,
            type: 'success'
          });
          this.GET_table_data()
        });

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