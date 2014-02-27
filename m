From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-hspi: Remove hspi_cleanup function
Date: Thu, 27 Feb 2014 20:09:01 +0900
Message-ID: <20140227110901.GX9383@sirena.org.uk>
References: <1393468050.25819.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qZTZQd/MRfnLEAAX"
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393468050.25819.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qZTZQd/MRfnLEAAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:27:30AM +0800, Axel Lin wrote:
> hspi_cleanup() is doing nothing except print a non-useful debug message,
> so remove it.  Also remove unused hspi2info macro.

Applied, thanks.

--qZTZQd/MRfnLEAAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDxzKAAoJELSic+t+oim9e7sP+wRH8lTgipIJwuvjEDJOWMSe
mxWsK2PNBYbeJNHjwuQtVnVwcTp+y7E26sQg9ecElOmt1eSjbBpjVYRoJxVjw9Tx
Wvy9aoVowE7OzxQHfsTwpR1UvXuz+4rHlqX9eRpuCFJCfMQpq0mC0hLa+fey3OaV
pgW94o4csOF0Z9QSwEVSRUfFwzCBonUnZqs7tAMaEAq5VVBYYvwtprVhtAA0vTSZ
BmC8CJpHiU7Wnu5ZSRY66oeE+V9dTitrUXKDdV+LQHIMijtaHCqEBa3Xr6Y0IIFW
z+S0Kzmoquyh5wjXNyFxgUNZAEIVlGE7QijcCcfY1hUa/gUbAKLFvUHFMzUwLssm
H7r3ssAwdAPhLyUVRo5yizFIZRS/7CfOTKvVQljSxGNi2YeHQ30Ocbl4SQFv5VM7
ih81qNIYq23DylP86RzuVxhvHBbl+6eSx6T5UQ+W+dCfrBUmaBTy0ZWH0SleRc23
Mgj7jfo8objDmHHpvgYL0ZC3u/IUCmiJpQF66G3UBPKOp9znFLcFLr2P/MIdMPUU
fuCh47cqhD6tW8HlVB57LINAWAqRvcyctv+vOBUvW3aOUXJRKsQyyGT/WL05kh8z
AJvBMiFMMw3oFgxbnwX2CeGPcLD3RcpBdTFceo4HSfEZi+lsZUhvjT+vAt702kw/
PtpMn0Dg9Ud19GDJNbeB
=RZDd
-----END PGP SIGNATURE-----

--qZTZQd/MRfnLEAAX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
