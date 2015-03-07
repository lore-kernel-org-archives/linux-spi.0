From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Sat, 7 Mar 2015 10:59:48 +0000
Message-ID: <20150307105948.GD28806@sirena.org.uk>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425655578-22400-2-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 05:26:18PM +0200, Ivan T. Ivanov wrote:

> Ensure that driver is owner of the GPIO's used for CS signals.

> +	for (cs = 0; cs < master->num_chipselect; cs++) {
> +		cs_gpio = of_get_named_gpio(dev->of_node, "cs-gpios", cs);
> +

Any new GPIO users should really be using the gpiod API, however this is
duplicating core functionality so as Stephen says why are we doing this?

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tojAAoJECTWi3JdVIfQhM0H/Ak3gnPPmFvukqMp5ECUWqzD
RngORM9ZUb44nJtPmO53dM8l/O9Hh1oAo9srJD5IZ1CNNxFDwqlbGtFZOCbBo4i7
af+iEYZWSb32bPzCinZFI68wZOU6Cjbk0CHHIVMNmwON253LfTSUIFU4Mwl+JQ8b
nZiI+7RNnHlWXdhzy8Lbrs/aQKAMx9DxBX1rmMvc7E0QUWHoPCzEDLmLnpOf6/B3
7UaKX63Sz87sXIAr51+GhsBmUrIBukGtlogLJRMHA9432Be4tQoKUg3a5+a3Tk0B
dtM3cu6SglEgg5ykKO4MoYB5FIB2sA7kp7dD8TTVKWdAeldZCIias1+mwn+QXo4=
=vBKV
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
