From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix one potential spin_lock issue
Date: Sat, 18 Apr 2015 13:49:14 +0100
Message-ID: <20150418124914.GQ26185@sirena.org.uk>
References: <1429084832-8953-1-git-send-email-huiquan.zhong@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huiquanz.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429084832-8953-1-git-send-email-huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 04:00:32PM +0800, Huiquan Zhong wrote:
> master->pump_messages workqueue can be queued by spi_start_queue(),
> __spi_queued_transfer().
>=20
> there is one case that if one resume thread call spi_start_queue(),
> and at the same time another spi_device thread call spi_queued_transfer()
> to do spi transfer, then the first workqueue will start the spi transfer,
> but the next workqueue queued before SPI transfer complete, will unusual
> terminate spi transfer.

I've applied this, it took a while mostly because it is very hard for me
to understand your commit message - I'm not clear what mechanism will
cause a problem for a running transfer ("unusual terminate spi
transfer").  I can see we might end up with the work being added to the
queue more often than is needed but not how that ends up causing
anything other than a little wasted work. =20

Your commit message suggests it's to do with multiple devices adding to
the queue simultaneously but the queue access in __spi_queued_transfer()
and __spi_pump_messages() all appears to be done with the queue lock
held...

I'm still not 100% clear that this is doing anything other than making
the locking a bit more consistent.

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMlLJAAoJECTWi3JdVIfQKAkH/0/iMiTHi+PlwRCFqqT0p3fO
XKBrw3ep1cLtBX40RGIA9AN0l2Ksds0w3zQu1PJB1CgJqf1z6n8DhKwrexW5Qnqm
vpQjtGVRRuudu/Sm2/adB348fjESMvOA5PyokbrtQTeQ0jvJwB4XBm0TDFa+cbHD
4M1S0b/i64kwM/PnNCK7+7ioTe+i13cbsaV++G06rVNDxZYuYb359YGkSAUlRGUd
W5jI6rysCYk8GuILFGCO9y+XD9zWFHv0rT+JIi9LCG7Z1yXG3IIzCnxlcRGzq5Ka
Jc7nl9ssk8+0rM9fZQXVOvVBHXRxJYBXweaE4kkLysxbq0UK30vJrjeCpJB+M6w=
=hWX0
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
