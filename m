From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] spi: SuperH MSIOF SPI Master driver
Date: Thu, 26 Nov 2009 15:37:28 +0900
Message-ID: <aec7e5c30911252237g73f6af6fg1de6fb802365704c@mail.gmail.com>
References: <20091124125531.14957.41264.sendpatchset@rxone.opensource.se>
	 <20091125121152.4ccf03dc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758291AbZKZGhY@vger.kernel.org>
In-Reply-To: <20091125121152.4ccf03dc.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andrew,

On Thu, Nov 26, 2009 at 5:11 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 24 Nov 2009 21:55:31 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>> This patch adds SPI Master support for the SuperH MSIOF
>> --- 0001/drivers/spi/spi.c
>> +++ work/drivers/spi/spi.c =A0 =A02009-11-24 20:39:48.000000000 +090=
0
>> @@ -17,7 +17,6 @@
>> =A0 * along with this program; if not, write to the Free Software
>> =A0 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> =A0 */
>> -
>> =A0#include <linux/kernel.h>
>> =A0#include <linux/device.h>
>> =A0#include <linux/init.h>
>
> whoops?

Yeah, i totally missed that one.

>> --- /dev/null
>> +++ work/drivers/spi/spi_sh_msiof.c =A0 2009-11-24 20:39:49.00000000=
0 +0900
>> @@ -0,0 +1,675 @@
>> +/*
>> + * SuperH MSIOF SPI Master Interface
>> + *
>> + * Copyright (c) 2009 Magnus Damm
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>
> But not consistently.

Never. =3D)

>> +#include <linux/init.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/completion.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/gpio.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/spi_bitbang.h>
>> +#include <linux/spi/sh_msiof.h>
>> +
>> +#include <asm/spi.h>
>> +#include <asm/unaligned.h>
>> +
>> +struct sh_msiof_spi_priv {
>> + =A0 =A0 struct spi_bitbang bitbang; /* must be first for spi_bitba=
ng.c */
>
> Well if that's the case then spi_bitbang.c needs smacking. =A0What ca=
uses
> this requirement?

The spi_bitbang.c functions spi_bitbang_setup() and
spi_bitbang_transfer() use spi_master_get_devdata() to get the bitbang
data structure. Most drivers want to be able to get a pointer to
private data using spi_master_get_devdata(), so the
bitbang-structure-as-first-member trick is used so the driver code and
the bitbang functions can coexist.

A couple of in-tree drivers do the same thing and store the bitbang
structure as the first member. For instance, have a look at
omap_uwire.c and spi_gpio.c.

Maybe adding a spi_alloc_bitbang_master() function to spi_bitbang.c
that does the bitbang structure allocation behind the scenes would be
a good thing. The bitbang drivers can then use that function instead
of spi_alloc_master(). The bitbang code itself can retrieve the
bitbang structure by doing offset calculations from the master
pointer. That would free up the private pointer.

There may be better ways to do this though...

>> +static void sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned long clr, unsigned long set)
>> +{
>> + =A0 =A0 unsigned long mask =3D clr | set;
>> + =A0 =A0 unsigned long data;
>> +
>> + =A0 =A0 data =3D sh_msiof_read(p, CTR);
>> + =A0 =A0 data &=3D ~clr;
>> + =A0 =A0 data |=3D set;
>> + =A0 =A0 sh_msiof_write(p, CTR, data);
>> +
>> + =A0 =A0 while ((sh_msiof_read(p, CTR) & mask) !=3D set)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ;
>
> hm, confidence. =A0No timeout needed here?

Good plan, I'll add some timeout handling code.

>> +static struct {
>> + =A0 =A0 unsigned short div;
>> + =A0 =A0 unsigned short scr;
>> +} sh_msiof_spi_clk_table[] =3D {
>> + =A0 =A0 { 1, 0x0007 },
>> + =A0 =A0 { 2, 0x0000 },
>> + =A0 =A0 { 4, 0x0001 },
>> + =A0 =A0 { 8, 0x0002 },
>> + =A0 =A0 { 16, 0x0003 },
>> + =A0 =A0 { 32, 0x0004 },
>> + =A0 =A0 { 64, 0x1f00 },
>> + =A0 =A0 { 128, 0x1f01 },
>> + =A0 =A0 { 256, 0x1f02 },
>> + =A0 =A0 { 512, 0x1f03 },
>> + =A0 =A0 { 1024, 0x1f04 },
>> +};
>
> Could be const (to save some .data) btu I think the compiler does tha=
t
> itself nowadays.

I'll fix that up.

>> +static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned long parent_rate,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned long spi_hz)
>> +{
>> + =A0 =A0 unsigned long div =3D 1024;
>> + =A0 =A0 int k;
>> +
>> + =A0 =A0 if (!spi_hz || !parent_rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 div =3D parent_rate / spi_hz;
>
> This could be more neatly coded as
>
> =A0 =A0 =A0 =A0if (!WARN_ON(!spi_hz || !parent_rate))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0div =3D parent_rate / spi_hz;
>
> also, if this warning ever triggers, you won't know whether it was du=
e
> to !spi_hx or to !parent_rate, which might make you sad.
>
> Can spi_hz and parent_rate ever be zero here anyway? =A0If not, zap i=
t.
> If so, why? =A0Programming bug?

I wanted to fail gracefully if the spi layer or the clock framework
handed us zeroes. They are most likely not supposed to do so, but it
probably doesn't hurt to keep the check. This to catch bugs that may
be around - the spi setup code flow is pretty complex and the clock
framework implementation may vary from processor to processor.

>> + =A0 =A0 /* TODO: make more fine grained */
>> +
>> + =A0 =A0 for (k =3D 0; k < ARRAY_SIZE(sh_msiof_spi_clk_table); k++)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sh_msiof_spi_clk_table[k].div >=3D div=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 k =3D min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1=
);
>
> actually it's pretty obvious from all the above that k should have be=
en
> size_t.

Cool, will fix.

>> +static u32 sh_msiof_spi_txrx_word(struct spi_device *spi, unsigned =
nsecs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wo=
rd, u8 bits)
>> +{
>> + =A0 =A0 BUG_ON(1); /* unused but needed by bitbang code */
>
> =A0 =A0 =A0 =A0BUG();

That makes sense. =3D)

Thanks for your review!

/ magnus
