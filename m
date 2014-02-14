From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] spi: Clean up probe and remove functions
Date: Fri, 14 Feb 2014 19:22:09 +0100
Message-ID: <1392402129.4365.51.camel@chaos.site>
References: <20140213152841.390de00f@endymion.delvare>
	 <20140214150341.GC4451@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140214150341.GC4451-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

Le Friday 14 February 2014 =C3=A0 15:03 +0000, Mark Brown a =C3=A9crit =
:
> On Thu, Feb 13, 2014 at 03:28:41PM +0100, Jean Delvare wrote:
> > While backporting 33cf00e5 ("spi: attach/detach SPI device to the A=
CPI
> > power domain"), I noticed that the code changes were suboptimal:
> >=20
> > * Why use &spi->dev when we have dev at hand?
> >=20
> > * After fixing the above, spi is used only once, so we don't really
> >   need a local variable for it.
>=20
> I've applied this but I have to say it's a bit marginal as a cleanup =
-
> for example while we do only use the SPI device once it's not entirel=
y
> idiomatic to use to_spi_device() in the middle of the code rather tha=
n
> at the top of the function so it's a small speed bump to see that.

I don't disagree. The rationale for the change is that I simply reverte=
d
to how the code was before 33cf00e5, assuming that the introduction of
spi as a local variable was caused by it being used more than once. If
you believe this was a good change on its own and would prefer to keep
it that way, I could send a patch replacing this one and only changing
&spi->dev to dev. Let me know.

And yes, this is not the most groundbreaking patch either way,
granted ;-)

--=20
Jean Delvare
Suse L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
