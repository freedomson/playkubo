#!/usr/bin/expect -f
spawn bash -c "scp /Users/freedomson/projects/playkubo/ssh_key_pair/id_rsa_playkubo.pub pi@raspberrypi.local:/home/pi/.ssh/authorized_keys"
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