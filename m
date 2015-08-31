From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: Replace spinlock by mutex
Date: Mon, 31 Aug 2015 11:31:59 +0100
Message-ID: <20150831103159.GJ12027@sirena.org.uk>
References: <1439783574-5933-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KAOsyhT1w54dc1u6JRzUdrjo-RpCb7CQBD66OdrSyPh=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lDJjfxLPd2/fL7KW"
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KAOsyhT1w54dc1u6JRzUdrjo-RpCb7CQBD66OdrSyPh=w@mail.gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lDJjfxLPd2/fL7KW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 03:54:13PM +0800, Nicolas Boichat wrote:
> On Mon, Aug 17, 2015 at 11:52 AM, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:

> Any update on this patch? It still applies on for-next but happy to
> resend if necessary (patchwork:
> https://patchwork.kernel.org/patch/7023091/).

Please don't send content free pings and please allow a reasonable
amount of time for review.

--lDJjfxLPd2/fL7KW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5C0eAAoJECTWi3JdVIfQNDYIAIUPVm2icAJcSliN+hvcpAED
NdoJc5zEG3oi0/XY8JGazMrdfDDkWXFCKAEaVefq3IMkblIHVnCpKTlaWMZ2sqa1
4CidOrE+srXnu9Lr6z0uvZAshavgUux1oo4n+YAGZkrE1Zhj93hx2WqTJd8UGIRK
BnrYOZS+XBWaC2S9AU028RLaNr1WciPLAkwRIPS9zeRJZaBawSP1qDBHOY/bVXHl
DYVxoKrBILVzG0qBwbkqBFwI8ny3zj4Kk6GxTbVz4RfSn1nA5y5hLs28l83bzqkP
5z5T796PmACwX1wgdaMy1DenPgiZE21r+GGiNDD2TkbN/A4X5I/U4dtgNWZK774=
=Opby
-----END PGP SIGNATURE-----

--lDJjfxLPd2/fL7KW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
