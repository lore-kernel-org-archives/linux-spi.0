From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] spi: rockchip: Disable Runtime PM when chip
 select is asserted
Date: Wed, 28 Jun 2017 19:42:28 +0100
Message-ID: <20170628184228.qdj7oslnljv6e2iy@sirena.org.uk>
References: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498624723-17332-2-git-send-email-jeffy.chen@rock-chips.com>
 <CAD=FV=UzDHfTNJgs8vvbKGd0RpY__Q9V27aSQiR5ugv6ff5gfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5uxnqcyip22z3qm"
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=UzDHfTNJgs8vvbKGd0RpY__Q9V27aSQiR5ugv6ff5gfQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w5uxnqcyip22z3qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 10:30:10PM -0700, Doug Anderson wrote:
> Jeffy,
>=20
> On Tue, Jun 27, 2017 at 9:38 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> w=
rote:
> > The rockchip spi would stop driving pins when runtime suspended, which
> > might break slave's xfer(for example cros_ec).

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--w5uxnqcyip22z3qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT+JQACgkQJNaLcl1U
h9CCNwf/exy0157PdbitfrMUHULKgSM+SMp2uJzj8ylcVXeAoPOQBOFIqeYbf8P4
RwSrX+QEdO3RjbEjJZgVYH4Lv5oSqv2bELCfjG6/verPRQJUDfm34djrXeLjGimz
ejCy/5BRrCBiPhU7ogXQ9ANiXRWZSsLS9oPN+o/6ghsTLw5RffEy21adM51E2znB
l1ex/jp96x75D/AfrXFGzwP9Mdz8svW+Id7iiPkvV8jVinGbHH+qFmzvZ7yi75LR
RdDngiSa4R7lYd1lJHCnjlH6esMdV3v5Ij3TNlTXNOZ7K1q5jwVSHmeWnm9mmgmz
7sO2br6r2L4Fc0s4Gf+hR9HpMHM+nw==
=TAYp
-----END PGP SIGNATURE-----

--w5uxnqcyip22z3qm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
