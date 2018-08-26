From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Sun, 26 Aug 2018 14:24:15 +0100
Message-ID: <20180826132415.GB2414@sirena.org.uk>
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
 <20180823102121.GC5207@sirena.org.uk>
 <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MRlEjvj2/M31Nfs"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3MRlEjvj2/M31Nfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2018 at 08:54:53PM +0300, Kirill Kapranov wrote:
> > For DT systems the dynamically allocated IDs start at the maximum
> > positive ID and work down so in practice it is vanishingly unlikely that
> > there will be a collision as idiomatic static DT IDs would be low
> > integers.
>=20
> Yes, this algorithm seems really bullet-proof. However, it isn't actually
> used now. The ID allocation algorithm using  atomic_dec_return call had b=
een
> introduced 2006-01-08 as [1]. It was being used in the mainline kernel (w=
ith
> some improvements) up to 2017-08-16, when it has been replaced with the
> newer algorithm using Linux idr, accordingly [2].

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> Since idr_alloc call works incrementally, the situation of a 'fixed' ID
> squatting by a driver with 'dynamic ID' seems more than possible.
> Therefore it would be justified to use a hardcoded constant
> SPI_DYN_FIRST_BUS_NUM (that was introduced in [2] and eliminated in [3]),
> but with a sufficiently greater value of the constant.

Right, that clearly wasn't an intended effect, though - should be using
the max of the big constant and the maximum static ID.

--3MRlEjvj2/M31Nfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluCqf4ACgkQJNaLcl1U
h9AqlQf/f1Ygj0gQJI4WHKVVOeOAKQ/lCjedt4b1RPCSVEI2bL6xDZe285X3giTA
O7esPQ5FidXofVcJbXVvI5RbkSm4wVYjjcYOuMLU5BruXLZlYXbQztVRSuZhqlXI
YVbERltGQV2TkCgR+y7IPB+BzIfJLz4ZS/kXnHwbRcD7VEAKiEm8CTn5xslXl2ao
BBGtKaTRalGAe7guBHLWvzsFoPI4lEO9y4AIJXksDCj0y7mX6NuAGxUNXl4HJMD+
ztyRWAywmC/zNL6c+z3sXIFyGDI5F6UgiWHb701i8frAVflq2sN/JuJWHid6j34U
JgU4Eotl2oBlxbZpjT5chbCuiHDoNw==
=vrmZ
-----END PGP SIGNATURE-----

--3MRlEjvj2/M31Nfs--
