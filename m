From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-uwire: fix compilation failure
Date: Fri, 27 Jun 2014 10:03:03 +0100
Message-ID: <20140627090303.GB23300@sirena.org.uk>
References: <20140620203858.GA14718@himangi-Dell>
 <1403849258-21779-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XeHo0rFSNt4mQX/E"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403849258-21779-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XeHo0rFSNt4mQX/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 11:07:38PM -0700, Olof Johansson wrote:
> Patch 'spi: omap-uwire: use devm_ functions' (b3f6a57506b8) introduced a
> build error due to a missing include file. Add it.

A similar patch was applied a few days ago.

--XeHo0rFSNt4mQX/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrTNEAAoJELSic+t+oim9ki0P/A7Q0H4ph4cBx8iqUpyhV3D4
2BdPi+gBoJBAWVhx+E05D8w1qN6Ud0cCzHsL0bFd3ejLbHSgw0Lgtz4rYdOJ9DkW
5sOvByejUPKJXHt1Ohgek/A+AUeQZM+cPncnZymQ8XyEQ/nu8Dvf5tSUlyUkEwDV
omtKjpZlhfabFAPithapFCNlwPxqkC4AWDSBmI7siJjBb8WD+2Ztk4M2dXk4BcOj
ZiFportodEPv21ogdIEV+JTrHn5KZi9X1ygZz7p70/1YmBOc/kt8tvYcRJuiQSmu
SP8T84cIVGoGSdjxX/TfQIvykphtDAGPumWp2ZFyBWBy2mEwYZoSO5+sK3hsq8L5
nmoB3VDiIGeX4UYWcB1GFxz3ZvhAIC2XssfI8zq4nj2pwA/MAfovQvHqEEQp5L/Q
cvcbms2pRV7ulwWZofkSwEf84A70/dmJB0qpAluXbDSkGRIwIkVs0+fkQoElV0XH
BLQeiOrhkPDX1PTDbaSpe05lX+JdHHJX5y0vaVixMBo2tryE6wZ+/8xXhFQbNAbd
lOWAxJ7i3+NeSHVISlVjyIrmPTObRQ5QbKxUjpmQ+BScemkhOKf6tU/URaoy8IoW
gdEGO27tZ4nAYPYhEwHS8hkXRmr0tli4JcofnGEPPDr+0zbQj4bva6lYAm9NK6bd
Vey4I2XfvzoJOWasXr6S
=zoWB
-----END PGP SIGNATURE-----

--XeHo0rFSNt4mQX/E--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
