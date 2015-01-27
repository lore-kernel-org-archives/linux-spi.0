From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 16/18] spi/xilinx: Reset core before buffer_size detection
Date: Tue, 27 Jan 2015 00:11:22 +0000
Message-ID: <20150127001122.GN21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-17-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CV9cI//wlcIKC9rG"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422029330-10971-17-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CV9cI//wlcIKC9rG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 05:08:48PM +0100, Ricardo Ribalda Delgado wrote:
> If the core had some data on the buffer, the size detection could show
> up a smaller size than real, affecting performance.

This should've been part of your earlier patch.

--CV9cI//wlcIKC9rG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxteqAAoJECTWi3JdVIfQOuIH/1lzrVJ4sMZytThBjyhekw4B
22kX3qGV6+xniLUqy7wJuKyUni18ZLVa47QJT9gtIqm/YuWz+3G1oOe8YdtvJ+sI
+TultdLUIll97oKrGAV/QheWajTqIRggfqric+zveg/1Bshosu0ncdxZAYHxH5gL
xZxH7qRdMCs0ufS2hooPigiDJHkAPGxJE2lOOzYw4B2vxQUN30Ja1h/AX7CwfjBW
FKXZMTnshX8KKkZDt0RE6HLfezXdQOnb3vma23R/+ry2X46K1GTSH0ImATpouJp6
24Xd57mVJOTNOy2fpJ33dWbMyO6FMkMpdEinhIafibCFP5B7Qtz6jWjDgv9bAps=
=+dwP
-----END PGP SIGNATURE-----

--CV9cI//wlcIKC9rG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
