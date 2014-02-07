From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Fri, 7 Feb 2014 17:31:08 +0000
Message-ID: <20140207173108.GH1757@sirena.org.uk>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
 <20140207165127.GV20228@joshc.qualcomm.com>
 <20140207171834.GF1757@sirena.org.uk>
 <20140207172051.GW20228@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140207172051.GW20228-OP5zVEFNDbfdOxZ39nK119BPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2014 at 11:20:51AM -0600, Josh Cartwright wrote:
> On Fri, Feb 07, 2014 at 05:18:34PM +0000, Mark Brown wrote:
> > On Fri, Feb 07, 2014 at 10:51:27AM -0600, Josh Cartwright wrote:

> > > 	config SPI_QUP
> > > 		tristate "Qualcomm SPI Support with QUP interface"
> > > 		depends on OF
> > > 		depends on ARM

> > Does this really depend on ARM?  If so why?

> The ARM dependency is there for the use of _relaxed io accessor
> variants.

That's not ARM only and I thought we were getting generic versions of it
anyway?  ARMv8, MIPS, Microblaze, Hexagon and SH also define it.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9RhZAAoJELSic+t+oim9s0EP/2uIi5MFABswcCqy3YRi3CFL
5e9W7eWe6WJSdgS9kVFJdCqRY586ZT8VpbWyKWFwX2amAum611BoB0CoiO2gAHoD
WGBIzDDdVt3lrich4N9+VDxrCnOiTX+ceoVpI+9tRP6N3FKhr8eDuU2QN3DK4C1q
ZCw76NeybQX9BwKiS/Npd8invMgW005GU9f2WKgJGVR6Y/LrKmcBlfUr9R/14855
F0rFo3/I/dwAa/ZjvUHR3p19klhOUYrmiydKULNtqUOVEUw70EyJy/tfn+GRQPVG
gt7DmF7ji0FrTqUXTQz/dwL0n8WqpKiPKyT+Dfc6g8d/dNy4BGac8e6ehdXpqGb0
oGGknhlyI03JeB0mQ+WOpToJgYvjbzPmwftiSPsMX9mVUjUT6POoao8BZ5hRa9dx
WwHlFtV8nO+pHouP5WPX4wL6/Rc5dlkErMAcURE7sgWiBl6wJ8NZhQBgXE62amdZ
0FcQVO/L8E3SCjWX1hOhp5WlPOPr0JK2piMtQFKx2uZF0+iLMn+VDpIptTt1DUYe
yJYbdvdCTsGGgKeooaZC/aiblYsmbWk9x2lFZfI410n6Hvsyus1O0Vu++vFoyoLk
0gxAPYv9r0VD+ZPiqeZgLcitgIywRdeYTTOc+WzNAuWgKRw15h2QilHV3YLTLD/q
ndA1zvzCPtFiqhjHhaof
=Bbch
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
