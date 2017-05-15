From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA
Date: Mon, 15 May 2017 11:12:35 +0100
Message-ID: <20170515101235.uy776lopdsyd4h73@sirena.org.uk>
References: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
 <20170514095020.roqoeohylvrgoad7@sirena.org.uk>
 <CAMuHMdUOMk9zpaVS9gj=jC5Cy2WFpj50+ut5TG=T69mYjMZ7hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2si5zoc2fzb2mqw3"
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOMk9zpaVS9gj=jC5Cy2WFpj50+ut5TG=T69mYjMZ7hQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2si5zoc2fzb2mqw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2017 at 10:46:15AM +0200, Geert Uytterhoeven wrote:
> On Sun, May 14, 2017 at 11:50 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Thu, May 04, 2017 at 09:37:18AM +0200, Geert Uytterhoeven wrote:
> >> If NO_DMA=y:

> >>     ERROR: "bad_dma_ops" [drivers/spi/spi-ti-qspi.ko] undefined!

> >> Add a dependency on HAS_DMA to fix this.

> > There's no progress on fixing the architectures that don't do DMA to
> > stub it out?  :(

> Then it has to become "depends on HAS_DMA || COMPILE_TEST"?

No, I was thinking more just not needing the dependency at all.

--2si5zoc2fzb2mqw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkZfxIACgkQJNaLcl1U
h9CxqAf+N5UQ+ak0o9OEyVZoGNuSypkmUIvNUl3YwMBvJYxR+2iTuBN3xuucYMYq
xACzvDXLiPY0jXVrmXq8uY6fjFM8KyfBTc0jEbazjD56REIQ2tZ3KIYGGtpIiYhV
oYcdsl/9wMzv47kVku1kKaoRIrfKF4igs62iFNk5KASTnNMHeIdrjMLZXyX3i39U
RQ7WI+n8UiBWaoB95VXmsEIj2hIM16ePR1Z8ehGhx40M4fyZJaofJqtv1Kic8Fsc
JwmYdPsUjZ7K7eOgbjkj+zTho8gjLQ5XIfAijSwIJ9e25+ccDGq15e4GEbtrgcRm
D2DB3EImO87rRK4hF4XaiEa/AkTtdA==
=SrMf
-----END PGP SIGNATURE-----

--2si5zoc2fzb2mqw3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
