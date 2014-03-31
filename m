From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix handling of cs_change in core implementation
Date: Mon, 31 Mar 2014 18:17:48 +0100
Message-ID: <20140331171748.GY2269@sirena.org.uk>
References: <1396139265-28900-1-git-send-email-broonie@kernel.org>
 <20140331074529.GE2775@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9qb+eAX/AZDW6n0"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140331074529.GE2775-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--R9qb+eAX/AZDW6n0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 09:45:29AM +0200, Gerhard Sittig wrote:

> The delay between deassertion and re-assertion looks good, too.
> It allows for propagation of the change through the hardware.
> Those who need longer pauses still can construct individual
> messages.  There's probably no need to change the boolean
> "cs_change" into a numerical "deassertion pause length" spec.

I'm more worried about board specific requirements to increase the delay
there than I am about devices, or about devices that wish to lower the
delay.  But I do think it's likely to be OK in practice, someone who
actually runs into problems can worry about enhancements.

--R9qb+eAX/AZDW6n0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOaM5AAoJELSic+t+oim9dHYP/36oocz+A15R78VAA6bKTRr7
eHEhFyIQ8dPS5dnuxtIe4GdTkwuGeVWwXUUM7QzcMF3XxSvDd+zOmHWZtpkPJ8Ke
NTN4OUZ/HrIql4AxzCpK7tsxksDClHDN7XBpnWvU3nA1w9361ThIUJdXkMq9svlP
7dlYqEtDQBmy/EvUNJ/WiBKGJ4Z/vHSE7x+6CwjOed9YZKY/ixIFEvxe2W6wiA1/
9+vpQHWFbWRFPeN8YqZKb/8R2KY1j8e4c0SJctBzBJprMM2+C4eX+HKLFi6GJEng
GdTS23twZeH3tTJ8/S5Cpf+gOYBpXpd+aqL+dYdIOeMvWg8scKCzvycTMe5lkryk
ErrtBzOhQgXbHFn/AkUMSUxJTtWzYzF2ABGiVYaiFlJO2tLizGFW/CS/ffub1egE
QN8eX2/O8iNjwIbV829VyPpdHI/Z581GdiFRWU/iG5GK8RnQBW2pSjaOTbhwzKmH
OYC4LqvH5IBbGrirdqgUZNoTpCdzGX1v4n2TY0IVLanQBlC59jwJwPaBoyicwco3
qvg20Im4Og2gMD0hVVG7V7hpddYXJIEFTKNmLzUTcklsrtSm+IngJMGw35URXes4
aNpvBnv1D8d4ieumD49lpp1yEqYJQVNmz0eZqJ9a17/icFYwQ0RuzFIKjlbak3l+
t+Kb6gIGRSiZOSEmIps9
=97AP
-----END PGP SIGNATURE-----

--R9qb+eAX/AZDW6n0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
