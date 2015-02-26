From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: clarify what driver can do with
 message->status
Date: Thu, 26 Feb 2015 15:15:45 +0200
Message-ID: <1424956545.14897.93.camel@linux.intel.com>
References: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150224132411.GF6236@finisterre.sirena.org.uk>
	 <1424784807.14897.24.camel@linux.intel.com>
	 <20150224141706.GK6236@finisterre.sirena.org.uk>
	 <1424788527.14897.27.camel@linux.intel.com>
	 <20150226024812.GK6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150226024812.GK6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2015-02-26 at 11:48 +0900, Mark Brown wrote:
> On Tue, Feb 24, 2015 at 04:35:27PM +0200, Andy Shevchenko wrote:
> > On Tue, 2015-02-24 at 23:17 +0900, Mark Brown wrote:
>=20
> > > ...which suggests that anything detecting an error should report =
it via
> > > status, no?

=E2=80=A6

> > Regarding my above comment can we extend the description of the fie=
ld
> > then?
>=20
> Let's see what a patch looks like.  I am wary of documentation that's
> too verbose since it can cause people to glaze over when reading it.

I asked Mika's opinion and he wasn't confused by current description.
Hence, let's discontinuing this effort.

--=20
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
