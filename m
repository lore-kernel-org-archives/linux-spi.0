From: kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: 9ce70d49fa ("spi: fix IDR collision on systems with both fixed
 .."):  WARNING: CPU: 1 PID: 1 at include/linux/idr.h:113
 spi_register_controller
Date: Sat, 14 Oct 2017 14:07:45 +0800
Message-ID: <59e1a9b1.bvX01JHa+mut7wXC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG"
Cc: LKP <lkp-JC7UmRfGjtg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a multi-part message in MIME format.

--=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git fix/core

commit 9ce70d49fa80b95a029c16432270f4edbbd2a953
Author:     Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
AuthorDate: Fri Oct 13 17:59:46 2017 +0200
Commit:     Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CommitDate: Fri Oct 13 17:43:27 2017 +0100

    spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
    
    On systems where some controllers get a dynamic ID assigned and some have
    a fixed number from DT, the current implemention might run into an IDR
    collision if the dynamic controllers gets probed first and get an IDR number,
    which is later requested by the controller with the fixed numbering. When
    this happens the fixed controller will fail to register with the SPI core.
    
    Fix this by skipping all known alias numbers when assigning the dynamic IDs.
    
    Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
    Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
    Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

2bd6bf03f4  Linux 4.14-rc1
9ce70d49fa  spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
9ce70d49fa  spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
+---------------------------------------------------------+-----------+------------+------------+
|                                                         | v4.14-rc1 | 9ce70d49fa | 9ce70d49fa |
+---------------------------------------------------------+-----------+------------+------------+
| boot_successes                                          | 56        | 0          | 0          |
| boot_failures                                           | 0         | 52         | 52         |
| WARNING:at_include/linux/idr.h:#spi_register_controller | 0         | 52         | 52         |
| WARNING:at_drivers/spi/spi.c:#spi_register_controller   | 0         | 52         | 52         |
| WARNING:at_lib/kobject.c:#kobject_add_internal          | 0         | 52         | 52         |
+---------------------------------------------------------+-----------+------------+------------+

[   31.566884] usbcore: registered new interface driver dln2
[   31.567675] Uniform Multi-Platform E-IDE driver
[   31.568897] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
[   31.570356] ide-gd driver 1.18
[   31.594454] ------------[ cut here ]------------
[   31.595244] WARNING: CPU: 1 PID: 1 at include/linux/idr.h:113 spi_register_controller+0x539/0x560
[   31.596900] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc1-00001-g9ce70d49 #1
[   31.597991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   31.599570] task: ffff99e1dd11d000 task.stack: ffff99e1dd114000
[   31.600735] RIP: 0010:spi_register_controller+0x539/0x560
[   31.601561] RSP: 0000:ffff99e1dd117d60 EFLAGS: 00010246
[   31.602300] RAX: 0000000000000000 RBX: ffff99e1dd3c2800 RCX: 0000000000000d89
[   31.603394] RDX: ffff99e1de40dc80 RSI: 0000000000000000 RDI: 0000000000000286
[   31.605906] RBP: ffff99e1d6f5a000 R08: 0000000000000000 R09: 0000000000000001
[   31.606929] R10: ffff99e1dd117d60 R11: 0000000000000000 R12: ffff99e1d6f5a000
[   31.607985] R13: ffff99e1d6b0a000 R14: 0000000000000000 R15: 4a01b6fc37876693
[   31.609091] FS:  0000000000000000(0000) GS:ffff99e1de400000(0000) knlGS:0000000000000000
[   31.615417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.616266] CR2: 00000000ffffffff CR3: 000000000ac11000 CR4: 00000000000006e0
[   31.618220] Call Trace:
[   31.618638]  ? refcount_inc+0x11/0x50
[   31.619190]  ? spi_bitbang_start+0xe4/0x1b0
[   31.619778]  ? spi_lm70llp_attach+0xfe/0x360
[   31.623582]  ? attach_driver_chain+0x60/0x60
[   31.624181]  ? port_check+0x2d/0x40
[   31.624695]  ? bus_for_each_dev+0x92/0xe0
[   31.625279]  ? __parport_register_driver+0x157/0x160
[   31.625987]  ? dw_spi_driver_init+0x49/0x49
[   31.626576]  ? do_one_initcall+0xe0/0x2bd
[   31.627113]  ? kernel_init_freeable+0x294/0x3c0
[   31.636918]  ? rest_init+0x160/0x160
[   31.637574]  ? kernel_init+0xf/0x169
[   31.638174]  ? rest_init+0x160/0x160
[   31.638799]  ? rest_init+0x160/0x160
[   31.639401]  ? ret_from_fork+0x25/0x30
[   31.640030] Code: 48 89 ef e8 9a 26 f4 ff e9 43 ff ff ff 41 bc ed ff ff ff e9 2b fd ff ff e8 f5 30 85 ff 31 f6 48 c7 c7 c0 74 8d 95 e8 f7 47 75 00 <0f> ff 48 c7 c7 c0 74 8d 95 e8 39 47 75 00 48 c7 c7 9c 8a 68 95 
[   31.643275] ---[ end trace df64f0f369d434fe ]---
[   31.644102] couldn't get idr

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start acb325accc41652d809e7efa3a02620fc91e9515 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f --
git bisect  bad 8ffaff92273be539472fb417f9ed66fadcb8029a  # 08:09  B      0    10   22   0  Merge 'jpoimboe/orc-default' into devel-spot-201710140421
git bisect  bad 228f85fc08150a8ac0e5aaf717db28a8a35d685e  # 08:21  B      0    11   23   0  Merge 'nfsd/master' into devel-spot-201710140421
git bisect good ea05a66ac0fdad8358d5a03363af0794510d4e81  # 08:40  G     11     0    0   0  Merge 'linux-review/Roman-Mashak/bridge-return-error-code-when-deleting-Vlan/20171014-024422' into devel-spot-201710140421
git bisect good b5c639a86d37266ff4215f58d38182628cd06a96  # 08:56  G     11     0    0   0  Merge 'kdave-btrfs-devel/ext/josef/queue' into devel-spot-201710140421
git bisect good 2932a42ad55a2424df27e55a4f9d1ebecc84ac44  # 09:13  G     11     0    0   0  Merge 'net-next/master' into devel-spot-201710140421
git bisect  bad ef43d04e04b9b9a39882d97e3ad3e152cee445b5  # 09:26  B      0    10   22   0  Merge 'spi/for-next' into devel-spot-201710140421
git bisect good 5a866ec0014b2baa4ecbb1eaa19c835482829d08  # 09:39  G     11     0    0   0  spi: a3700: Return correct value on timeout detection
git bisect  bad 04d6089edc878ae19d55f33ebb5c8c21cfc0210d  # 10:34  B      0    11   25   2  Merge remote-tracking branch 'spi/fix/core' into spi-linus
git bisect  bad 9ce70d49fa80b95a029c16432270f4edbbd2a953  # 10:53  B      0    11   23   0  spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
# first bad commit: [9ce70d49fa80b95a029c16432270f4edbbd2a953] spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
git bisect good 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e  # 13:40  G     32     0    0   0  Linux 4.14-rc1
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect  bad 9ce70d49fa80b95a029c16432270f4edbbd2a953  # 13:40  B      0     8   20   0  spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
# extra tests on HEAD of linux-devel/devel-spot-201710140421
git bisect  bad acb325accc41652d809e7efa3a02620fc91e9515  # 13:45  B      0    35   50   0  0day head guard for 'devel-spot-201710140421'
# extra tests on tree/branch spi/fix/core
git bisect  bad 9ce70d49fa80b95a029c16432270f4edbbd2a953  # 13:51  B      0    52   64   0  spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
# extra tests with first bad commit reverted
git bisect good b2f1e295e38fc6c3d4c36798849c1fdf0ca38231  # 14:06  G     11     0    0   0  Revert "spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-intel12-10:20171014131949:x86_64-randconfig-r0-10140658:4.14.0-rc1-00001-g9ce70d49:1.gz"

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
1swECB3ieGg+ZQs3bLN03w6D03wxnkzmwSUylAYvT3+rhmBJI30wyQDXVzlI//b8hNi0GO6w
7jJwpHF1VcDNUPlzJ7xnmEkcYbE93A1lSKO12AmfGA/GXk6XxXr02eKnCmrd9af+p+lgvbQE
+NGkcl3hGpR9t9VMwjF0fDMdB1MEg13B2WA2nDjasMo6ziBppmiTnF+8PA96HDts/Jqcrll2
kiCAh3hQJ/WjG7ydGd1kbiYvn33ZonFQ+S8wuuBHQNNW7/zZVksWUilI3Az5e5VnuFuPuh0a
zwg6hGToJIc85eSQyANDmtw74lwe9Oqo80ND+WJ+Wy5gAA8+jXPkju0vSlhvnQFHESx149nN
mo57hg+erFcr4iJpjEfVM/fRi1d/9P639+ZlNwzx74vfL5+8wr8Zz/wZWppxqmTjR+aSfE+I
zz7UgDJMOD/ggH90Vq/Twt0rmLQPhT02nuer4TSvkmMcXD4K/mc9Lj6e5cSTN2VxPZtP5ldf
gjPDXl37KBEFkjUTOIz2aNnh6SmVUXgk6PAKm8wWdOchsM/ktF9e52Z9usXsQIdkFjzfVu4L
nPwTr6rnR685t04aHKDUxnGgH3Pwc3+Qr4f00SRvfoT3ojzgdk8sSR0i6qWdUXRfHT1fJ91n
AveZwP//ZwL3ddJ9nXRfJ93XSd+9z32ddF8n3ddJD3yddF8n3ddJ30PA10m/dwS+Trqvk+7r
pO96vfV10n2d9P3d8nXS78bzddJ9nXRfJ93XSfd10n2ddF8n3ddJ93XSfZ10Xyd9NxlfJ917
R3jvCO8d4euk+zrpG7i+Trqvk+7rpPs66aGvk+7rpPs66b5O+sjXSfd10n2ddF8n3ddJ93XS
A18n3ddJ93XSGyhfJ93XSfd10n2ddF8n3ddJ93XSfZ10Xyfd10nn/3yddF8n3ddJ93XS7yfq
66T7Oum+Trqvkz7yddJ9nXRfJ93XSfd10n2ddF8n3ddJ93XSfZ10Xyfd10n3ddJbiL5Ouq+T
7uukB75Ouq+T7uuk+zrpvk66r5Pu66RX7fg66b5Ouq+T7uuk+zrpvk66r5Pu66T7Oum+Trqv
k+7rpPs66b5O+jcN19dJ93XSfZ10Xyfd10n3ddJ9nXRfJ93XSfd10n2ddF8n3ddJd5vWmhaT
+AebFtR0GsIR565kpgSmkR0g+1B7WgBI2JalbVk9uGVNuzVN/lGSyEUA2+zJzc1kTIJuNbHd
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
gBqu3t8xOWLm64Sa6XECdd+ZrzKHmJIZ9EfMfJ1QI+plU3vvPfN1YlUyheGYma8Tq0f6tO49
81XnfM/AZ6ved+brxGJNkI6Z+TqxlJRyHDPzdWDF2PxSoWNmvk6sHP1U7zEzXydWJUfkjpn5
OrHYsbZjZr4OrJTFT9EeM/N1Ykn1I9VjZr5OrBKpw6EzXxFrbrYzLDbzFbEamQ+VIZOzYhm7
H3SkI6uTa/fJ2H1Oic4UTq7dJ2P3OVc66zi5dp+M3eex+tPZva7dJ2P3uQjldnLtPhm7H7fo
R6oZMjkLVjZ2n7v4TY4zZHJWLGP3EkjzkgyZnBXL2P24Kn8XIEMmZ8Uydj9UAp0Xnl27z8bu
hU0pypDJWbGM3UshbWgyZHJWLGP3w33ReeHZtfts7H6oFz/qzZDJWbGM3Wskw4AzZHJWLGP3
swMNwxLX7sXY/Xjy1OeIa/di7H42AqVYrt2LsXstnUfjrt2LsfvxFv0sWoZMzopl7F47ORaS
IZOzYhm7L5Ecf82QyVmxjN0XdjQ0QyZnxTJ2X4T0s8yQyVmxjN2XQiaZZ8jkrFjG7kslJZgZ
MjkLlhq7L634JTkZMjkrlrH7GpKfkcuQyVmxjN3TTj0ZMjkrlrH7mrq/a5Ihk7NiGbuvw+Ez
m1DX7tXYfdXml9FkyOSsWMbuhxD1S7UzZHJWLGP3Q7b7rVoyZHJWLGP38zQnffau3aux+xbV
L63KkMlZsIqx+5YTtYni2n0xdt+EtNzLkMlZsdZMzsQqid+ja/eQyZlYtfjlr7KmX5b2oTtj
qq1nfyqKrOmXFcpYag+kT46s6ZcVyhhqH7EXg3KH2++MnfahHd13KGv6ZYUyZto1KJv7vqRf
1la3xkx7Eb9nokD6ZcUyZjrEnp8WEki/rFjGPc90Fb1Hd7a9Sb/EEEihg0D6ZcVC9xxDIhOw
oDUzYKHND81OuvVBZ2bAQqOPI770QxxozAxYaPVxrLP+5jH0ZQYsNPs4uOhvTEBbZsBCu4+h
k9Oq0JV5xTLplxgjGTYJTZkBC+1+QKm/sQo9mQEL7T7G2SqUYbl2b9IvMSpJVwmkX1YsY/ex
Rr9zkkD6ZcUydh9b9UNogfTLimXsfgSE/maVQPplxTJ2nyI5gSGQflmxjN2n1P2NQoH0y4pl
7D6J+uk9gfTLgmXSL3EbZcawXLs36ZeY5g4Tw3Lt3qRfYmqk05RA+mXFMnafg/jlrwLplxXL
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
s5QXZg2tQ47CKRRmKS/MallYxgUKs5QXZrWsib+Axc54YdaQAZmsTlCWorwspeUh0X1/BmUp
ystSWm7Fz4YqlKUoL0tpuZNNeYWyFOVlKU0CmUKuUJaivCylSQrkbUJZivKylHmu1D+orVCW
orwspc3+qD4YbMor35RvMgSKbxqwKa98U77J3ElnYMvb5JvyQ7uSLv0Km/LKN+WbBtJlTGFT
XvmmfBtk8k/IKGzKK9+UH5Ku+oVZCluSyrck22yP6j8z2JJUviXZdERovguCLUnlW5JtHnfy
XwBsSSrfkmwlNL9lmcKWpPItyTaPFfkvADZklG/ItDKnr1Gw6IKZZ1aFZQ9gQ0b5hkyrSjqa
KmzIKN+QabWScs4C6ejC09GzC7K/1BVIRxeejm5D8ftJkgLp6MLT0W0oMX93p0AyrvBkXGud
OMcCybjCk3EDi5hGgVTEh2vxwSL2c9z/U4qwi3R6+frtq/Ob890XSVLfvvb68S5s6O+uzq9/
uf+s1Hnyabf7/cnLi9Pdm3evn59fPdvps5r0Wc7x4w/2nLbJV9/87o/f7n7z618PqNOLVxc3
P+9+DE9j2c0zhE/+47s3T9KMoXZn5z9enJ5f715cvntz9h6jPw05yqxW/uubq/OXF9c351e7
tz/urr8/uTo/270+f3159fP4wNXu9O27Xbj9kMrWd+xXf/rruIGL692by592ly9evLp4c77/
Gd3KoM/On797+Wz37s3rk7dvL9683F28ubjZ/W1A78I/Xnz4r+tJPA8hPPn0r86qjl//vges
eZ76+Zeri/EQ315d3pyf3kzAm+/Pdz+cX705f7W7Oj85e3L55tXPu7OTm5Nnu1kcUn64RShx
28M/eEm9n8fTE+m6v6T3f6Xbpe0vqaStAd49AZ/rCQI+B8BZGTDc4D9a+fL162e7X31/fvrD
eBH/8j//l90H7Otnu7cn19fnZ4/HU9/+4e3Jy49v9ekeSNq2iXY5H8R37y3w5NWr92a3++n8
6nx3/e50mMP1i3evPn4qprY13R8Pd/7LLu6+mHfyy93Jzc3567c340pOdn/647e/+y+7m4vX
w1Suf74+nag/fX/x6nz3qz/+4be/++fvth/47i+/+/1v/vzte+O42V2f33z8ktxkK0yayM92
vx3WP2BvLnen4+XNFzvM98lu8PHk+av5KF9dvnw5f51G+N8un9+i9LqlAd+j/GVc3eXVybDV
j5d+/fbkpze786ury8GcP1zOm/1+92Je5cA5u7gatjNM+yOapLLJts+7JpnHPB/smjTOHsef
e006dFptD3ZNKbby2c9pds2bq+DDXNNYUcsMaj7vmobHre3hrmkQaVaMfuY1pb7V0T/QNc1d
xf7Z1zSnLcqDXVPvW/Oyz7umFkLZP+3PvaaWUtqz+O2rn19fvrv5/sn47uGCL97con6Rcvzl
8KdXry/enEzX+NPFzfe765uTm3fDc+7Rusb82XcoMUp9sDvUsM0m/sxrGvcVHsw6hwAo89zg
uxGlnP0t5fr3Z/NZXm0r/I/nV9cXl292wyPe/nydXSU++x7aCMXig91DD9to68+8pv6+C+Vn
XtOHByny9/fh7PtLOf/H+em7cS3/9OX184s3X76+PBuwz8//Cf9i9+T5j7uT07cXz/7zH/7L
t//127/8/tk/3ePbNP/bv+3t6cWzH0d8NBstlrP5m1mPfr39Vfz6t3L9/u9iCM9PQ7k+DeEi
hHtd1Gc8AntRdfwfuah434vSB72oEdj6F9Xu/aTaA1zUvIL3FzD+Fy9q/JfGRcVjXl9/iItK
+cNFjf+cJ5WPuKgSHtTQQ/iNc1HpmIuKD2vo0TP0uBl6u99Fpf8Bbao8hJ968Iv6DJfw0VX/
6V/+/M0f7uWqS3mIheGbv357r2+rD7IM3fvbHsK5PvTrrZ/xwP/fu6j6P+JF/Y+4DNXPWIY2
C/4/fvP7v87vvZcFtwddX5J+/Y3jytsR4UH7XBL/6Q9/Cl+HfL8n8BnrxvZlX//qT7+bb//D
t+r9vvUzFobbW4z3vcXPdfjzy34Vfnu/L/tcf3/Ul32GWzn+yz7DXRz/ZZ/rBo75sv4ZXuBo
a+yfE6i9OrkZMvb1s+9fnrx4fq9v+5xY9eO3vXx7cfnk9eXpD+/e3us7P4PcF2/evrt59nz6
zelI49v5/86//kbik/PwOD6WxzE+jvL4hxof1/S45sdVHld9XMvjWh/X/rh+/bh+87j+6nH9
9eP6m8f1t49beNx+9bj95nH77eP+zeP+q8f914/7bx733z7+Oj/+Wh5/rY+/Lo+//tXjr3/9
+Jv6+Jv2+Jv++Nf98W/S46uT1/L41fzi9Pj6xU/3uvv/Txew/hDu5utQ7vdlDxBd/upPf73f
dz1AlH7v73oIN3rvh/gQbvSeX5bTQ5hHvp9ny+khfLaGeK8vyw/hs2sI97uzh3hn972z9BDW
KPe8s/y54d/8st/G+xlI/pwM4cfF6ONvnrwYzvn8+bsXL86v7vXln7EqXZ9fXVw+u/l5rEdX
Q8mMwP78H/eK5eeph89/vt8cepkzpS3xaQi9S/qsxPhEiTHXh9lenWhVt/lMn3lNtfcH2pgZ
aCMqyuHzNhA2lCQPtDEz0GYFpn7eZtGGMiTtA7279DSUqvtN7WnF1ycvzmF7Lov8cvfDxat5
vc9/3v3lN3/+/e764uWbk1cfYeocXyifd2tpHq5Js5/Mw9zanI32mfuFG0raxlU90DXlHvUz
6TtQZmeDh9lhn2hFqn7ezvGGorU/zG72RBsv7wGeU8tb+ejDXFMPuchn2/jwS/pAFRsTTaqk
z3QpE6VtlbEPdE3zAPdn865X3SrMHuKa8lg2S9j7grlwP3lx8urV85PTH568vDp5+/3F6TU6
vaZ+TUKqe+Su/TOtYqDEXsvD3W2NLd8uyLd1F9cjrrr+Hm+zk9t89J/eFwNupW7Pdt9cXt7s
/vif/t3H74mtt31VzZvzm58ur36Yd4dfUchX/OVqfvzn3Y9jaXt7db7b/frkx/Pdf7x8c369
+1/Oxu//2/92dX72/cnN09PL1//ro7/Nn/777vcn77/pY9ncy/Ob70ZU9e765rtXF9c3uy+K
PB8Xlarscpq/yzH9cndyPV/NiL3ev5Dzs6ePfj2+aPf25Op6op1cvXz3+vzNzfXTRx+/YIJ/
+JLr+fnzNx8++OFCfn37am9/6vX46Kzvu779mrlqjqt/ffLmbDcrO3eXb28uLt9cf3o346eK
PBmX6t/TuJvtHs7OT05vLn6cD/MpQOTEIT4+hrsg1s+O9z081cf7fbyL+4e2gyudPxrznT/6
6Ndf/+Gff/PnZ7s///UPf/jdH/559/W3uz//8Y9/efror29eTev4+fLdeOznu6t3b968r/fc
nex+vLi6eXfyajzJ0+/H43q8u/n+4no8wXevznanJ++uz9+H68N+Zij96vz19XtGjBu7/PH8
6qeri63Y5Ve//+O3jwZBri9eX7w6uZq1leOH3sO8vbwZL/piXP3P42t+OH//FR++cPfuzfNh
6/MWNmsd9BlX9eLi6vVP27WeX5/fPH306PTm6tWT061k993+bgbxJ+gP869/GnZ7e4tnl+Oi
3teV6gwseuy3Lunm5mdZaXP+5mw+y/Fdk/vjk7cfzO2Tes3xQUW+1X6gmmpD6T11H8X/+jpP
/3zywWQc56Firg2ll1x9FP/ru8S9bxsfzObr0z2+vmvcr8IWxf36HqWm9skHi/n6fPjreyxR
oo9yx9e/p+hfNzf19uLsu9cn/9h9tRvqpHz8tw+++qfp5AbY/PLLN+8rv969fbr7lxG/70bQ
fjks8cWrk5fjp6ZxTsM8eTWrvX/ebVb9Ae3b+bl5/Sc3p9+fXb78eG2Pd3/63a9nLbLk8Ohv
86qn7xnXfvP9BJn/cvLq4sfzpx//8dvzm+vL0x+Gx/si7lLYnZ7FEMI80TIv78XZru7+Fp+l
Z/Hvd37i7OMH2sefj3F+QL0P7L9Cbj+R+CeS/USmF3XXd8j4RBkfCc5H4sePnJ7ffkbnt8Qj
br1sX5KfRT10Kyfp9kOV3/1zey+NXtddd9/pJ+KZ+cQAYU/41H4g8q+4vah8evuRcs/7aC9u
P9L4iz+x19Xp423mAznQq7LfkCO/ptuH+/z2EwcMvt9+4vZZ5QMWb99gFvqJeGuK6eT2I3ok
1/Mhg7fGK9yw7OOVxK0kf/xEvb0PyR8uK93bo4jc762XePsJ5S/xjjsp/B1m+4n28fmWOz8T
znf2Qxq4q7s1+XxrkHrAhG8/cnbrHDWz2x8XJvaR6Ucn7NzO/tLSreFr+/CZu9/lp190+wRK
OPD+b92X3nqWct9l68X+I4k/6PNbZ3/7Cc7Jvc2c7O/lgJnd+op2dvuRzpl/y+N8eyuVm386
N8+4KjfNT64s315ZPcCA/dfk24/Q5XG8fr21s/3XdP5irCNr1CN/+i1y+wTaRy/jfEs3z6wd
eP12MWpKrX+X1H7kwDO2S3fjIV56YT7RuU+21tIzjw6sQ+71wJ3fPt6TWysef+RmfMuv+Hz/
GX4vd0R5gbq+u55XDLeez1kobx9ZOdl/iC/H9tXHcCCiun1mZ7r/TGWfWUx//xnulO/8CHVK
dy5k8TZod74m3vERHrPfISUOxN93fUejn7DWH+Ohm799YGe3i2XcImriX+5wyjEd8mN3POWU
D9jm3qBf7EmQuC+z0U88FLtb7xcPhda3r/N8/9gOBNd3uJqYPz4BubcPOBBd751T33/kwEp+
e/+nef+ZQj9zazbpk6+5N5/LJ0+g8ydw18s5EMnvveDe18qB97mPmPaPQPjSccfrFOE3c3sv
J3urEW6cdi2PwoXl/omdfJJQuK/w07r/DL//O9ID2g8R+o6HVvjS+UnQGPaf4Zp/v9zW/RJd
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
OKwEAA==

--=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-intel12-10:20171014131949:x86_64-randconfig-r0-10140658:4.14.0-rc1-00001-g9ce70d49:1"

#!/bin/bash

kernel=$1
initrd=quantal-core-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.14.0-rc1-00001-g9ce70d49"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.14.0-rc1 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_DOMAIN_DEBUG=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ_FULL_ALL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_SYSCTL_SYSCALL=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
# CONFIG_SHMEM is not set
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_MEMCG_SYSFS_ON=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PADATA=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
# CONFIG_XEN_512GB is not set
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=64
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_MPX=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_X86_POWERNOW_K8=y
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
# CONFIG_RAPIDIO_TSI568 is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_GRO_CELLS is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_TI_DAC7512 is not set
CONFIG_VMWARE_BALLOON=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEACPI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
CONFIG_BLK_DEV_TRIFLEX=y
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
CONFIG_BLK_DEV_IT8213=y
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MQ_DEFAULT=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=y
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=y
CONFIG_DM_CACHE_SMQ=y
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_QL=y
CONFIG_DM_MULTIPATH_ST=y
CONFIG_DM_DELAY=y
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=y
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
CONFIG_DM_ZONED=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
CONFIG_NVM=y
CONFIG_NVM_DEBUG=y
CONFIG_NVM_RRPC=y
CONFIG_NVM_PBLK=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_TWL4030_PWRBUTTON=y
CONFIG_INPUT_TWL4030_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
# CONFIG_INPUT_PCF50633_PMU is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
# CONFIG_INPUT_ADXL34X_SPI is not set
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_XEN=y
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
# CONFIG_SPI_DW_MID_DMA is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_DLN2=y
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_AXP209=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LYNXPOINT=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_SX150X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_RDC321X=y

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_SCH56XX_COMMON is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_SPI=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RTSX_PCI=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AB3100 is not set
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=y
CONFIG_DVB_CORE=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
# CONFIG_VIDEO_AU0828_V4L2 is not set
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=y
CONFIG_VIDEO_CX231XX_RC=y
# CONFIG_VIDEO_CX231XX_DVB is not set
CONFIG_VIDEO_TM6000=y
# CONFIG_VIDEO_TM6000_DVB is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB=y
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=y
CONFIG_DVB_USB_A800=y
CONFIG_DVB_USB_DIBUSB_MB=y
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
CONFIG_DVB_USB_DIBUSB_MC=y
CONFIG_DVB_USB_DIB0700=y
# CONFIG_DVB_USB_UMT_010 is not set
# CONFIG_DVB_USB_CXUSB is not set
# CONFIG_DVB_USB_M920X is not set
CONFIG_DVB_USB_DIGITV=y
# CONFIG_DVB_USB_VP7045 is not set
# CONFIG_DVB_USB_VP702X is not set
CONFIG_DVB_USB_GP8PSK=y
CONFIG_DVB_USB_NOVA_T_USB2=y
CONFIG_DVB_USB_TTUSB2=y
CONFIG_DVB_USB_DTT200U=y
CONFIG_DVB_USB_OPERA1=y
CONFIG_DVB_USB_AF9005=y
# CONFIG_DVB_USB_AF9005_REMOTE is not set
CONFIG_DVB_USB_PCTV452E=y
# CONFIG_DVB_USB_DW2102 is not set
CONFIG_DVB_USB_CINERGY_T2=y
# CONFIG_DVB_USB_DTV5100 is not set
# CONFIG_DVB_USB_FRIIO is not set
# CONFIG_DVB_USB_AZ6027 is not set
# CONFIG_DVB_USB_TECHNISAT_USB2 is not set
CONFIG_DVB_USB_V2=y
# CONFIG_DVB_USB_AF9015 is not set
CONFIG_DVB_USB_AF9035=y
# CONFIG_DVB_USB_ANYSEE is not set
CONFIG_DVB_USB_AU6610=y
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
CONFIG_DVB_USB_EC168=y
CONFIG_DVB_USB_GL861=y
CONFIG_DVB_USB_LME2510=y
CONFIG_DVB_USB_MXL111SF=y
CONFIG_DVB_USB_RTL28XXU=y
CONFIG_DVB_USB_DVBSKY=y
CONFIG_DVB_USB_ZD1301=y
CONFIG_DVB_TTUSB_BUDGET=y
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_SMS_USB_DRV is not set
CONFIG_DVB_B2C2_FLEXCOP_USB=y
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX18 is not set
CONFIG_VIDEO_CX25821=y
CONFIG_VIDEO_CX88=y
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_DVB=y
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=y
CONFIG_VIDEO_CX88_MPEG=y
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_RC is not set
# CONFIG_VIDEO_SAA7134_DVB is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=y
# CONFIG_DVB_AV7110_OSD is not set
# CONFIG_DVB_BUDGET_CORE is not set
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
# CONFIG_DVB_PLUTO2 is not set
CONFIG_DVB_DM1105=y
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_MANTIS_CORE is not set
CONFIG_DVB_NGENE=y
CONFIG_DVB_DDBRIDGE=y
CONFIG_DVB_SMIPCIE=y
CONFIG_DVB_NETUP_UNIDVB=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_WM8775=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_EC100=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_GP8PSK_FE=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_SP2=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
# CONFIG_XEN_FBDEV_FRONTEND is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
CONFIG_FB_AUO_K1901=y
CONFIG_FB_HYPERV=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HWA_HCD=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
# CONFIG_USB_NET2272 is not set
CONFIG_USB_DUMMY_HCD=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC=y
# CONFIG_TYPEC_UCSI is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
CONFIG_UWB_WHCI=y
CONFIG_UWB_I1480U=y
CONFIG_MMC=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_ACCESSIBILITY=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_DECODE_MCE is not set
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I7CORE=y
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=y
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IOATDMA=y
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_UIO_HV_GENERIC=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_BALLOON=y

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
CONFIG_XEN_GRANT_DEV_ALLOC=y
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_ACPI_PROCESSOR=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_IRDA is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=y
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SERIAL2002 is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
# CONFIG_COMEDI_DAS16M1 is not set
# CONFIG_COMEDI_DAS08_ISA is not set
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
# CONFIG_COMEDI_PCMAD is not set
# CONFIG_COMEDI_PCMDA12 is not set
# CONFIG_COMEDI_PCMMIO is not set
# CONFIG_COMEDI_PCMUIO is not set
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
CONFIG_COMEDI_ADDI_APCI_1032=y
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=y
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=y
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
CONFIG_COMEDI_ADL_PCI7X3X=y
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=y
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=y
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
# CONFIG_COMEDI_GSC_HPDI is not set
# CONFIG_COMEDI_MF6X4 is not set
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=y
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
# CONFIG_COMEDI_CB_PCIDAS64 is not set
# CONFIG_COMEDI_CB_PCIDAS is not set
CONFIG_COMEDI_CB_PCIDDA=y
CONFIG_COMEDI_CB_PCIMDAS=y
CONFIG_COMEDI_CB_PCIMDDA=y
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16203=y
CONFIG_ADIS16209=y
# CONFIG_ADIS16240 is not set

#
# Analog to digital converters
#
# CONFIG_AD7606 is not set
CONFIG_AD7780=y
CONFIG_AD7816=y
CONFIG_AD7192=y
# CONFIG_AD7280 is not set

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
# CONFIG_ADT7316_SPI is not set
# CONFIG_ADT7316_I2C is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=y
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=y

#
# Digital gyroscope sensors
#
CONFIG_ADIS16060=y

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y

#
# Light sensors
#
# CONFIG_TSL2x7x is not set

#
# Active energy metering IC
#
# CONFIG_ADE7753 is not set
# CONFIG_ADE7754 is not set
CONFIG_ADE7758=y
CONFIG_ADE7759=y
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
CONFIG_ADE7854_SPI=y

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
# CONFIG_AD2S1210 is not set

#
# Triggers - standalone
#
CONFIG_FB_SM750=y
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=y
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORBUS=y
# CONFIG_UNISYS_VISORNIC is not set
# CONFIG_UNISYS_VISORINPUT is not set
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
# CONFIG_FB_TFT_BD663474 is not set
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
# CONFIG_FB_TFT_HX8353D is not set
# CONFIG_FB_TFT_HX8357D is not set
CONFIG_FB_TFT_ILI9163=y
# CONFIG_FB_TFT_ILI9320 is not set
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
# CONFIG_FB_TFT_PCD8544 is not set
CONFIG_FB_TFT_RA8875=y
# CONFIG_FB_TFT_S6D02A1 is not set
CONFIG_FB_TFT_S6D1121=y
# CONFIG_FB_TFT_SH1106 is not set
CONFIG_FB_TFT_SSD1289=y
CONFIG_FB_TFT_SSD1305=y
# CONFIG_FB_TFT_SSD1306 is not set
CONFIG_FB_TFT_SSD1325=y
CONFIG_FB_TFT_SSD1331=y
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
# CONFIG_FB_TFT_TINYLCD is not set
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=y
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
# CONFIG_FB_TFT_WATTEROTT is not set
# CONFIG_FB_FLEX is not set
# CONFIG_FB_TFT_FBTFT_DEVICE is not set
CONFIG_MOST=y
CONFIG_MOSTCORE=y
CONFIG_AIM_CDEV=y
# CONFIG_AIM_NETWORK is not set
CONFIG_AIM_V4L2=y
CONFIG_HDM_DIM2=y
CONFIG_HDM_I2C=y
# CONFIG_HDM_USB is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_GREYBUS_AUDIO=y
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_FIRMWARE is not set
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
# CONFIG_GREYBUS_I2C is not set
CONFIG_GREYBUS_SDIO=y
CONFIG_GREYBUS_SPI=y
# CONFIG_GREYBUS_UART is not set
CONFIG_GREYBUS_USB=y

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
# CONFIG_TYPEC_FUSB302 is not set
CONFIG_PI433=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CHARDEV=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=y
CONFIG_AD7291=y
CONFIG_AD7298=y
CONFIG_AD7476=y
# CONFIG_AD7766 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
CONFIG_MAX11100=y
CONFIG_MAX1118=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_TLC4541 is not set
# CONFIG_TWL4030_MADC is not set
# CONFIG_TWL6030_GPADC is not set

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5755=y
CONFIG_AD5761=y
CONFIG_AD5764=y
CONFIG_AD5791=y
CONFIG_AD7303=y
# CONFIG_CIO_DAC is not set
CONFIG_AD8801=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=y
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM36651=y
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_DS1803=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_IIO_CROS_EC_BARO=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_HSDK_V1 is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_ALTERA_PR_IP_CORE=y

#
# FSI support
#
CONFIG_FSI=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_DEV_PATH_PARSER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_KMEMCHECK is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
CONFIG_TEST_UDELAY=y
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_NULL=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_IOMMU_DEBUG=y
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_FRAME_POINTER_UNWINDER is not set
# CONFIG_ORC_UNWINDER is not set
CONFIG_GUESS_UNWINDER=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_X86_64=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_UCS2_STRING=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--=_59e1a9b1.8BsJvyoq9pE8RFfs+5TQEa36HC0he/LMu7H7eyCabqgyK8qG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
