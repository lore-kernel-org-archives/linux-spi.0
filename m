From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
Date: Tue, 8 Jul 2014 16:56:05 +0200
Message-ID: <20140708145605.GZ30458@sirena.org.uk>
References: <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
 <1404784397-5157-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D+UG5SQJKkIYNVx0"
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404784397-5157-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D+UG5SQJKkIYNVx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 09:53:17AM +0800, Addy Ke wrote:
> In order to facilitate understanding, rockchip SPI controller IP design
> looks similar in its registers to designware. But IC implementation
> is different from designware, So we need a dedicated driver for Rockchip
> RK3XXX SoCs integrated SPI. The main differences:

This driver is already applied, please send updates as incremental
patches against the current code not as a completely new patch.

--D+UG5SQJKkIYNVx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvAaCAAoJELSic+t+oim9DcwP/jSXromLc5Pc7peD3nrv4ONE
ny6alpVNbvS4X6OcSbXYv+NYghvxgTL85qqQZ314l6N0CA9DpFkJTD40iv3cnuwd
w0vWjMtZXZk3Mhv94HOi35OLNZdBTIBkYnjpmVy1zwhrAozYfuR9Ta3KhiufJdCF
FjOE06L/qAPCvhkBy3p4fpFuaZiT9vqSCtY6iSss2BK6iZQfjD+wZg0xGXLEJCJp
9KwdT96Q6oOJA+Rki+y24A3cDqRi3OKMZ44ioSxf0IB4fUsX+2KPGuiOhESV9mz6
NDSEoL5kJei461si1brY3zcvbh2AxDReBTXpjGecc0kvU1jQE2+CYzoywmGpDFN2
0wtKNwgO3qM9o1hMkWrhrM+rZ76EdGi8AmXGf4e6umSw8z6x0GPkZEHfVCzfcpd+
w+Ajs4/pV9W/AcYzy+AsFiQ6Rb2GiZk/9qanSrfG1bv1NaEcGbcU8xVk5BTiuy1y
17pV+fRESb6fZ/LEadoqN3qDMFbbNxhvZzk0Vl7G9hziRmN9rEsxkuw6ZsNhBZI6
bUKsmaGnVtnV4QKeFCwhsbA3FWWCeEPJ9cjyJvApLoA6cUjTbdRf1F+ufWNg5VeC
fN5O+Jy7F7MQuIZcZuGnH1+7/AYr82oPRed56CiuwNRCPjT16fYU94FffOUZrqXn
mZ8ricoRpkUBDmMLonsV
=7chh
-----END PGP SIGNATURE-----

--D+UG5SQJKkIYNVx0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
