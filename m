From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
Date: Tue, 26 Feb 2019 11:37:20 +0000
Message-ID: <20190226113720.GB7082@sirena.org.uk>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
 <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
 <20190224103913.bjw7g6ievr75iawz@wunner.de>
 <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4951245521128774269=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-spi <linux-spi@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 Lukas Wunner <lukas@wunner.de>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4951245521128774269==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2019 at 12:03:33PM +0100, kernel@martin.sperl.org wrote:

> Some devices - like the mcp2517fd -  have for example an internal PLL
> based on an external clock. So during setup you have to use speed_hz=20
> of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we=20
> may be using speed_hz from the dt (or less if a module parameter is
> used to limit ourselves further)

> So the initial setup would not be able to help here - and every
> bus controller would now be required to implement setup.

> It also means open coding the calculations in each driver that=20
> needs something like this.

> Thus it is - imo - in the right location to support it in spi core.

I agree, this feature makes sense to me.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1JO8ACgkQJNaLcl1U
h9DqiQf/VIQKFSWAfGMPLHiXyFgCxDWSMEJBXx+qqHGX4tavUNpc/O5N4MNu52M7
/OUmB5qjgGIDXgUwVVL3ePo6qE76yqvvbXBO/XPGjoFxJMVKs/mX4jFC6gUiDU7S
ZV4xEya2ro12xZZSvAd5GoGq6OClBhSjpj18pudOh4DoqasYVYNaJUWKQW+r++zu
wsYvaUNnpRn3FmzsT/+Ptp+tB3Q8psXMRtM7fCOyhAcXY2yfVi8WTjplvjWoUlAU
oxfMql51xNPPUYMwtEEWeqGDhJMP6i6nAAChPeTE4Pjp7HZQxLj0+MioeSSicd8b
68XET/UO9eO9OR9WmFmhyGKkUJH8nw==
=wUxh
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


--===============4951245521128774269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4951245521128774269==--
