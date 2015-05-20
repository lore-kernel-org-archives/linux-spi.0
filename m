From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
Date: Wed, 20 May 2015 16:25:48 +0100
Message-ID: <20150520152548.GH21577@sirena.org.uk>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150520145552.GV31550@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150520145552.GV31550@xsjsorenbubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 07:55:53AM -0700, S=F6ren Brinkmann wrote:
> On Wed, 2015-05-20 at 12:57PM +0530, Ranjit Waghmode wrote:

> > +static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset)

> > +static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 o=
ffset,
> > +				      u32 val)

> why are you wrapping (readl|writel)_relaxed?

It's very common to wrap the lookup from driver data to the MMIO
address.

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXKd8AAoJECTWi3JdVIfQ8AgH/iK6k95a816u3bD022ppAl1L
+wP5nUi0SuummRSJbfLL+7cJYtOGHsCXQVnlpmeq2SW7g5kRMG19YRDYVkMNDM2/
7fobrkdM7SLM5KhY1HWrzWcl4taMetbDJ3tC4zIb2gPv/2+7Ft9djMbfbOUyyTET
4w1ibjgxRJKj3vRB3DRAW0hmlbmU7n9dRU2Pfm1cKqngeV+ScSPEHYosszuRNLo/
dINYNv5kRLhg3pN9j8FsWao4yA4CF46Dnez39GFpoqjbHuA6RxMnRqf6nKrxCj1Y
5AP31E1oSOnHabXqncejjJzJX5Hje6ujimPo6fU5W+80mCLzmeBF0VdAfN26IJQ=
=uZQr
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
