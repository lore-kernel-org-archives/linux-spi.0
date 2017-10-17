From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix bogus SPI bus number
Date: Tue, 17 Oct 2017 13:25:37 +0100
Message-ID: <20171017122537.dj4ey3g4nb7hqhn7@sirena.co.uk>
References: <20171017104519.878892-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4fp2dv4kipqtzav"
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Naresh Kamboju <naresh.kamboju-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171017104519.878892-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--v4fp2dv4kipqtzav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 12:44:50PM +0200, Arnd Bergmann wrote:
> lkft found a boot time regression on the Hikey board that has no
> aliases entry for spi buses. of_alias_get_highest_id() here
> returns -ENODEV, which is then used as the initial number for the
> IDR allocation, and that in turn triggers a WARN_ON:

This doesn't apply against current code, please check and resend.

--v4fp2dv4kipqtzav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnl9sAACgkQJNaLcl1U
h9DfqAf/QCAAV/OGq18UiNzgM+NWKlGKmYZzwYm1sYZeK41jjigNfK879xJWdNBf
nC3qwULe/SJh2P8ZrKvQqGG7epEN0vvc/lsE8n7FbpIGvW/EdZmLZnqyBuclfQIp
lTfNysyP9S/zQZcTzCVAqL7i3lo3or0wcJmMkNI1NX3JJdkLE1lKk9vgSh1yN5GZ
B+TuNp18gWbwKAlytXJqXOWRqNkiKH+M4hGYwG8WfUmXCwxXxAWvxC5Vs0dGdAtf
HzOk6LbMCNRuqOfB/EfA9fEDzp40SuiAHa2WUUpy8692m4461vQNubJnuoPnhJAl
w7vdOdV6ksdQY7hr/JDc0rSwOmnmRg==
=ZZNb
-----END PGP SIGNATURE-----

--v4fp2dv4kipqtzav--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
