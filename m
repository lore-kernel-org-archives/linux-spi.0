From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sun6i: Set bits_per_word_mask to only support 8
 bits word length
Date: Mon, 3 Mar 2014 14:56:28 +0100
Message-ID: <20140303135628.GA607@lukather>
References: <1393770310.4044.0.camel@phoenix>
 <1393770358.4044.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lymARMIdFDV9dylT"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393770358.4044.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lymARMIdFDV9dylT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 10:25:58PM +0800, Axel Lin wrote:
> This controller only supports 8 bits word length.
> Set bits_per_word_mask so spi core will reject transfers that attempt to =
use
> an unsupported bits_per_word value.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lymARMIdFDV9dylT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTFIoMAAoJEBx+YmzsjxAgbnsP/0k+q40AafoI78NFpD5oGmeU
gnoSjFi6OKxvv3LMm1x55Z+KA6cFZx8Y7DFIeawCAKleDjR28nZIwSyxegBs0l5a
m+w8dXrhZBzdw9ukrSTK8SN3t6hbBwfu1G4h6hodqo1lFvNDOiPVtnDQ876PxwDv
hhUoucjzC8RGP8nn2Q8v+1uXfXMMgukwZaUGEuZtS+nxVo/vMeYFMZtzX756CNdD
WPrSNIyuoaA9sPQ1XZ4ZDdHsQ4Vbr6AUd3xRnU5P32fimmnXJ/1gTykeqvgQ49nO
c6WYnA3dUcGwErr1+oCZqjX+jbvdYCfn8/TFJ97LCFBfGmJ3oD/jJ5pHL/9hRAU3
Dypp2Xps3r6hFuGzn5K/Vl/gUbi+MPUTEuKU1hmc+ZtrDUvlYWOHxDvWiYjMgS1Y
oTOribEQnK3yNufjRM4kQRgao/wEn6Pw7Xa0PbhDbTu80QgkKzf73+xNgfpUKnJZ
K+kuZp6EnHCA86uL8QWIr3OJn51ugDmuC6mSgz6hpsy0DSmS2n1+6Oz0equAWmot
I0RjMRCa1lZMApyGDu3LxJSmCl0rcAbWwKg6LbvHDZSFTnVFOMr/bfNGAsVr+XAo
5diMetL05pinKbAoju6wOKhqQ/6rvlftQuBd1FIUSCSW00+z/XnjHghj1/xVGWH2
jAUQvVskwwGZHbnRgXMt
=gzCg
-----END PGP SIGNATURE-----

--lymARMIdFDV9dylT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
