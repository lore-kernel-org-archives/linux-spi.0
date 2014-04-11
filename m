From: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Subject: spi-atmel: scheduling while atomic
Date: Fri, 11 Apr 2014 15:25:43 +0200
Message-ID: <1734135.RAAc8zgbc4@kongar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I'm trying to use device-tree on my at91sam9263 based board. Works so far, but I'm getting those BUGs
for each SPI device being probed (2 in my case)

[    2.787000] BUG: scheduling while atomic: spi32766/37/0x00000002                                                                                                                                                                          
[    2.793000] Modules linked in:                                                                                                                                                                                                            
[    2.796000] CPU: 0 PID: 37 Comm: spi32766 Not tainted 3.14.0+ #72                                                                                                                                                                         
[    2.802000] [<c000d8dc>] (unwind_backtrace) from [<c000bcfc>] (show_stack+0x10/0x14)                                                                                                                                                      
[    2.810000] [<c000bcfc>] (show_stack) from [<c0355a54>] (__schedule_bug+0x48/0x64)                                                                                                                                                        
[    2.818000] [<c0355a54>] (__schedule_bug) from [<c0359880>] (__schedule+0x64/0x410)                                                                                                                                                       
[    2.826000] [<c0359880>] (__schedule) from [<c0359554>] (schedule_timeout+0x164/0x190)                                                                                                                                                    
[    2.834000] [<c0359554>] (schedule_timeout) from [<c035a734>] (wait_for_common+0x180/0x1d0)                                                                                                                                               
[    2.842000] [<c035a734>] (wait_for_common) from [<c0242aa8>] (atmel_spi_one_transfer+0x8dc/0xb7c)                                                                                                                                         
[    2.851000] [<c0242aa8>] (atmel_spi_one_transfer) from [<c0242df8>] (atmel_spi_transfer_one_message+0xb0/0x1ac)                                                                                                                           
[    2.861000] [<c0242df8>] (atmel_spi_transfer_one_message) from [<c023f500>] (spi_pump_messages+0x1dc/0x204)                                                                                                                               
[    2.871000] [<c023f500>] (spi_pump_messages) from [<c002fc30>] (kthread_worker_fn+0x154/0x170)                                                                                                                                            
[    2.880000] [<c002fc30>] (kthread_worker_fn) from [<c002fd0c>] (kthread+0xc0/0xd4)                                                                                                                                                        
[    2.887000] [<c002fd0c>] (kthread) from [<c0009630>] (ret_from_fork+0x14/0x24)                                                                                                                                                            

Currently, I can't figure out why this happens. It's a plain v3.14 kernel with some own patches which don't affect SPI.

Best regards,
Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
