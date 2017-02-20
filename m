From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [spi:topic/lantiq-ssc 11/12] drivers/spi/spi-lantiq-ssc.c:38:0:
 warning: "SPI_STAT" redefined
Date: Mon, 20 Feb 2017 11:21:05 -0800
Message-ID: <20170220192105.cwrfjvgm2z64oovd@sirena.org.uk>
References: <201702200120.GUUW1HrG%fengguang.wu@intel.com>
 <78872df1-ddbb-79cf-7fc3-da07d900bc47@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2dnq3o75q722tnmn"
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <78872df1-ddbb-79cf-7fc3-da07d900bc47-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2dnq3o75q722tnmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 19, 2017 at 11:56:51PM +0100, Hauke Mehrtens wrote:

> I think the blackfin.h should change and not export such generic names.
> Or should I prefix the defines with LTQ_ or something else in the
> spi-lantiq-ssc.c driver?

I think both should probably be changed, or at least that patches for
either are fine and would fix the problem!

--2dnq3o75q722tnmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirQaAACgkQJNaLcl1U
h9DTQQf/VPUlf0Fy3/MVxyD8W0Aq5U++3MJZipDs5Uly5HavYa6Qgu0Z8Va9Fqie
dzWqnI+4Jj0IuKO/d7YfJVZ+t0i4vkPIuGwAeH6TD10VUa4nNNe9e/K44uPiInei
K9E1BKqPjeI1R68XxPEmmyQAggY9qL/Zk2Fagl5IXgwRpE2mlo+UJgvd5/4yyIWT
vmbdlMn5Vko8EtXaq6YZVhU1X8pUPMlsVKKOJU4R/iIysrnmPvZwApmU0GlYJgDG
yl0LFe5aknQrtqgc0a1OwgGI5sM1kt2woA49pfwBQ8HYg65FrDePhbyPrUbfn/YM
8gV8D8eRFgxIYyQWZQ6FGmNa4JUp9w==
=yTpM
-----END PGP SIGNATURE-----

--2dnq3o75q722tnmn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
