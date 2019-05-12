From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Add spi_is_bpw_supported()" to the spi tree
Date: Sun, 12 May 2019 12:08:00 +0900
Message-ID: <20190512030800.GA21483@sirena.org.uk>
References: <20190415085333.EA6241127A64@debutante.sirena.org.uk>
 <e87abf19-4616-01e3-5bca-5938dee39c63@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1099525566=="
Cc: dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e87abf19-4616-01e3-5bca-5938dee39c63@tronnes.org>
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


--===============1099525566==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 05:50:36PM +0200, Noralf Tr=F8nnes wrote:

> I can't see this in for-5.2 or linux-next. You also gave me a topic
> branch for this, but I wasn't able to get an r-b on the drm patch in the
> few days left before the -rc5 cutoff in the drm subsystem. This means
> that the patch didn't go in through drm for 5.2.

Well, the graphics people can still pull the signed tag whenever they
get round to reviewing stuff.  The patch should end up in the next merge
window as well.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXjg8ACgkQJNaLcl1U
h9AWnQf/YSKH6Ojax+mi/Qg2E/gJA3mB9KtuTNWX0pU3SWbflLTEYQF3Js4fKT1m
yAWx/SPN/vkrbgzZvrqmn7N0YCba4OQlIdbXd7MXa9lfLMS3zT749gE1jxJXp3GH
yEg5E3nJfBbPAHELXFWKJvEQ1/PhUVUvzGtIMI+TgqUxlbWx4RjyD7jEzlNG3qur
vWCx7TWLX7++30cR82sAdF35fTQWL45AOFQujXEzaA7CXdR68A/ez4kM8lCuK1Qm
m+HzPhWN85pcgG2LAlMvovd86IHdTLFZ2WBZv/bDzG31Xn77dH1Gw8jAaViM6sST
a1+FeaRHSfKweF8l50b4qYoQQGPuIw==
=5dFD
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============1099525566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1099525566==--
