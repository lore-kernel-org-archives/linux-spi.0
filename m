From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: spi-atmel: scheduling while atomic
Date: Fri, 11 Apr 2014 22:48:15 +0100
Message-ID: <20140411214815.GI28800@sirena.org.uk>
References: <1734135.RAAc8zgbc4@kongar>
 <20140411162223.GG28800@sirena.org.uk>
 <2776532.qUm2PuCHHs@kongar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2776532.qUm2PuCHHs@kongar>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 11:11:29PM +0200, Alexander Stein wrote:
> On Friday 11 April 2014, 17:22:23 wrote Mark Brown:

> > Converting to use the core transfer_one_message() would also help, we
> > could then return from the transfer function and have the core implement
> > the wait for the completion.

> Mh, this driver already uses that.
> > master->transfer_one_message = atmel_spi_transfer_one_message;

> Or did you mean transfer_one?

Yes, I mean the driver should use the core version of
transfer_one_message() rather than providing its own which in turn means
that it has to provide a transfer_one() function.

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTSGMbAAoJELSic+t+oim9uBgQAJaePrP85ERVJIOsC71Q+0zZ
BbuYMzMD60ekZVxBqyyLQNL1NvD+3JQHSy0uHE22QPyjUss0pyvRVmMm9RTWn4BC
MAaLiph9I3WaO1vvUCw7XN0ZfsPvRxPuLimQNXSMZ8QTnSGNq521v21UMF5nW02s
t6sYZb2HKVH7ydv65w36Lyj1blWPrf/EP9GGxX37nhhdbCnKUu/tfMkuzV1vu6vz
qvFyvY+jgZk1rI2oUvNGumnZuxtGdilTJOuqE12iudx3SfCtK/aBvZwg4sNDGiz6
wgGg9mQOd4kwTnUoSmIEISrdb5RgvMIKnoN7g7HqWq3jgJdu6jAGLyqsn8ySB9yU
a0s4P9DM5o8pOa9wvM5/S1LA2btoVSr/9tUhuKeyqex/34cqITqTtFUWt5/YsBcw
dzB/pObo07cNLLHV4m+xA85yXYosaZxT579l0nfPeb8xRmkw9Ueg3dNIPMRIYHCa
XgYdF9vuh3ePydVDHuSKP+0mbh3xYR8Oe0+vmRyxvr8wxdnI0tkUDCMjXMgZ7t8w
GDnB65B5r3mR7Q/7jAz+7scbLtEE4FxuovxDD+n8q7Yh6wPXE330uIxZ5Fg6thnA
odDLhLWeSvVrvBLZXtNzzZPPPaXGX/0RRBn+AB+vHSiv6sKfpmAXc+foJO6/sW4z
H7rVJYL8g1AfLBoWa3C5
=fLER
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
