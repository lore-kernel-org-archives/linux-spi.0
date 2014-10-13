From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/12] spi/spi-dw-mid.c: use dmaengine_slave_config() API
Date: Mon, 13 Oct 2014 12:32:33 +0200
Message-ID: <20141013103233.GI27755@sirena.org.uk>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
 <1413042040-28222-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4MTjg8yAiOaLjoFv"
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413042040-28222-8-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4MTjg8yAiOaLjoFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2014 at 09:10:36PM +0530, Vinod Koul wrote:
> The drivers should use dmaengine_slave_config() API instead of
> accessing the device_control which will be deprecated soon

Applied, thanks.

--4MTjg8yAiOaLjoFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO6pAAAoJECTWi3JdVIfQpOUH/iilgElY6zXJ4FSI9jORpB9n
NjePb/AJrafy39bQmCApCphpMtwQKrTqJVQTW1dT2eQ7wkNezUkQGWrvKJ1SRh2P
/xo4fsMnBYFjjKF/hpTABcHE9aJ0XdC2XDNHCe4JiBJ+d6FBH/v369X/+15MCUpr
1e7JPC1lo8co1nEOqZSPr/PzRCkh/5ghz70wDffaHzb+Nb3hp2K+NGk+8EJseSoX
/Whkqea8Yrie/W9tKyafIG04Hcf3f6H0IW1JDC+NMHY5UPMHXg8Lzl3pcs0r2LP1
0/VSPWzbRpDalRxLT6aLCKQj34V7rOHbxk8rbSwhgiqs2aVTitfAP1tZ5WDP87A=
=PPSK
-----END PGP SIGNATURE-----

--4MTjg8yAiOaLjoFv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
