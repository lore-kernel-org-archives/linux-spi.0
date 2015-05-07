From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
Date: Thu, 7 May 2015 10:41:51 +0100
Message-ID: <20150507094151.GI22845@sirena.org.uk>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
 <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vkcg3CJmgV8j7eyn"
Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vkcg3CJmgV8j7eyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 09:25:02AM +0200, Geert Uytterhoeven wrote:

> What about setting SPI_MASTER_MUST_RX and/or SPI_MASTER_MUST_TX,
> and removing the dummy page instead, so the spi core will handle it for you?

Yes, that's what it's there for.

--Vkcg3CJmgV8j7eyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSzNfAAoJECTWi3JdVIfQSzEH/1ybZDZsmMhl3EkJ+Wz06qky
+k17wLzYNNFeSYS05HP8Fj+kJr/Yu2I4JmgUscMuagmeNCrWMhkytCYivVFVeXyv
hK7xguQP9A8ZS+LJAUidabozJuJiB5SiaNg2NlrZ/2C/j530dl0pBBFjrk+JgFGA
9b/ujJfQbG0Q7QqYnI9VoOnKYuPLf/b0TJG4qbRTKtDE/1/lQ2S83M83qoAFq23L
D6e7si2TeajiLUqZBHpjj7H6sv5JmpKy1RToNzlttW3uVCwxx8Pa5ulbbHBcpwQx
wjq2/whE+0b5dRn7/yF1mxig97DoqzdnAIGiKA5S5aot3uhLTlcEQbivxgyCm1Q=
=6UEz
-----END PGP SIGNATURE-----

--Vkcg3CJmgV8j7eyn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
