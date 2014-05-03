From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Protect DMA code by #ifdef CONFIG_HAS_DMA
Date: Fri, 2 May 2014 18:52:18 -0700
Message-ID: <20140503015218.GC22111@sirena.org.uk>
References: <1399004974-19566-1-git-send-email-geert@linux-m68k.org>
 <20140502171411.GS3245@sirena.org.uk>
 <CAMuHMdW6kGfVq8y_HV7Aupa7jB9+qdtM4PYGGG54=aCi1AvRYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW6kGfVq8y_HV7Aupa7jB9+qdtM4PYGGG54=aCi1AvRYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 11:09:18PM +0200, Geert Uytterhoeven wrote:
> On Fri, May 2, 2014 at 7:14 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Ugh.  It would seem better to have these functions stubbed out.  But

> As long as we have include/asm-generic/dma-mapping-broken.h,
> it'll be like this...

Yeah, I'm not sure that it's an ideal approach.

> BTW, I have a few more "depends on HAS_DMA" patches lying around for
> drivers...

Sure - it's good to fix these things, fire away.

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZEvOAAoJELSic+t+oim9qJIP/1+TTiAhDLwFvI8PZ/J5iM/t
xtSNn6b72/cCgtIRa8cMetvGmGtZBPPcsFPyqqsG/AQahH0FEjMJAwwikZyGlfM+
Bz0E96PSuNGelUdKQACEnocS/W0iw3KFrzKcqhwwZ2551Cz02qQK5a7rbEswHRsO
5bKL/Ckg+g8j2EMZQZu564JrcI9E3+OU+U+WoCmpwtJyyf5idYwl7kbkQRszxDFl
U3+3EtV2olHxXk7t3LLbwL1ajRxOcDlMqb39unrK796YoLJdsKifBvTUOuM3I2Yc
to6BdUVTG/CrgM9xj6rqqEGSFtSFn+HuqkI2DI36C46hk1S6z7Afp+a/XTF/A/rI
znQYs6xbZ7Y9AqzYg/HXXdlw1g0e9XyVrZkomN+qUSZElCAgyZNlcLHOB5a/jaRn
5pIAgoAhOR/B85yQb8dCjEEB8hxh2B9b1XhsyQ/ABNHjHYmmKa7PkVrwyADvK2uO
/yBGqEhhwkaBqyn5XMfdKFOdh87cB1h71yxjosIkqMQsIYGZfzQXbwSjOAi2sJCM
HnOvBa2c0YGVlBoeyu/NfqPfHlMsLaTqteRKnZYl1qV1Bn8q/sTaWtxHRnjDE3ic
doBYixOeVZKJ/eDVAwtOE+cPlFm5P+n/lM7cW9kb84pfdZNGlhoK/EYeFkudYA4N
F3uug7taHsJf8ZIDL0Lt
=hmrX
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
