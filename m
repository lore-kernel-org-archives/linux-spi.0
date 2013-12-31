From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: dw: use managed resources
Date: Tue, 31 Dec 2013 12:30:07 +0000
Message-ID: <20131231123007.GQ31886@sirena.org.uk>
References: <cover.1388427564.git.baruch@tkos.co.il>
 <9fca9e7e34cd6bd0ec14d28952d422014d94763b.1388427564.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ByALBa1F2BBmKLOT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9fca9e7e34cd6bd0ec14d28952d422014d94763b.1388427564.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ByALBa1F2BBmKLOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2013 at 08:30:44PM +0200, Baruch Siach wrote:
> Migrate mmio code and core driver to managed resources to reduce boilerplate
> error handling code. Also, handle clk_enable() failure while at it, and drop
> unused dw_spi iolen field.

Applied all, thanks.

--ByALBa1F2BBmKLOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrjMAAoJELSic+t+oim9bHUP/2WwQ7Ho3Fb933H948aaXt1r
Gw8QSle60K17G1JSLBFvic5h6zpQ3h+JcIg/+HXphlX8t4naDgch8HgDXARrY4qE
FGfwrYNysjeU7RKSVT7qybSjaiUTq+omZ9ZwzTZxETm7MbUk1ICe2NGbs+OL8s6G
EC6u3H9BofejB+Jq+HgiOw0bgdTLeiTM/Jrst85ZHztOZfiJHto9HPaPzQGiAZy+
KF/jpa6Vgt/la/qEStnjGP6X5yq+5OaVTtgtAZbDZdscZEQD0gA7RkKjCk+BTHBV
TDnq+PY7+rxKa2CE3/ow4HjPbSoV2noaFOVvyX9QaHJTpXKUoh4DlV3oNHcOu/o0
eJRF23MOi9AeKoKqgPgS5gXpuxibCfHdAv599U24nyCgM5awWWNrCU4/a+nRRfSI
yltJh0piA2XlFfGsLrGrRTIHa8usodSrHVtOh2lRvjPH/0W1cribuBWVZY2xBBmD
Qv/x55dXE6k2xbJ+PC7Tj2ccjyvIoClVNKXEXQio0XTUzwxcrlJjSF9unm5Bl9j4
fx+1fIiAIkXHgbVdC36b3p6oWL9zyTapoJa0+lJYg+mNe2O2Ls4dE6+94l7I01ap
g+Qjwhc/jkX46D7ElTg4JPo25rAfAAXv7hRUR77aPRJRkQLdW+C+5hKQmDGJqxW5
o5AyBuCM2e5Pue3Ho4n6
=mM2b
-----END PGP SIGNATURE-----

--ByALBa1F2BBmKLOT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
