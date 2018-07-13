#!/usr/bin/expect -f
log_file -a "/tmp/expect.log"
set ssh_folder [lindex $argv 0];
set ssh_host [lindex $argv 1];
set ssh_user [lindex $argv 2];

spawn bash -c "scp -pr $ssh_folder $ssh_host:/home/$ssh_user/"
expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
  -re ".*sword.*" {
    exp_send "raspberry\r"
    exp_continue
  }
  -re ".*100%*" {
    exp_send "Closing\r"
  }
}
interact