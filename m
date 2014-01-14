From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Add MODULE_ALIAS to support module
 auto-loading
Date: Tue, 14 Jan 2014 17:41:00 +0000
Message-ID: <20140114174100.GS15567@sirena.org.uk>
References: <1389690114.22958.0.camel@phoenix>
 <20140114142159.GN15567@sirena.org.uk>
 <1389720129.337538528@f13.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389720129.337538528-tO/HdyGGtlvWO3iv0lnsqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 09:22:09PM +0400, Alexander Shiyan wrote:
> > On Tue, Jan 14, 2014 at 05:01:54PM +0800, Axel Lin wrote:
> > > Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

> > Applied, thanks.

> No dependencies on the driver for the other modules, which gives this change?

I can't parse the above sorry?  If you're asking how inter module
dependencies get resolved the module loader does this automatically
based on the symbols referenced in modules.

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1XapAAoJELSic+t+oim9TYwP/1KvrzIqM/flUExvbLZElRa5
Lgdb/8akF9qPS2KwidLaHZs2goN43DnkLVPLyTV1qfkIUV2t22PlYnjKeStv3ZwS
vEGBmtKBb3DblD8g3s2k0ZPh2zpGgO/lKrt7UVOn0LAT+TtzeTgAYp/Fb7TwUuo+
koU2cMTPhM+ogrK8S7aKAOG6Jwd4OU9uOxhzi7J2Y9SccCtAx4VQDucIwdwM0u3d
DtRXmal8rIZndCdkRODSxvN2MqVWC+IvOTWj5onOZiUCvOlMHbfsWDvgswQsu7hC
9a6EullFm2eMX+05XqNukEismcXiG7zHalGUvGo8B//XGWM2vNCiAaw9fEKeaZZT
5sRxqueBvf7rHYjCvIDjATdhAPhTZTRcSEU/JefrzqYhLviJTyMI590z3WuCRsVy
lxgEsuGN/iysyfVKQO4ALOuETRNfA6Z7LaEWceE8ErFWHPbXqOPXtMG4oe0C96hW
iedvZ5HkiwFbmePQjklinulsx4vmkDnkfVQNAoStpfKH36uSPg7FQpia47ZCsU3g
GLJCl7ZICjM99zmoFJLnqnyE/chMt4O9kEY1J4H/fTKITdzKO9dogBbG6UxNeTan
U4AKETHhcc+fAkQQ2ncueUTSAr3VUfDVGzDIzZyuTcbB1i2+9DjLSMEbLgWaOA9+
9MF2ESVNAkZXUSJ95UNi
=mquJ
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
