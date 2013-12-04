From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
Date: Wed, 4 Dec 2013 13:38:23 +0000
Message-ID: <20131204133823.GS29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vy6UCbb9EK60RK4A"
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385811726-6746-6-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vy6UCbb9EK60RK4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 12:42:06PM +0100, Jonas Gorski wrote:
> Add a driver for the High Speed SPI controller found on newer BCM63XX SoC=
s.
>=20
> It does feature some new modes like 3-wire or dual spi, but neither of it
> is currently implemented.

This is basically good so I've applied it but there are a few minor
things that could use improving, please send incremental patches for
these.

> +	clk =3D clk_get(dev, "hsspi");

Use devm_clk_get().

> +	clk_prepare_enable(clk);

You should check the return value here.

> +	/* register and we are done */
> +	ret =3D spi_register_master(master);
> +	if (ret)
> +		goto out_put_master;

devm_spi_register_master().

> +#ifdef CONFIG_PM

This should be CONFIG_PM_SLEEP.

> +static int bcm63xx_hsspi_suspend(struct device *dev)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +	struct bcm63xx_hsspi *bs =3D spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +	clk_disable(bs->clk);

This ought to be disable_unprepare().  It would also be better to move
this to runtime PM (you can set auto_runtime_pm to have the core manage
the enable and disable for you) since that will save a bit of power.

> +static int bcm63xx_hsspi_resume(struct device *dev)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +	struct bcm63xx_hsspi *bs =3D spi_master_get_devdata(master);
> +
> +	clk_enable(bs->clk);
> +	spi_master_resume(master);

Similar comments here, plus you should be checking errors.

--Vy6UCbb9EK60RK4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnzBMAAoJELSic+t+oim9w1UP/1LRGjzhrrNY9PqSaUkXo9sJ
jfcCG7gn6AlbrKJyQ0xNuvERTQbXdhT3WtvmQx2hbf18lPkCdXK4UA1mHzNykxym
pogCLM2GH3/+/FbQk75lvGwpZaWpL9CEjykVpd9e8rj5afND1vsCy9x826HFDMLR
Yj9sivZpt50YrxdQXK8yqfF9VveW+Pc+kaDc1DtxJQHCYkhPdLsrHfpC9w0SlzQJ
pi6O0vd33ihonCwoP+XvV8OykK9vZvIDc0zHtMOEVM++tKU+gi7GADdHANwUL7Hy
8V9j9+WruPHIZhyfw0exJf8tT5FlzwGPlKab89PzZZOMe0ScX2c7efr3JGizctz4
APMsgq4aRulzyrqPNqPkm/ZFhI1ujfJhkil6O6e4rpA89FA9CtKJM2aWeDw3X2Gz
4khPq4u4lYfo1N/AhVO4S7fD55WEygdK10KUnH3Lw/eZLgdG4eSR29WoxCzhaciL
4lCy7/ECThNsh0m09A0REwY9YopkNgLhR8LegS4I6EYq8tLfz4m/H7h5PWby3MRh
0/DuKO7mxTQZZ7kHhkDKZU9M0EOjzCw7BXnyeyJz4W5xTBQ4vlbl6Wv4wkshR1cJ
FrLVl/P7tiSBtS3AQgpl9SDbOP48hbKA7yzYeVoy/AFfaA0u5HniRLGoN8HrsUO1
eW5tlia/IgEcpruyfjWX
=FTNe
-----END PGP SIGNATURE-----

--Vy6UCbb9EK60RK4A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
