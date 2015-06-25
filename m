From: Jonas Andersson <jonas-tL4/tsH4a1YwFerOooGFRg@public.gmane.org>
Subject: at91 spi problems
Date: Thu, 25 Jun 2015 11:12:13 +0200
Message-ID: <558BC5ED.3070300@microbit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

I am working on with a spi wifi module connected to a a91sam9260 soc, 
unsing linux 3.19.

The driver does two transfers in one message and sets cs_change:

         spi_message_init(&m);
         memset(t, 0, sizeof(t));

         t[0].tx_buf = cmd;
         t[0].len = 4;
         t[0].cs_change = true;
         spi_message_add_tail(&t[0], &m);

         /* Busy and non busy words read */
         t[1].rx_buf = busy_buf;
         t[1].len = WL1271_BUSY_WORD_LEN;
         t[1].cs_change = true;
         spi_message_add_tail(&t[1], &m);

         spi_sync(to_spi_device(glue->dev), &m);

this triggers an error:

[ 4686.320000] ------------[ cut here ]------------
[ 4686.320000] WARNING: CPU: 0 PID: 881 at drivers/spi/spi-atmel.c:1089 
atmel_spi_transfer_one_message+0x854/0xb64()
[ 4686.320000] Modules linked in: wlcore_spi wl12xx wlcore mac80211 
cfg80211 [last unloaded: wlcore_spi]
[ 4686.320000] CPU: 0 PID: 881 Comm: spi1 Not tainted 3.19.0+ #20
[ 4686.320000] Hardware name: Atmel AT91SAM (Device Tree)
[ 4686.320000] [<c000e3ac>] (unwind_backtrace) from [<c000be70>] 
(show_stack+0x10/0x14)
[ 4686.320000] [<c000be70>] (show_stack) from [<c0014c00>] 
(warn_slowpath_common+0x80/0xa8)
[ 4686.320000] [<c0014c00>] (warn_slowpath_common) from [<c0014c40>] 
(warn_slowpath_null+0x18/0x1c)
[ 4686.320000] [<c0014c40>] (warn_slowpath_null) from [<c01b8dac>] 
(atmel_spi_transfer_one_message+0x854/0xb64)
[ 4686.320000] [<c01b8dac>] (atmel_spi_transfer_one_message) from 
[<c01b6c04>] (spi_pump_messages+0x3a0/0x3c0)
[ 4686.320000] [<c01b6c04>] (spi_pump_messages) from [<c00284b8>] 
(kthread_worker_fn+0xfc/0x110)
[ 4686.320000] [<c00284b8>] (kthread_worker_fn) from [<c002858c>] 
(kthread+0xc0/0xd4)
[ 4686.320000] [<c002858c>] (kthread) from [<c0009538>] 
(ret_from_fork+0x14/0x3c)
[ 4686.320000] ---[ end trace 358e59d225b0a29d ]---
[ 4686.320000] wl1271_spi spi1.0: spi trasfer timeout, err 0
[ 4686.320000] atmel_spi fffcc000.spi: overrun (0/4 remaining)

If I split this in two messages i dont get this error. Also if i remove 
cs_change from first transfer i dont get the error.

Thanks
  Jonas Andersson
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
