From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: mxs: cleanup wait_for_completion return handling
Date: Mon, 2 Feb 2015 12:11:37 +0000
Message-ID: <20150202121137.GO21293@sirena.org.uk>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
 <1422865837-10357-2-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vET4Xl8WLaXB2XUg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422865837-10357-2-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vET4Xl8WLaXB2XUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 03:30:33AM -0500, Nicholas Mc Guire wrote:

> -	ret = wait_for_completion_timeout(&spi->c,
> -				msecs_to_jiffies(SSP_TIMEOUT));
> -	if (!ret) {
> +	if (!wait_for_completion_timeout(&spi->c,
> +	    msecs_to_jiffies(SSP_TIMEOUT))) {

Your new indentation is pretty confusing here, I had to look twice to
realize that the msecs_to_jiffies() is still an argument to
wait_for_completion().  Generally arguments to functions should be
aligned with the opening ( for the function, or at least much more
deeply aligned than the function itself (as was the case with the
original code).

--vET4Xl8WLaXB2XUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2l4AAoJECTWi3JdVIfQp24H/3o9SLtcwpAJi3YKizec2TXp
6h+JKrGD2WAZXAyf8B9Hn3xYjz830C5V4+NEbRwPdR1zRcpOBUNHdIiyjjiZikWx
lOdcLV+YH0vn1xkAicc+tAG2Ow2yx9dwqysJoJZj3KEggfNBi+lo7uMOLAFZgFZ0
AuX2MIfJZTIAKMBLZ+SaSnEDTr2I0dnENZtXRtBkV4okGpKPcP70mm0nfxFRIMeq
DF4WhPobxzG2dvxTgywS5FSnZJz5L6XdAmSD0elekRBDYoU3yguPxSV/WFPvgWkz
MSREuzQPP51dIPWRDNKyOWViONHRbGbmh6HhiM71oXVHBMytozP5qed6zrv/YuY=
=fzuo
-----END PGP SIGNATURE-----

--vET4Xl8WLaXB2XUg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
