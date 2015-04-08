From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: bcm-mspi: Make BCMA optional to support
 non-BCMA chips
Date: Wed, 8 Apr 2015 21:03:06 +0100
Message-ID: <20150408200306.GM6023@sirena.org.uk>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
 <1428516275-12819-5-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yfgt5/gpfXq9ryTU"
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428516275-12819-5-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yfgt5/gpfXq9ryTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 11:04:34AM -0700, Jonathan Richardson wrote:

>   - A new config for non-BCMA chips has been added.
>   - Common code between the BCMA and non BCMA version are shared.
>   - Function pointers to set read/write functions to abstract bcma
>     and non-bcma versions are provided.
>   - DT is now mandatory. Hard coded SPI devices are removed and must be
>     set in DT.
>   - Remove function was unnecessary and removed.

This looks like it should be a patch series in itself - for example, the
move to using function pointers as a read/write operation looks like
something that could easily be pulled out, as could the removal of
unused functions.  Having things split out makes life a lot easier for
review since it makes it much easier to check if the change is doing the
things it's supposed to be doing.

--yfgt5/gpfXq9ryTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYl5AAoJECTWi3JdVIfQdfcH/0hJB2TpIJARWa1y8Yny0t6O
gPvmpMQZxAKi0gMzP9R+9A0RaIJ3KmAlDXu/wC5saOfYPQQQDC1wOWqtDL4WWJRQ
8q/yJSGpaknD1Y2OVpxLfEZhsYxU6JSl427czMVKOas9ES6AIzbFLfPLWNRU6cLS
+LM7UtX9jzPMJRokh2p3b5R+pMSFtc9A++icBACtIiT7ZErhNW4vos66xpo3JarK
H75pHl+vPQcGE7BPrv7bnZIGubCc8nPBXiP9wPlotr607M2q09d8NVFoUl6YDNIO
6wSyoiGIpRif2MoMcNLTl2QAA2bVtBnOIIaUMk72ebH4NbZYC/NybRmQ8UUGxNo=
=hrkq
-----END PGP SIGNATURE-----

--yfgt5/gpfXq9ryTU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
