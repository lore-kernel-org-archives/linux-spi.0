From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
Date: Mon, 9 Jan 2017 19:33:50 +0000
Message-ID: <20170109193350.aufenjuhtge5e3lu@sirena.org.uk>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
 <1483522697-6691-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cobhi6l4omk4t4g2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483522697-6691-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cobhi6l4omk4t4g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 05:38:17PM +0800, Gao Pan wrote:
> When system enters VLLS mode, module power is turned off. As a result,
> all registers are reset to HW default value. After exiting VLLS mode,
> registers are still in default mode. As a result, the pinctrl settings
> are incorrect, which will affect the module function.
>=20
> The patch recovers the pinctrl setting when exit VLLS mode.

Why is this a change here and not in the pinctrl driver?  It sounds like
it's the pinctrl driver that's forgetting the settings and should be
restoring them on resume but perhaps I'm missing something here.

--cobhi6l4omk4t4g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz5Z4ACgkQJNaLcl1U
h9Cwwwf/YvtN+Xg1l/TDCdxFAm0QP7HG+XbebO5ahCgVhttgLmvEX7//QbG9QntR
HMGn3tAnPdVMdfXFvu06mtO6F/Oss8APOMa5ibvx7IVHlJizzN3dwgr4DiMFY/jQ
NHZx8jvO/zJQ5kJlw06AVb1ZydSneoxtkeGMPckjIe/rBcT7SzvVpGmq6HO9TX1z
hfYF+eOi89k+NIdBKi1jp9AcYuBhQK9cDYBeQ885qcapIVQyBXR1LA2L6aYna7IT
1FpHDJppTBkyjCIm0xXuyi4FrSsO7WjMMlSY0G7TEsEOzQnGocl4fjac02KT/zWA
NXauy2ZCz/P2Za62RzVBTeCxM/Dyjg==
=7rIG
-----END PGP SIGNATURE-----

--cobhi6l4omk4t4g2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
