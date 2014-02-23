From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Convert to let spi core validate
 bits_per_word
Date: Sun, 23 Feb 2014 12:53:41 +0900
Message-ID: <20140223035341.GC25940@sirena.org.uk>
References: <1392383203.31961.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ly6DD2zUc33o81TT"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392383203.31961.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ly6DD2zUc33o81TT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 09:06:43PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--Ly6DD2zUc33o81TT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXDBAAoJELSic+t+oim9axwP/iUf3w8Yn6L/ezudBPUQh5E6
NGztrSRiFu6LOsZAbUhCx5DWTyVRuYjBZb/Dv73t3ehsPhpIk3vmmJAiShwaqSY8
HZ0hUm/oMeq0CW24dbTojvcKDWUSiXZ6JIeNvKUXchwWjQHwtAzrmPeuSWNKabRl
fsoRI+XLBBIFgqvQlzLQRHbqnzIbH1l6XUuUEE2ESWR16qWIA0poBcW8CouEybR3
7w5BSVXSQwDn4T2bHkjAM8wTkWUtcq4qVPuXE1gFhqO/5GKnBlXeQHnMDqldKePo
dDPd3sYdqVCp5zI+RYNN+Jt196yErcf9bqaRWj1rNj6CTxCX0NI68Dprkz0u77Zb
Jtvlg3np/SDxf0dzM76SLCvETBvMu077ABL/wzs7kYPdoLX4/hCb3ab5Iy0oWjQG
IMzO/3lk9pDqlUBjtwYF/ovxS47yBFfC35jWSho5kAVaVCMeXXSFED+/SF45SmuE
Z18ljwTwB/QTP8YBg6Tk1WH8X4D7yzlyGMOZcQF5Y8MZOsI3Tt5bfRUPruzA2joC
AZt8H73m+2lPXe7u2OXGnF2VYIkjo5R1pM/8ODIG2uTqMroA3/7FZNtZOHGnQ+aV
QrIHuq442ZHpR8vZDL5gLszkr6jL38dNaqdqwp6P2dzMIYMZraOgSVj9Arq4gaMQ
ipcffRM5nslEVQqdJPor
=Lu50
-----END PGP SIGNATURE-----

--Ly6DD2zUc33o81TT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
