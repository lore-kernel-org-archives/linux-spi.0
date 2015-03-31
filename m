From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
Date: Tue, 31 Mar 2015 09:44:25 +0100
Message-ID: <20150331084425.GI2869@sirena.org.uk>
References: <1427739857-13395-1-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k0ZRCT9yCxlKcKW0"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427739857-13395-1-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k0ZRCT9yCxlKcKW0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 08:24:16PM +0200, Bert Vermeulen wrote:
> Changes in v2:
> This is a near complete rewrite of the original OpenWrt driver. All comments
> were taken into account, and the spi_transfer.fast_write flag is gone.
> Instead, the cs_change flag is used. It's not too bad a hack, as it really
> does use CS.

Don't send cover letters for single patches, if there's anything that
needs saying it should either be in the changelog or after the ---.  A
separate cover letter adds to the mail volume and probably means that
the patch itself is inadequately described.

--k0ZRCT9yCxlKcKW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGl5pAAoJECTWi3JdVIfQINsH/2SYu3oaYferb6YG3DJM6BZz
p41HA/vLqkIQYOk1HZy9XuUWdj3A4hQ60sflTooqymPaxa1l3ibHor+43f67AmWf
QHGVX8O5BabytdZ3o+9k5kw8F6vs8CxciaHeZjrSmTGjWLS3/atEEKU88WM2u134
h/JeTHeskj6xU5hjRRi45DBWpqO5/U1dYtxkT3QKG8Aw91dRDdWScnSJBy2RwppS
gdoF+49y+fP2zR/rkWeo/EobANxFAvUzFlsbwcoUY/u/WNpWNeUSmp/j/ag9f8Ll
q7Pv6f1vgcLswJSF9xO/yT0iPRTMaKSxKnc25bDIE2zZT5Tgl1RjgtEZ2xNUL7M=
=CfCM
-----END PGP SIGNATURE-----

--k0ZRCT9yCxlKcKW0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
