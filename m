From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as
 "spidev"
Date: Thu, 23 Apr 2015 14:36:23 +0100
Message-ID: <20150423133622.GV22845@sirena.org.uk>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org>
 <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org>
 <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com>
 <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw@mail.gmail.com>
 <20150423103652.GT22845@sirena.org.uk>
 <5538F1D6.7020503@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dkgfGZfPp4OU3Le7"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5538F1D6.7020503-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dkgfGZfPp4OU3Le7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 03:21:26PM +0200, Martin Sperl wrote:
> On 2015-04-23 12:36, Mark Brown wrote:
> >On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wrote:

> >>I guess this has been suggested before: the spi core could provide spidev
> >>access to all spi client devices which are not bound by a driver?

> >I don't know if it's been suggested before, certainly nobody did the
> >work to make it happen.  I don't think I have a massive objection in
> >principal.

> Maybe until that is fixed keep the warning message but remove the
> WARN_ON(...), which is responsible for the 50+ lines in dmesg which
> looks like a major issue because of the full stack-trace produced
> and not just a "simple" warning...

No, the whole point is to be loud and obnoxious so nobody has any reason
to say that they didn't know there was a problem - we already have the
initial solution Geert pointed out of adding things to the ID table in
the driver and I fear a simple warning isn't loud enough for something
like this.

--dkgfGZfPp4OU3Le7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOPVWAAoJECTWi3JdVIfQmCoH/RiXUXToZd31gjvIL+aZlCYL
FFgJI6vmspwMkDkk+/KplFj6cudrMm15Cvx4LzXa3PCK8VntsNHn04420K62GySA
Lq9WWVIXeoUrK4DiCerHCxGeKGwEWi7KB1/1+sETJgd9lJxbMVqpJ3KdTWdCm7x4
y99BaaptjmNKLwV8iF+ICMAq53PEu6Uwjt54Cr4iCFsuOISLHw5owvxO56GUkszs
DClhazg9RVZGtmfiKZ82LG3Yhy3IXSAs7/2tR2AT/wd6iWRHwHXEoYIxwy7C6N1P
+QRKGtJOOKKEMPMV+o14Zr7Bwg4iRz/0zrrSs6RFFwDb/lyBrBziCy2kFTnmVZw=
=aQ6v
-----END PGP SIGNATURE-----

--dkgfGZfPp4OU3Le7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
