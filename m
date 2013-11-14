From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 3/3] spi: Use stable dev_name for ACPI enumerated SPI
 slaves
Date: Thu, 14 Nov 2013 10:10:22 +0000
Message-ID: <20131114101022.GD26614@sirena.org.uk>
References: <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384419661-28293-4-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384419661-28293-4-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:01:01AM +0200, Jarkko Nikula wrote:
> Current spi bus_num.chip_select "spix.y" based device naming scheme may not
> be stable enough to be used in name based matching, for instance within
> ALSA SoC subsystem.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShKGLAAoJELSic+t+oim9r/wP/0fwpqZAHy+j4Nc0mWkxxzvx
bzNVcn2T55pxN5oRr6Dq2PIS/iEPq7Jnsjwp0HIUvser06Z9TyCpulNOC3JdBar7
MP4ydZ++uTCQclTosY/Rp0yxFL34zZXTM9OBHfzTtyC0+rZMdRDe1TPSZGcng+Cx
XkQpxLHhiGH3zreGtPFprkIGJvpY+ifEU+zMqOumw/Zwp6zlP/trDmZRY08WYqMV
bd+PxVbx3+2nvi3Hw4pj2yfNpKaVd2ks7+fCi31/GuVJ06ys//0PFktAelQHwG+y
/3ozto/11RIU+cfoXcwRFScv4pamzMgCHKeZ1j0ibysAG4leLyFQpE8RiX/86wiL
XlFWs9uDW3qPVdGkxUMKI9f960TfjOaCTKmrwSf31P8yRb1f+pDIHPVPEqcgmf5X
a4G36+zSJafbjLe3WgFvdToPcHW6uwrBDE6FHR3lNxsr+HyTfDUf6e162EVkKMVt
QLxyJzwVM0eX1afvw8CM74JD5kiB4Gu23IkS/NFGWqGwafTlvZAsU0s4SXRz+yVo
JS1Y3oMqxEwQgkAyr6mqXOAiSHafz+4B4CY1WxWZmJlWgPX5Pku8CS3AoWWrJEDd
yOBe9LLhrLGpTsb/J3dXGQX0abr34pHuff6eSehL2eWsCkUSgUZqhd6cpaHu+6Ax
WKmY1n5by9XDazWrHG4i
=FLVO
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
