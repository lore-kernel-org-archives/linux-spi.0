From: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
 atmel_spi (AT91RM9200)
Date: Sat, 26 May 2007 17:02:25 +0300
Message-ID: <20070526170225.029c1448@newbox>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>
	<20070525180236.33f634d2@newbox>
	<20070525175502.4927c151@dhcp-255-175.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Nicolas-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org,
	Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>,
	Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070525175502.4927c151-RzfXdsu3MTOUA/xf2v/QOMGzbamoMwWuEvhb3Hwu1Ks@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 25 May 2007 17:55:02 +0200
Haavard Skinnemoen wrote:

> 
> Hmm...not too surprising really. Could you add a call to show_state()
> as well? I suspect it will just show init waiting for completion in
> spi_sync() though.
> 

Haavard, log with show_state() is attached, seems you are right it's waiting for completion.

[<c017f040>] (schedule+0x0/0x750) from [<c017f83c>] (wait_for_completion+0xac/0x110)
[<c017f790>] (wait_for_completion+0x0/0x110) from [<c0120018>] (spi_sync+0x54/0x68)
 r6:00000000 r5:c0405c78 r4:c0405c00
[<c011ffc4>] (spi_sync+0x0/0x68) from [<c0120170>] (spi_write_then_read+0x144/0x204)
 r7:c01eb978 r6:c0405c78 r5:c06aa6e0 r4:00000001
[<c012002c>] (spi_write_then_read+0x0/0x204) from [<c011f664>] (dataflash_probe+0x6c/0x244)
[<c011f5f8>] (dataflash_probe+0x0/0x244) from [<c011f99c>] (spi_drv_probe+0x3c/0x48)
 r6:c01eb634 r5:00000000 r4:c03ea200
[<c011f960>] (spi_drv_probe+0x0/0x48) from [<c0104e7c>] (driver_probe_device+0xe8/0x18c)
 r4:c03ea200
[<c0104d94>] (driver_probe_device+0x0/0x18c) from [<c0104f30>] (__device_attach+0x10/0x14)


> What might be more interesting is a dump of the contents of the SPI
> controller registers, i.e. something like this:
> 
> 	void *p;
> 	int i;
> 
> 	p = ioremap(0xfffe0000);
> 	for (i = 0; i < 0x100; i += 16)
> 		printk("%04x: %08x %08x %08x %08x\n", i,
> 			readl(p + i), readl(p + i + 4),
> 			readl(p + i + 8), readl(p + i + 12));
> 	iounmap(p);
> 

Here is dump of SPI regs:

Power!
0000: 00000000 000e0011 00000000 00000000
0010: 000100a0 00000000 00000000 00000018
0020: 00000000 00000000 00000000 00000000
0030: 0a0a0202 00000000 00000000 00000000
0040: 00000000 00000000 00000000 00000000
0050: 00000000 00000000 00000000 00000000
0060: 00000000 00000000 00000000 00000000
0070: 00000000 00000000 00000000 00000000
0080: 00000000 00000000 00000000 00000000
0090: 00000000 00000000 00000000 00000000
00a0: 00000000 00000000 00000000 00000000
00b0: 00000000 00000000 00000000 00000000
00c0: 00000000 00000000 00000000 00000000
00d0: 00000000 00000000 00000000 00000000
00e0: 00000000 00000000 00000000 00000000
00f0: 00000000 00000000 00000000 00000000

P.S. I placed ioremap outside irq handler, otherwise it complains
kernel BUG at mm/vmalloc.c:171!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000

BR, 
Ivan

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
