<template>
    <div>
        <el-row type="flex" class="" justify="space-around">
            <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="8">
                <div class="grid-content bg-purple-light">
                    <el-container>
                        <el-main>
                            <el-card shadow="always">

                                <h2>新用户注册</h2>

                                <el-form ref="form" :model="regForm" label-width="80px">

                                    <el-form-item label="昵称">
                                        <el-input v-model="regForm.username"></el-input>
                                    </el-form-item>

                                    <el-form-item label="密码">
                                        <el-input show-password v-model="regForm.password1" ></el-input>
                                    </el-form-item>

                                    <el-form-item label="确认密码">
                                        <el-input show-password v-model="regForm.password2" ></el-input>
                                    </el-form-item>

                                    <el-form-item label="邀请码">
                                        <el-input v-model="regForm.inviteCode"></el-input>
                                    </el-form-item>

                                    <div class="button-right">
                                        <el-button type="primary" round @click="onReg">注册新账号</el-button>
                                        <el-button round @click="onBack">返回登录</el-button>
                                    </div>
                                </el-form>
                            </el-card>
                            <div class="copyright">
                                <span>❤️之初体验 waf 后台管理系统注册</span>
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
        name: "Register",
        data(){
            return {
                regForm: {
                    sub:"submit",
                    username: '',
                    password1: '',
                    password2: '',
                    inviteCode: ''
                }
            }
        },
        methods: {
            onBack: function(){
                this.$router.replace({path: '/login'})
            },

            onReg: function(){
                axios.post(
                    config.reg_api,
                    this.$qs.stringify(this.regForm),
                ).then((res) => {
                    var login_result = res.data
                    if (login_result.message == "注册成功"){
                        this.$message({
                            message: "注册成功",
                            type: 'success',
                            onClose:() => {
                                this.$router.replace({path: '/login'})
                            }
                        });
                    }
                    else if (login_result.message == "用户名已存在")
                    {
                        this.$message.error('用户名已存在');
                    }
                    else if (login_result.message == "邀请码错误")
                    {
                        this.$message.error('邀请码错误');
                    }
                    else if (login_result.message == "注册失败")
                    {
                        this.$message.error('注册失败');
                    }
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