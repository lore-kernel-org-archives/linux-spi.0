From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Convert to use devm_kcalloc
Date: Mon, 31 Mar 2014 19:23:10 +0100
Message-ID: <20140331182310.GD2269@sirena.org.uk>
References: <1396100264.10175.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gf9uwQCH04IP1HVU"
Cc: Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396100264.10175.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Gf9uwQCH04IP1HVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 09:37:44PM +0800, Axel Lin wrote:
> This saves a few unwind code and return proper error if devm_kcalloc fails.

Applied, thanks.

--Gf9uwQCH04IP1HVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTObKKAAoJELSic+t+oim9K4cP/idRNcLy8FIcBREGak4LIVZH
AuB+hxoZbDg3jxjNltKBgop34nS8+s7cYrLDwipcmP5Kys7arw6Ug1WtIcN40rZU
M7xY4ypIaCrrdkrQmRo3lzxcpdL14sBUfs/fxrvCJuL8GVYfEjTT8yIdJCUKKhuh
AC0/DqYIlXCBbUuNL3cQEBeCq+bgPYBc03F3ruCYXuEdwveEqRAklmMdX+XUTzRx
EFiLrnTSCE+i1iQ5KpTpBm2bIon3rZd8U7TEbtIeZzg2DnoUsA2djlrD3qEQpbv8
BuY1ihrkXFMplUwJobPfuqGgTaHbcURiQPJm74UiGtTa31womK11HfsSfIuC0/HX
tKJBQevOqndO+G3Wup+tc56GTb1N5Xmzfxxm/HuUPkhGBvow2Es/itwMbHApJG/r
w8Nm5/l4moQMupr/0y6e9K6fcXAa6KY1f0d6+NZJLm7DhNDZxRUBQwJKcaYj9vyx
QqrlNFfPcUMtDza7SlIE5ytoq9vjramWyFS7l6htLBGWMvtbuQGItg0AnO0xK//s
GCOLxw12qyD7sea8f8HZoKH+bWNvoujQ7Rrb1zMuY505UOSTTxle4LcOss/KHGzL
YHLZBjRCcV1boT+bjcijztf+kE5aRREtqSIvdVmPSfaI17vxbmQ987CuDkkj7DQL
10dpbOqrPrkpAfAVs+WO
=9pws
-----END PGP SIGNATURE-----

--Gf9uwQCH04IP1HVU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
