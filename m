From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/rockchip: Make sure spi clk is on in
 rockchip_spi_set_cs
Date: Fri, 26 Feb 2016 10:58:29 +0900
Message-ID: <20160226015829.GC18327@sirena.org.uk>
References: <1456308004-29102-1-git-send-email-huibin.hong@rock-chips.com>
 <56CD8F85.2090204@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/CMXFb8mCYhr2S8D"
Cc: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"shawn.lin" <shawn.lin-NgiFYW8Wbx6Ta72+1OMJgUB+6BGkLq7r@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
To: "Huang, Tao" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CD8F85.2090204-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/CMXFb8mCYhr2S8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 24, 2016 at 07:09:57PM +0800, Huang, Tao wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Another way to solve this bug is add runtime PM support while spi setup.
> Some other chips may have some problem, for example mt65xx and orion,
> which access hardware register too.

No, this is telling you you're doing something wrong - setup() might be
called while another transfer is in progress so you shouldn't be
changing the hardware setup (see Documentation/spi/spi-summary).  This
means that you normally shouldn't be writing to registers there.  Moving
this to prepare_message() instead is probably what you want.

--/CMXFb8mCYhr2S8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz7FEAAoJECTWi3JdVIfQoM8H/1CE73Xyyf2R4+65oHHv/ISN
RRSbDBOeGC4xi0Ci5p2mwSRQsG6Yj7RSv+k/L9qd1SoMu3CAgZkWYV8Stj0UczHl
eatog3FiLzCc68NJcBvxL/7uzjY1UIZ+tZH8DkkD2GPJzjP1v6lt2b+CKUp7km6P
TgGt/CbTiQidAVcd0PcwNGl1yqsMwU4nrEWlP/OWjfnYL+SoN60YSmHJ0r5EMbIL
zRSPBMmmYpdM/kvLVZe85nNmcmdhAH+HKJLXct/k+ES/JqI1G7yjQmLD8/PHBySD
mKBnYcwZ9soRUI3kuz+GXQfin4ZDoqnrvPH8pNXAJeJ3Bof2tF0LPDXNBbgLa3U=
=WAJU
-----END PGP SIGNATURE-----

--/CMXFb8mCYhr2S8D--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
