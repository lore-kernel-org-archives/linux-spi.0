From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] spi: Switch call order of spi master setup and spi_set_cs
Date: Tue, 13 Oct 2015 13:10:47 +0100
Message-ID: <20151013121047.GD14956@sirena.org.uk>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nsekhar-l0cyMroinI0@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444683671-15570-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 04:01:10PM -0500, Franklin S Cooper Jr wrote:
> Keystone 2 devices currently fail to boot in linux-next after the
> below commit was applied:

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that
any important information is recorded in the changelog rather than being
lost.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHPTGAAoJECTWi3JdVIfQyHkH/A99/xbS95Lr3fBQ7ZEt6c1p
inQqbvGuuDDkc4c3kwjHEycLp67mNwuPcuxz27LQObSS3CU0T3UaQohQjbyqhqki
0HLhAIZ4OHiQ9YWBiDHw2h0aaW1dtxqKCbHem/No3/cWrLkePtC8XtLlTgW5Tvbn
LXfnbwaigSWjlh2ks5Uc4Fhu78qY5Mt2mSbqqybgzdFJLcS2f7hw+3O5UYKcK2j8
TFUCnlaInEdiJNxVjBGPRx8nR8hVIf53dZ4P1sCh6VW/Ww78uLOhsAMNsQ2LC/0i
LkLuRywRF3w7sNmr4YgB/fJCoMtt/50xk72ry5Zg4jz2zqIFx/WxBzvG++BgJmM=
=6If8
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
