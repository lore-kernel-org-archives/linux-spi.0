From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: spi-s3c64xx: problems with SPI_MODE_3 transfers
Date: Sun, 8 Apr 2012 20:39:33 +0200
Message-ID: <201204082039.34325.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[@jassi: I know that you do not work at this stuff any longer, but I included 
you in the list of recipients in the hope that you might be able to give me a 
pointer on where to look for the culprit of the problem :-) ]


Hi,

while working on the beginnings of a wireless driver connected via SPI [1], 
the s3c64xx-spi-driver produced strange problems while doing MODE_3  (CPOL | 
CPHA) transfers: [2]

[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
(chip_id = 0x0000, chip_rev = 0x00) 
mapped channel 24 to 0
mapped channel 23 to 1
[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
CIR: 0
[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
mt592x_spi spi0.0: I/O Error: rx-1 tx-0 res:rx-f tx-p len-4
CIR: 0
[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
CIR: 0
[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
CIR: 0
[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
CIR: 0

where the expected result would be:

[write] spi cur_bpw: 8:  0x00 0x00 0x04 0x00
[read]  spi cur_bpw: 8:  0x00 0x00 0x00 0x00
[read]  spi cur_bpw: 8:  0x21 0x59 0x91 0x00

The pattern of either empty results or read errors also varies with each 
invocation, i.e. sometimes all fail or all result in wrong values and so on.


In contrast when doing this with the spi-gpio driver, everything works as 
expected and I get the expected results. 

Also the device-family I'm working on contains a variant with a Marvell 8686 
wlan chip [= the rest of the system is the same]. Using the spi-s3c64xx with 
the libertas driver (MODE_0) works as expected.


As I'm not sure where I should look for errors in the driver, I would be glad 
to get pointers in the right direction.


Thanks
Heiko


[1] a MediaTek MT5921
[2] the ouput is a simple

printk("spi cur_bpw: %d: ", sdd->cur_bpw);
for(tmp = 0; tmp < xfer->len; tmp++)
  printk(" 0x%02x", ((u8 *)xfer->tx_buf)[tmp]);
printk("\n");

same for rxbuf

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
