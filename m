From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Sat, 20 Jun 2015 14:10:54 +0200
Message-ID: <CAMuHMdUpGgQRD=pwywDE=nKK8p3CQoFFuRZduvXkttmc0dfRTA@mail.gmail.com>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
	<556EE446.3060407@metafoo.de>
	<20150603115319.GF14071@sirena.org.uk>
	<8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
	<B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
	<20150618134918.GF14071@sirena.org.uk>
	<20150619113539.04a7fcf2@north>
	<20150619095346.GG14071@sirena.org.uk>
	<394B0003-AA2E-469F-AD9C-C291FAC60A94@martin.sperl.org>
	<20150619101046.GH14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	=?UTF-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150619101046.GH14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jun 19, 2015 at 12:10 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote=
:
> On Fri, Jun 19, 2015 at 12:02:22PM +0200, Martin Sperl wrote:
>
>> I got a patch in the meantime exposing the following files in
>> /sys/devices/platform/soc/20204000.spi/spi_master/spi32766/statistic=
s/:
>> bytes
>> bytes_rx
>> bytes_tx
>> bytes_transfer_histo_0-1
>> bytes_transfer_histo_1024-2047
>
>> If so then I would post a =E2=80=9Cbasic=E2=80=9D patch for the othe=
r statistics
>> and have debugfs for the histogram as a separate patch.
>
> Either approach works for me, though I suppose we might want to bikes=
hed
> the naming of the histogram files above (but I can't think of better
> ideas immediately) and I guess from a user point of view getting the

Zero-prefixing the numbers in the filenames would make it a bit less ug=
ly
and auto-sorted...

> histogram as a histogram might be more helpful so people might be
> happier with debugfs.

=2E.. but indeed, quoting Documentation/filesystems/debugfs.txt:

"Unlike sysfs, which has strict one-value-per-file rules, debugfs has n=
o
 rules at all."

So storing the whole histogram in a single file sounds like the logical
thing to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
