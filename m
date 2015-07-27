From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] spi: dw: Reintroduce optional 16 bit data
 register I/O
Date: Mon, 27 Jul 2015 13:58:11 +0300
Message-ID: <1437994691.29746.80.camel@linux.intel.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
	 <1435163696-14767-1-git-send-email-michael@smart-africa.com>
	 <1437751812.29746.74.camel@linux.intel.com>
	 <20150724153704.GM11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150724153704.GM11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2015-07-24 at 16:37 +0100, Mark Brown wrote:
> On Fri, Jul 24, 2015 at 06:30:12PM +0300, Andy Shevchenko wrote:
> > On Wed, 2015-06-24 at 18:34 +0200, Michael van der Westhuizen=20
> > wrote:
>=20
> > > With this series applied:
> > >   m25p80 spi32766.0: m25p40 (512 Kbytes)
>=20
> > Mark, what do you think about this? For me it looks okay.
>=20
> Please don't send content free pings, if you want me to review a=20
> patch
> please send me the patch.

Hmm=E2=80=A6 It's strange since patch series was sent to mailing list (=
Cc'ed to
you) on 24.06 [1].

[1]=20
https://www.mail-archive.com/linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg05530.html

P.S. It has not mine authorship, though I can resend the series if
needed.

--=20
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
