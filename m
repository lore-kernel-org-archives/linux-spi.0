From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] Add spi power control when set cs
Date: Wed, 23 Oct 2019 16:11:33 +0100
Message-ID: <20191023151133.GD5723@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
To: Luhua Xu <luhua.xu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 08:38:41AM -0400, Luhua Xu wrote:
> This patch add power control when set spi cs to fix register
> access violation.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wbaQACgkQJNaLcl1U
h9AZ8wf/YsPE4g2DB7vKBwqbkxq/ALWspomqahnmYRS1ybVmFae84b4Y3Xzplke5
VU7AJlcmslaIf2Js7txBb4HlATcKiqZlF0TsqOiIsw2Q4/rS0hJBFZ6DLVuLrwwz
dtvRrTurDuYVBo5Empbka7kYAgowqqZxwcqWVAPXHcx6C2wbdOO7VmQmxsMD/VvX
qWJ2DgEFIps2ZKsofdbLOK+iVaQFVcsT3mo/X/TfFz7zWB0GEglAXVUixrD8iqRZ
LRok6FnVsK+vVRasKGCp9c9Thjb3+DPfx64ONurPnRphX6RkYHSb4EgTlecjgOVj
+g+CiFeIDbyPWJaII6qEnmOs/OwejA==
=MGjC
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
