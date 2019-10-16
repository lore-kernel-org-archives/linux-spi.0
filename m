From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma mode
Date: Wed, 16 Oct 2019 22:49:18 +0100
Message-ID: <20191016214918.GA11473@sirena.co.uk>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <36610873-fa30-a286-d05c-5eceb3cbcb57@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1527627776=="
Cc: linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Sam Ravnborg <sam@ravnborg.org>, Daniel Mack <daniel@zonque.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <36610873-fa30-a286-d05c-5eceb3cbcb57@tronnes.org>
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


--===============1527627776==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 11:30:51PM +0200, Noralf Tr=F8nnes wrote:

> As Andy mentioned, ->max_transfer_size is a callback:

> struct spi_controller {
> 	/*
> 	 * on some hardware transfer / message size may be constrained
> 	 * the limit may depend on device transfer settings
> 	 */
> 	size_t (*max_transfer_size)(struct spi_device *spi);

> (I looked at its users and they all return a static or probe time value
> so not sure why it's a callback.)

Huh, I wonder why we did that...  I can't find any clear record, and
like you say nothing is using it so we should probably fix it - however
that's best done separately to this :/  Sorry for the confusion, I
didn't register what Andy was saying as being pointing out the current
state of the code.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2nkF4ACgkQJNaLcl1U
h9A+Pwf/W+TqlKqBacstyeP18KY0oRQ7ySrj544UYjH8VdN93ZMgWCSCZ5FgL9tv
APkLEB1mXcpDeqLbLHKrNBS+8yMpCzqOVIYjmA1COIRm627P28BGBF1IKaFaPg2N
fjG5vu2nWcgpCjPneFPOdCP0RLEiRd0qWLCbPv4VpKJpYHK4U44/m7bN8iuM9cHB
Chd4H3kndisVKQXkwsAT6emauaPLaf17Hbhovoar5TlHECfIwOYKanPDPIYqgol6
uOFs93BJbfky2Wj5rbCNh1F6T2zKpG8ctOvrPrDVvNcVF2vv0+EIlESSGM+aON42
h/DQKS+S9hNCPnEKRtbjv++nzuZbow==
=+n2p
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============1527627776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1527627776==--
