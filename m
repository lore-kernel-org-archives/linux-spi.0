From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: question about drivers/spi/spi-au1550.c
Date: Wed, 2 Jul 2014 20:44:02 +0100
Message-ID: <20140702194402.GO410@sirena.org.uk>
References: <CAB78YHy2tW4u5rrsz9yKqpD7uigtkp=B4Z950323-v0vGk5R8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5wfsVCgeKAcINk2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
To: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAB78YHy2tW4u5rrsz9yKqpD7uigtkp=B4Z950323-v0vGk5R8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y5wfsVCgeKAcINk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 12:31:45AM +0530, Himangi Saraogi wrote:

> I find in the probe function that hw->ioarea is allocated using
> request_mem_region but a release_resource and kfree is called on it instead
> of  a release_mem_region. Is there any special concern behind this. I was
> planning to use devm_ioremap_resource here.

I'd expect this is just a bug you've spotted.  If you could send two
patches, one fixing the bug and the other doing the devm_ conversion,
that'd be ideal but a single patch is also fine.

--Y5wfsVCgeKAcINk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtGD/AAoJELSic+t+oim95boQAIObeO7TILt1eUAl/HnuwKlt
6KClFZ41AZSSj1FlW61qRbjTBHIzbkgY6pn5O9/o+6MXjV7Q2PMsJljqn0QmgNo6
HJklfCYVbnC0GHuGT/sfroqqOkdP3FfiFHaJBgwoRuTLIOrWzMuG3xl49sWhkUn2
qmeIiP66O4j5DjwkaIdVJj4gjT1FX0eOSiv4L3YKKSC7E1G0l1JOh31BEF3rD36w
tzisL3vE1V2RP5uXPMOll5E3wKH17Uq1OK6T/KtqwdkeR9ssiIm6cy8ntWoefGgH
GOE1qL/DVei1u/WEhSB22gNFTw4KT+Fb10+em75QgzfXseVytYSiVenxh6V+HNV0
pW9lvERKdVSwoXhES6BFoZfctr9XGkcbcAnLyzWuzoyMqd2Es9Hw7BOUjhNitOaO
JAEzYC4jX8teRP1hG55RcFoE22kA+eZWhkIT3d2+tuUXhCxc/GSmJtnN8zzdHxsu
DFgoYRLZA/oELxo7cKU6KBoFvUoInC29gg+i8z8QOCrVPkb+fw/5Mq+33F4ARzox
KB1su+gAxlzs4P3J9iSyXVN6XyeXH/Bifi/Ij6Jc7XbV6dXzICWZUh1viWKT0xtm
XQy/wkmIPfmGAi0c48M5sMmdlUnOVWZh0m73wXSkuaECAi7M4+ymE1Qlzd3oVOTg
ItikoGLyq7+x8M0L4zwa
=L+XM
-----END PGP SIGNATURE-----

--Y5wfsVCgeKAcINk2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
