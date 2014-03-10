From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Provide label argument for
 devm_gpio_request
Date: Mon, 10 Mar 2014 11:24:01 +0000
Message-ID: <20140310112401.GA28112@sirena.org.uk>
References: <1393909193.18753.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vqm4/nuivowh7wCF"
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393909193.18753.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vqm4/nuivowh7wCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 12:59:53PM +0800, Axel Lin wrote:
> The label argument was removed by commit 989847967cd762
> spi: clps711x: Use devm_gpio_request(), add it back.
> This makes it easier to know the gpio usage in /sys/kernel/debug/gpio.

Applied, thanks.

--Vqm4/nuivowh7wCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHaDOAAoJELSic+t+oim9F9oQAIyNtlgnvji/VVyx1wKeDEcz
uwfwKR0TZSBHfNLkAqm9+glt/42OONm47iS4TVRWKnEBCHOVqEFIpB/Y77FjtQg1
/JlmEXtZC0v9FTVT3tldiI1uutYQvZZlv5IcRBJuqpDZu017B2AdJHyX56/Kgp9m
0C4vBEo0pS3N380AfayR2tw2J37Us7vsGvKE8go3azcu+qxg5mrtuMOtl5w3Wg0G
XhO6fx2MAlEz0PzWxbDdsC/TEBE8/hvKMzCAnOI/C97CIPdBZK4IqpMJgr3NhJDX
un4gDbq/HWdvh33RgCaQ+21A88mvp8H/sInIeG63096qydf1qJ4vC4sDfn9q9PBl
HXwWX3zqqFcdgC8EVGu/Ub+lizlPeRvfFpqgmZynJu24uGsSbgEjM21KL41ahNth
hR+/wbiPOFMMyxVDt25YiXOygIUJtCsgmgEhfvmKz3HP2BMOVP3vaFah5aoxItNM
T9AE0NxhdgIbz93XsM1iFY1FDY69rAT/QW/zMDANEG1RZTCqvJ73OujoaXwrqU68
h/QhEO/Fhc0jJzB/6t4v1ZOLgU66Fs3juTfC6zQzwSVQk24focwWZlIvEukGY27V
ej7iKQHUtZX20vAbipdCwccUkRTGd6WBG5sxzYcDUKexBpgaWyEbz5/T1slpcot+
R6bIFkyRciM2C/E3mBqa
=VpYj
-----END PGP SIGNATURE-----

--Vqm4/nuivowh7wCF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
