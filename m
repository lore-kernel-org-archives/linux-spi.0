From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Thu, 27 Feb 2014 13:37:19 +0900
Message-ID: <20140227043719.GH9383@sirena.org.uk>
References: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393428679-18462-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 04:31:19PM +0100, Alexander Stein wrote:
> If during registering SPI master due to SPI device probing a SPI transfer
> is issued the DMA buffers are not allocated yet.

Applied, thanks.

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsD8AAoJELSic+t+oim9UC0P+QEThap1quaLd1VC+hfagsS7
tnaCURLUJkklnRLjjQdu724uRawM9M2oLxp+cRD+EGLDKAVF+dMKMRzbhP14TFI7
6p0b/kDhBMCjY4n6qRaHXnKLjPFugWP/+DJ2h4Wc14HARaMPM6x3tCYfan831JQP
O/EHL7cpDcxuB8IDut+p53R7FVacOt4tBYf/wtShFwKo7zF+QJI8jW0sfEElvOiB
wGYgzb2kEoCC6RSSd+aTSJLfzAoVpTKCyUjmtpLagfe5UcTCSrUBk7DRBOxFLDKo
dj/8MT8uqn114I3VleDSLO9bhhDJPRW6f2KLe8fvxGhuxMnSVgUVl5XZAnV7eVlV
mQBrWzNIBjwnJjIkwKo2o6vHvSoq2r3z9/CxnODHfmB6qpCNiozt59g+IFWsvwmQ
jzcejnPiHSxL2hKjLBE5V46T+f6VAmLiXdpEJ4LpLAteXZLAmyQc3crWIUhrC3jb
B2gCnOec193iBnpnocWy0vpQBa70fS9QiATzJyURxW+bHTKSuaYSnu9R8WsW6WLa
nn+p6nQVX9jSdEPt9D4Q0R3DLWa/xgwaDrjVCoIsb8XClgadwn77e0K9Jo++D7v/
G7dcSri43/zT/HiOtoxBhRMgaM42eeuiviVUJFe5hEeSoshMSwyGwpqoCxTeyIhF
e0AU9QcgjcnITP17BtOi
=Tz5A
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
