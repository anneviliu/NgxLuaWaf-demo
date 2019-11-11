<template>
    <div>
        <el-row type="flex" class="" justify="space-around">
            <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="8">
                <div class="grid-content bg-purple-light">
                    <el-container>
                        <el-main>
                            <el-card shadow="always">
<<<<<<< HEAD
                                <img style="width:20%; position: relative; left:40%" src="../assets/logo.png">
                                <h2 style="text-align:center;">登录</h2>
          
=======

                                <h2>登录</h2>

>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
                                <el-form ref="form" :model="loginForm" label-width="80px">
                                    <el-form-item label="用户名">
                                        <el-input v-model="loginForm.username"></el-input>
                                    </el-form-item>

                                    <el-form-item label="密码">
<<<<<<< HEAD
                                        <el-input show-password v-model="loginForm.password" @keyup.enter.native="onLogin"></el-input>
=======
                                        <el-input show-password v-model="loginForm.password"></el-input>
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
                                    </el-form-item>
                                </el-form>

                                <div class="button-right">
<<<<<<< HEAD
                                    <el-button type="primary" round @click="onLogin" >登录</el-button>
=======
                                    <el-button type="primary" round @click="onLogin">登录</el-button>
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
                                    <el-button round @click="onReg">注册</el-button>
                                </div>
                            </el-card>
                            <div class="copyright">
                                <span>❤️之初体验 waf管理平台登陆</span>
                            </div>
                        </el-main>
                    </el-container>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import config from '@/config'
    import axios from "axios"
import { log } from 'util'

     export default {
        name: "Login",
        data(){
            return{
                loginForm: {
                    sub : "submit",
                    username: '',
                    password: ''
                }
            }
        },
<<<<<<< HEAD
=======

>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
        mounted() {
        },

        methods:{
            onReg: function(){
                this.$router.push({path: '/register'})
            },

            onLogin: function(){
                axios.post(
                    config.log_api,
                    this.$qs.stringify(this.loginForm),
                ).then((res) => {
                    // Check the callback
                    var log_result = res.data
                    if(log_result.message == "登录成功")
                    {
                        localStorage.setItem('token', log_result.token)
                        localStorage.setItem('username', log_result.username)
                        this.$message({
                            message: "登陆成功",
                            type: 'success',
                            onClose:() => {
                                this.$router.replace({path: '/'})
                            }
                        });
                    }
<<<<<<< HEAD
                    else if(log_result.message === "用户名或密码错误")
                    {
                        this.$message.error('用户名或密码错误');
                    }
                    else if (log_result.message === "用户名或密码为空")
                    {
                        this.$message.error('用户名或密码为空');
                    }
=======
>>>>>>> 2e4034207e64312ac2f3fa69eae323355411dbcf
                })
            }
        }
    }
</script>

<style scoped>
    .button-right{
        float:right;
        margin-bottom: 20px;
    }

    .logo{
        display: table-cell;
        margin: 0 auto;
        width: 200px;
    }

    .copyright{
        font-size: 12px;
        text-align: center;
        padding: 10px;
        color: gray;
    }
</style>