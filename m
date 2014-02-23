From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] spi: sunxi: Add Allwinner A10 SPI
 controller driver
Date: Sun, 23 Feb 2014 11:15:30 +0900
Message-ID: <20140223021530.GD25940@sirena.org.uk>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393104959-12831-2-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Eldrgvv4EWsIM1sO"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBJF3UWMAKGQEJD2XPGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393104959-12831-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--Eldrgvv4EWsIM1sO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 10:35:53PM +0100, Maxime Ripard wrote:
> The older Allwinner SoCs (A10, A13, A10s and A20) all have the same SPI
> controller.

Applied, thanks.  Please differentiate between these two devices in the
subject line when sending patches for example by using "sun6i" and
"sun4i".

--Eldrgvv4EWsIM1sO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVm+AAoJELSic+t+oim94BgQAJttAmEoi3Ix8FKOHo64QWiu
mwv3JTsqjzsm0I+brOwv3hndxJqekCyOaLvLG+Bn17UBd6Ao2y/GToWoecqcTrjv
Wu6+T7EQSPkWkGqpXj5D1v5EQPtkWSyZIKkxSzfWg2AELoFSzEzUzQYXMnCla3lT
wIf9IzAZHkSri5+O/EumHRue+J85qCO2tdFCdxUP8lekysQwuXIIjtWYLNhxNerY
vQqkMzCx8IU8kVEWT0LlLTS4OrdTjQDZKuxKAf6rk/tFOkpb6DuCPKHkbwcaEvFu
Pj4c2OlHG2wR8IKlnMSIJijNKfdgDFD9MqZx21dvN8EsovEZq/ZaX7eRobwcPG9P
eSCyFf5FJ2UoxLBx3rfwcFSyrENpGr6iN7phq5euyAdAmr98rbW36D9mMPTWIkP+
ZB5aL+t1sOtoPVl+7kEhb8jorjWNBbdIVLSdpnITjt51QKMmst+nhNCPd+LfsY95
XvewwWpxXe3t8XkHsBDAjIp7KAgIhVNPaI4gGxSX+K10/Urr62Nzv1lkUPSasrYy
FHchBs2svB6wJfREsM/Jwti/5GPidns4ulynUCcleJzEGXSy/37/hTEDFUvPzxlu
W/WxfawWSaCxj9KaGwrAhL7iEVa8FAThgz7xRW/28zk/Nwo72CtcGC1zMjCZ4xNK
ynofq0Q6sfGS9+bntH3X
=3jUr
-----END PGP SIGNATURE-----

--Eldrgvv4EWsIM1sO--
