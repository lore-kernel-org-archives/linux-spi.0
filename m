From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Fri, 21 Aug 2015 10:29:31 -0700
Message-ID: <20150821172931.GK12027@sirena.org.uk>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
 <20150820183634.GN12027@sirena.org.uk>
 <20150820210822.GH74600@google.com>
 <55D64A65.7030905@osg.samsung.com>
 <20150820232517.GZ12027@sirena.org.uk>
 <55D666F4.2080801@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yruHGtsrg8HLSUpe"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D666F4.2080801-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yruHGtsrg8HLSUpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2015 at 01:47:00AM +0200, Javier Martinez Canillas wrote:
> On 08/21/2015 01:25 AM, Mark Brown wrote:
> > On Thu, Aug 20, 2015 at 11:45:09PM +0200, Javier Martinez Canillas wrote:

> >>> IOW, it's labeled as such mostly for safety, since it has quite a few
> >>> distributed dependencies.

> > Are there really only 17 drivers that are missing an explict of_table?
> > That seems like a low number.

> In fact the 17 patches are the combination of the SPI drivers that:

> a) Have a .id_table but not a MODULE_DEVICE_TABLE(spi,...)
> b) Have a .of_match_table but no a MODULE_DEVICE_TABLE(of,...)
> c) Don't have a .of_match_table but have a DT binding document

> Maybe there are more SPI drivers out there that only have a .id_table
> and don't have a .of_match_table nor a DT binding doc. But in that case
> there isn't too much I can do since I've no information that these are
> drivers are actually used in systems booted with OF.

We could at the very least scan through the in tree DTs.  There does
seem to be a substantial overlap between systems that often don't use
modular kernels but could and systems where people are using the I2C
and SPI ID mapping shims.

--yruHGtsrg8HLSUpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV11/6AAoJECTWi3JdVIfQeaMH/j4RkMt5AWFuuGckUO7+k8u8
pm6BjBybJctgdDkx5UZSXM0TXE49cVpXcZze+D//hfmR1BDbzZ1Yy2ChCWHhnUs3
xetevjM4h7ESNsnlUzlYO5bpPRvQ9Ymb3cHCO0V9rjQhjkRGLOmFiNUEit4MPcJq
h4cG7tvdp1fHLZiNrIJ+NUwgNoXx0pdhh3ipaVC3wDJntIIsuOSPYknO+8GDXGXm
0FGC8LcRE5TuZBH+cUNu95xAw/AlTPABT8QEVpjdIaIPN0OkEQ8xBxWO2027vJuO
4wPj4jYqjeydNrPdFHqU5T2SH7dL89lWtkdkAggcyAU42WPWNtC7saZ+cVYj9KY=
=yvX3
-----END PGP SIGNATURE-----

--yruHGtsrg8HLSUpe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
