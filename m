From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: au1550: Convert to let spi core handle checking
 transfer speed
Date: Fri, 14 Feb 2014 20:28:57 +0000
Message-ID: <20140214202857.GN4451@sirena.org.uk>
References: <1392122947.1351.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y4VYWfdFdHwFhC6D"
Cc: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392122947.1351.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y4VYWfdFdHwFhC6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2014 at 08:49:07PM +0800, Axel Lin wrote:
> By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
> checking transfer speed. So we can remove the same checking in this driver.

Applied, thanks.

--Y4VYWfdFdHwFhC6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/nyGAAoJELSic+t+oim9B08P/10lq9p6sMS7jj4DNU7pxLNm
DhjpYcCJOvmiztTzi27QY84Q48GjaHtWwamSl2iZyADhHAR1aKsxq3M91Y0fHCcI
cyan+QJFiw0Fz+g8YTuNAC4bzZE9YiYJqXXKB1W1+wofrbC18QaPtyRFJlcGaZOF
WQ8XMtt5TL2Z3xSpYlQCOG7wJXXleqHmv0SZKLG232x7NW3FvZJSUOxJaZQjkhJO
cWMfqOGG+7H9rsDQMY7MmFSoEG4Z4zFKRgyEzfG27FqN0+rRNY8TSIv9ZES/s7gs
q0uLYcHkSm9jSPxAOMkpjJbdY5HPZvNBRPSTLWXrB5atq7T/OdzaU+OEntxlXyDK
safTCbScny607b9SRsuM8VKpWyGA8WzQ5T2GkzwxI2GXUmMSuwMpeluTIg7d3KfQ
HI6IAxp1NaDHzCr35CUx+oCR62EerAgkM6zVHhBEXtaZBsjEF6frlIiDvC+06v4Z
BYtWP/JflX1nr3jLTJX/oU6/yOzK0xeIUwOmSjX3WuGjfq+ae46A3daH0wps2cYV
Xm4g9MKAZx7yNj0u1gDBxAe9fcWfe0f+V3jfFpEq5UWhcN0aRXJV8GCoANY+iuZ1
VSOhxEB+n21W7Lzz29H9aa0gaAQsxLNKZSnK3cwttdO4egBlHNkmNS7EKXjE/1oT
gqgtpjhqtmjfoObM1CMP
=fQry
-----END PGP SIGNATURE-----

--Y4VYWfdFdHwFhC6D--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
