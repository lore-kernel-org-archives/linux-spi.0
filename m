From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/10] spi: dw-mid: respect 8 bit mode
Date: Wed, 24 Sep 2014 09:49:19 +0100
Message-ID: <20140924084919.GI4015@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FKNvYlRPwIaB7a7A"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FKNvYlRPwIaB7a7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:08:51PM +0300, Andy Shevchenko wrote:
> In case of 8 bit mode and DMA usage we end up with every second byte written as
> 0. We have to respect bits_per_word settings what this patch actually does.

Applied, thanks.

--FKNvYlRPwIaB7a7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoWOAAoJECTWi3JdVIfQZ70H/jfrjRMomltdOQnHxLzYG72e
UxBR8hbQZohb5wfO6tn+I7kYgB4Iml3ZqwIq+6JQ/7VW3AeEybEH0KXTMg3vG268
IYDJ+oB2pshGCoCj7MIfz2HoAg6ERTztHZDvqWkd+ah9ugb/qZVHOZXEl7XZATWb
3NL2HGGWWkgkjdT/DhwjcwzU+WVhsSvaIdj0NsoY9a6N06FRdfufEkU0mJMZnlW4
N6BOrWTchPeUBQlVFtOBIya1j6Xgfht/eJhejsAF74l9Uwz8cK+dIGRgCTXemp6O
MTfBfg1TZZrULwWoKbK/57NZNKpbcpQNFVSzFK/wWvqG3woVfwZ//Hahfz7u5U4=
=dVOC
-----END PGP SIGNATURE-----

--FKNvYlRPwIaB7a7A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
