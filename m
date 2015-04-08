From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/5] spi: bcm-mspi: Add support to set serial baud
 clock rate
Date: Wed, 8 Apr 2015 20:53:33 +0100
Message-ID: <20150408195333.GL6023@sirena.org.uk>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
 <1428516275-12819-6-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vBRHxyNZEr4ELWc5"
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428516275-12819-6-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--vBRHxyNZEr4ELWc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 11:04:35AM -0700, Jonathan Richardson wrote:

> +	/*
> +	 * Enable clock if provided. The frequency can be changed by setting
> +	 * SPBR (serial clock baud rate) based on the desired 'clock-frequency'.
> +	 *
> +	 * Baud rate is calculated as: mspi_clk / (2 * SPBR) where SPBR is a
> +	 * value between 1-255. If not set then it is left at the h/w default.
> +	 */
> +	data->clk = devm_clk_get(dev, "mspi_clk");
> +	if (!IS_ERR(data->clk)) {

This is adding things to the DT binding, any new binding or binding
changes need to be documented.  It should also be paying attention to
errors rather than silently ignoring them, at least -EPROBE_DEFER should
be handled properly.

--vBRHxyNZEr4ELWc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVJYc8AAoJECTWi3JdVIfQ2J8H92B53JZia2zuMVX3pbCe2yBV
nO8cikzfycqE1o4hhye0h7NOn8yNOqloETeKBXiDEm1LwYkiMC1vR7RYEXJdX4pS
n7WxYgdz+FNMgU7keMKwhoGw003FK1KSty/iIDLsAdr+/LDCzGktJfVZnbJula8/
DDlj5PYqrF8BlEFpoTFyRVVCMmkonytENNkDIQxCqyL0I63POp2Rj7IvL+oVqRp9
F7BmYNB3zBCm0GtjYXvuctgB9or1Vb9ZFbBMTFzxY6iscn3ykuk4alx7Qe9cbF/C
kSSUcC5c65HTK+HkaMfSQS4UD4197KyHhbLCTYv/rIrP+lPMQRQhqGTZuHeFCQ==
=GO8V
-----END PGP SIGNATURE-----

--vBRHxyNZEr4ELWc5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
