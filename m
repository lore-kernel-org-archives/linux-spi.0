From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Fri, 10 Apr 2015 16:45:05 +0100
Message-ID: <20150410154505.GM6023@sirena.org.uk>
References: <1428285263-15135-1-git-send-email-bert@biot.com>
 <20150406163905.GL6023@sirena.org.uk>
 <5526EFA0.2010108@biot.com>
 <20150409215047.GE6023@sirena.org.uk>
 <5527ECC3.1000209@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mgP3ep6s6oWoM+py"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5527ECC3.1000209-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mgP3ep6s6oWoM+py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 05:31:15PM +0200, Bert Vermeulen wrote:
> On 04/09/2015 11:50 PM, Mark Brown wrote:
> > On Thu, Apr 09, 2015 at 11:31:12PM +0200, Bert Vermeulen wrote:

> > implementation of that standard API to the core.  It *sounds* like
> > you're just trying to implement two wire mode which does have a standard
> > API, please use that.

> Can you please advise what kind of solution would be acceptable then? I need
> to signal from an SPI protocol driver to an SPI master on a per-transfer basis.

Please refer to my reply above...

> Also, I have no idea what you mean by two-wire mode. This "fast mode" is SPI
> + one extra pin.

SPI_TX_DUAL.

--mgP3ep6s6oWoM+py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ/ABAAoJECTWi3JdVIfQHnkH/2RtnbZDBAPSWGyuBsbA7EP9
UAeU4TYPsx0VpZjzx6g7TAVIgnLaysxe4II0fI3Z9MZosxj5dTmCGWguNHtpWZE7
vFXWx/55JhazlWmCVdxFAdQKJ+pmQAHSQ/ymFooJ1ZxMly5DAiABPT58aPjYyqQr
wABLeWbQuAAMSaV2690FPa7ENPldsxipum4RCrfHMwGXLjyeeTw7NBvKvnrjsezV
Wxi91QqiuxRKjD7EZJ7nLlUebh55VWHv8FwprBQJMkZvu0amsSHLLBA3YY/76mm0
nwjpB3XiGAtxffbMeaVdqwxgCSaVT2oKBWWXn/Wou9JiSjroxryhy9jGZi/NH8w=
=6CLs
-----END PGP SIGNATURE-----

--mgP3ep6s6oWoM+py--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
