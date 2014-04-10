From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] SPI: Add driver for Cadence SPI controller
Date: Thu, 10 Apr 2014 13:21:46 +0100
Message-ID: <20140410122146.GY6518@sirena.org.uk>
References: <1397132030-2440-1-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7tPHY7RFL01rOa8z"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397132030-2440-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7tPHY7RFL01rOa8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2014 at 05:43:49PM +0530, Harini Katakam wrote:

> Firstly, the timeout value obtained from this is a too low.
> This timeout is typically used for an error conditions such as
> hardware hang etc. and using a value >1*HZ would be better.
> This driver used to use similar timeout and as I understand, other
> drivers also use similar values.

Send patches...

--7tPHY7RFL01rOa8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRozXAAoJELSic+t+oim9yQUP/RheMmc5lFwvXa2yuTAe3Lkv
dgC8+WEke3iYWHQNJHJIYewKdZtVzucbMDX4JhnQfkdtkA7w34RHxU79YBADfYD3
Q9Aig63VvE+1VvM+bh3qNPnERNlilH1TBRCGO9P2FOqEGLCt0yy6btka0HcsUnny
xD8QFLEQHxxrJLi6WtwkfAEHOxCBqaey+IwDMfU/Mbr7ZpdL8yP/RIcXgKNlXj9V
8m+L3TEhjyeaEWdjwvIIrHuhQUwOIABMCnWJsBMdX/6kjWOe6oIZK+Y7JJ5GAHZd
mHwDCUv5cyo10OmJQvgVM4k61oHDZ0ZPrOPxy+U6MQcUNsrcvMBTRLVyQeDp4p36
pAquchakenME1mcdjjKM4eXer5RYQs2gdny6VPG4lAG2ySGt2bb5gJMGlgPqDS3d
iN80Kdbu+eWqRtN+uOaVbUEOlaK/qd+WvK0TxfsqeE+eJukBDv4e3viqY/YRI/Se
DCIXYgfCbApjDbIMU2ylHXFvsGXD88dSN62dX5OiukqnE2Wfia+rrOkUU4XOwd2r
+NABGhbjsm1QOgbptKXzTYRgenO68qaQ6DWrwBZ9YZGn2sI0mHQk25IaaY6SKoa9
wFMguYks2jLTwX0IPOAQ3E/L2ou4jd0I7u+kmR+R4wCIPSTofHBThp65ir+NgVfe
rPeQWyiAUoAgu2azgYzD
=EaHN
-----END PGP SIGNATURE-----

--7tPHY7RFL01rOa8z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
