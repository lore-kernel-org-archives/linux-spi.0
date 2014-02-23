From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: fsl-spi: Convert to let spi core validate
 xfer->bits_per_word
Date: Sun, 23 Feb 2014 13:14:58 +0900
Message-ID: <20140223041458.GH25940@sirena.org.uk>
References: <1392289538.20787.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y3ZGpI4yi7dqmmo+"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392289538.20787.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y3ZGpI4yi7dqmmo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2014 at 07:05:38PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--y3ZGpI4yi7dqmmo+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXW/AAoJELSic+t+oim9wusP/ilFDJSbFhoE4NvilIw0PGjJ
XpfQzg+6AeU8ao/3oZ2vx7ZhFtGITqZet2b+Q+SoxCfKSrhJOL2yH4Dqsf4Sq80f
rZRQns4omXWncsToEEaf2e6IZDbDRizUa4F/M8J9HOn2gLSbZPOg36trSqozlOrE
4uvXVRifylKH60PljH7y0tLVJ/1FsPkj7dqVg9q0LvNYFL0l+Rlg451FJUd+lCcC
4AVX3Vl97UPGgTXNyx2Nq+q71MaMgMEdLODnwHDa8oTJUWcqNkWiSDmWLApYt4V6
MKwUEwktOv5Q2RwyLV7ud+LN/UwLnoO+KNkErNl62/BcMFtF8ov6UkTMtac0Fjta
JXnDzz6QpgVcUIfCKK01W8nPrir6dXipVZThL24fcdCKhTsmT/MSEn5TaHzbH9NE
mO3aw5G5TVn1Fq9bzKcfWnLt1jRCyjGb3lcucMX0py2NAnulmYAahVtN/F9CZHRS
K+v7y1MmUKjAIlu8YSv3mXNcJkUCBIU++wyXbR5iB+Y5fcGLbazgTRkBD0yq9vSC
7bHbsluw6B3Igy0TpW+thoZVa6jeKx3+iPrUH9GCeo5nU6H9wityUGbG/0PI32II
EVlnUCsHbiA7bWhwfyhYSWBhVhluEO4Gmq6yoUYkeYDI7szBJxCs2FRl33pgcysp
Je8zY1DXAnEX7R+QnPKv
=AbB1
-----END PGP SIGNATURE-----

--y3ZGpI4yi7dqmmo+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
