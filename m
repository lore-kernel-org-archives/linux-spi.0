From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on
 RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 15:05:29 +0000
Message-ID: <20151105150529.GN18409@sirena.org.uk>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
 <20151105112847.GA18409@sirena.org.uk>
 <CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA@mail.gmail.com>
 <20151105122038.GF18409@sirena.org.uk>
 <CAK7LNASkXUb-S-MzmaA6KxJbnAPKnLbYvH8KtHPb=fzUrPK2ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNASkXUb-S-MzmaA6KxJbnAPKnLbYvH8KtHPb=fzUrPK2ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:32:15PM +0900, Masahiro Yamada wrote:

> For compile test, right, "depends on RESET_CONTROLLER" is
> redundant in the first place.

> For run-time on real SoCs,the driver failed at the following point
> without the reset-controller sub-system.

Your changelog needs to say this clearly, right now what it's saying
clearly doesn't correspond to what the change does.

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO3A4AAoJECTWi3JdVIfQSBAH/Aiuhd6HtxSsgl3elvMw9QdR
cD75iTuvZVEbaht/+s/4na/RRoAc78HGtPIBlC7A2O3ZXWerZ4eSQh42x8CgeCsx
JS/7Ko5UU0m8wKuM/lthLkttxKX1qZ6KpldCPEPNiqHW7OSriVFaTrhsnWFssNZZ
M3ltHzAh2AzmrkD6JSykGYB9rKB3+wNHTD5Ok46LRb+abRS++74I/LglevfbT+mQ
b5a+EM6923EWeiw87FZp24ZKtFvDK88GDoj+OSEeUIR+SBJHOcKf3iPp/eeNHcjP
NTHEMsX+518bmhpihuvfSmTg5sKwJ0DJczYZkRtaHX3So2Yj/VL67s7tORcYV7Y=
=Gubt
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
