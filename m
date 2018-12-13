From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Date: Thu, 13 Dec 2018 11:53:45 +0000
Message-ID: <20181213115345.GC10669@sirena.org.uk>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 10:04:56AM +0100, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:

> > =20
> >  	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
> > =20
> > +	meson_spicc_oen_enable(spicc);
> > +

> Any specific reason for doing this in prepare_message() ? It looks like
> something that could/should be done during the probe ?

If it's for power management then there should be a matching disable in
unprepare_message() (or this should just be in the runtime PM code,
though it's possible there's stuff that's only needed while actually
doing transfers in which case this could make sense).

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSSEkACgkQJNaLcl1U
h9CHGwf8CNMeR7WV+TrBE53uFRRrhrKajnV4JWbLuA67Kua7X2ESoTqkgJ8tc9T/
8RQ7EfxtVkGspy1ZkjpiGBrWgY0YGk6/R+N/OkMmuCDJmk5cQNdZtRy5WGIEm1ZI
I751ssIVt3EZCSE/GcpV4bJ8O7x2fGTWRbnjczwnypYeWwBqfnCxta5+N2DS7T8V
jis/mZjM8VmLv+qtryIqyfrRGlDaXB47AgQeXBCZcQh68/ab8QoUIdh4Dn/Zecl1
OBpuTheeAmfkjbLiHQNFi/XWclWK7RGACX/Xlmr+9BVmcl6CAFekXKImBoNMj8jv
kTkvW7/4I1wvzOJIkaRS0DGZFqF7Yg==
=Aegn
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
