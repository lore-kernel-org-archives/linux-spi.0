From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/dln2: Fix for PM_RUNTIME removal
Date: Mon, 29 Dec 2014 16:03:59 +0000
Message-ID: <20141229160359.GP17800@sirena.org.uk>
References: <1419294557-10632-1-git-send-email-broonie@kernel.org>
 <CAMuHMdUeD4dFAxCgK8JO9MS_BCruCJk4AZ29Qr77XpfcgVpnRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GntRFHHYckrB+kfD"
Cc: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUeD4dFAxCgK8JO9MS_BCruCJk4AZ29Qr77XpfcgVpnRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GntRFHHYckrB+kfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 04:03:40PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 23, 2014 at 1:29 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > +#ifdef CONFIG_PM
> >  static int dln2_spi_runtime_suspend(struct device *dev)
> >  {
> >         struct spi_master *master = dev_get_drvdata(dev);

> You forgot to update the comment for the corresponding #endif a few
> lines below:

>         #endif /* CONFIG_PM_RUNTIME */

*sigh* which is one of the many reasons to get annoyed about those
comments; if you care about this please feel free to send a patch.

--GntRFHHYckrB+kfD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXtuAAoJECTWi3JdVIfQvwUH/RpTVc2ORknNRHwdaN6zAr4I
Vn4dRa6KoFJ4MuR7ljY2NnVVQo0V3SOJ9W/lJo3586El0LZTkywFFnyEUFn4znVp
O1+nN2XWHJQJqo7RRcpUB4BJq61mpadktzHZhClASFwZT34P3cCXby2gOFKYHoAI
X8T7baCI3JTCeO4e7dhTQiP8o/CO9YtG57mCqJHnKFKMbKFlr6dmvYvxMO46YI1x
77hc9olRHodUHUTQVdsOkzC6+TNW31sDyBFY57/M5L+5aL3Uy5SgjQOHAvAumvog
wOYb1En4i48SHPRmBseCE22eNlk3wPZX4HPCYbeemOYsKhFOK07G/kEpGzRljIk=
=srqd
-----END PGP SIGNATURE-----

--GntRFHHYckrB+kfD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
