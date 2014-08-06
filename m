From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/12] spi: sh-msiof: Fix leaking of unused DMA
 descriptors
Date: Wed, 6 Aug 2014 21:35:43 +0100
Message-ID: <20140806203543.GV17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rT2J5DU38xRYJFcJ"
Cc: Simon Horman <horms@verge.net.au>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-7-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rT2J5DU38xRYJFcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 02:59:03PM +0200, Geert Uytterhoeven wrote:
> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
> unused DMA descriptors.

Applied, thanks.

--rT2J5DU38xRYJFcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4pGcAAoJELSic+t+oim94zIP/2I0+gJWLqdtDt3XKKd2zmAb
Qd9jsZWmnJhcxCq7CzpvYOmocPrHQoTd7WfMoqv5BwsHyp0+1NOsALKDKW+dXkP1
BGAL5Ox2aSNm1O3gXqtK+bAh7mz/8EcbPTfcVn3EJnHt0j6uVbiAkH25MWEhmmIr
I9Kmg1sj6ROUSSJlbJcaCTJKSneKGxFV8Zt3ikMy3xWe+mFGVLGLiQJQrC7gRztg
0BzXPsMIIsvmbnEAz/S3dkU9YFLgk+2HNwXGGr4Tv00u5DePLfydOonwVgbH/2fO
3mZFVvIOvL4f/w3WNWaDlc2QO8ieUxpjs+ac14TIbwCLNAVJFRyOQLDBLYL5soGc
zvkxnvwrqxNGEfvDRAUe+tnlKdqXLqpncB/v0bWZxEOdfPvgH0x0JBhZR6AI8yoK
opL6nT08qnUKUJ7UHYzlOebdO9vBjUI7xNBHme4AwC+RpN6/EYKWoCcvmaV9VglC
G1rpS8wLmgybAvE5ps1xVfc8dkPc2z5MNnwzx1KbTGfQloBa3b7kLRHcsjzxMOCv
BRdqSBF+zujQPhXs0x2ho5MHZjggrhEsOWMbzcNXgZAs+qUeM+hjewKjjRro3ucR
yvXO0KoE4jdK7c9vbD6OK42MVBbY0FeTDrMt05Q23FrPmZC3PZEVrIqV95CoXww6
SlY28KKY7ekdR+0MbBkV
=tqID
-----END PGP SIGNATURE-----

--rT2J5DU38xRYJFcJ--
