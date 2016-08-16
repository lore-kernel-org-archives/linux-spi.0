From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 5/8] Documentation: dt: spi: Add Broadcom NSP, NS2 SoC
 bindings
Date: Tue, 16 Aug 2016 19:32:47 +0100
Message-ID: <20160816183247.GA9347@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-6-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t+hlxQ2APDzOSz17"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469830393-13295-6-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--t+hlxQ2APDzOSz17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 06:13:10PM -0400, Kamal Dasu wrote:

>   BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
> -        for flash reads and be configured to do single, double, quad lane
> -        io with 3-byte and 4-byte addressing support.
> +	for flash reads and be configured to do single, double, quad lane
> +	io with 3-byte and 4-byte addressing support.

Please squash this and the other reindentation into the commit adding
the binding in the first place.

--t+hlxQ2APDzOSz17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs1xOAAoJECTWi3JdVIfQA74H/1VdkHF706PdhRKzyy/X9JrY
D8PrPpijRGf4aX654vUW3We8Y1EgVgLWtp9GJ072fVRWzdXI7S/Q6Vv1OuqEReJM
vcurv9Jwp8cmb6DevzTFF+6V1Lf+rIkzV7PCwqYW3R7u9gs5cULd+ngnjb6DYOOP
NKiTXEKnzWrssOeZua0MQpcJ31cjhRbUqXdYEK8vDvPOB8vlNSrfLMmKiv1IMx+X
5dNMH7BG0+jWCkIDRvCeac9MNY7Mp/O0PQ5aFA5Wvs4S4ckrww3ffiq5/texmlI2
HVy5McM4eKKV0XpM7CeDdcthOGAsKJHKjsWqqA3CXP/a6fddU1ooaOgbikzXapI=
=I2bw
-----END PGP SIGNATURE-----

--t+hlxQ2APDzOSz17--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
