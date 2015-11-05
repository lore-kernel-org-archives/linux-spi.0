From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on
 RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 11:28:47 +0000
Message-ID: <20151105112847.GA18409@sirena.org.uk>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446722128-11961-3-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 08:15:23PM +0900, Masahiro Yamada wrote:
> ARCH_SUNXI selects RESET_CONTROLLER.
> The dependency "depends on RESET_CONTROLLER" is already met.

No, it isn't.

>  config SPI_SUN6I
>  	tristate "Allwinner A31 SPI controller"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on RESET_CONTROLLER

The dependency is on ARCH_SUNXI || COMPILE_TEST which is not the same as
ARCH_SUNXI.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOz1uAAoJECTWi3JdVIfQagUH/1PWfcUM9XM7LtGVPhiRaK2r
xpjMgoo8emvsRoTxZl4Eh7bS48FbtI/QeiYLnk/w1RsJFJN0w8YhIF70p4n+ISLh
iFW4zCu5j4bgcpBXWw8mJOyYVQPnrdrSSjpjpxWRTjfbG77rVq3fXA79NKmsv4Fa
uPWTZ87FNk8ysVk6jI2pxBCBstkvfvQIErzsodMcgF9UPfkcQ/Yrod29Ktee0YyX
VFpgrGrAQC6QdUsHqYa+FvTyyY4gINUDr/qI+L8HhGUIoTIz+pl0F9K8/d49Scjn
bwInQBSosePOQoILGSQKcLmG6IJTbVAP6MpVbsJydClaQU2APe/6KxUBmI8hNP0=
=WOJc
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
