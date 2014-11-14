From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Fix mapping from vmalloc-ed buffer to scatter
 list
Date: Fri, 14 Nov 2014 17:26:26 +0000
Message-ID: <20141114172626.GI3815@sirena.org.uk>
References: <1415979645-26264-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20141114155222.GF3815@sirena.org.uk>
 <20141114160607.GB12443@opensource.wolfsonmicro.com>
 <20141114171133.GC12443@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fs+4yvttfcUcVuyi"
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141114171133.GC12443-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Fs+4yvttfcUcVuyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 05:11:33PM +0000, Charles Keepax wrote:

> Ah... ok I think I see the difference here. The MXS architecture
> has CONFIG_HIGHMEM=n whereas Arndale has CONFIG_HIGHMEM=y. So
> that means on MXS all the pages will always be in low mem so I
> think will always be mapped into the kernel logical address space
> hence no problems. Not sure if it would be worth updating the
> driver or not, what do you think?

This is a user configurable option, it's not something that depends on
the architecture (and in any case it's better not to leave people
wondering why things are different when they consider consolidation).

--Fs+4yvttfcUcVuyi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZjtBAAoJECTWi3JdVIfQdfkH/RhIichPpQVi17vMrn2r6ADd
8NeC0BjiUaFq7/zcURxBivwX6u603++7fYBALcgv1zaZF75j3Hg7Cayo+BxvHM+K
upokfi//XBYSFtKjt9m7S0WR2WN5J65pSkDIC4uYt/fmwybSjaNGvMlmhacmrWtA
GlxwR7Pvzq06LUpP4igl/Np9EQXyVJfrsdfQTSbhEnLcEeCoskndAjoGnZZ33/HJ
97L9Cj0jWyXkdw0KaHbsWqTFTWbyMZDm5mL5dv7xjk2oAQjNI/iLQTSePj+6lmrE
n0xnMZXU28NWMpYUg0n4EFZcozS6OMtMCvX2RG9uYISuIhb0IFM0HyEMg1OBrJ8=
=IQPw
-----END PGP SIGNATURE-----

--Fs+4yvttfcUcVuyi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
