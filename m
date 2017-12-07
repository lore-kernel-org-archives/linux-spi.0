From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3] spi: sun4i: disable clocks in the remove function
Date: Thu, 7 Dec 2017 11:58:58 +0000
Message-ID: <20171207115858.rsycg7esimogylbr@sirena.org.uk>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
 <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjy7f5c2tnzgy5qt"
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org, takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512631227-27334-1-git-send-email-takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vjy7f5c2tnzgy5qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2017 at 04:20:14PM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled. Since pm_runtime_disable does
> not disable the clocks, use pm_runtime_force_suspend instead.

Please don't send new patches in reply to existing threads, it makes it
harder to spot them.

--vjy7f5c2tnzgy5qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopLQIACgkQJNaLcl1U
h9ARtgf/YWrnjyx8oGrG2XH9Zmlj4Ni8HQ7nht7vnaEXXyVAvBM/YDj4zkaNN0lM
j5wPeTjNh9L1P0PeTAiLlK3ytccMqWWPV8vJlsPuU5p9yKcguHPdMtIpFqRDlidm
8ZOtHFp98EIAe8/8+TLzgCQ57vc1ELg0vMcfecj1f4msM236lQVU4xxn5FcP6Gl/
azNGZIDL9nti1Gf+P5BnAwE61RtCekh9Cg5q0Tk4Ae/BCcBQUHjDBdJ4wo1Ni7xH
hcZRdW3ySEkNu/RKMTYk/AukLmpXvt4NgUW9gGB1Hf6NlQCA65zkV6mAad8iJbZT
ffcuf9/AJO5vND5c9SXT5JIz8Osx5g==
=/bwF
-----END PGP SIGNATURE-----

--vjy7f5c2tnzgy5qt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
