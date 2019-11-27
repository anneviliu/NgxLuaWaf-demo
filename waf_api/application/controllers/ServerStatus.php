<?php

Class ServerStatus extends CI_Controller {

    public $meminfo = array();
    public $diskinfo = array();
    public $cpuinfo = array();

    private function sec2human ($time) {
        $seconds = $time % 60;
        $mins = floor($time/60) % 60;
        $hours = floor($time/60/60)%24;
        $days = floor($time/60/60/24);
        return $days > 0 ? $days . ' day'.($days > 1 ? 's' : '') : $hours.':'.$mins.':'.$seconds;
    }

    public function meminfo() {
        $array = array();
        $fh = fopen('/proc/uptime','r');
        $uptime = fgets($fh);
        fclose($fh);
        $uptime = explode('.', $uptime, 2);
        $array['uptime'] = $this->sec2human($uptime[0]);

        $fh = fopen('/proc/meminfo', 'r');
        $mem = 0;
        while ($line = fgets($fh)) {
            $pieces = array();
            if (preg_match('/^MemTotal:\s+(\d+)\skB$/', $line, $pieces)) {
                $memtotal = $pieces[1];
            }
            if (preg_match('/^MemFree:\s+(\d+)\skB$/', $line, $pieces)) {
                $memfree = $pieces[1];
            }
             if (preg_match('/^Cached:\s+(\d+)\skB$/', $line, $pieces)) {
               $memcache = $pieces[1];
                break;
             }
        }
        fclose($fh);
        $memmath = $memcache + $memfree;
        $memmath2 = 100-($memmath / $memtotal) * 100;
        $memory = round($memmath2) . '%';
        if ($memory >= "80%") { $memlevel = "danger"; }
        elseif ($memory >= "50%") { $memlevel = "warning"; }
        elseif ($memory <= "45%") { $memlevel = "success"; }
        $array['remain_mem'] = $memory;
        $array['level'] = $memlevel;
        echo json_encode($array);
    }


    public function diskinfo() {
        $hddtotal = disk_total_space("/");
        $hddfree = disk_free_space("/");
        $hddmath = $hddfree / $hddtotal * 100;
        $hdd = round($hddmath) . '%';
        var_dump($hddtotal);
        var_dump($hddfree);

    }
}