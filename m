From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/8] Documentation: dt: spi: Add BRCMSTB SoC bindings
Date: Tue, 16 Aug 2016 19:19:44 +0100
Message-ID: <20160816181944.GY9347@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LZCLy8Sy7WgNZQM"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469830393-13295-2-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5LZCLy8Sy7WgNZQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 06:13:06PM -0400, Kamal Dasu wrote:
> Added device tree bindings documentation for SoCs supported by the
> new spi-bcm-qspi, spi-brcmstb-qspi driver.

This doesn't document the clock-frequency property the driver
implements.  However I'd recommend just dropping that since it appears
to duplicate the existing facilities for setting the bus speed per slave
device.

--5LZCLy8Sy7WgNZQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs1k/AAoJECTWi3JdVIfQaAQH/j3RufX6A5hc6Ofy6ndc94qU
47mn1UL9z4Toal1hDgXrPTQ86suj3L2Rq19EIOEebhXkyGlf6sbN8SAzN+j/qRQA
lYA6qRoV4113d45Vk7J0UDOwuAIKHW8oLtfK632zP2I2PRVCtyAU63Sz9ZOVGdNu
evWjUlrdPGISwKqXFbfsSqXUArkzG58YSo91PKocUMU04gB8NcX13eGZ4kVNWZ7r
OEbwyoWg5KxJWxXCYixDJe688o8rlAqW5D+XWPwvFcP61liZaCXR4rznqZieTOmc
jgh6dSgQfv8OOLgt1/g1HXACW4bsj+6pZXdaCm2AVIrU/OIEClQR5wX2scGvw+Q=
=WWPh
-----END PGP SIGNATURE-----

--5LZCLy8Sy7WgNZQM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
