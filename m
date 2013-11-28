From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sh-msiof: Convert to clk_prepare/unprepare
Date: Thu, 28 Nov 2013 10:34:07 +0000
Message-ID: <20131128103407.GI14725@sirena.org.uk>
References: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385602783-3439-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PSbnZfZb/hnz6qjT"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385602783-3439-2-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PSbnZfZb/hnz6qjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 02:39:43AM +0100, Laurent Pinchart wrote:

> Get the driver ready for the migration to the common clock framework by
> calling clk_prepare() and clk_unprepare(). The calls are added in the
> probe and remove handlers as the clk_enable() and clk_disable() calls
> are located in atomic context and there's no callback function in
> non-atomic context that can be used to prepare/unprepare the clock.

Applied, thanks.  However it does seem like you should be able to move
the prepare and disable to runtime PM rather than leaving it prepared
for the entire time the driver is loaded.  In most systems this won't
make any difference since prepare won't do anything but it's a bit
neater.

--PSbnZfZb/hnz6qjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlxwbAAoJELSic+t+oim90X4P/jrVHDMyqpdKTj4ghj/ml5dx
8Vw79C/nJNTHoZfh/GJboYziNPcbTTVKoOGr0UsPYPayt2wcFoD4vtTSkB4zredy
7JtfhwGIoCb6SalfVCfmvBi9Xzkuu2r5km06qGFJwLRgbxe14+dmZKXj9nsznSPt
mc0WuN5BZbixjwqERKU2nCr0GrCJBEKmqQbA+/hMhon2v9lrUg9kN+KaHZua9oCf
qiWqfc5MityO4AZnmrpkZM3HHXbFXXGJY7DBphakz+6sxEQma4K4xgOl7zKIYqy2
SRR7KwzrTjByiTvzDbOKb/snn/sbp3Wntr0aLdzMysOL9kYCCvHNjnDkLPLJYaPW
SWaWr+MMnZBngYZu/HO1dNkQ18FeKfo/zTn4kiuTzlTN76dr017wdjvV0EFluCD4
jLi7fcoANLMFAj/K37QHcQQHJmXhwY7RFp1h5+q1wOafs2T1icMX/GE2tM6KP7LG
hUZb2mkdgcogusTR7SVhyekGyswsmr2gshfnQgiISDiqkLzH/m9mn97rcAeSwTfC
ODUHq23k00SDFKfs0hno9uaaynxU55UrICB6IiPypcBh+j2zGOdvWmrN0yNZ5NAe
ZUKFLs8knUg/TonjHyMtrU6Pc9K9ZgR+Fk4ThFkFGf3F81ur2kS70J0STEJfLHlf
YB0CI9EXSAwghOjXAYmq
=l9HP
-----END PGP SIGNATURE-----

--PSbnZfZb/hnz6qjT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
