From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 11:06:16 +0000
Message-ID: <20151120110616.GR31303@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <20151120000746.GQ64635@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Og4V1LL7XI16KR+9"
Cc: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151120000746.GQ64635-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Og4V1LL7XI16KR+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2015 at 04:07:46PM -0800, Brian Norris wrote:

> So for transfer size limitations, are you speaking of the same thing as
> Heiner (who began this post mentioning *message* size limitations)? I
> read a difference between the two, where a transfer size limitation
> might mean that one could improve the SPI core to just split transfers
> up into multiple sub-transfers, and still complete the whole
> spi_message (and therefore the protocol driver has less to worry about).
> But if we're talking about spi_message limitations, then this would be
> more exposed to the protocol driver.

For almost all hardware these should be the same things - most drivers
shouldn't be working in terms of messages, they should be working in
terms of transferrs.  Anything that has to work at full message level
almost certainly has substantial other limitations in place given the
need to be able to change parameters arbatrarily in the middle of
messages.

--Og4V1LL7XI16KR+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTv6nAAoJECTWi3JdVIfQSEYH/j6cJNCYstxY+BkwBAjXTUT6
IQ8qTXdMeIo627daVhx4TX1g7mrp/obQGUFB8aQBocBOZ6H5VirB2JXKAWDPG0/h
1fQ39zSoRLgoY+91j+ycXFAUxhzVgFkifu8BF/AGm0CENueNXz4o7ZR7Ibfj+kbX
UlW3RS8LsUn8Se8ffrw9Z4eTXUXncYKiyDmlMOIYu3raewy2ifDXIHBdgRk07Uxp
pSjzgwecRO0q7kE4koHVxf/B5UArymgUaH9c7p//lrxeit9cT2pB775Nd1/QZko3
NR8mIN0q2vC8z7HaTQIpFldzBIcZdxo1LJ2hoclTAzwP23WNuTNv2xIlcL1OL2U=
=4IpX
-----END PGP SIGNATURE-----

--Og4V1LL7XI16KR+9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
