From: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: mxc_spi producing kernel panic during spi_async
Date: Sat, 26 Nov 2011 21:13:31 +0000
Message-ID: <CAN=k24kxSbJh1nQ=V8MZ8PwukhDD2Vs+sqS4r2tysrTxrhEw9Q@mail.gmail.com>
References: <CAN=k24=6uvoBTobj3RGZGD8qec_dqtWp47OXGEaUmDPKhdkwPw@mail.gmail.com>
	<20111126170829.GA5951@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20111126170829.GA5951@tarshish>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Nov 26, 2011 at 5:08 PM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> Hi Wayne,
>
> On Fri, Nov 25, 2011 at 04:38:10PM +0000, Wayne Tams wrote:
>> I am needing some help understanding a kernel panic when I try to load
>> the at25 eeprom driver, I have traced it to the spi_async function in
>> drivers/spi/spi.c but I do not know where to go to from here. I have
>> found some similar issues in forum posts but threads never offer a
>> solution which has left me scratching my head. Perhaps I am missing
>> something in my kernel configuration?
>>
>> I am using the 2.6.35 kernel and mxc_spi driver for my i.Mx53
>> platform. The message returned from the kernel is as follows
>
> Since the mxc_spi is not in the mainline kernel, people here can't help y=
ou
> much. Try using the mainlined spi_imx driver (renamed to spi-imx since ke=
nrel
> version 3.1).

Oh sorry, it didn't click that mxc_spi was not in the mainline. I
think I need to find out why this driver was favored over the spi-imx
driver? Hopefully whoever from Freescale that can answer that question
should hopefully help me get to the root of the problem.
>
> The following command might give you a hint as to what source line has
> exploded:
>
> ${cross-compiler-prefix}-addr2line -e vmlinux 0x80210ae0

I will try this, thanks for the tip
>
> This assumes that you've built your kernel with debug info, and that the
> mxc_spi driver is built into the kernel and not compiled as a module.
>
> baruch
>
>> # modprobe at25
>> [ =A0 14.378564] 1
>> [ =A0 14.380286] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>> [ =A0 14.394892] pgd =3D 80004000
>> [ =A0 14.397618] [00000000] *pgd=3D00000000
>> [ =A0 14.401220] Internal error: Oops: 17 [#1] PREEMPT
>> [ =A0 14.405932] last sysfs file: /sys/class/gsl_kmod/gsl_kmod/dev
>> [ =A0 14.411687] Modules linked in: at25(+)
>> [ =A0 14.415474] CPU: 0 =A0 =A0Not tainted =A0(2.6.35.3-744-g27fdf7b-g7e=
6da4e-dirty #24)
>> [ =A0 14.422635] PC is at mxc_spi_buf_tx_u8+0x1c/0x28
>> [ =A0 14.427263] LR is at spi_put_tx_data+0x34/0x5c
>> [ =A0 14.431716] pc : [<80210ae0>] =A0 =A0lr : [<80210c30>] =A0 =A0psr: =
60000013
>> [ =A0 14.431726] sp : 990e3ee8 =A0ip : 80210ad8 =A0fp : 990e3ef4
>> [ =A0 14.443220] r10: 990e2000 =A0r9 : 990c4600 =A0r8 : 990c4518
>> [ =A0 14.448453] r7 : 00000000 =A0r6 : 990c4518 =A0r5 : 00000001 =A0r4 :=
 9a866000
>> [ =A0 14.454989] r3 : 00000000 =A0r2 : 990c4518 =A0r1 : 00000001 =A0r0 :=
 990c4518
>> [ =A0 14.461528] Flags: nZCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0ISA=
 ARM
>> Segment kernel
>> [ =A0 14.468848] Control: 10c5387d =A0Table: 89410019 =A0DAC: 00000017
>> [ =A0 14.474602] Process mxc_spi.1 (pid: 145, stack limit =3D 0x990e22e8)
>> [ =A0 14.480792] Stack: (0x990e3ee8 to 0x990e4000)
>> [ =A0 14.485162] 3ee0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 990e3f14 990e=
3ef8 80210c30
>> 80210ad0 990c4518 993c3d80
>> [ =A0 14.493356] 3f00: 990c4600 00000000 990e3f34 990e3f18 802117ac
>> 80210c08 993c3d80 00000000
>> [ =A0 14.501550] 3f20: 993c3dc4 993c3da4 990e3f74 990e3f38 8021066c
>> 802116cc 990c452c 80210c84
>> [ =A0 14.509744] 3f40: 00000000 ffffffff 990c5b88 990e2000 990c5b80
>> 990c5b88 990c4520 990c451c
>> [ =A0 14.517938] 3f60: 802104e0 80480d80 990e3fc4 990e3f78 8006c4a4
>> 802104ec 9908f9e0 9908f9e0
>> [ =A0 14.526131] 3f80: 990e3fc4 00000000 9908f9e0 8007089c 990e3f90
>> 990e3f90 990e3fc4 99029d98
>> [ =A0 14.534325] 3fa0: 990e3fcc 8006c2a4 990c5b80 00000000 00000000
>> 00000000 990e3ff4 990e3fc8
>> [ =A0 14.542518] 3fc0: 800703dc 8006c2b0 00000000 00000000 990e3fd0
>> 990e3fd0 99029d98 80070350
>> [ =A0 14.550711] 3fe0: 8002a16c 00000013 00000000 990e3ff8 8002a16c
>> 8007035c 00000000 00000000
>> [ =A0 14.558918] [<80210ae0>] (mxc_spi_buf_tx_u8+0x1c/0x28) from
>> [<80210c30>] (spi_put_tx_data+0x34/0x5c)
>> [ =A0 14.568073] [<80210c30>] (spi_put_tx_data+0x34/0x5c) from
>> [<802117ac>] (mxc_spi_transfer+0xec/0x16c)
>> [ =A0 14.577225] [<802117ac>] (mxc_spi_transfer+0xec/0x16c) from
>> [<8021066c>] (bitbang_work+0x18c/0x314)
>> [ =A0 14.586294] [<8021066c>] (bitbang_work+0x18c/0x314) from
>> [<8006c4a4>] (worker_thread+0x200/0x2b4)
>> [ =A0 14.595192] [<8006c4a4>] (worker_thread+0x200/0x2b4) from
>> [<800703dc>] (kthread+0x8c/0x94)
>> [ =A0 14.603479] [<800703dc>] (kthread+0x8c/0x94) from [<8002a16c>]
>> (kernel_thread_exit+0x0/0x8)
>> [ =A0 14.611850] Code: e92d4000 ebf86186 e590304c e1a02000 (e4d30001)
>> [ =A0 14.620165] ---[ end trace 46f1e82486d44485 ]---
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~. .~ =A0 Tk Open Systems
> =3D}------------------------------------------------ooO--U--Ooo----------=
--{=3D
> =A0 - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure =

contains a definitive record of customers, application performance, =

security threats, fraudulent activity, and more. Splunk takes this =

data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
