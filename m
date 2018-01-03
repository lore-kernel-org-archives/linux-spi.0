From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling
 more explicit
Date: Wed, 3 Jan 2018 16:05:17 +0000
Message-ID: <20180103160517.GE28713@sirena.org.uk>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-5-linus.walleij@linaro.org>
 <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q@mail.gmail.com>
 <CACRpkdZaLKUs+9BP_Tp8bhdCur+CHaTK1RsS=i2na4Edqz1VGw@mail.gmail.com>
 <CAMuHMdVeTQOxRMJaohGFtw6LUtwQb6H46rsrf1fRFno9KBQXXA@mail.gmail.com>
 <CACRpkdaEyKcWPY543CZz0grepAhVijefh_+FCsPd3g+83hv2Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaEyKcWPY543CZz0grepAhVijefh_+FCsPd3g+83hv2Fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 10:40:52AM +0100, Linus Walleij wrote:

> So someone wanted to save a slab by using this instead of allocating
> the array dynamically. It's not a very admirable coding style to begin
> with. I doubt the system gains much from this.

Right, David was very focused on saving memory.

> If you agree I can rewrite it to have struct gpio_desc ** and
> dynamically allocate that to the number of descriptors with devm_kzalloc()
> instead, that is more in line with kernel patterns and this memory
> optimization anyways seems a bit overdone anyways.

Yes, that would be clearer - it's something that's good to fix anyway
rather than trying to contort around it.

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpM/zwACgkQJNaLcl1U
h9CE9Af/bp5ISdiEVDRvxRcpT+4A9zSbCpVZzK2yhN6zmdyE4IqzLE0G+bSB3qPq
IwIHR0r9M11g+jSSKJUZ3coVinBXS2wUooiEJkNTbd5LKB4oy+WMz//mNcvtnVSQ
fefbn0JSWyjQNfAjI7fIqCCYpV4X6Pt4chyyGPy8uciQ9fi9K5UUaKXFIYQKzB2Z
aQXDjv679d7q3zNbpvtB/7dAlbiyti9F7lNtQJbXVONEkmElTtjcKyZir8MLWMsN
eXDJX1OvWySkYU3WmVBDByznEInmEzmxM3Q65W0/FD8+SJz+NZuBFA8WE63o59bM
aICzQO2g0/+tTukGbHsxno9bj6cOww==
=uA5r
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
