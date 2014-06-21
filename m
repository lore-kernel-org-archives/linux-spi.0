From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: spi-orion: add runtime PM support
Date: Sat, 21 Jun 2014 12:03:39 +0100
Message-ID: <20140621110339.GG5099@sirena.org.uk>
References: <E1WyIay-0008KP-Mm@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MOlTsKDG63roIlK2"
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1WyIay-0008KP-Mm-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MOlTsKDG63roIlK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 21, 2014 at 11:32:28AM +0100, Russell King wrote:
> Add trivial runtime PM support.  This will only be of benefit on SoCs
> where the clock to the SPI interface can be shut down.

This is good but...

> +static int orion_spi_prepare_transfer(struct spi_master *master)
> +{
> +	int ret = pm_runtime_get_sync(master->dev.parent);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int orion_spi_unprepare_transfer(struct spi_master *master)
> +{
> +	pm_runtime_mark_last_busy(master->dev.parent);
> +	pm_runtime_put_autosuspend(master->dev.parent);
> +	return 0;
> +}

...it should be possible to replace these by setting auto_runtime_pm in
the master struct.  There were a lot of drivers cut'n'pasting the same
code so this got factored out to save a little code and make sure
everyone remembered to do their error checking and so on.

--MOlTsKDG63roIlK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpWaHAAoJELSic+t+oim9tcUP/0Jt5ADLVAKrzqMa5hVf5k9b
XbkEC2uWl8DH/HRkSYYfGtomgwISyEiixJKIZ9utv6+y1EdJTLHt4fZi4DC0cjnn
0EIpQbFfs6VeDoQdcD8p80P36YSna43imiVlnp803JzG/CEWBZWf10z2YTedjk7E
lVuFUa65f58AtGSqA6FfjszanDGIML84J7d9jsewJ2XlmCvG6+WunHqd2E2jtbgZ
d+NIQVZkOxoui9vkMCXioFIW0688OEapI7QLl6CUZkng9PMV4IbOFcRgAhTxwqoV
h2Ps17JKjEQOA6CcSdmYov92pPPmkgXgQAM1D790khv4NfW12I8ZMY/TpjG2jYRq
mo270VV1ZlGmy26JLVtMdN8mNCkxnmwZqS+Tnu1I0vkfGErKqArJDiHP9yqSTAve
kS92mmCOdUfEUy2jwRBMl6pAsv+8p2CpZXyML6evUEfvlnkxhUy+sfT6O6f+he05
URUHng6aRwIx29o9z5rfgVkX9+t/oZXR5sSdTytGLMqGjHIKxMMbUO+aHw6JmLnw
4v4+byhXezHx2gmADwAr9pJJG1K7YHUaOr0a4LuHMPMqz9gHdKEjgyijK3lK4Hrv
u7gsytzRtWvjtSMaF7aOi/JNQ6ytu6F3hs2MFzrGmodxqYfzNZxMIFEgCo9426s6
5nII2u5UEUnx9XR01IOm
=vqom
-----END PGP SIGNATURE-----

--MOlTsKDG63roIlK2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
