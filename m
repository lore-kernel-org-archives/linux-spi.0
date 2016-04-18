From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dspi: config dspi master regmap with right mode depend
 on BE or LE
Date: Mon, 18 Apr 2016 11:11:17 +0100
Message-ID: <20160418101117.GP3217@sirena.org.uk>
References: <1460545402-8162-1-git-send-email-po.liu@nxp.com>
 <DB5PR0401MB19281A317BFB1D9001F97ABB916A0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="movZSYdJ761vCHaE"
Cc: Po Liu <po.liu-3arQi8VN3Tc@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DB5PR0401MB19281A317BFB1D9001F97ABB916A0-GXldUsIPo7Z/SeJcUcAJq43W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--movZSYdJ761vCHaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 17, 2016 at 02:41:40AM +0000, Scott Wood wrote:

> Looking more closely, the binding has a big-endian property.  It says
> the default if that property is absent is native endian, which is
> insane.  Fix the binding to say that little endian is the default (this
> change shouldn't break any existing trees), and make sure that's what
> the code implements.  I think you need val_format_endian_default, not
> val_format_endian.

The binding defaults to little endian and (in implmentation terms)
always has done though that used to be unintentional.  There *are* a
reasonable number of devices out there which are native endian, for
example most of the MIPS chips switch the endianness of the entire chip
rather than just the CPU, but most of the current usage has been on ARM
devices which only switch the core.

--movZSYdJ761vCHaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFLLEAAoJECTWi3JdVIfQmCsH/Rky0sbE5P5ZmAaq30LBa4/8
DgTx093CeYON+ZOomSajn8X9PB3F/rOWuHIm8JCNI8VuWOP1GBA1IN4eknuCRCwd
y6tA+1c5Fl8I3vYLpUUAEGfSo+CCsvFeMHzzlWCaCmOWpKxIkoBaPFeV70+V5mtH
U2i78vEQ2GRkTAcKtsfGC12fR/54IOfFkOO87rSzVZmyTXIDMkd8Y37n+aFcWgyi
8GOY/DfyTyDUuRkWbqJLx7SjXLKh/Xw85m7CnhEKefnwdSMaZVXWVVRGCcccdX8R
YjLELrTstLYQQcV0kbH0lLsBqqUBZKdRllCtZgf8d/uieVhhzm/EHSMkXY8vOF8=
=OHy8
-----END PGP SIGNATURE-----

--movZSYdJ761vCHaE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
