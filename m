From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Tue, 11 Mar 2014 19:49:59 +0000
Message-ID: <20140311194959.GB28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tdmc70C6TklGKgyg"
Cc: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394541891-26469-2-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Tdmc70C6TklGKgyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 04:44:49PM +0400, Max Filippov wrote:

> +static inline int xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> +	while (xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY)) {
> +		if (!time_before(jiffies, timeout))
> +			return -EBUSY;
> +		else
> +			cpu_relax();
> +	}
> +	return 0;
> +}

So we'll busy wait for up to 100ms - that seems like an awfully long
time.  Perhaps fall back to msleep() if the delay is non-trivial (or
just reduce the timeout)?  If there are large enough FIFOs dead
reckoning a sleep for the expected transfer time might be helpful but it
seems like there's no meaningful FIFO.

> +/* Unused: this device controls its only CS automatically,
> + * deactivating it after every 16 bit transfer completion.
> + */

This is too limited to use with most SPI clients, they'll want to be
able to transmit more than one word (and the fact that only 16 bit words
are supported is also an issue, though that's easy enough to handle for
a bitbanging driver - I'd really strongly suggest supporting 8 bits per
word as well).  Clients are pretty much going to need to use GPIO based
chip select, you should make sure that's supported and covered in the
binding.

> +static void xtfpga_spi_chipselect(struct spi_device *spi, int is_on)
> +{
> +}

Omit this since it's empty.

--Tdmc70C6TklGKgyg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH2jjAAoJELSic+t+oim95Y4P/3qAvXHC1Be5ufU34cmYeMwQ
1QULypLbsN0LPf67sySX2/RmzSdEnxzLIADD/zz33vjVAz2FZNtIdEuvUDfhPbcm
HJs64FQjLLrLcxQplN/ja9Fn4jnKpWoL+UB7OSBwqsZqVUhv1Yj8bUWTJYBJwhX/
+KSTtyvXzexWfKGbSSEfUbuTM/FXZ4RG2jLnxS2x4i/WeXkHI3g8zgTrtTUWJpvV
kNSByKs9jCLK4u649QiTmOJ/8WKokijHJB7i2IPZ1GPhU+vtIAL+PIxfYnz9QQU0
qFrxtVguPrHnABYDsovx81s3f0+IUKZECr0YzZEJ5tGgG+Qe1PWiaEmVrFCYu4bv
VFfXEOA5+Y2B6cJow576qsqi/qG6enlnDhocbV1FFq5NdhMSFSScp0pK9wp3KhaH
M5FLpdR8lw4/s5Nbt0SAFIF29Ul1KJrqZOjJvUww4kGHRLSBKUhoNJ6sYR+hkchj
S7ooqB8DyHIibfX0K+E+oabtKVg3b9b/gd6+Hp+d8Mk2bj/lo41ElrdDmLHL23u/
t7TcSmrRCyPWLtiFlTP9KcrBdgsiCy6Et7hFp0dvirjM0KicP6hsbGtrB6Aygs7u
LrumrLmdYfXQnKZCHywyhcrJj78LM3TZJDPEZiPE+09UXlpzkzv7mfH2qfC0GNUy
tCT9YEMBDhQvxIZo//fX
=dWNJ
-----END PGP SIGNATURE-----

--Tdmc70C6TklGKgyg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
