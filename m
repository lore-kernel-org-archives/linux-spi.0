From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] spi: of: allow instantiating slaves without a
 driver
Date: Tue, 19 Jul 2016 11:52:12 +0100
Message-ID: <20160719105212.GA30372@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach@gmail.com>
 <20160718230234.GX30372@sirena.org.uk>
 <CAOMqctS0+eaufGdsGV96h3SJCOGrjhaAL1aRxxkMRtpK_p_3YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="07KgZKBWke2i7lgQ"
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctS0+eaufGdsGV96h3SJCOGrjhaAL1aRxxkMRtpK_p_3YQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--07KgZKBWke2i7lgQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 10:31:54AM +0200, Michal Suchanek wrote:
> On 19 July 2016 at 01:02, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jul 19, 2016 at 12:35:41AM +0200, Michal Suchanek wrote:

> >> SPI slave devices are not created when looking up driver for the slave
> >> fails. Create a device anyway so it can be used with spidev.

> > Nothing has change since you last sent this patch which converts
> > of_modailias_node() into something which looks up a driver so the
> > patch description still fails to describe what the patch is doing.

> I have split the other part of the patch. Regarding the commit message
> if you have suggestion for better wording please do share it.

As covered in SubmittingPatches your commit message should describe what
the change does and what the intended effect is.  If we were looking for
a device driver the code would be looking up a struct device_driver or
some other struct that contains one. =20

> From my point of view the conceptual change described in the commit messa=
ge
> is that whenever SPI slave node is encountered in devicetree you get eith=
er
> a device with active driver or a device with no driver whereas
> previously you either
> got a device with active driver or no device. So yes, it's about

This is not the case, it is perfectly possible to have a device with no
driver bound to it otherwise it would not be possible to use loadable
modules for drivers.

--07KgZKBWke2i7lgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjgZbAAoJECTWi3JdVIfQlGIH/2Y5OEtNlmvj1zi51YRHoXOZ
M8iTMCV17WvWIyNVozASVUq3laURj5jOBlGy84N5y/rjokQF/0L/WRQQJRCFbrU3
L8BS188cQhF/Yzq3yrxfpkw/9pQs7ofERITJEobaeNZAgOJm2HvfMJpc4QFRiztY
hRr+EOK8BqPq/V+SIj2ybbG81BFkPdHcAHMOIx3/eQSXphSMVY6lha0z1iJPWMVY
XMb/lydPcrCHZ+jZ3XYofGnmwOr7TFsJkMFsPGQIaCVvyQ2neTjygRBeOubKIGMC
gxGGj6u7+Ja1adbrzaDApb0ols7vYzsKOhUS90cJc7pQEq5dHlmdaLXRODqzulQ=
=NY65
-----END PGP SIGNATURE-----

--07KgZKBWke2i7lgQ--
