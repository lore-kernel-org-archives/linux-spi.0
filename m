From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/11] spi: txx9: Use devm_clk_get()
Date: Tue, 17 Dec 2013 22:56:40 +0000
Message-ID: <20131217225640.GW28455@sirena.org.uk>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <001601cef4c8$aa1f7d30$fe5e7790$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/iGx3h4bc2ZI981g"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001601cef4c8$aa1f7d30$fe5e7790$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/iGx3h4bc2ZI981g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 07:23:12PM +0900, Jingoo Han wrote:
> Use devm_clk_get() to make cleanup paths simpler.

Applied, thanks.

--/iGx3h4bc2ZI981g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNakAAoJELSic+t+oim977AP/05pKy8JNsk2rFSjCHqcZ8O3
f3I3MTpgE5ww5H/8VTJYIT0G7JhRfmvUorr6UMC+bRtW8HzRvG+GmkxJO7W/5AVY
Qac+7pMuEIR8aj9t41RuZEDjQ15OtjuonIgX/cpNTve/M7ggs+l5euk05LyWKgFx
l9zlgTjXsumbDWBvq6q+4vayRMR0zFHioAPiEDVDGUZZIowKk/p6X0x6/wCDRc7X
HjnUQAp30YTrDHX+T7smQUPoyQE6y3woEjC0N//gvg0hD5PBL0KR+R10WmI4KysO
5YOayCqHQAtObpEIkizUYseaVSi/EGg5zKcBkKND1pjVpwIbZV4La/7p46PQwYlP
kaj1zKrbWFCDqKaJy1EQrGNMDjWTp/pJ/B3MbnkFyMJeYQYKZMKt8Nwp5w5pXVNu
4dMO0obV1xGawdQg45NCcvIJE94EQ2TF8Y+ZhcX/Q1aW7rC9nB7FdKxEO+9OKiC9
g65AIq/F5h+PjScaJ8a6lY/ACk51LYQSTUSx7+L1XeOhwsA3yOryF/64cG/3GOFT
foyrJBVMixGPQH54MVKSjrbGAREx9ozQ2423XYBrtVZKGgHmBa9SOlfeqwnoLRRm
I+WFvomEYHOZTV1crhXpfCzWEof4tpoCOHov0wZ+LOtf6geoYrhIDm/9hibU4A8D
DqiyExrdZWn91xX0s/KM
=in7s
-----END PGP SIGNATURE-----

--/iGx3h4bc2ZI981g--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
