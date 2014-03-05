From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: add missing spi_master_{resume,suspend}
 calls to PM callbacks
Date: Wed, 5 Mar 2014 12:00:45 +0800
Message-ID: <20140305040045.GC13126@sirena.org.uk>
References: <1393990141-3157-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k/A+UfywgnnvevLW"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393990141-3157-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k/A+UfywgnnvevLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 11:29:01AM +0800, Wenyou Yang wrote:
> The PM callbacks implemented by the spi-atmel driver don't call
> spi_master_{resume,suspend}, fix that.

Applied, thanks.

--k/A+UfywgnnvevLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFqFqAAoJELSic+t+oim9s9kP/io0JQ7rTaDLy979yeHLK+56
jNQ6ObYhIGVqTl/8XTIUAdNGkfAnyD8UIlEm0yOa8tgJSaazIsROdlx6iRdx+fd8
+989/HhgKfXDZROGBR8f6Vs67OgkU0iS+tAe7sNR0pmAnZj5A+Y33D120VM1l7rN
gXFcqoPRIaRbE8k3NrAaF02XSW7KiB1QeLJvn+scZg5yuASJoWkCHNQgMTWbvsAV
5LRnFU0muUbveZfH9a7nqsUQAbA8PJQRxlaH1186VcMidFLa/Tgro1I+oR/GM3pZ
vsnQJZFkIhhBfCey00IvAODnGhwmWPef+vGurePvtmYNhL6okBSXTmlqZTBZqJq0
810BbpCS89sPhI/YG5AwEvlOido1SaUdQYZh4s34wEW7emBW2guMNlxDLtZMuMki
bNqtx9gQjtEQ9FBsJOA6t6bRmjb9vUAmEqqd0ax/ID+/mv/IxE0/L0DQIdgRueIJ
UZQVWcDPkyF/fZl540XRl1z14FNA2aLzt0psq+cpxnk24yJrnhq0Z8KZJwkVg7KJ
uFBL/LFXIKJBdybncJPUVK2kC6rzLh5bDGczUtmOnbd0VBowVYrCbVjZYki62Blj
DMudbdHrM5tl855eFqF1GHKy5NpVypWlb9FXxNOMlAkc2GHiYJISQ6DMEfkFX8pw
QNCF7mO+rNogDVRuYHDb
=VvZg
-----END PGP SIGNATURE-----

--k/A+UfywgnnvevLW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
