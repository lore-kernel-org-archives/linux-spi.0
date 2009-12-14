From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: +
	spi-imx-use-platform_driver_probe-as-probe-lives-in-inittext.patch
	added to -mm tree
Date: Mon, 14 Dec 2009 10:57:29 -0700
Message-ID: <fa686aa40912140957t3a828baegd74af59fee60e7d@mail.gmail.com>
References: <200912082330.nB8NU1Ud016093@imap1.linux-foundation.org>
	<fa686aa40912081634q22319e2ud67d56f10cfc6c25@mail.gmail.com>
	<20091209074251.GA8136@pengutronix.de>
	<fa686aa40912090715j7235a722nac10f0dc08554d97@mail.gmail.com>
	<fa686aa40912090723n6b15dba3p9b63a2f4ae5d9067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	daniel-rDUAYElUppE@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40912090723n6b15dba3p9b63a2f4ae5d9067-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/12/9 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:
> 2009/12/9 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:
>> 2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
>>> On Tue, Dec 08, 2009 at 05:34:21PM -0700, Grant Likely wrote:
>>>> Hi Uwe.
>>>>
>>>> On Tue, Dec 8, 2009 at 4:30 PM, =A0<akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
>>>> > Subject: spi-imx: use platform_driver_probe as probe lives in .init.=
text
>>>> > From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>> >
>>>> > Using platform_driver_register with a probe function defined using _=
_init
>>>> > is wrong.
>>>> >
>>>> > This fixes an oops after:
>>>> >
>>>> > =A0 =A0 =A0 =A0cd /sys/bus/platform/drivers/spi_imx
>>>> > =A0 =A0 =A0 =A0echo -n spi_imx.0 > unbind
>>>> > =A0 =A0 =A0 =A0echo -n spi_imx.0 > bind
>>>> >
>>>> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>> > Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>>> > Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
>>>> > Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>>> > Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
>>>> > ---
>>>> >
>>>> > =A0drivers/spi/spi_imx.c | =A0 =A03 +--
>>>> > =A01 file changed, 1 insertion(+), 2 deletions(-)
>>>> >
>>>> > diff -puN drivers/spi/spi_imx.c~spi-imx-use-platform_driver_probe-as=
-probe-lives-in-inittext drivers/spi/spi_imx.c
>>>> > --- a/drivers/spi/spi_imx.c~spi-imx-use-platform_driver_probe-as-pro=
be-lives-in-inittext
>>>> > +++ a/drivers/spi/spi_imx.c
>>>> > @@ -666,13 +666,12 @@ static struct platform_driver spi_imx_dr
>>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
>>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>>> > - =A0 =A0 =A0 .probe =3D spi_imx_probe,
>>>> > =A0 =A0 =A0 =A0.remove =3D __exit_p(spi_imx_remove),
>>>>
>>>> This looks wrong. =A0Why can't spi_imx_probe and spi_imx_remove be
>>>> changed to be __devinit and __devexit?
>>> I don't care much, but I thought this to be in accordance to
>>>
>>> =A0 =A0 =A0 =A0d1e44d9 (SPI driver runtime footprint shrinkage)
>>>
>>> (http://git.kernel.org/linus/d1e44d9). =A0I have a whole bunch of such
>>> patches and already sent it three times (I think). =A0There is no
>>> accordance in the community that one of the two possibilities is better
>>> than the other.
>>
>> hmmm. =A0I don't like the pattern, but I'm not going to reject it out of
>> hand. =A0Let me think about it for a bit.
>
> But regardless, I'll make a decision before the end of the merge
> window because I know it fixes an oops.

I've committed a patch to change probe/remove to __devinit/__devexit.
>From a patterns point of view, I don't think it is the right thing to
do.  I understand the pragmatic reason for calling
platform_driver_probe() in the module init, but I think there has to
be a better way to go about it.

The way I see it, right now CONFIG_HOTPLUG is an all or nothing thing.
 Either all drivers discard __devinit sections, or none of them do.
It should be possible to make that decision at build time (or even run
time in the case of modules) without changing the coding pattern on a
driver-by-driver basis.  I think it is worth investigating, but in the
mean time I've just done the __devinit thing to fix the oops.

This isn't a final decision, but I wanted to merge something before
the window closed.

Cheers,
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
