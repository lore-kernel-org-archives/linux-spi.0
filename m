From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: mediatek: revise coding style
Date: Wed, 19 Aug 2015 09:53:16 -0700
Message-ID: <20150819165316.GU10748@sirena.org.uk>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
 <1439955478-2733-2-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H7iji7vV8C4tfdBP"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439955478-2733-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H7iji7vV8C4tfdBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2015 at 11:37:56AM +0800, Leilk Liu wrote:
> This patch revises mediatek spi driver coding styles.

Two problems here.  One is that it's best practice to make purely
stylistic changes after any substantial ones, that way people can pick
up bug fixes without needing the stylistic changes.  The other is that
this just isn't an adequate changelog - what are the revisions that are
being made to the coding style and why are they being made?  This is a
very large change and there seem to be many different and unrelated
changes being made here.

--H7iji7vV8C4tfdBP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1LR3AAoJECTWi3JdVIfQunUIAIXfYzovROdkwQ4hrInx3Y2F
2/hDkd4YvSF7Botajaig607K9sHnROc10OTfnysfooyE6o2H/rzc1wxlV5g31uVW
IebShDhZgWy930UqD/UNmv19vpBgoERZZWi7VDis7To3iExrbqoj8eLzIRaDQ6EG
/RrqMjtu5Uw4rclPx4nfyvgBRBkNQcN0a8z+dEqNN1AznAh8WjG7PI0kw8ACGjlw
UP1ity51Z7Jj9oYzoCkqYgGCYYrWkYpHEQHBDounvogcbXFa7GW+I797S6TQ568r
3siAIe+9/UsSbmrGBoXYUMWAJNC/zjDXHEWCzAXth9GRkEKVjEUS1OsVw3p/o/I=
=AkDi
-----END PGP SIGNATURE-----

--H7iji7vV8C4tfdBP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
