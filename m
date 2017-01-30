From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 12:52:28 +0000
Message-ID: <20170130125228.t4tva3x6y3gavn7w@sirena.org.uk>
References: <CGME20170130045527epcas2p18ca90e9cd6b0a6153bf941eec4f40ddf@epcas2p1.samsung.com>
 <1485752113-29581-1-git-send-email-shailendra.v@samsung.com>
 <CAMuHMdXqvLAH6NJduThQ54Ygi91A53huUHgG0jtOtrjxyagthw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhkxzp5gdoz74oub"
Cc: Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        p.shailesh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ashish.kalra-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
        Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqvLAH6NJduThQ54Ygi91A53huUHgG0jtOtrjxyagthw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zhkxzp5gdoz74oub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2017 at 11:00:28AM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 30, 2017 at 5:55 AM, Shailendra Verma
> <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > of_match_device could return NULL, and so can cause a NULL
> > pointer dereference later.

> Can it? The driver uses DT exclusively.
> There is no legacy platform code creating "mxs-spi" platform devices.

Yeah, the changelogs on these aren't very good - there's no present
risk, though future changes could potentially cause an issue so it's not
unreasonable to do it defensively.

--zhkxzp5gdoz74oub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliPNwsACgkQJNaLcl1U
h9D/2gf/cse6+jFN10kKzXnNohcBuQe/GTkO7nQp8nOTCaJyLtEKSobtub4ADDo0
82SkuTagIqvqtzDsga6QzSttfaa03jHYvVio1ZSOJ7RUuHDlxDRk0aGFYWOt4vTI
pnowgRUPA17FONLNVL4NvY/owOOZdyMwWc1SJMMfn49MErmzH4W7mgCBqJkrjt+e
oFXbdUolLrKrhre4VZk/snXf5Fjwt9rmEoo2/IBcX9miEdYDh/22DbMEW2GVYAga
gcBS9+0WexpFXgdbZ5F4wWu+KUMvpJU+p4+Q3VDyZCrDatgTFRzznfZ+26Wxwxuu
AF9AeesBZm8fDUWPYKN3c93c5GMh4Q==
=Sd1U
-----END PGP SIGNATURE-----

--zhkxzp5gdoz74oub--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
