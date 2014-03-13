From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: oc-tiny: Remove unneeded NULL checking for
 hw->bitbang.master
Date: Thu, 13 Mar 2014 09:54:29 +0000
Message-ID: <20140313095429.GK366@sirena.org.uk>
References: <1393997661.19790.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393997661.19790.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 01:34:21PM +0800, Axel Lin wrote:
> We already has NULL test for master after calling spi_alloc_master().

Applied, thanks.

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIYBSAAoJELSic+t+oim9MfIP/3zxeSsuOiZq2WiEYMfNEcIt
yHfyaZ4sqqGm89/J+MFHZcOvdwytCeTzVtLquYENqtwheZuBzXtwQdb6FsE/iOjd
4S5mVH4fcid/LMRd7rMGEWc0AN2jNQqwd11ZVCoa3+/7c/FltBuhcbaDrdf8o3yM
+t/B1KP5B0nuuJweeqV6Jrtt/i1+bhjY5Dtlftl3+3CAiyUayp84q5eRK7ksN/y1
OSZp/V5OX4KrpV5WCKN6px66fefpfEAx23hI6Mk2klFIv7ZoPbtKYqdOOIDlzOIv
55RsgIKFB+dZZZqt/QvLWBR4uZtVNvd0dNIQrk7TRIO/V14V+lF/DD+HhN8oy9br
UhAvUat63RE/IxTULSHelSvWhN4DDJhPxTJXeQdevDzNHnI9FxMhFC0VFXL3S25j
CDzDpodLJgGgM/HKlA9BloxBCiN4G9h+jDXVPRA1cLQnjx/oC8P6eSqnoOgoyJOL
0/dxmUP7lES9RpuI0hLwWWdxMucm0APyRudNbFRcIlkipPCxd7YVCy8B4wXm3kqH
wjZubgRsMp0OdIuqwTH2/mCoU1D0kQz56ro0228m550Yr8aauIuK+3+VE0gG2iWP
aDHq7rYgYWG+Rwtf3/zP2o38d5fW2xCsDG4GOOszUTOiuy7vbZdkbmL2Eyln5biZ
K/WNgNf70FEsHHuACQaa
=Zc3k
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
