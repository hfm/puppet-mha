class mha::params {

  $manager_version = '0.55-0'
  $node_version    = '0.54-0'

  $user     = 'root'
  $password = ''

  $repl_user     = 'repl'
  $repl_password = ''

  $purge_relay_logs_schedule = {
    minute => 10,
    hour   => '2-23/6', # 2,8,14,20
  }

  $ssh_key_path    = '/root/.ssh/id_mha'
  $ssh_key_type    = 'rsa'
  $ssh_public_key  = 'AAAAB3NzaC1yc2EAAAABIwAAAQEArtdvtkbHIW0GOUcDSBJtK0ql14YMLGxyvROqWUzH89UhMzUoMyViFMYdKDJJ/99F/vTiMtTl4lAyw93UVTMAyI1wfDlUjv9CDEWshuFUW6FPRSYJq+zo9GXrLZK84UJItjngP5Zdxuyd38chSPfnBG5scrlsgwVZmQEU9wStWhYewU/DKvXmMvX7b2nzmvaaTKdl6tAOq5ZFC51DVaYk1dpNW8LpjL617Gfj69z5ot+zexXZgIIJapjmpyaqSeGg834W9YaUFtCGXnKIrOQuseiRz4TE0wLJ5V+4VqQM6CDrN90QX23WTXLLkkvMXYg97rbPriO8+T5y7t9ugYx/Qw=='
  $ssh_private_key = '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArtdvtkbHIW0GOUcDSBJtK0ql14YMLGxyvROqWUzH89UhMzUo
MyViFMYdKDJJ/99F/vTiMtTl4lAyw93UVTMAyI1wfDlUjv9CDEWshuFUW6FPRSYJ
q+zo9GXrLZK84UJItjngP5Zdxuyd38chSPfnBG5scrlsgwVZmQEU9wStWhYewU/D
KvXmMvX7b2nzmvaaTKdl6tAOq5ZFC51DVaYk1dpNW8LpjL617Gfj69z5ot+zexXZ
gIIJapjmpyaqSeGg834W9YaUFtCGXnKIrOQuseiRz4TE0wLJ5V+4VqQM6CDrN90Q
X23WTXLLkkvMXYg97rbPriO8+T5y7t9ugYx/QwIBIwKCAQEAn9rpyzllmudWJb1E
1C4aqzzvZfbmjwQRIeYYFyGg3u6/RMLi7O76lqaBDs7kkis4rpbALnmBuPjd9OgS
lwoPWEbNPmBNT4pLA+fuMi0Z7WBIebxgnTBf9WR/P5waZ40PR4VfUBRy/wQ4khUl
vw6KEq4aAn2lChOFHizf98nDEIe91GJF0FgSclAJGi8AhayaAe3bmB1SDRTYA2mZ
LrhJq8UTectSGlo8NKcf3ivPoDVdebCfpOx6+vIVOAaQ991jZZjbTrNgV26jpODY
YqkY7YS2Zy0a0eWGLof7b+Q2mvFzf0cTXT8vZWfRpfEgWexjvU6NJUM2Tzonpj2E
VMQriwKBgQDT34T5DO4AgQdfcEokErh2phuI1E1bp835VZkzF5olTEc6pv9ZhzLp
Y2ImC0/i+to69d8bIyBjTdishP0t+mpbFtv36ZzjGbiFOkWg4TOz5q/C+/GEyQXg
rNRXuY3A/z2cfy2hU/lo53bdrXlo0TYEJbmzdHRqAlgLlMy0PpvjUQKBgQDTQX9N
wieRhOcSCnxm9glbNG+06CKhRXl/ckiQsvJu9bOFZ40uOLkar27zBY0rkMsaSB2P
wP7/mkdy7OJNwF0hJYLvLdV/nXb+J9b7H8eHh2+nUrnqtGnedaalmrSwL2s4ZXmx
3XdRjxJgl1KoKfesse8x2O3PkD7L/D9xhjoMUwKBgQDN0dGhekZJoennrujv16vg
+SIP5C3kAhiLz37hLN7iZ1sjCKBIV3NJHrcdpJa/PNP+wvX9Gs8BYZCnlyHU5KHU
1GCnr7z53ni773bWzCOY0XeKNpLYw0eJzHaBGqb1/0MqT6irWOOnvEeVg/JIkLgh
STgNadAsd043ItV75Qx2awKBgQDBJfC8HzoepWWM1mMcTql39W1yM1Lcl0qDJqi+
z36RVatyp9GJWG65T/BpKaWkLJxvzOfT46dQGAbPeX5y+QSwl1Mj0iJIyntsByr0
OlAG4joylMc8/LiQ4Jhc5Td8gyAzj/o8ODKTtgIsbRhfPFAo3TJ2t7TbB4nfEoMl
9xCASwKBgHU8zO3C1xPQjh8hso1+ypIoJNu1IX/xN784BpxfGH0xAHIFJqAavQ2b
kg5/f5OY4sfCDqVqB381m0yx1bRHiPrT6gwQFUpFjCiMO9kF2e7c2X072iA6rQAN
vsTLvLSpURCF6XLRL/u0WxavQk9pr5hvJVahu6xGpToe3/8uH+vH
-----END RSA PRIVATE KEY-----
'

}

