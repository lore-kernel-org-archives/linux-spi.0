From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: core: Validate lenght of the transfers in message
Date: Wed, 19 Feb 2014 10:51:48 +0900
Message-ID: <20140219015148.GL2669@sirena.org.uk>
References: <1392444566-23605-1-git-send-email-iivanov@mm-sol.com>
 <20140216142512.GR4524@book.gsilab.sittig.org>
 <20140218000938.GE2669@sirena.org.uk>
 <20140218193747.GE4524@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQv0vi9oZBoYbpa7"
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218193747.GE4524-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LQv0vi9oZBoYbpa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 08:37:47PM +0100, Gerhard Sittig wrote:
> On Tue, Feb 18, 2014 at 09:09 +0900, Mark Brown wrote:

> > It seems fairly clear to me - if we're transferring 16 bit words we need
> > the transfer to me a multiple of 16 bits and so on?  The requirement for
> > padding is unclear I have to say.

> I meant "padding" in the sense that e.g. 12bit bits-per-word
> require data to be provided or consumed in 16bit quantities (2
> full bytes), 20bit bits-per-word require 4 bytes per SPI word.
> Why not 3 bytes?  I'd guess this is due to FIFO port width.

I do tend to agree that things need to be rounded up just to the nearest
byte, I'm not sure what the standard thing for hardware to require in
terms of port sizing is here - it's going to need an audit of the users
to see if we need to worry and what they do if it is an issue I think.

> At least this is how I read the check which this patch
> implements.

I don't recall the actual code now, sorry - I was mostly just following
up on the review comment here.

--LQv0vi9oZBoYbpa7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBA4xAAoJELSic+t+oim92/IP/i/7MaWvwKDxbzWtCBV4ne/Z
rK6ckJsia2ALi+AYr8iOyHXZSMZs4PbfA5JJW8j+35lyIneiPOmPJWtNzpWSya/0
p6eUzwDzo1AmBDTuE8Ee+qQuEWQmCZMXHCEkqtlr9wXKxt7ibMuXVk5Kb8+mOsk2
aAi55m3NpwSAyPc73zF+letZo7350le/2ZTp1crRRukCy0KX0DkS+kcEioKplfSA
I6gBkJOkh2+QQCLLvnd4O557R49cJEnOZ63u7qcwYImtRR04zohprMnD61XyhGeD
QNd5EkWN0b+oIj+llOXaTVlXfdYhwk9PMsLkkSfppSrIhYqDGCRgF+AGOS19DCpr
eQqxNlHN65VawwvL+/NfzhQcVyNO4DBTq9NterCZDueM+7sB1h70SF2wXdmBAb+U
FjhnrAVKTMABm0V7Su/mTgjkMM7oxNxUjyBt4qgPyo4sQLM4Hr6vvYzBtYHd86mv
vOMLTLrpxqsbwEs4q5NkJYSAVNTk5Xpq92U68ZfcFENkxxYbjh+liM1RdaunLD2V
pxI/UhsHpuNQAtrPRoBgqVKP4f0GRGpXenESVTI0Slj8bwrMttVlXy2kHTY8EmG6
8pmxdxACbXnX0d5WPZAd8Xx6mJrTwkCyJrs3ni6h29u8uNEftM8xK07FYnY+D6yh
y+YdaSxwJX8AdWN/HBYY
=Vfdg
-----END PGP SIGNATURE-----

--LQv0vi9oZBoYbpa7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
