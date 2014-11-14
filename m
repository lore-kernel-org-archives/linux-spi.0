From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: wm_adsp: Use vmalloc to allocate firmware
 download buffer
Date: Fri, 14 Nov 2014 17:32:42 +0000
Message-ID: <20141114173241.GK3815@sirena.org.uk>
References: <1415979645-26264-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1415979645-26264-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FPx55lsxtxrAWWkX"
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415979645-26264-2-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FPx55lsxtxrAWWkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 03:40:45PM +0000, Charles Keepax wrote:
> Use vmalloc to allocate the buffer for firmware/coefficient download and
> rely on the SPI core to split this up into DMA-able chunks. This should
> give better performance and means we no longer need to manually split
> the download into page size chunks to avoid allocating overly large
> continuous memory regions.

Applied, thanks.

--FPx55lsxtxrAWWkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZjy5AAoJECTWi3JdVIfQh4AH/0m+5sznibVtenj1i/gNXOeV
tY6/3skUtAQOS28FGR/UeXf42398TifZd+15NvxOoPk/sGt83lyW+HY+QdM7mFs+
kMypZncqCihFUGRXvnaMzYTrwcVTygt7GyaAu0mJMu2m8gw4RCNVNpX2EMW1lS+B
wTpH2Eh8EWvVGNH/FaS1wyv45nEWNGp3huBQZ5CR9boyqMlLJXqD41fge0dYod47
D+JxbbINDfiVZDmAq/TJOVj1O0EiVR/at5XeFIKxjKXk06u5TvcgYxRASZrMlvMW
KVaQq2jtHpVAFMd0yjUYOi5GHSst+Z/0NwVFzxsnfH8Vz7ZoEmMV0TUASYCRDmY=
=4T3P
-----END PGP SIGNATURE-----

--FPx55lsxtxrAWWkX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
