From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: driver for the Synopsys
	DesignWare SPI controller
Date: Sun, 31 May 2009 21:27:56 +0200
Message-ID: <63386a3d0905311227v5bb5c278r306e8ae429e77691@mail.gmail.com>
References: <1243338914-7811-1-git-send-email-baruch@tkos.co.il>
	<63386a3d0905271416u4b2cee48k40c12e91e1796f83@mail.gmail.com>
	<20090531080434.GA16463@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090531080434.GA16463-X57xyCW21FZ5l4KbKkTfamZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/5/31 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:

>> > + =A0 =A0 =A0 r =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
>> > + =A0 =A0 =A0 if (r =3D=3D NULL) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>
>> -ENOENT
>
> A quick search in the drivers tree showed no -ENOENT in this situation. O=
f the
> 10 first results of grep -ENODEV is the most popular as follows:
[The other: 3x -EINVAL one -ENXIO]

Wowsers! And I felt -ENOENT was so intuitive, well if I'm going against
common practice, no good. So let's ask the maintainer of the platform bus
what shall be returned in this situation:

Greg (or some other wise person from linux-kernel) what would you return if
platform_get_resource() returns NULL for an expected resource?

Linus Walleij

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =
