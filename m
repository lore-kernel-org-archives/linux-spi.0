From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: core: Validate length of the transfers in message
Date: Fri, 28 Feb 2014 15:19:20 +0900
Message-ID: <20140228061920.GG29849@sirena.org.uk>
References: <1392890528-7417-1-git-send-email-iivanov@mm-sol.com>
 <20140225.225528.453119424.anemo@mba.ocn.ne.jp>
 <20140226001407.GM2927@sirena.org.uk>
 <20140227.223826.522636360.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Cc: iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140227.223826.522636360.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:38:26PM +0900, Atsushi Nemoto wrote:

> I don't object to the whole patch.  Validating in spi core is good of
> course, and "xfer->len % w_size" part looks no problem.

> I just want to keep ways to handle an odd device, for example, which
> requires long delay between chipselect and the first transfer, etc.

Can you submit a patch adding that support back please?

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTECplAAoJELSic+t+oim9rkAP/j9SC0inyk1XgVXIOeURtMnc
kOZJBOfxDozRF0g+MGWBNaKXQoedBAl/Z1ZTSynpcjiJVEwM+8xMRqcli0Tot7Nt
fmAmjUQuJ2htxf6l/6gDgj/zUaD9aVaTW8vvaz6DCB9qUWUrrRHZ/UgDhFqheYII
i5RV8Pdy9qU3Ozn5Abkjznf2CmhKBF6j40aXvoE4fT39wExMhRUBv3fjRmgJgww8
4PQVKc5s4lJcXy7ioswhX0BjKOIb8FBBV6tsIJUbi3niYKsQTcvfUsmQ4J4BNpx/
YQ/fof7zC3OEQWZ/NuOWC6v5NxOq/jcRnFaN2N88SYRmRMVV2VFIVgt30LVMl/Sk
JLuCCugUIaAjlA0UK/1k8tKBydBJeS2vtfTVsUoPbaUwVz4YhZEMD62EbmcvAjJf
eXr0g5hN1/e5fd6gTL9D+506uT7Epy3ERBRpJWx5aTNXwqwLiN0Kq5YPuYeOxLH4
N8s0ndV8lOaHqBTI/NZYodJhbS3P93YPBqW5fonLfpCb3Qd8xQiCjxaLnTMccaf0
HH6ulEJg154jh4d3BEXgD1orEgsh8oYdhLjMGpA1ucnO0l3hy4y72W767uZwABC0
ahFfrTZ3CBERDMpHrnMK1Rfvh0dMjJnvBeiDlglI3QLzAhpJ81Sojv+CggDGhHR7
/rfzq+ZxcwkUUWbnk5bv
=n9Rr
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
