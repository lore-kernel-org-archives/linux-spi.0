From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Add MODULE_ALIAS to support module
 auto-loading
Date: Tue, 14 Jan 2014 18:00:48 +0000
Message-ID: <20140114180048.GU15567@sirena.org.uk>
References: <1389690114.22958.0.camel@phoenix>
 <1389720129.337538528@f13.i.mail.ru>
 <20140114174100.GS15567@sirena.org.uk>
 <1389722311.613593800@f13.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4fNq9Po2wJlmxAaR"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389722311.613593800-tO/HdyGGtlvWO3iv0lnsqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4fNq9Po2wJlmxAaR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 09:58:31PM +0400, Alexander Shiyan wrote:
> =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 14 =D1=8F=D0=BD=D0=B2=D0=B0=
=D1=80=D1=8F 2014, 17:41 UTC =D0=BE=D1=82 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > I can't parse the above sorry?  If you're asking how inter module
> > dependencies get resolved the module loader does this automatically
> > based on the symbols referenced in modules.

> Yes, but there are no modules that have clps711x-spi dependency.
> I am not guru in module handling, just want to understand the need
> to make this change.

It's so that if the driver is built as a module if the device is present
in the system userspace can figure out which module to load to support
it.

--4fNq9Po2wJlmxAaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1XtNAAoJELSic+t+oim99wsP/15hIm65Pwgw32+E/JWMtUpP
9DxeOnL+mD04L5/wF8IZheMCbY7pVwu/4r24KuQrxAeKlaSqP8Ntul0mzj3lN+NR
ewPij44DcL1/ta9jJMFumycnISo7odgapurncOzkTx363xkH98aOIDXYHn2IgyCr
rSUedebWOdrCxZtOcw4UCK+j18/A54NpKXKkr5JURoCY66Scoz8vo6EESAzoZDtx
pSQfTlAemx0aUDSRjZtdDuiwdZj1QB7wUfBiY736txlqRXOn6XVPI3IeWJJkoE9Q
Q+YlMxBsOURQ4rdymKEofEkj5gdP82O1icZPsov9kVX2h50UGxrWxG6HvC9qCrEq
gm+nBOtQeNm9EPslCaBaKRPp+OPweOBck++j1xB4JfxcBcpDE52sqbR8mvws/4ml
M3lXXLrNPkj26E+VocBbx0NuWV6Q4qEwYTU/DJHaYG656KnA8AkbCoSMr9AL48mR
co8gKmZ3JmreGKd8rQLYR9eAnDixNiM3MgBM3LzuXle363oYoS9NoJW8AfUlYIec
mfCy18pXr3ZaJ8SkHyR1Y235O6lT+/Z6S8hM3LhrY36cm6Ai1ciW4bqPihPdWlgm
srw/K+lzWpkjK7B4UH3/TiIWyggHfmNjiQxTJo6bPbzMTO0vhQbx6HJbsAwHZVEt
iY9ddF7DFMIcLlJZrItY
=VvxQ
-----END PGP SIGNATURE-----

--4fNq9Po2wJlmxAaR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
