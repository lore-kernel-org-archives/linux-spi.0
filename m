From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-rc2-git] SPI: add 3wire mode
	flag
Date: Thu, 31 May 2007 21:44:35 -0700
Message-ID: <200705312144.36282.david-b@pacbell.net>
References: <200705221242.49050.david-b@pacbell.net>
	<200705230843.51147.david-b@pacbell.net>
	<1180666086.22670.19.camel@ktp.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kaiwan-IEKcLuOed2vyqGx8YZ3XskEOCMrvLtNR@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1180666086.22670.19.camel-39dk4Mr1OVg@public.gmane.org>
Content-Disposition: inline
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

[ To folk on the CC list, this is mostly about a parport adapter
driver that hasn't recently been sent to this list ... it needs
to use the SPI_3WIRE flag, that's the relevance to $SUBJECT ]


On Thursday 31 May 2007, you wrote:
> Hi David,
> 
> I did get down to testing the patches you sent me... I built the
> 2.6.22-rc3 kernel & worked off it.
> 
> Both drivers (lm70.c & lm70_spi.c) build fine, but lm70_spi Oops'es
> (have pasted the Oops o/p below fyi --any ideas?).

No; I don't notice any changes in that area.

You shouldn't need to provide your own setup() method
anyway ... much less one that just calls the default
(and then discards its status code)!


> Will continue working on it today..
> 
> > > > +	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
> > > > +	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !spi->mode & SPI_3WIRE)
> > > 
> > > I don't know anything about SPI, but the second half of the test looks
> > > broken to me. Missing parentheses?
> > 
> > Right, my bad ... Kaiwan would surely have seen that in his testing
> 
> Nope, my compiler does'nt catch it either..still, i think i'll set it
> right.

Right.  :)

 
> One qs. Dave (perhaps a silly one, forgive me :) :
> which kernel ver did you work off when generating the patches you sent? 
> Would it matter v much? If so, where can I download it..

As it says in $SUBJECT ... or better, try on 2.6.22-rc3.

- Dave


 
> Kaiwan.
> 
> ----------------------------------------------------------------------------------------------------------------------------------------
> Oops testing spi_lm70 / lm70 w/ Dave Brownell's new patches (31May07):
> 
> --snip--
> [  582.907303] pnp: Device 00:0c activated.
> [  582.907817] parport_pc 00:0c: reported by Plug and Play ACPI
> [  582.908481] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> [  583.077843] parport_pc 00:0c: registered master spi4294967294
> (dynamic)
> [  583.078114] BUG: unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [  583.078123]  printing eip:
> [  583.078125] 00000000
> [  583.078128] *pde = 0ef7c067
> [  583.078130] *pte = 00000000
> [  583.078136] Oops: 0000 [#1]
> [  583.078138] PREEMPT
> [  583.078142] Modules linked in: parport_pc spi_lm70 spi_bitbang
> parport lm70 ipv6 autofs4 sunrpc dm_mod button battery ac uhci_hcd
> shpchp i2c_i801 i2c_core natsemi floppy
> [  583.078162] CPU:    0
> [  583.078163] EIP:    0060:[<00000000>]    Not tainted VLI
> [  583.078165] EFLAGS: 00210246   (2.6.22-rc3 #3)
> [  583.078172] EIP is at 0x0
> [  583.078176] eax: ce81d6b8   ebx: ce81d6b8   ecx: c2c73dd8   edx:
> 00000000
> [  583.078180] esi: cf1efbb0   edi: c2c73d10   ebp: cfafbf14   esp:
> cfafbee4
> [  583.078184] ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
> [  583.078188] Process insmod (pid: 4209, ti=cfafb000 task=c07fcb00
> task.ti=cfafb000)
> [  583.078191] Stack: d084f259 ffffffff ce81d838 0000000a 00000014
> ce81d824 c03cb3a3 cfafbf30
> [  583.078201]        c2c73dd8 ce81d6b8 c2c73e4c c2c73d10 cfafbf1c
> d08640e8 cfafbf50 c02900e4
> [  583.078211]        ce81d824 00000014 c03cb39e c2c73db4 00000000
> fffffff0 ce81d824 c129ee48
> [  583.078221] Call Trace:
> [  583.078224]  [<c01046fa>] show_trace_log_lvl+0x1a/0x30
> [  583.078239]  [<c01047ca>] show_stack_log_lvl+0x9a/0xc0
> [  583.078244]  [<c0104a1d>] show_registers+0x1cd/0x340
> [  583.078249]  [<c0104d7c>] die+0x16c/0x210
> [  583.078253]  [<c0116d4b>] do_page_fault+0x2bb/0x5e0
> [  583.078260]  [<c0336daa>] error_code+0x6a/0x70
> [  583.078269]  [<d08640e8>] lm70_master_setup+0x8/0x10 [spi_lm70]
> [  583.078277]  [<c02900e4>] spi_new_device+0xf4/0x200
> [  583.078287]  [<d086423c>] spi_lm70_attach+0x14c/0x220 [spi_lm70]
> [  583.078293]  [<d090c14d>] parport_register_driver+0x2d/0x80 [parport]
> [  583.078306]  [<d086600d>] init_spi_lm70+0xd/0xf [spi_lm70]
> [  583.078311]  [<c01426a7>] sys_init_module+0xf7/0x150
> [  583.078320]  [<c01040f6>] sysenter_past_esp+0x5f/0x99
> [  583.078325]  =======================
> [  583.078327] Code:  Bad EIP value.
> [  583.078334] EIP: [<00000000>] 0x0 SS:ESP 0068:cfafbee4
> --
> 
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
