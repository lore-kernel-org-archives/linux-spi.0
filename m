From: Baptiste Clenet <bapclenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi-mt7621 doesn't handle message bigger than (rx_len > 32)
Date: Wed, 1 Jul 2015 09:52:42 +0200
Message-ID: <CAPpUg6O=9PfpQCTL7jdzr2rcFJKLJJByAAJabG=sKV6j3-5-ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

When I set a lowpan interface up, it sends some ndisc messages, which
goes through spi (because my transceiver is connected by SPI).
These messages have got a size bigger than what can handle the driver
apparently so WARN_ON is raised:
[  193.320000] ------------[ cut here ]------------
[  193.330000] WARNING: CPU: 0 PID: 175 at
drivers/spi/spi-mt7621.c:148
mt7621_spi_transfer_one_message+0x134/0x448()
[  193.350000] Modules linked in: at86rf230 pppoe ppp_async
iptable_nat pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
nf_conntrack_ipv4 iph
[  193.560000] CPU: 0 PID: 175 Comm: spi32766 Not tainted 4.0.4 #22
[  193.570000] Stack : 00000000 00000000 00000001 00000000 802b86d4
80311de3 000000af 8035342c
          818ee570 819a2388 819a2200 00000004 80ea450c 80049318
00000003 802bd674
          00000094 819a2388 802bbc78 819bbd7c 80ea450c 8004785c
00000000 00000004
          00000001 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          ...
[  193.650000] Call Trace:
[  193.650000] [<8001475c>] show_stack+0x48/0x70
[  193.660000] [<80025260>] warn_slowpath_common+0xa0/0xd0
[  193.670000] [<80025318>] warn_slowpath_null+0x18/0x24
[  193.680000] [<801b7ec4>] mt7621_spi_transfer_one_message+0x134/0x448
[  193.690000] [<801b6e4c>] __spi_pump_messages+0x404/0x464
[  193.700000] [<8003ad80>] kthread_worker_fn+0xa8/0xf4
[  193.710000] [<8003aea4>] kthread+0xd8/0xe4
[  193.720000] [<80004878>] ret_from_kernel_thread+0x14/0x1c
[  193.730000]
[  193.730000] ---[ end trace 0d3b96d7ce28c6fc ]---

How to handle that? Re-writing the spi-driver? Any patches?

Using Linux 4.1

-- 
Baptiste
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
