From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 09:21:01 +0100
Message-ID: <20160701082101.GD6247@sirena.org.uk>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
 <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HjNkcEWJ4DMx36DP"
Cc: apronin@chromium.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WSHKfAmskimrxOaiFvGmF-FTzNgiv-_=RtK+DfX-ZuuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HjNkcEWJ4DMx36DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 09:23:26PM -0700, Doug Anderson wrote:

> Also, something doesn't seem terribly robust about this, buy maybe I'm
> being paranoid.  If something happens where the timer hasn't fired
> quickly enough then you might not know that you need to assert the
> wakeup, right?  I don't think there's a 100% guarantee that a timer
> will fire and finish running within a certain period of time, is
> there?

No, or at least a minimum bound on accuracy - you'd need to set the
timer for something lower than the actual limit.

--HjNkcEWJ4DMx36DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdifsAAoJECTWi3JdVIfQ/bQH/i5E4qmz6D9CyvinnTcn0ltO
PlhllF5RvScG/delCF9lbxuO+FAi6Mmu0z67nJ0mYw3ltWmhsRjfSR0wL5ZnRzxR
1EzpaJoTTSiI54xkPZ4YAi/taIPtY2DWndNngLoa0PLpDdGo2y3fl+LG/OHe4l0o
qcO4joknLaU2H1ozMBGPUgz3hEVWoUgKc++8C3T5jtxxqQEJLW5AUtsIPme/cw5T
n8GpYlRfeQglZ2Vd0r4p0bgYPKpRbMdEZj6PSPFZz65UP2WLfTKFNNbR67L67HQ6
kuYnIvJMZ++iwZtYbx2zwm+bAQ8SX8y1zvcp9+WqWCvScKtImGTz/kzfk1/Dp9g=
=LeWY
-----END PGP SIGNATURE-----

--HjNkcEWJ4DMx36DP--
