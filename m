From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: davinci: set new SPI_FC_* flags
Date: Wed, 2 Mar 2016 19:48:51 +0900
Message-ID: <20160302104851.GJ18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
 <1456843400-20696-4-git-send-email-linux@rempel-privat.de>
 <20160302021616.GP18327@sirena.org.uk>
 <56D68754.3090405@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aca4q5SZ1DcD6eE6"
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D68754.3090405-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aca4q5SZ1DcD6eE6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 07:25:24AM +0100, fixed-term.Oleksij.Rempel wrote:
> On 02.03.2016 03:16, Mark Brown wrote:
> > On Tue, Mar 01, 2016 at 03:43:18PM +0100, Oleksij Rempel wrote:

> >> -		if (spi->mode & SPI_READY) { +		if (spi->mode & SPI_FC_READY)
> >> {

> > This isn't setting new flags, this is replacing old flags with new
> > ones which suggests that the patch renaming the flag needs to
> > rename the flag in all the drivers...

> Only this driver was using this flag SPI_READY. So i assume, i will
> need only to reword patch comment. Right?

No, if this is a rename you need to do it as a rename.

--aca4q5SZ1DcD6eE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1sUTAAoJECTWi3JdVIfQJ0gH/2JCAbG6hZZp5L8tPr3/0FWv
8ZePQriKnF+mA9xPszGEU/D52rkLSn2BhuY0uySQSBzVi6v6yhjCPGrOf/DkxRD3
n8u/x1HSOhIo2IR9n6V89N00C7n7CzcxMUI/phR5PXS/8Hui843l5M46wvwcCJrh
wwHzhyUw6P4Jul4uqO5GnM6u/07U1I5I+9wjSsqbTox2CiuqhsORl9jl9ukWQhps
OrbvOTUCNM7BkErCeGSK9KRJdfoke2QSmZErWoudqvgHonkMk6YAXa+K4kb9nvlO
XDS4AbOV0UjLBPCCJyiTF1qUynjcGg+kViroQXV40nJLTgbvji3k7lhEPbiG6wk=
=UQrh
-----END PGP SIGNATURE-----

--aca4q5SZ1DcD6eE6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
