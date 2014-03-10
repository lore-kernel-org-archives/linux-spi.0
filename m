From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Enable clock before calling
 spi_master_resume
Date: Mon, 10 Mar 2014 11:22:11 +0000
Message-ID: <20140310112211.GZ28112@sirena.org.uk>
References: <1393379275.7490.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SJ2dn9eo9utwE8uN"
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393379275.7490.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SJ2dn9eo9utwE8uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 09:47:55AM +0800, Axel Lin wrote:
> This ensures clock has been enabled before calling spi_master_resume().
> while at it, also add checking return value of spi_master_suspend and
> spi_master_resume because they may fail.

Applied, thanks.

--SJ2dn9eo9utwE8uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHaBgAAoJELSic+t+oim9XM0P/2HZqlthgJA1UWx2BG7jLZLW
N48bUuNZvFtzY2Ccvx7CmIXgbRsTwW6FeZKJKFBUqi3EjaoNJA1+tkFLCiwnXKvf
B7lCnbcsbUzZhMoJETonl3UgG8x/PD1tpoajCN1HN7FsSn4yAsg6+mvYNcKDbN/W
r1IySDOR7Sf/YXs1QV82GecIueMe1YDVgYvsxt84X0snxc4UxjwU25B7uEoGheVb
QoeuR3HNtVFkUPupQp0YRk0Z36s9WfMNMNv83iofRVuDMD12RftXBkFNGZS5cTKI
fgOv76dzgIg2UD8V8fw1o0vX8Qg9M5kTxUWr9DxktYTY7AV/06fanhCxH01T+g9C
dE5XRPO5PMSLmxlfWzCPSAFCJCZPug1wYv3qe592EVGKvCdYouIR0RwTJgZ1W2C4
OdKg92wZBJtxho1sCAmuEsXyUDHnsaHjAFU4chQu4RNSbIXZT5KEGSrquK3gANQp
O4yCQpIBypWVUpebbJCGCS6ao3XWIx/WiqUXFO0RvByZTnHiSfSRegRvWzDnYVvO
2PNikiYSqz538oHVT9lBOq/iBV0gauyoSXB6jOQiqDrmrsqxRpUFhz7GT68ppgPe
+GEDp9SF2TXbQrogY8/Nkuw9l0bbUSMidM+fJDSKaHQTjsKy8RX/MA/vE53Y/49U
CGP+xH+e0OiFneefFLG/
=KRmf
-----END PGP SIGNATURE-----

--SJ2dn9eo9utwE8uN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
