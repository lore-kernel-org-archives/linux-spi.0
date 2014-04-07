From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: qup: Depend on ARCH_QCOM
Date: Mon, 7 Apr 2014 14:08:53 +0100
Message-ID: <20140407130853.GG14763@sirena.org.uk>
References: <1396784733.30640.25.camel@x220>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q4EqwgQSYGfzam5l"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396784733.30640.25.camel@x220>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--q4EqwgQSYGfzam5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2014 at 01:45:33PM +0200, Paul Bolle wrote:
> Commit 8fc1b0f87d9f ("ARM: qcom: Split Qualcomm support into legacy and
> multiplatform") removed Kconfig symbol ARCH_MSM_DT. But that commit
> left one (optional) dependency on ARCH_MSM_DT untouched.
>=20
> Three Kconfig symbols used to depend on ARCH_MSM_DT: ARCH_MSM8X60,
> ARCH_MSM8960, and ARCH_MSM8974. These three symbols now depend on
> ARCH_QCOM. So it appears this driver needs to depend on ARCH_QCOM too.

You probably want to CC some of the Qualcomm people (or whoever made the
above change) who know what's going on with these symbols.

--q4EqwgQSYGfzam5l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQqNiAAoJELSic+t+oim9pAkP/R+FZz7MOa/s/qcncjOXl8vQ
InmURnZlQ2dAvZzO6YROauTanH6WU9Xq+vWgPirprpgz+yqfAzLpYNMuPpbP3Wnc
nO84qc5PwPXzlO679LP/FUCsd8N/tSWTqr6ls0+7gGMyYshPhYNS9RIdhfxeqMnV
eghsWhEesyUxETDTQgDAj2E1VhkrfBLYvYIuL/fsKKwjt+WnyZKGVsNcXiDmLrGa
vj4yWP1CoFbDbuOEDrpx6j69MhuFuYzHeo0DETs/L1FmNkltpa+u5FnaZk7kb8wX
45/Bt/UX/+YI9NXRarDxBzpwozRo+hyDs6aAehl5N8Qa/7b6Tj0XuruwBYnO4Gj2
rzPTgi1Q/X5Kv/vpfqguDX+ku1pC6H9JQ07CbDwNtsRExwiv4RTGt1Z7/K9O8XqF
OGUNQJqL724mUYDqIrZnjH1RjtScRuTk6zKgaqZCzqkqaqfnPVELY+mAD6tiCb36
JxDojE8zaqZXsHhFaTbqpxpxQeTgZCtbFTuQoxH9hLhP4cxtFWzgpHusf9zDvJCB
Hdo55Da4aOh6GkTM+CfwXN202mKCBSJ+o5mGxZ5ZyBTg/f7Vv3Wk7SuQxBh1C8PC
5PnH9sk4RpEjnhtoGjswYYqsrtZOl9dByptkq1+e51h90ep5fKNmJCvteBM3H2bg
HCHKdXXjANQ7uk1fVDv7
=O1JK
-----END PGP SIGNATURE-----

--q4EqwgQSYGfzam5l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
