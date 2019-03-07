From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
Date: Thu, 7 Mar 2019 16:09:24 +0000
Message-ID: <20190307160924.GE6529@sirena.org.uk>
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Cc: xiao jin <jin.xiao@intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanmin.zhang@intel.com,
        bo <bo.he@intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 05:26:53PM +0200, Jarkko Nikula wrote:
> On 3/7/19 9:24 AM, xiao jin wrote:

> > The patch is to do cs again if spi-pxa2xx restar the SSP during
> > pxa2xx_spi_transfer_one()

> Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer() =
is
> called always when there is no more messages pending and the spi core sho=
uld
> have deasserted the CS already?

Yes.

> > @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_co=
ntroller *master,
> >   	if ((pxa2xx_spi_read(drv_data, SSCR0) !=3D cr0)
> >   	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
> >   	    !=3D (cr1 & change_mask)) {
> > +		/* It needs to deassert the chip selection
> > +		 * firstly before restart the SPP */
> > +		need_cs_change =3D true;
> > +		cs_deassert(spi);

> I think code comes here at the beginning of each transfer so will be hit
> multiple times before pxa2xx_spi_unprepare_transfer() if SPI message
> consists of multiple transfers.

> This makes me wondering if the device driver setting up the "struct
> spi_transfer" is maybe missing the cs_change flag set for transfers before
> last one in case HW needs CS toggling between transfers? For instance what
> following drivers are doing with the cs_change flag:

> drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
> drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()

Right, this really feels like it's fixing the wrong thing. =20

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyBQjMACgkQJNaLcl1U
h9D+IAf/RPJBHypK+ouTHdrAKEfxDNywJpo2oajUzbpOk+84L90tpxhXxJqmNkfO
wBqnszhfTMXP/bPgFKBRxni3WdiHW8De4enQ0SrP3MPUEh4t6j1iUsbTTpbocxbl
SsosvIJKdjFTvz0oE5rUM6OKl5wB6ENyk2AFZffJxY0I3ktHkEgdSYJ1bi006x5X
uIwEUJwM8I/wwo151dQXsUOGu93b7j92P6p5iTEnPL+gbiE/0X8OxCxe1KVveCbY
flsc/Sk6IFJ2p4Ll5qKooM6Ef+/fCXiTeFkSIolUXBwnR04R2sC404aelPR2zj7X
/EQ3J6/PFUg4m9aV/HQNiJCKp6bmXw==
=7VDL
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
