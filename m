From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] Revert "spi: pxa2xx: Only claim CS GPIOs when the
 slave device is created"
Date: Thu, 27 Jul 2017 11:15:41 +0100
Message-ID: <20170727101541.wpulhph3nckb4bxo@sirena.org.uk>
References: <20170727100954.46801-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fpkcvvb4j2j4fwu6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170727100954.46801-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fpkcvvb4j2j4fwu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2017 at 01:09:54PM +0300, Andy Shevchenko wrote:
> There is a valid case to call setup() following by setup_cs() several
> times for the same chip.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--fpkcvvb4j2j4fwu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll5vUwACgkQJNaLcl1U
h9C7Qwf/UMEaDo9BRwDfiwpNkngBMc7dEVwcfg1/onE+97efMrOD3qNj8uI7+VRG
mnq/2sclxldBJjxX2tT7E8zJvtYp0Og3rBKx4a9VSautOHjVjvn3UtdMCq+rmLW/
pXtastZoTljvugLmOWIdg+z/lhOhJOBLV4Fxj6rLgahBAUZ8Ylp3wcQQ6rvwcscF
0QU0rq3RZFSevMj9EvPXhx0EsmEdVZER+LFsIdGv3sYTsyHt16RixlLOa8A1lyOB
+cvdxyo5a+plocfMbecII4q8+7a6rjB7L6OqiqMltFlkzSwfXkFA6bN41cU2K4pl
gAjWzUrgCtbVWjnZ4s4CxCEJVFSMGA==
=/5UT
-----END PGP SIGNATURE-----

--fpkcvvb4j2j4fwu6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
