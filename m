From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] regmap: Add regmap_pipe_read API
Date: Tue, 21 Jun 2016 19:42:51 +0100
Message-ID: <20160621184251.GC28202@sirena.org.uk>
References: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2016 at 06:24:36PM +0300, Crestez Dan Leonard wrote:

> +		val = ((u8*)val) + read_len;

This cast looks broken, you should be able to do pointer arithmetic on
void pointers as though they were char *.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaYqpAAoJECTWi3JdVIfQ7pEH/RFH3tcyBkhbnOSAj0PiWzlv
1h4SRNxPL022/YNc1S/lx1aTwamipUyuPCteqlIfru0bg/77jXWbIyxBXIykJhgx
vBZ31Ql7hKO2XPi0vPrI35B7SmGwqk1aQsL0OwDX8G/npG9AEz/TBFM4E7D10MEw
jzRuVTsIbjXbETCZay5Jdq0s12HSj7WcgFZlZLEMolZlwLfaLZdnfrNap1cvgT0h
a00q3JM3WaMYX+IR+XTeCKyZF/yCzsQhIu1PYzQs6YAX3gLlirN06XxBUuA88aCW
P7FpIIoFLbt22ShIJSJno81Q8gDsFZJyyEHDRu2URyjunhMdF1TKa+jSK2S50mU=
=Ig0V
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
