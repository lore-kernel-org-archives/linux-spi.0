From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Fri, 8 Nov 2013 11:05:17 +0000
Message-ID: <20131108110517.GK2493@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <20131106082141.GA11602@sirena.org.uk>
 <CAPs=JDctq1yRbuwnFH40dnQJJHF0C_D1p3iVokSPusPXA27Qeg@mail.gmail.com>
 <1546740.qqSm3Pi1hO@flatron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HHj6mHPeUinss9N+"
Cc: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Lukasz Czerwinski <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1546740.qqSm3Pi1hO@flatron>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HHj6mHPeUinss9N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 10:39:37AM +0100, Tomasz Figa wrote:
> On Thursday 07 of November 2013 14:52:36 Rajeshwari Birje wrote:

> > The reordering of the words is taken care by the Swap configuration
> > (swap_cfg) register, which I have set for both 16 and 32 bits_per_word
> > case. I have tested this patch and works fine for me and also has
> > improved the timing performance.

> This driver seems to have already worked fine with 32 bits per word,
> using the s5c73m3 camera sensor, which uses SPI for firmware upload.

This is all sounding very confused.  Either this patch is a bug fix or
it's breaking the driver but I can't tell without more information about
what it's supposed to do.  Can someone explain in concrete terms what
the intended effect of the patch is on wire behaviour?

It is possible that the s5c73m3 driver is buggy here if it's only been
tested with the s3c64xx driver (which seems likely) since the author
could have worked around the driver behaviour.

--HHj6mHPeUinss9N+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfMVqAAoJELSic+t+oim9N50QAJ5iTk3wSiHvSKPQfv1UO0LO
0TJi38N2wB+EJIgPre2mftMgxE1htIHG0Bnfuo6PUrpEbIT93TQ+xMTVPO8Mpx31
yI0I2U65MntCTHKr7KEK2Pg/dLSFt7VXqYC1aVIjkxSTnEeuP06rsJOsct7HNTvO
Qolk6M00xl6ESlfXYc1hQYJ7AGHbHhrot7OHiAVyI/VgJzeM2cML4pLolse24Xbj
dvRVELzWf1MW99lciZJGrH+B0cl1Gpr0eZJxKrf5hENAQyFxPhSMf9R7g4yC+2Xq
Bb0ILZsiKWiB4VU91CMs+UB+00Hboa/S7HAt+oW0p+lgF7lGjCb4ykX3UIFRSesY
XgXXa5PHu/OEnYlpzokV7g6BjFnH5S/auu5Bg4OIrhr9X7QFzgomzzvifkLwz3FC
jf3ETYpq1fqev8DOpeLmWJXlES22x6dxcTokIInL7E9dDFW3lGyoRw9eQ1pL8CGo
nOS0RHJrfkwz8U6vm3LIrv1QStSE16bISFr3PB/re92Cqq1ntJyUwgBl0alofR6E
Zi4HU7cox762kL61YTykiQfrAWAwzcHC5iYymFFReFyzIGmoI3pK5BtAWKoGq6HY
yW83aSUWth3AAHAy4LGkWib9eCpGs8K2IB6Da5+jzCDoAlEGJpEsNQIm6+IM7gnf
bHg02GaxBjj7V4C6QGOM
=S6FQ
-----END PGP SIGNATURE-----

--HHj6mHPeUinss9N+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
