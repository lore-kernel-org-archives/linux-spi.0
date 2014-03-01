From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: make zero length transfer valid again
Date: Sat, 1 Mar 2014 13:13:30 +0900
Message-ID: <20140301041330.GO29849@sirena.org.uk>
References: <1393596196-8652-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G50dybFf3pRZKd7"
Cc: iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393596196-8652-1-git-send-email-anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5G50dybFf3pRZKd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2014 at 11:03:16PM +0900, Atsushi Nemoto wrote:
> Zero length transfer becomes invalid since
> "spi: core: Validate length of the transfers in message" commit,
> but it should be valid to support an odd device, for example, which
> requires long delay between chipselect and the first transfer, etc.

Applied, thanks.

--5G50dybFf3pRZKd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEV5nAAoJELSic+t+oim9dhgP/2fxY+yLfTtA0VJGxzFbxKKh
ncJjiPyxTteX7uyb14uagXsorSOBHphlIZ8EeUqvOQ1xrOO+njffZLEQAmDnGFBe
JbfB7mylrHG2ZQ+VW4SydyKynG2zzbHzw33PON9SO/OAy1G10IRT6nb+gIKPwJ+J
2BkruE65aTTDIxLXzoOEUu2KcZ6fyWCfSpFb+t9QN7PtB65sVnNZ/TBdtl/fCrKD
iJFghmhbKQ5jErOBb90KfhZI+tVVNOY3ZyK487GcOnXwL+V2FFFRI4N+0JGPqjDT
3I6J58r6BttSJpT7QdGhKbDGqRQOAQpRVde158fQ0nKRMg44BBlyi8Oq56vJripC
joH/U6KoP+cIyxDSHUylLePKVpamQMvIeU8H03RQrViN0MNQbyWP4E/8fZIfCaXI
Lh9TVE3g6hhTdyHPoAU2KNIkKjybOKE2tZ1LcqXXH4reBQ2mu4pAL6YJpaQmsdxQ
n6bbvNpEg+2YizNDsCO2lX5k/JQrl4+i5occ5z8r2FRCYcXvgjDQtNJtA1cJjsq3
JDgjAYyRDrZvPXIoZZX2cwzHu07J+YGnpzrdQUnPYMqI9o38O1ClhcD89QXP6TY0
VP/nckKDigsAQlIst7IlwB9Ty+Brudn+O9KpcPDU01bStiAvkkjfMBK51HgJurHg
jVf7SfRgZ3GPU3FqoypH
=iw+c
-----END PGP SIGNATURE-----

--5G50dybFf3pRZKd7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
