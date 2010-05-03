From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v6 1/2] spi: implemented driver
	for	Cirrus EP93xx SPI controller
Date: Mon, 3 May 2010 07:21:23 +0300
Message-ID: <20100503042123.GM26418@gw.healthdatacare.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org,
	martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <h2r63386a3d1005021718k31125e4fz43a08025997b5c5c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 03, 2010 at 02:18:44AM +0200, Linus Walleij wrote:
> 2010/5/2 Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>:
> =

> > This patch adds an SPI master driver for the Cirrus EP93xx SPI controll=
er found
> > in EP93xx chips.
> (...)
> > +#define SSPCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0000
> > +#define SSPCR0_MODE_SHIFT =A0 =A0 =A06
> > +#define SSPCR0_SCR_SHIFT =A0 =A0 =A0 8
> > +
> > +#define SSPCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0004
> > +#define SSPCR1_RIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> > +#define SSPCR1_TIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> > +#define SSPCR1_RORIE =A0 =A0 =A0 =A0 =A0 BIT(2)
> > +#define SSPCR1_LBM =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> > +#define SSPCR1_SSE =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> > +#define SSPCR1_MS =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
> > +#define SSPCR1_SOD =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> > +
> > +#define SSPDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0008
> > +
> > +#define SSPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x000c
> > +#define SSPSR_TFE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> > +#define SSPSR_TNF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> > +#define SSPSR_RNE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> > +#define SSPSR_RFF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> > +#define SSPSR_BSY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> > +#define SSPCPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0010
> > +
> > +#define SSPIIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0014
> > +#define SSPIIR_RIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> > +#define SSPIIR_TIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> > +#define SSPIIR_RORIS =A0 =A0 =A0 =A0 =A0 BIT(2)
> > +#define SSPICR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSPIIR
> =

> When I look at this it's quite obvious that this is the same hardware or =
very
> close (maybe a redux version) of the thing supported by
> drivers/spi/amba-pl022.c.

Yeah. It looks pretty similar. Although there seems to be differences. Docu=
mentation
of the controller can be found in:

	http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1.pdf

It does not mention anything about AMBA PL022.

> What is the difference really? I suspect this is a PL022 PrimeCell straig=
ht off.
> Even the CPSR algorithm is the same, just written differently.

There are differences, for example PL022 has 4 interrupt registers (SSPIMSC=
, SSPRIS,
SSPMIS and SSPICR) whereas EP93xx has only one. SSPCR1 is different (in EP9=
3xx we have
interrupt enable/disable bits there) etc.

> Can you make a hexdump of the PrimeCell ID registers at offset
> base+0xffe0..0xffff and post the contents?

Here it is, you probably meant base + 0xfe0 .. 0xfff, right?

[    2.410000] 0xc6070fe0: 0x0
[    2.410000] 0xc6070fe4: 0x0
[    2.410000] 0xc6070fe8: 0x0
[    2.420000] 0xc6070fec: 0x0
[    2.420000] 0xc6070ff0: 0x0
[    2.420000] 0xc6070ff4: 0x0
[    2.430000] 0xc6070ff8: 0x0
[    2.430000] 0xc6070ffc: 0x0

Thanks,
MW

---------------------------------------------------------------------------=
---
