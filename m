From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: fix dma transfer for vmalloced
 buffer"
Date: Tue, 12 Apr 2016 02:22:21 +0100
Message-ID: <20160412012220.GP3351@sirena.org.uk>
References: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kynn+LdAwU9N+JqL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460140995-4062-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Kynn+LdAwU9N+JqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 09, 2016 at 03:43:15AM +0900, Akinobu Mita wrote:
> This reverts commit 3525e0aac91c4de5d20b1f22a6c6e2b39db3cc96.
>=20
> The DMA transfer for RX buffer was not handled correctly in this change.

Please use subject lines reflecting the style for the subsystem.  This
makes it easier to spot relevant changes for review.

--Kynn+LdAwU9N+JqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDE3LAAoJECTWi3JdVIfQUBEH/0ACs18KAc5RwVNFA7CHImrV
eIpc8raS5CM0yzieFnHC950DyiGByfQ7kTcYqraLG4slYeQG6T7WlfdstHwV2raz
kOc8XQr/Ag4v1wPMbcLFsgSR+EuU1PkcCD8+EWYLerz3dnZQCYuTh8n1FnGstOkw
+a3siw551wlfWIPkx28zbuVkb1Kj59pyEnBA7shMnooFveSd6TKwu4XUy0OCbm4K
NklHAO20w77NeItO6UN8N4G87LMYbrntmpaKFaUxaWRxtm3LPJPEEKetSZPB+6Oz
raiVLH7EF/VP23NOi7i9lQk+4ZdfuWacdOIEYxipvMqigq7EzzmbeOdyTcsRJ7c=
=dpow
-----END PGP SIGNATURE-----

--Kynn+LdAwU9N+JqL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
