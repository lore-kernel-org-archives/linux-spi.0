From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 13:49:54 +0200
Message-ID: <BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
	<BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
	<20110605075458.GA2712@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110605075458.GA2712@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 5, 2011 at 09:54, Baruch Siach <baruch@tkos.co.il> wrote:
> On Sun, Jun 05, 2011 at 01:13:28PM +0530, Jassi Brar wrote:
>> On Sun, Jun 5, 2011 at 12:48 PM, Grant Likely <grant.likely@secretla=
b.ca> wrote:
>> > [repost: I had a typo on the spi-devel-general mailing list addres=
s]
>> >
>> > Sort the SPI makefile and enforce the naming convention spi_*.c fo=
r
>> > spi drivers.
>
> [snip]
>
>> Though the spi_ prefix seems redundant considering the files are in
>> 'spi' directory.
>> Just a thought, no objection.
>
> When looking at the list of loaded modules (e.g. in an Oops message),=
 the name
> "spi_xilinx" is much more meaningful than just "xilinx", for example.

Plus, when dropping the prefix, spi_xilinx.ko and gpio-xilinx.ko
become the same...

So now we have spi_<name>.c (with underscore) and gpio-<name>.c (with d=
ash)?
And other subsystems go with <name>-<type>.c instead, e.g.
drivers/mfd/wm831x-spi.c?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
