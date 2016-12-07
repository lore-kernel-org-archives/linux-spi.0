From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/5] spi: armada-3700: Add support for the FIFO mode
Date: Wed, 7 Dec 2016 16:34:21 +0000
Message-ID: <20161207163421.2efafvlpapgdsxwx@sirena.org.uk>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-3-romain.perier@free-electrons.com>
 <20161205133728.sza2pt4tfkywu35k@sirena.org.uk>
 <a9b86043-b631-8154-edc8-5abe49e47114@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hgjkrzslmuctkbzu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a9b86043-b631-8154-edc8-5abe49e47114-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hgjkrzslmuctkbzu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 05:19:57PM +0100, Romain Perier wrote:
> Le 05/12/2016 =E0 14:37, Mark Brown a =E9crit :

> > Why?  If the hardware supports a more efficient mode of operation it
> > doesn't seem sensible not to use it.

> That's just that our customer want to keep both modes, this is why I deci=
ded
> to use the more efficient mode by default and disable it via a module
> parameter. Previously the more efficient mode was always enabled, based on
> the "compatible string" of the DT (the PIO mode was simply useless in this
> case and dead code)

Keep that out of tree, if the user wants to do silly things then let
them pay the cost.

> > > +	if (xfer->rx_buf) {
> > > +		/* Set read data length */
> > > +		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
> > > +			     a3700_spi->buf_len);
> > > +		/* Start READ transfer */
> > > +		val =3D spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> > > +		val &=3D ~A3700_SPI_RW_EN;
> > > +		val |=3D A3700_SPI_XFER_START;
> > > +		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> > > +	} else if (xfer->tx_buf) {
> > > +		/* Start Write transfer */

> > So this only supports single duplex transfers but there doesn't seem to
> > be anything that enforces this.

> A flag or a capability, typically? I will investigate

SPI_MASTER_HALF_DUPLEX.

--hgjkrzslmuctkbzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhIOgwACgkQJNaLcl1U
h9Bbqgf9G7NNd2ByuHzojcHoCJcjPY6gaTjfNeksJ/7+h+XRJMHrW91Mq99dQziT
sxGx0pZNLpXeM/KTu8HZmVevqij7LilWEAlfz8366shamSCcThWF1DWLRqMGq0eP
KgU61RgMK/1BipwT8H0V1J4ltih20gyd2cGXOFDKa3eroduCR97B5c7YBVp51b7r
ab4vwBKWbYWc7n0zBpJph4iMNUpCZoInw+YnoOsvL1Cqgzm89LciY/A8/6FlwzLg
KHs/0ARHMJrGdaufFxb6o4wv97ZCFiaSkVoh+GsMuSkAgXwKrgFth6x0XHeNMPdl
d7lHoNIoczXVA8BLoTbceuafo9Basw==
=euU8
-----END PGP SIGNATURE-----

--hgjkrzslmuctkbzu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
