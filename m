From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: + spi-imx-correct-check-for-platform_get_irq-failing.patch added
	to -mm tree
Date: Wed, 9 Dec 2009 11:00:19 -0700
Message-ID: <fa686aa40912091000h16942fe9m239997ca3f2d9e4a@mail.gmail.com>
References: <200912082330.nB8NU4IO016215@imap1.linux-foundation.org>
	<fa686aa40912081638m734e97c3r2c3f412898d293b@mail.gmail.com>
	<20091209074533.GB8136@pengutronix.de> <fa686aa40912090708g45879802l6cea7b401b1434e3@mail.gmail.com>
	<20091209153241.GB1389@pengutronix.de> <20091209175553.GA25451@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
	daniel@caiaq.de, dbrownell@users.sourceforge.net,
	s.hauer@pengutronix.de, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756407AbZLISAg@vger.kernel.org>
In-Reply-To: <20091209175553.GA25451@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Dec 09, 2009 at 04:32:41PM +0100, Uwe Kleine-K=F6nig wrote:
>> On Wed, Dec 09, 2009 at 08:08:19AM -0700, Grant Likely wrote:
>> > (resend because I forgot to cc the mailing list)
>> >
>> > 2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>> > > Hello Grant,
>> > >
>> > > On Tue, Dec 08, 2009 at 05:38:57PM -0700, Grant Likely wrote:
>> > >> > diff -puN drivers/spi/spi_imx.c~spi-imx-correct-check-for-pla=
tform_get_irq-failing drivers/spi/spi_imx.c
>> > >> > --- a/drivers/spi/spi_imx.c~spi-imx-correct-check-for-platfor=
m_get_irq-failing
>> > >> > +++ a/drivers/spi/spi_imx.c
>> > >> > @@ -554,7 +554,7 @@ static int __init spi_imx_probe(struct p
>> > >> > =A0 =A0 =A0 =A0}
>> > >> >
>> > >> > =A0 =A0 =A0 =A0spi_imx->irq =3D platform_get_irq(pdev, 0);
>> > >> > - =A0 =A0 =A0 if (!spi_imx->irq) {
>> > >> > + =A0 =A0 =A0 if (spi_imx->irq < 0) {
>> > >>
>> > >> This changes the old behaviour. =A0Is that what you intended? =A0=
'<=3D 0' perhaps?
>> > > Yes, the old check was wrong. =A0What if the irq to use is 0? =A0=
I thought
>> > > the commit log to be understandable. =A0platform_get_irq returns=
 -ENXIO on
>> > > error and an irq number on success. =A0So 0 has to be interprete=
d as valid
>> > > irq, not an error.
>> >
>> > 0 is not a valid IRQ
>> Hmm, on my x86 I have:
>>
>> =A0 =A0 =A0 $ grep '\<0:' /proc/interrupts
>> =A0 =A0 =A0 =A0 =A00: =A0 =A0 =A024330 =A0 IO-APIC-edge =A0 =A0 =A0t=
imer
>>
>> arm/davinci starts at 0, too. =A0As does arm/ns9xxx. =A0arm/pxa seem=
s to
>> start at 1. =A0realview starts at 1, too. =A0So four out of five mak=
e are
>> wrong? =A0Seems like a big area for cleanup.
> I've read a bit and I think the best for a driver writer (i.e. the ro=
le
> I have when changing drivers/spi/spi_imx.c) is to accept what
> platform_get_irq returns to me. =A0If the platform specified
>
> =A0 =A0 =A0 =A0struct resource mydevicesresources[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.end =3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D IORESOURCE_=
IRQ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0};
>
> then the best thing to do is to take irq0, isn't it. =A0So as
> platform_get_irq is implemented as
>
> =A0 =A0 =A0 =A0int platform_get_irq(struct platform_device *dev, unsi=
gned int num)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resource *r =3D platform_get_re=
source(dev, IORESOURCE_IRQ, num);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r ? r->start : -ENXIO;
> =A0 =A0 =A0 =A0}
>
> testing for <0 seems right to me.

Regardless.  I won't accept that change for a theoretical use case.
In the general case I'll maintain the pattern that irq 0 is invalid
unless it is the only way to get around a real problem.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
