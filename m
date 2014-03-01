From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: txx9: Let spi core handle validating transfer
 length
Date: Sat, 1 Mar 2014 13:51:30 +0900
Message-ID: <20140301045130.GT29849@sirena.org.uk>
References: <1393327017.6723.1.camel@phoenix>
 <1393327183.6723.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y80AKZIs+e/pKYlV"
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393327183.6723.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y80AKZIs+e/pKYlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 07:19:43PM +0800, Axel Lin wrote:
> spi core will handle validating transfer length since commit 4d94bd21b333
> "spi: core: Validate length of the transfers in message".
> So remove the same checking in this driver.

Applied, thanks.

--y80AKZIs+e/pKYlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEWdPAAoJELSic+t+oim904YP/AjN3eSC979iGa6r7MATdtxu
yGrWxApMJmQ+Ijocxgw/Y0LVMLnpDnHh/BVAAnuKdECGZ0rGId0rgAJvG+vcG7U/
o8W6NxBCCBG8t4oIKXgSsxtfd9+tvCrR2ZYGcpvNVWPXNCBv5frKpYftsBMKG4zw
SOl1rlNOTSVbASUfHkHdqv34o5aYMcyWArfftwyqrUD6IXoVq0T3njQ3wcSyjYI+
sH/Zm1oWNUAnXMCKjFu4MfLNYOmKGRZsJWxcYvDvdlGguLFJkBqNpuyLofAg9ffx
+j4Q4oo6Q58aaRwvUZViNRSjG3WftETTckuCXQNjN7c4t9WDrt0sunH1/W7cjmE8
yjyv6z5qCutGuYjeesCVsXRlb8VKHw9C7iTCArto2XkmjuQCNe40Xg94tXm3A4v1
pseLm79L6iVWXQov+6TD2H67vH1YzKdZ1u2LIGx6D/aSTzpYT0cnN8A60sBB9Ivs
j+qd66URwW5sc1AA7tOBmIdJnO9jvOonKZeKRhdS9rqPoM9LhwPks+tnyyvTbZoa
2Riko8Ro1WHAQMIJOPuSRUBgH6vjjihK+GqmZgprzdJbonvNpswA4gMtJcYi29lc
Qk+EncKEMolJ+Ab+3IX0dQ1zyXIjqw5ruakaA5bA1eszUP64nuB51EOau1VTpRpV
IYyAksD3RUaSc4eKDgT/
=nU/w
-----END PGP SIGNATURE-----

--y80AKZIs+e/pKYlV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
