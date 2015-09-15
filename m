From: =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Subject: resend [BUG] atmel: spi: scheduling while atomic
Date: Tue, 15 Sep 2015 16:10:16 +0200
Message-ID: <55F826C8.7090304@aksignal.cz>
Reply-To: jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
again I discovered a problem when I access devices on SPI. It appears if I access one device pretty often (about once at 
second) and the error message appears about 3 times a hour. Nevertheless it works correctly.
I thing it's in kernels 3.17 and 3.18 maybe even longer, now I have 3.18.21.

...
[10176.960000] BUG: scheduling while atomic: spi0/401/0x00000002
[10176.960000] Modules linked in:
[10176.960000] Preemption disabled at:[<  (null)>]   (null)
[10176.960000]
[10176.960000] CPU: 0 PID: 401 Comm: spi0 Tainted: G        W      3.18.21_cpm9g25 #2
[10176.960000] [<c000eef4>] (unwind_backtrace) from [<c000c558>] (show_stack+0x20/0x24)
[10176.960000] [<c000c558>] (show_stack) from [<c04a214c>] (dump_stack+0x20/0x28)
[10176.960000] [<c04a214c>] (dump_stack) from [<c049fc74>] (__schedule_bug+0x88/0xac)
[10176.960000] [<c049fc74>] (__schedule_bug) from [<c04a3488>] (__schedule+0x68/0x508)
[10176.960000] [<c04a3488>] (__schedule) from [<c04a3ae0>] (schedule+0xa0/0xa4)
[10176.960000] [<c04a3ae0>] (schedule) from [<c04a3cac>] (schedule_preempt_disabled+0x20/0x2c)
[10176.960000] [<c04a3cac>] (schedule_preempt_disabled) from [<c04a5684>] (__mutex_lock_slowpath+0xe8/0x17c)
[10176.960000] [<c04a5684>] (__mutex_lock_slowpath) from [<c04a5758>] (mutex_lock+0x40/0x44)
[10176.960000] [<c04a5758>] (mutex_lock) from [<c039086c>] (clk_prepare_lock+0x58/0xf4)
[10176.960000] [<c039086c>] (clk_prepare_lock) from [<c0391808>] (clk_get_rate+0x1c/0x54)
[10176.960000] [<c0391808>] (clk_get_rate) from [<c0311c60>] (atmel_spi_transfer_one_message+0x264/0x9ec)
[10176.960000] [<c0311c60>] (atmel_spi_transfer_one_message) from [<c030f428>] (spi_pump_messages+0x5cc/0x5f0)
[10176.960000] [<c030f428>] (spi_pump_messages) from [<c003541c>] (kthread_worker_fn+0x140/0x1ac)
[10176.960000] [<c003541c>] (kthread_worker_fn) from [<c00355c4>] (kthread+0xd4/0xe8)
[10176.960000] [<c00355c4>] (kthread) from [<c0009798>] (ret_from_fork+0x14/0x20)
...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
