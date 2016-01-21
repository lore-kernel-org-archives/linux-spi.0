From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: qup: provide proper bus numbers
Date: Thu, 21 Jan 2016 20:14:22 +0000
Message-ID: <20160121201422.GS6588@sirena.org.uk>
References: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160121183810.GN6588@sirena.org.uk>
 <56A127C6.9000409@linaro.org>
 <20160121190357.GO6588@sirena.org.uk>
 <56A130DB.4080202@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6W/vd+xQRxZFP9Eu"
Cc: Andy Gross <andy.gross@linaro.org>, linux-spi@vger.kernel.org,
	David Brown <david.brown@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A130DB.4080202@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6W/vd+xQRxZFP9Eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2016 at 07:26:19PM +0000, Srinivas Kandagatla wrote:
> On 21/01/16 19:03, Mark Brown wrote:

> >That doesn't help explain why it is a good idea to open code this in
> >individual drivers.  I was asking why it's a good idea to do this in a
> >single driver rather than at a higher level.

> Oops!!, I should have looked at spi.c which already does exactly same thing.
> I think the logic did not get triggered because (int)-1 overflowed into s16
> busnum.

Ah, that sounds like a bug...  I'd actually forgotten that we did that,
it should work though since the code is there and it (hopefully) worked
at some point.

--6W/vd+xQRxZFP9Eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoTwdAAoJECTWi3JdVIfQ8FEIAIWBmZyYe2UWePH41436OR8Q
DDOGhgoDMnBH/TobV7jGQf2v46z0ACwNrLcj9vlTPqhyEpoKFmyP0X2/2vguKymF
/W4sDCpXiov6IyTj/TdRZi7cdTpMNJj3tY9p6AEsfy1xWAMXPDJ+APNZcorXkstm
g8uCXx9r3uBfcNuANSTiwJVvdBVsQWEnfYMzbjcDdeww4FHosGn5nNorIDW+B0ej
lUqrBEniUkpd1fTJNb58YLApbPnTI9P4jB+Np+0rHMYzmIyzN/sb49WG95uROxrt
WWaA43E7hWf0fyJ2zcqnaYVMqhGm6XhqmV4yrlheuz5wYOTuYDoGUx0ayRxoMjI=
=mXiR
-----END PGP SIGNATURE-----

--6W/vd+xQRxZFP9Eu--
