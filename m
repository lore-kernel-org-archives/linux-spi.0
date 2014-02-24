From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/7] Add Allwinner A10 SPI Controller Driver
Date: Mon, 24 Feb 2014 10:04:24 +0100
Message-ID: <20140224090424.GC3468@lukather>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBP4WVSMAKGQEJYWONKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2014 at 10:35:52PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> This patchset brings support for the SPI controller found in the
> Allwinner A10 and derived SoCs.
>=20
> Even though the controller supports DMA, the driver only supports PIO
> mode for now. This driver will be used to bring up and test DMA on the
> SoC, so support for the DMA will come eventually.
>=20
> It doesn't support transfer larger than the FIFO size (64 bytes) for
> now, It's one of the things that will be fixed whenever we will have
> DMA support.

Applied patches 2-7 to sunxi/dt-for-3.15

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTCwsYAAoJEBx+YmzsjxAgG5QP/RFUpXFsoITNvSb5TWzt199j
hctAi6objewNo0X0YwRDkVQdTpymKNuBal8MA9Q2kusZT8fagzikhdG3bi902UUf
1A+43VnJJReexMGANMQmSJlM7H7FvvYIXYuLhCml0I+h6eKrfmJa4X8c+LkC6MPs
wrw3uFYs5KPSCyWjO8aTOPdnJcjoO62FMt+GLVrTEUnA1Y4emquhojVZg3xA6Vw2
dQyUfRhi4BaejVh3Vqeb6R/oa5M4xIpV+QMrLRky03HRWn4AF1sKJpZekCdXW0mg
7ovOQ2cAXg9ZTJn64F5esY03dM6CImw2y/h2RZfdy8KWczTBCFh9Dk2UuBQ1OB69
6jSn+r2nBaxHYcZo1hdtvKdZ0lkYvseVac8JJlF6o01VgPNteAG7gJiIkJUoQkPp
3psvrJjipLY8mfy6pCSGpOkuwMjuJ7CEA88t3r8lJEtv1tT9XP5C2cIvcZhxVNFe
psbm1HOqGG4AXmDgRgdyQeP8sol4oPWcuUc3AaJOOjprJf1PB3evX1WU+hKiw+h6
dsLDkFI/fL0+9lC2MNrv9Tqd+Vcge4OVGgrfw2A56G5LpgMXeWKF6msQ/iB6pPC3
c4v19S/k/Oc8pQGYQTNdyK0cDd7XvCC/8ALG8mVW1mx1f57SWzm5TGlIxlUnVKa1
Cm8ooRSmGjSpGDD4lKkb
=mD1l
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
