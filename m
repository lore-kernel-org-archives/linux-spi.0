From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: +
	spi-imx-correct-check-for-platform_get_irq-failing.patch
	added to -mm tree
Date: Wed, 9 Dec 2009 08:08:19 -0700
Message-ID: <fa686aa40912090708g45879802l6cea7b401b1434e3@mail.gmail.com>
References: <200912082330.nB8NU4IO016215@imap1.linux-foundation.org>
	<fa686aa40912081638m734e97c3r2c3f412898d293b@mail.gmail.com>
	<20091209074533.GB8136@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	daniel-rDUAYElUppE@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091209074533.GB8136-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

(resend because I forgot to cc the mailing list)

2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> Hello Grant,
>
> On Tue, Dec 08, 2009 at 05:38:57PM -0700, Grant Likely wrote:
>> > diff -puN drivers/spi/spi_imx.c~spi-imx-correct-check-for-platform_get=
_irq-failing drivers/spi/spi_imx.c
>> > --- a/drivers/spi/spi_imx.c~spi-imx-correct-check-for-platform_get_irq=
-failing
>> > +++ a/drivers/spi/spi_imx.c
>> > @@ -554,7 +554,7 @@ static int __init spi_imx_probe(struct p
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0spi_imx->irq =3D platform_get_irq(pdev, 0);
>> > - =A0 =A0 =A0 if (!spi_imx->irq) {
>> > + =A0 =A0 =A0 if (spi_imx->irq < 0) {
>>
>> This changes the old behaviour. =A0Is that what you intended? =A0'<=3D 0=
' perhaps?
> Yes, the old check was wrong. =A0What if the irq to use is 0? =A0I thought
> the commit log to be understandable. =A0platform_get_irq returns -ENXIO on
> error and an irq number on success. =A0So 0 has to be interpreted as valid
> irq, not an error.

0 is not a valid IRQ

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
