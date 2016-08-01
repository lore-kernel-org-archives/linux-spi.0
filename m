From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Mon, 1 Aug 2016 18:28:38 +0100
Message-ID: <20160801172838.GW10376@sirena.org.uk>
References: <20160728083144.16625-1-jglauber@cavium.com>
 <20160728083144.16625-3-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1RhGCd1AsoFHGRHc"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728083144.16625-3-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1RhGCd1AsoFHGRHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 10:31:44AM +0200, Jan Glauber wrote:

> +config SPI_THUNDERX
> +	tristate "Cavium ThunderX SPI controller"
> +	depends on (ARM64 || CONFIG_TEST) && 64BIT && PCI

You mean COMPILE_TEST.

> +	p->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(p->clk))
> +		goto out_unmap;

We're now just using the normal clock API which is good but I'm now
unclear what is going to ensure that the clock is there - is there some
other change elsewhere that I'm not aware of?  We're also not passing
the resulting error code back to the caller which will break deferred
probe.

> +out_clock:
> +	clk_disable_unprepare(p->clk);
> +out_clock_devm:
> +	devm_clk_put(dev, p->clk);

There's no point in using managed allocations if you're going to manually
free things...

--1RhGCd1AsoFHGRHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXn4bBAAoJECTWi3JdVIfQeQEH/2676yiEm8S+6e8Ydj4kqZmr
peWvuXS1jEZ1NgSmsfurExIXd/sZR7B6eNRdPIyEtJv77HaAUxMbFr3J/29GKTMS
og3crc4wgGoR9zPEBrqTFGDkTDnK5g2FxVsi7wNsQ6RDhcBm4rScJgVkbq5OHpWw
SX8rf/U0TAUvsyMUmdQZGjwbGbSpWGnR96mxSax66LEg7yD6wU0MpUwoLkgS1nya
xFfQ07/KuYl4R0dgQVdnl7K11YgJy0D0A3ihxIEMM7kk5AOoOdSaPFH43oBWIHPM
nzYbgIopKbMpjzhbK2PqwAyh1DkR70gfUw9MLe8YJqn0oFsyxPwShzWZPg3/ObQ=
=F/6Y
-----END PGP SIGNATURE-----

--1RhGCd1AsoFHGRHc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
