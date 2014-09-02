From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: altera: remove unnecessary #ifdef CONFIG_OF
Date: Tue, 2 Sep 2014 12:16:56 +0100
Message-ID: <20140902111656.GU29327@sirena.org.uk>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <CAFRkauAD7upo4e1Vc08FAMFamv=Lwy2whzJz3vADtse18kjriA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PUHnpEUN0SLOjcm5"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFRkauAD7upo4e1Vc08FAMFamv=Lwy2whzJz3vADtse18kjriA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PUHnpEUN0SLOjcm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 01:34:39PM +0800, Axel Lin wrote:

> > -#ifdef CONFIG_OF
> >  static const struct of_device_id altera_spi_match[] = {
> >         { .compatible = "ALTR,spi-1.0", },
> >         { .compatible = "altr,spi-1.0", },
> >         {},
> >  };
> >  MODULE_DEVICE_TABLE(of, altera_spi_match);
> > -#endif /* CONFIG_OF */

> For !CONFIG_OF case:
>         #define of_match_ptr(_ptr)      NULL
> Can you explain how of_match_ptr() handle this?

Unless MODULE_DEVICE_TABLE knows about OF that's not going to trigger
the dead code elimination.

--PUHnpEUN0SLOjcm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBaclAAoJELSic+t+oim9PfsP/iFpMfb/XTApA+VCL687eXnG
Hb6JLkfVtMKUCg6RB6EMnR0syl8qf/S3vAH0BSMRN0TiEtZZ8maOJyM9lbwo4dr4
+Sw4yLUd5jiF1sAzhwZ/6wNyWMNwl7RmPP1KFjPrUaUurCX+FEAx0hFA55ADDe3L
wIvndMeTwPCMHwJb9goMacZFq5+7/D4skt7O98Y1Qvp1N3Ek3qpUcXvjuUjMIQA0
MapPfKLZ3RTDNB6GuYmDdhhvshO13tq6llqsI4pcz6DuKIPo+9RD+pRApevd0sRY
OI7ZLXcfpSnN0zL9tLvGLexQjend6furhod1eBZSan0qvxtnogO/d5cWt2kGeD6K
yos9GcFfcOwm3OaWNYx/MKrAf4Hs6aK41V1w0PzK/eYS+fXTtfmJtkzhCDQm1FJj
4lOepapvbPWk2hEPGX9x4smPURF6tW4aHoRjOWk8Y/yEynexYEyBJktWR5K+CP27
nMaC85IDICZfacVPMkhyDY2EfP3TM1zuU0VZ95X3IaGklSciRk8PlNqR+l3i2aT4
Hr5ZFzqlRqDXR6Tn36OBvo9hKi88mMU5BYbpCrSdeOvEkPUbYLFzKuz4cgQ1Bmrs
4Z37cpq31DOAXPruHGhSe3e0MHStpcNcRczjuSoROSwYl23GbetMDYX97kQI9ZjD
pQb8Ml2TCdC44Wl/SJiq
=p/CC
-----END PGP SIGNATURE-----

--PUHnpEUN0SLOjcm5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
