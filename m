From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Wed, 8 Oct 2014 19:21:23 +0100
Message-ID: <20141008182123.GH4609@sirena.org.uk>
References: <rjui@broadcom.com>
 <1412743127-4523-1-git-send-email-rjui@broadcom.com>
 <20141008112143.GT4609@sirena.org.uk>
 <543562EB.8060300@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SOtBRHVUTiB0e0Vw"
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <543562EB.8060300-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SOtBRHVUTiB0e0Vw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 09:14:35AM -0700, Ray Jui wrote:

> Thanks for the reply. It looks like you are also the maintainer of spidev.
> In this case, could you please help to confirm that you expect spidev to use
> separate buffers for TX and RX? If so, I can go ahead and make the change in
> spidev.

Yes, that would be my expectation for maximum robustness (or if it is
going to use one buffer it explicitly maps it for mixed use but I'd
expect that to be asking for trouble).

--SOtBRHVUTiB0e0Vw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNYCiAAoJECTWi3JdVIfQB0EH/j/kNQG1QgTj6zKBsCfVYKBy
Zlyampo/pqtrRqo3+PSiEv4Kq6vV+VazJUgypVacC5LLFeiWTl1qQ4G6n8x345oT
SklY3cjCZkduKMsBOrPIzcUnP0CZYqVps/fl4nIf3rXjloed8Ch3V4+7ewDFyFH7
Q28NkW3bH3wvl83oGdKD4peh3M2N62lFKyNexebXYLv8vTDJb1U+WiMZvDkORA7W
FstTWQaWzOSM554SKE++BqJ+IWPKTZ8MYw8RHW7GdvSiy9gsnECS2z/YAfhXypIF
LE7/UY3peQlD432gCiJa9gyv+cDaL/HJLOURuimE25JPa1Ea2ZDuYvp0xFx2Awk=
=JBXg
-----END PGP SIGNATURE-----

--SOtBRHVUTiB0e0Vw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
