From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: don't use uninitialized variable
Date: Thu, 6 Apr 2017 11:55:02 +0100
Message-ID: <20170406105502.baaj4c2xcetp5z6p@sirena.org.uk>
References: <1491466583-6121-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xhczc5yados7macr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
To: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491466583-6121-1-git-send-email-rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xhczc5yados7macr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 10:16:23AM +0200, Rabin Vincent wrote:
> From: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
>=20
> The num-cs property is a required property according to the binding
> documentation.  However, if it is not present, the driver currently
> simply uses random junk from the stack for the num-cs since the variable
> whose pointer is passed to of_property_read_u32() is not initialized.

> @@ -2074,7 +2074,7 @@ pl022_platform_data_dt_get(struct device *dev)
>  {
>  	struct device_node *np =3D dev->of_node;
>  	struct pl022_ssp_controller *pd;
> -	u32 tmp;
> +	u32 tmp =3D 0;
> =20
>  	if (!np) {
>  		dev_err(dev, "no dt node defined\n");

This shuts the warning up but since it's a required property shouldn't
we be failing the probe instead of using the value?  Looking at the code
we end up actually doing that since we end up with zero chipselects
which is flagged as an error during the main probe but it'd be good to
note this in the changelog since it looks like we just silently ignore
the required property.

--xhczc5yados7macr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljmHoYACgkQJNaLcl1U
h9DiTAf9FVZicKq7/yEBOUtdLWDHOvT7PwM35KkcJPy5jp/lgEazNbIEPnhGdoxU
lFYWK6LKYx60VUCgsoROCxD/k9dLycpx3hNmKcYGcUI+zlPiVeMJOi4vHPHXYjLq
xyn0+7+wEoUez8l1M9boc26abrPjoyUW+9JUTUZjXCPXELZ7Fz7iBbb0tVqeOjqY
7lJs841IL0LFepdmNLVUfDjJfh0sNYMAEsoI9J6vrdKn4zsRwVUvtypL1XoDakvs
VsAP94HfbS0e6veXGlLA3h/V4qeSKWMObhR5gYPoajnupblSj1e1PkDUG0edvYfT
5MllRKBaVMOovew10sPfmuw4jMDNbg==
=K8ba
-----END PGP SIGNATURE-----

--xhczc5yados7macr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
