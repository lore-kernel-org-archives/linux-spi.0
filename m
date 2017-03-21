From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] spi: sun6i: update max transfer size reported
Date: Tue, 21 Mar 2017 08:24:35 +0100
Message-ID: <20170321072435.vmr3p77vh5af2ysh@lukather>
References: <20170320143849.13213-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4000136424722427509=="
Cc: Martin Ayotte <martinayotte@gmail.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170320143849.13213-1-icenowy@aosc.xyz>
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


--===============4000136424722427509==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5elbrzt2yzrnefrj"
Content-Disposition: inline


--5elbrzt2yzrnefrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 10:38:49PM +0800, Icenowy Zheng wrote:
> The spi-sun6i driver have already got the ability to do large transfers.
> However, the max transfer size reported is still fifo depth - 1.
>=20
> Update the max transfer size reported to the max value possible.
>=20
> Reported-by: Martin Ayotte <martinayotte@gmail.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5elbrzt2yzrnefrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY0NUvAAoJEBx+YmzsjxAgpREQAK5Ku0KmqsM921fHSZwMW5up
ws0DyKoEd7yDIQVKzzxTDVt0EcpmXV8Q2PZZOcMtdUqlXqFJDDPFOuCYJFJCltUH
zp/KIyZ2TCDKOofL6he+3oM2QnzHDhm3f22EUqoFopGpPU8RxQaoeQI8t5mUJk22
GF9LZ5oAducWr6/nqlzThPrgesDaK4j9zMheyfEvfm7qfXZxnq/g/6w3+TXyUl/A
SZjLKP6CW5hsc3F8YGfWDjkwR0DG644PZhIOj3PXez7uCrg3VSiLti3ufi0gegYW
ps4Xt8gXRrvZ1NdE/V6X5xaLBFOdqCjgJx2vKyu9BmTJJ5uKeqRtl6L5gqcDJ0Qg
aW9hyOds70Ah4uQD007kbbLpU5c4RMnM8ADfG9liLxpA3F5FNtIhH9yRnm2GVEju
TRDeDCjUr/L1BPJQ+FYXdTqlJdKTWdK0kfeN10IaPzVFTqldq9iQPwFfidUxJ4F4
nID1M9cyHKSFIovyTdsI+fRwQBLzypGTaJ+DQuH/rz0WKjYqWHctx3dao+E0aAs1
E8g8NfgMl9HxsjR78MGwZZ8C3LBmkANSbN8wKnaBIm8DCPuEZhzMqV4QNijMZOHG
QNtC88Vfw0APQO9oc/N/92zzaldC9aNX/11aET6amVO8j59cvUfq8z79NRbgezqY
jMaPeGok7eVH/gsBenhm
=VyNg
-----END PGP SIGNATURE-----

--5elbrzt2yzrnefrj--


--===============4000136424722427509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4000136424722427509==--
