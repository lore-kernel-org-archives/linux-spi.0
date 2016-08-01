From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Mon, 1 Aug 2016 19:49:31 +0100
Message-ID: <20160801184931.GB10376@sirena.org.uk>
References: <20160728083144.16625-1-jglauber@cavium.com>
 <20160728083144.16625-3-jglauber@cavium.com>
 <20160801172838.GW10376@sirena.org.uk>
 <579F958F.9020508@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ytgo/kJyDF3J5kSH"
Cc: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <579F958F.9020508-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ytgo/kJyDF3J5kSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2016 at 11:31:43AM -0700, David Daney wrote:
> On 08/01/2016 10:28 AM, Mark Brown wrote:
> > On Thu, Jul 28, 2016 at 10:31:44AM +0200, Jan Glauber wrote:

> > > +	p->clk = devm_clk_get(dev, NULL);
> > > +	if (IS_ERR(p->clk))
> > > +		goto out_unmap;

> > We're now just using the normal clock API which is good but I'm now
> > unclear what is going to ensure that the clock is there - is there some
> > other change elsewhere that I'm not aware of?

> The clock is an integral part of the SoC and is always running, so it will
> always be there.  All we want to know is the frequency, which is supplied by
> the device tree clock-bindings framework

So there's something there that registers the clock?  What is that thing
on ACPI systems?

--Ytgo/kJyDF3J5kSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXn5m5AAoJECTWi3JdVIfQYjYH/R3pBuMNTYIrYttij+NOYtgW
uTbY0IOR5Tz5dZJlZT3WDZhqr3aOCeu7YoExcGvAsSYOMwqeJ3ndNoVEFNRUc2ot
BvqYai0hub+7Jx7BvCN+9Ka7uALVewnHgx42GNPY/onCKy/WgYzCBUoW3Mnq2IG2
PsS71qlAsFwiPGZt+6n86yoZdwWDCSJChrLwehH4YAR4kTRSp7ePpxS41qF612jN
Z5nApioSXKDCX+rF+gY39GwTln60R3EfBwUtmANTtv6FRZWm9R37kWC7MZtD9P0I
VUQG62n3RR7zQ4itI0fvGNhbHMB0m5kRkwSTofa9g+bgGMNQB6oAUPz/a9ajXVw=
=Szk7
-----END PGP SIGNATURE-----

--Ytgo/kJyDF3J5kSH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
