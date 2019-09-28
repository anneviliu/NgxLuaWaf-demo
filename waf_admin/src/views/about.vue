<template>
  <div id="app">
      <el-menu router="true" :default-active="this.$router.path" class="el-menu-demo" mode="horizontal" @select="handleSelect" background-color=rgb(255,255,255)>
      <!-- <el-menu-item @click="drawer = true"><i class="el-icon-s-operation"></i>控制面板</el-menu-item> -->
      <el-menu-item index="/" ><i class="el-icon-s-operation"></i>控制面板</el-menu-item>
      <el-menu-item index="/about" ><i class="el-icon-s-custom"></i>关于我们</el-menu-item>
      <el-menu-item @click="onLogout" style=""><i class="el-icon-switch-button"></i>登出</el-menu-item>
      <el-link type="info" style="position: relative; right: -32%; top: 20%;font-size: 30px"><i class="el-icon-user"></i>{{username}}</el-link>
    </el-menu>
  </div>
</template>