From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: unnecessary double init_completion removed
Date: Wed, 24 Dec 2014 11:58:17 +0000
Message-ID: <20141224115817.GR17800@sirena.org.uk>
References: <1419356493-22539-1-git-send-email-der.herr@hofr.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGw25I70SdcL9+dm"
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419356493-22539-1-git-send-email-der.herr-kA1LtwSENNE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZGw25I70SdcL9+dm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 06:41:33PM +0100, Nicholas Mc Guire wrote:
> The double call to init_completion(&mpc8xxx_spi->done); is not needed
> presumably this is a editing mistake only.

Applied, thanks.

--ZGw25I70SdcL9+dm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmqpYAAoJECTWi3JdVIfQ4dQH/2COul2XOu553PdjXAOmaDfF
uJC4TtpTBFGQhSGMGxHSARVPr+RG1yi9Pa15EW3wwcICoDUxsIhU69JEXxUpqVco
sTqR56AKkuTKFCmrhx97ZCzY6hvUFzkCpYgxW1zsWHlDWEh24vyAO2dPOa5oDP0E
Enh8VA6LqMEJbNG4+mm0jKgsQsb7fqAH2eiMeV+KFPj2KvSMi5pKQIoDNj57Yqhr
cxvWpi0D4oXPdC+vdnswN6VNlCqHgxSimyWS0Y+rVSDkXRwu3ptj44pR4QNrmuaE
2YgarTORkGGgX5xq9Fp1ZTrg/KPa0mpgJzDaRV2K+BDx2AR/SB4IPh/fl36/p1c=
=fMjG
-----END PGP SIGNATURE-----

--ZGw25I70SdcL9+dm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
