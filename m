From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 12:46:23 +0100
Message-ID: <20190412114623.GJ6909@sirena.org.uk>
References: <20190411164235.49771-1-noralf@tronnes.org>
 <20190411164235.49771-3-noralf@tronnes.org>
 <20190411181836.t2vuutqhjglsxsaz@wunner.de>
 <98571639-840a-494c-9e41-29ff89a22a8e@tronnes.org>
 <20190412104644.rg6dxoxuaxptexdj@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2072550339=="
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 meghana.madhyastha@gmail.com, kernel@martin.sperl.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190412104644.rg6dxoxuaxptexdj@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============2072550339==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 12:46:44PM +0200, Lukas Wunner wrote:
> On Thu, Apr 11, 2019 at 11:02:26PM +0200, Noralf Tr=F8nnes wrote:
> > Den 11.04.2019 20.18, skrev Lukas Wunner:

> > > Note that spi_map_buf() already splits every transfer's sglist into
> > > segments that are smaller than ctlr->max_dma_len.  Now all that needs
> > > to be done is to amend spi-bcm2835.c to iterate over the sglist
> > > and transmit it in portions which do not exceed 65535.  Addressing the
> > > problem at this lower level would drastically reduce the overhead
> > > compared to the approach in the present patch and hence appears to be
> > > more recommendable.

> > In a previous version of this I suggested to Meghana to put this in the
> > driver, but Mark wanted it in the core.

> Do you have a link to these comments of Mark?  The first version of
> this patchset that I have here is v2 of March 2018 and it already
> uses spi_split_transfers_maxsize().  I've never seen a version which
> splits the sglist in spi-bcm2835.c (instead of splitting the transfers
> in spi.c, which, again, is significantly more expensive).

The basic theory is that we shouldn't be open coding the same handling
in multiple drivers, they should just be able to declare their
capabilities and have the core handle things as far as possible.  Since
we're already iterating over the whole message I'd be surprised if there
were a particularly big hit in cases where we don't need to split things
out, though obviously that's not been tested yet.

There have also been discussions in the past about pre-cooking some of
the messages so that if the client is sending the same thing a lot (or
things that vary only by data) we can do a lot of the validation one
time which would help.

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyweo4ACgkQJNaLcl1U
h9CHwgf/bKJ1Pu6mNMt4H3BTiiFIF3imgxw5avFxzC0AV0J8lZ7wJB48P9I94Mw3
6Q/RG7jcPK6gvqcQO2IwGczqP22b5kHAlWlvptXRBQqB0vj6PCdv1pU84CgA3rum
zfJC5uL0gBUCgB5ZEtSiobt6mWlna2zS5Z1nirIXsIZQlf2/bdls5OpGcr1O6KAG
MMr0zayfv+Y2iCVOcQ/IIJnd/rZPoKI9Q+cgtuK3KCRoxFxDA8vl4Bl8zLZ9RHAw
YD+oaiV9tJzKVahUElUpsEeWe95/agW5QOQtQQLoVf/5K9oGAelSrDbmewUrjm/R
UqgxWKH5fw6iINHW9oDc1N16fJ9EkQ==
=rIwL
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--

--===============2072550339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============2072550339==--
