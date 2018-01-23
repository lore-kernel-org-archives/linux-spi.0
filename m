From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] Add ability to multiplex SPI bus
Date: Tue, 23 Jan 2018 10:46:55 +0000
Message-ID: <20180123104655.GA7600@sirena.org.uk>
References: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ben Whitten <ben.whitten@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 10:51:11PM +0000, Ben Whitten wrote:
> A chip that I am working on acts as an SPI multiplexer for downstream rad=
ios,
> this patch adds basic support for adding an SPI mux with DT.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpnEpsACgkQJNaLcl1U
h9AGDQf/XZ4cBcYaPUX6PhSI59auwJz44xdsmDTSB6YY5sGWwAyCvtu9+WMXHNsM
Qfds43e/OLalIvYWEZR1T5c2xxxNNCl9/5PfFjpxA4Ymq+B6TgO92xrVzfwr49Vr
NksWEMu23z6HUgd/n08PGUq14BP4xG381cUEpStLIGmZeNZu3aWnvsAKZaD1fRqd
aQ6Hv/VsrCNwRk41jt/PanP+Oei6rmVKls/K/qXLdCzT45Fvz8DDGHuub/s4vlLA
bnKNgM7VCeWddQ3jLFCmch8jlLBBWrUyTxL/LHkHDlBTME5eB30VKXQRkz/IQ+uP
H9dXR3Fs/aJSVwIR+l6TDpHNpV4bPQ==
=DUNF
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
