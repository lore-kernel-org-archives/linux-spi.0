From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/6] spi: davinci: use rx buffer as dummy tx buffer
Date: Wed, 15 Mar 2017 19:35:30 +0000
Message-ID: <20170315193530.fjguqfb6vjd7kfey@sirena.org.uk>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
 <1487872921-26628-4-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aq2sp22zgdptq3qy"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487872921-26628-4-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aq2sp22zgdptq3qy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2017 at 07:01:58PM +0100, Frode Isaksen wrote:
> When doing rx-only transfer, the transfer will fail
> if the number of SG entries exceeds 20.
> This happens because the eDMA DMA engine is limited
> to 20 SG entries in one transaction, and when the
> DMA transcation is resumed (which takes > 150us),
> rx errors occurs because the slave is still transmitting.
> Fix this by using the rx buffer as the dummy tx buffer,
> so that resuming the rx transcation happens at the same
> time as resuming the tx transcation.

Please submit a followup patch adding a comment explaing what's going
in the actual code as someone's going to clean this up at some point.

--aq2sp22zgdptq3qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljJl4IACgkQJNaLcl1U
h9BYngf/ambB4WHWY/jG1DKCUkpWiTXbkpMRU/rzZ5ub1oRtnBjAqI0iJIYxtFmg
zZAbIY8HYLhBMzal5GqokJOHaxJ1ziQHhlKfk3Mq1rAYypKpMJXIROB7uvVAjnik
D0nD7eMK28tKqYWFHfSj9hpQzsHIy+fa9N7qfuC8pirvKRJzQjimebrMAXlzBF0t
Prw+tBgXjRhfTxbZS3I2bq1TJZIWhjiCuHxhwIf9UwnB2PL4OeHA8nDO6G9jR23R
hCJtaQW6xMsUakDl0tW5IlEcZ+JT+oD+KxwM/jQyHwcEEqI12Dpo5DB4nTknZOdJ
qUlj3ZFjZsKFEC+5YVZd43UNmGbfjg==
=RPIX
-----END PGP SIGNATURE-----

--aq2sp22zgdptq3qy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
