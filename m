From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= dw-spi driver bus number
Date: Wed, 10 Aug 2016 12:03:29 +0100
Message-ID: <20160810110328.GH9347@sirena.org.uk>
References: <1470712490330.33016@dji.com>
 <20160809105132.GI10383@sirena.org.uk>
 <1470819008289.64659@dji.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Edison Chen <yongsen.chen-dS4nfl7sBO4@public.gmane.org>,
	Fang Yingju <yingju.fang-dS4nfl7sBO4@public.gmane.org>, Flare <jiaquan.su-dS4nfl7sBO4@public.gmane.org>
To: First Light <xiaoguang.chen-dS4nfl7sBO4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470819008289.64659-dS4nfl7sBO4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2016 at 08:50:08AM +0000, First Light wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> But I found the dynamically assigned bus number is always -1.?

> I have two spi buses, both get the -1 bus number.

That shouldn't happen, if it does it's a bug - users should never see a
negative bus number, the core should dynamically assign one if it is
given a negative bus number.  Can you check what happens in
spi_register_master()?  That's where the dynamic bus number should be
being assigned.

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqwn/AAoJECTWi3JdVIfQG5oH/3ts+uURkuUPI41V+SOawYqk
CYdHLeKOlwGHzwpBCwtnxxbEDvFm9GEUBzNOQQ3soKQRhFzad1Fwu300L7o5KJXx
HpVIYs9lN5ONxKMZQWhw4RcxAx68yk1mOXvo6Mw/8+jkIE6Us+UQxhYCqUWDlQ8V
qaLUqePjD2giNAEAzKDwPE+cVUz3Yvl8qqcay+aJxyaTQBCoGbzJasCnuM7UHj65
wbqImz9RrjzLwVvgJrw6a1lla7LGkJu9F7Js2tag1kcEgqKUU3tKqcNCOp4ZhPuk
sD+H4oNxka8eRGvCC6OHCzL/adJ4Ld2gZii9gONH/F19lTjeEj3eUyzHIbxaQzA=
=8vaK
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
