From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Tue, 24 Feb 2015 10:54:44 +0900
Message-ID: <20150224015444.GK6236@finisterre.sirena.org.uk>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
 <1423742848-15369-3-git-send-email-a.bouin@gmail.com>
 <20150221143528.GU6236@finisterre.sirena.org.uk>
 <CAFeThoDBstQ_=gsi2o509qqQR6PbV4MxsNe=hEhKj4Mj162osA@mail.gmail.com>
 <20150223144626.GE6236@finisterre.sirena.org.uk>
 <CAFeThoD+k0DMM=dCzxO1bmC=32W_9g1pCgevNyKNsv_kzaRHeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ENS8W0Tt0j5TmTCM"
Cc: Fabio Estevam <festevam@gmail.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: =?iso-8859-1?Q?aur=E9lien?= bouin <a.bouin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFeThoD+k0DMM=dCzxO1bmC=32W_9g1pCgevNyKNsv_kzaRHeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ENS8W0Tt0j5TmTCM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 04:25:51PM +0100, aur=E9lien bouin wrote:
> 2015-02-23 15:46 GMT+01:00 Mark Brown <broonie@kernel.org>:
> > On Mon, Feb 23, 2015 at 09:44:50AM +0100, aur=E9lien bouin wrote:

> > Once more don't top post.  To repeat what I said:

> > | Why would this be a DT property?  It seems like something the driver
> > | ought to be able to figure out automatically if it matters.

> > The above doesn't address my question.

> Currently the driver does not figure it out automatically, it is a fix
> 8bits per word DMA use.

You're still not explaining why it's not a better fix for the driver to
figure this out for itself, or why it's not possible for it to do that
even if it would be better.

--ENS8W0Tt0j5TmTCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU69njAAoJECTWi3JdVIfQEcEIAIVkXldqyK1kA6U8Egr/PAc4
+YhJTKdEzprrxTfFZeaoau9B9dqN5Cr0s8LcgL6ZyPeSBZ2TUACsnZTpWT2rycob
xMIOnMGC+zpPSdzaMJohS/bTlCiXKJqNVXHBaYrjubR+YU0np6Aimtz8Gflr84tZ
oZoz+CQD5Tus51QUdnwZKjKr0Dbmh0y6s41apf12ckLKxN/FVJ72u+CcAjCui6FH
zBFaud9nC/Xa38we7R9IfH4ftOb4YjIcoiDCuuQY1GCWKyoCdnNCaXyIrDdRD3df
jGgYsyeBIqsWVgotEvb+lYyQ7FEIEwXICEmw4YliVL4AF0PjCAr8pQnvgMn4x3g=
=L4GX
-----END PGP SIGNATURE-----

--ENS8W0Tt0j5TmTCM--
