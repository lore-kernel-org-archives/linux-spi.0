From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 00/13] sunxi spi fixes
Date: Mon, 13 Jun 2016 21:57:16 +0200
Message-ID: <20160613195716.GD9354@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Cc: linux-sunxi@googlegroups.com, stable@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
	Thierry Reding <treding@nvidia.com>,
	Alison Wang <b18965@freescale.com>,
	Timo Sigurdsson <public_timo.s@silentcreek.de>,
	Jonathan Liu <net147@gmail.com>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Priit Laes <plaes@plaes.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@list
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
> Hello,
>=20
> This is update of the sunxi spi patches that should give full-featured SPI
> driver.
>=20
> First three patches fix issues with the current driver and can be of use =
for
> stable kernels so adding cc for those.
>=20
> I merged the sun4i and sun6i driver because there several issues that nee=
d to
> be fixed in both separately and they are even out of sync wrt some fixes.
> I guess some of the merge patches can be squashed.
>=20
> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cann=
ot
> tell if that side was broken by this patchset - especially the last patch=
 that
> adds DMA was afaik never tested on sun6i.

So, you didn't run that code through checkpatch and you rewrite the
whole thing entirely without even testing it... Awesome.

For the record, I'm still very much opposed to such a merge.

The first fixes are very welcome though, can and should go in.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXxAcAAoJEBx+YmzsjxAg9SAQAIgYwmPOmGbLSQ/SUUwcB5Oe
RaJjByOlmc4Te9z1IWheyWWkNHoNvn5JP9aJYYCoYPp64/io9bZ4XoVUWhED1Lqp
Y4ibeO/xWUBQtIsuEosZ9kFCtA9L30G/3HX0DW98wFOXWI4yctGd+DRaFNeIWyz0
mH1JjKwTCmUXeBPFVZIb9qpJLkagbReY7M2mFDRZohRuhDxbzZkkbmeN3bjHVbIL
VrEhOU/2AOKKuCkOI5x/Qf7Kp3ZvEClIvXS58BPN2op1fKlmh791cmiJPXHu8hxC
JPv9zGZxfRRW4+xb3dDGKW7g5KOUjHl8Yck4tHNQlBGp7R19YEE3zQq6a/UNZ0ST
HDKAvlm2CGaN1ZExk7LKakUOqZvQDqDDkk03x8fVUFkngO1H+PwdAUzZ4J4vIFW0
WK/AN9mcMtcshBvrCcI7eLLfCpp6S5cJVZbSI7LXvQdt7vttUivxPQNcvaeJlCn9
YPdAHUJNtcwTvwaPxp0/9KVQnmz5Y754FanJsN/b0UZQbXxbVCFK4rpCbW4AJgW4
TRXak3osnx2+TUxy22oUGGxTIkF8FPThgy/9vtPMTHbMFmEGTxdi16w7DI0KPCfM
K8snDke0MaAkO5erIlJi8RSZlg2+cfCZfF2RgoF/hl15WSVb2ZBjLSEe59m5jzYo
Dk5Pq3WqzBLqP3pEGGmL
=sa5+
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
