From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: npcm: fix uninitialized 'val' warning in
 receive function
Date: Tue, 20 Nov 2018 13:02:10 +0000
Message-ID: <20181120130210.GA3894@sirena.org.uk>
References: <20181118123504.83082-1-tmaimon77@gmail.com>
 <20181118123504.83082-2-tmaimon77@gmail.com>
 <CAOesGMjUJ1+qmbPWcVFm1F_F0fcdg-54YY6o4iK=PYWoAuEczA@mail.gmail.com>
 <CAP6Zq1j46ch8UUxJkO7SnrHWyP3Y7g58Fodejr98WN-TW8jhEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Cc: olof@lixom.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-spi@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP6Zq1j46ch8UUxJkO7SnrHWyP3Y7g58Fodejr98WN-TW8jhEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 12:51:19PM +0200, Tomer Maimon wrote:

> We just tried to reduce the number of lines to minimum, so we have debug it
> quite a lot (with all the numbers that can
> get from priv->tx_bytes) and the only numbers that minimum function return
> are 0, 1 or 2.

> But in the end of the day,  we don't have an issue with your solution as
> long it will be done also in the transfer function.

In general it's better to have the code be obviously correct than to try
to push down the line count - it saves people the effort of figuring out
if things are safe every time they look at it.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0BdAACgkQJNaLcl1U
h9ASIQf/cI3kpprBTkLEFxruAQbRVP4iqcAlySu6P7KxALXVKRtjn5bSW6zo68KR
pdQQSaIy69W6iehi7+9YacuKmtJcDiqfRItJLuj5FK4PM0Wfv5SjLEs5oS5SahGi
+CZsjlLWD7IKm/eiBfgpujOh1SuuAhJd0VuuEFkWE9ICbZWqaXYNTa4+5UVjwKPJ
FQqUz1BO7UYUZ9rsECcO0IpJBThxcdSrSl3UV5CAivmve0HEo3FTD6Os9wO8wAx1
e5+3m35TBPjUatI3kdyB9PrQNSroqgGe5Ou3atz7GXwXPR5eA0Zt391/0I53kPsx
vc11Ia8qPkKFJBlJQKYJRNzdRMdBXw==
=b+mA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
