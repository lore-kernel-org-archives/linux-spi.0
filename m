From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: +
	spi-imx-correct-check-for-platform_get_irq-failing.patch
	added to -mm tree
Date: Wed, 9 Dec 2009 10:23:48 -0700
Message-ID: <fa686aa40912090923v3a694fb6l18cb0d97cb1cdf9b@mail.gmail.com>
References: <200912082330.nB8NU4IO016215@imap1.linux-foundation.org>
	<fa686aa40912081638m734e97c3r2c3f412898d293b@mail.gmail.com>
	<20091209074533.GB8136@pengutronix.de>
	<fa686aa40912090708g45879802l6cea7b401b1434e3@mail.gmail.com>
	<20091209153241.GB1389@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, daniel-rDUAYElUppE@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, David Vrabel <dvrabel-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091209153241.GB1389-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/12/9 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> On Wed, Dec 09, 2009 at 08:08:19AM -0700, Grant Likely wrote:
>> >> This changes the old behaviour. =A0Is that what you intended? =A0'<=
=3D 0' perhaps?
>> > Yes, the old check was wrong. =A0What if the irq to use is 0? =A0I tho=
ught
>> > the commit log to be understandable. =A0platform_get_irq returns -ENXI=
O on
>> > error and an irq number on success. =A0So 0 has to be interpreted as v=
alid
>> > irq, not an error.
>>
>> 0 is not a valid IRQ
> Hmm, on my x86 I have:
>
> =A0 =A0 =A0 =A0$ grep '\<0:' /proc/interrupts
> =A0 =A0 =A0 =A0 =A0 0: =A0 =A0 =A024330 =A0 IO-APIC-edge =A0 =A0 =A0timer
>
> arm/davinci starts at 0, too. =A0As does arm/ns9xxx. =A0arm/pxa seems to
> start at 1. =A0realview starts at 1, too. =A0So four out of five make are
> wrong? =A0Seems like a big area for cleanup.

As discussed on IRC, regardless of some of the core & arch use cases.
As far as drivers are concerned, 0 is not a valid IRQ.  Linus'
comments here were referenced: http://lkml.org/lkml/2005/11/21/221

The return of -ENXIO was added in commit 305b3228, and it is
definitely in the workaround category.  Damn.  And a quick grep show a
lot of broken drivers because of it.  (variations on the common 'if
(!irq)' pattern abound as well as a large number of the variant 'if
(irq < 0)').

Well.  Though I don't like it, I will take the patch as testing for <=3D
0 instead of < 0.  At least that doesn't create new situations of 0
being used as a valid IRQ.

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
