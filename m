From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: mxc_spi producing kernel panic during spi_async
Date: Sat, 26 Nov 2011 19:08:30 +0200
Message-ID: <20111126170829.GA5951@tarshish>
References: <CAN=k24=6uvoBTobj3RGZGD8qec_dqtWp47OXGEaUmDPKhdkwPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN=k24=6uvoBTobj3RGZGD8qec_dqtWp47OXGEaUmDPKhdkwPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wayne,

On Fri, Nov 25, 2011 at 04:38:10PM +0000, Wayne Tams wrote:
> I am needing some help understanding a kernel panic when I try to load
> the at25 eeprom driver, I have traced it to the spi_async function in
> drivers/spi/spi.c but I do not know where to go to from here. I have
> found some similar issues in forum posts but threads never offer a
> solution which has left me scratching my head. Perhaps I am missing
> something in my kernel configuration?
> 
> I am using the 2.6.35 kernel and mxc_spi driver for my i.Mx53
> platform. The message returned from the kernel is as follows

Since the mxc_spi is not in the mainline kernel, people here can't help you 
much. Try using the mainlined spi_imx driver (renamed to spi-imx since kenrel 
version 3.1).

The following command might give you a hint as to what source line has 
exploded:

${cross-compiler-prefix}-addr2line -e vmlinux 0x80210ae0

This assumes that you've built your kernel with debug info, and that the 
mxc_spi driver is built into the kernel and not compiled as a module.

baruch

> # modprobe at25
> [   14.378564] 1
> [   14.380286] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [   14.394892] pgd = 80004000
> [   14.397618] [00000000] *pgd=00000000
> [   14.401220] Internal error: Oops: 17 [#1] PREEMPT
> [   14.405932] last sysfs file: /sys/class/gsl_kmod/gsl_kmod/dev
> [   14.411687] Modules linked in: at25(+)
> [   14.415474] CPU: 0    Not tainted  (2.6.35.3-744-g27fdf7b-g7e6da4e-dirty #24)
> [   14.422635] PC is at mxc_spi_buf_tx_u8+0x1c/0x28
> [   14.427263] LR is at spi_put_tx_data+0x34/0x5c
> [   14.431716] pc : [<80210ae0>]    lr : [<80210c30>]    psr: 60000013
> [   14.431726] sp : 990e3ee8  ip : 80210ad8  fp : 990e3ef4
> [   14.443220] r10: 990e2000  r9 : 990c4600  r8 : 990c4518
> [   14.448453] r7 : 00000000  r6 : 990c4518  r5 : 00000001  r4 : 9a866000
> [   14.454989] r3 : 00000000  r2 : 990c4518  r1 : 00000001  r0 : 990c4518
> [   14.461528] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [   14.468848] Control: 10c5387d  Table: 89410019  DAC: 00000017
> [   14.474602] Process mxc_spi.1 (pid: 145, stack limit = 0x990e22e8)
> [   14.480792] Stack: (0x990e3ee8 to 0x990e4000)
> [   14.485162] 3ee0:                   990e3f14 990e3ef8 80210c30
> 80210ad0 990c4518 993c3d80
> [   14.493356] 3f00: 990c4600 00000000 990e3f34 990e3f18 802117ac
> 80210c08 993c3d80 00000000
> [   14.501550] 3f20: 993c3dc4 993c3da4 990e3f74 990e3f38 8021066c
> 802116cc 990c452c 80210c84
> [   14.509744] 3f40: 00000000 ffffffff 990c5b88 990e2000 990c5b80
> 990c5b88 990c4520 990c451c
> [   14.517938] 3f60: 802104e0 80480d80 990e3fc4 990e3f78 8006c4a4
> 802104ec 9908f9e0 9908f9e0
> [   14.526131] 3f80: 990e3fc4 00000000 9908f9e0 8007089c 990e3f90
> 990e3f90 990e3fc4 99029d98
> [   14.534325] 3fa0: 990e3fcc 8006c2a4 990c5b80 00000000 00000000
> 00000000 990e3ff4 990e3fc8
> [   14.542518] 3fc0: 800703dc 8006c2b0 00000000 00000000 990e3fd0
> 990e3fd0 99029d98 80070350
> [   14.550711] 3fe0: 8002a16c 00000013 00000000 990e3ff8 8002a16c
> 8007035c 00000000 00000000
> [   14.558918] [<80210ae0>] (mxc_spi_buf_tx_u8+0x1c/0x28) from
> [<80210c30>] (spi_put_tx_data+0x34/0x5c)
> [   14.568073] [<80210c30>] (spi_put_tx_data+0x34/0x5c) from
> [<802117ac>] (mxc_spi_transfer+0xec/0x16c)
> [   14.577225] [<802117ac>] (mxc_spi_transfer+0xec/0x16c) from
> [<8021066c>] (bitbang_work+0x18c/0x314)
> [   14.586294] [<8021066c>] (bitbang_work+0x18c/0x314) from
> [<8006c4a4>] (worker_thread+0x200/0x2b4)
> [   14.595192] [<8006c4a4>] (worker_thread+0x200/0x2b4) from
> [<800703dc>] (kthread+0x8c/0x94)
> [   14.603479] [<800703dc>] (kthread+0x8c/0x94) from [<8002a16c>]
> (kernel_thread_exit+0x0/0x8)
> [   14.611850] Code: e92d4000 ebf86186 e590304c e1a02000 (e4d30001)
> [   14.620165] ---[ end trace 46f1e82486d44485 ]---

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
