From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
Date: Fri, 9 Nov 2012 14:38:42 +0000
Message-ID: <20121109143841.GG23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6419780030256719707=="
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352469625-32024-5-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============6419780030256719707==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 03:00:23PM +0100, Steffen Trumtrar wrote:

> The wm8974 can be controlled via i2c or spi. The current driver only supp=
orts
> i2c. Add SPI as possible bus.
>=20
> As the driver has to distinguish the bus type, pass this info via the wm8=
974_priv.
> This reverts c2562a8e3b5f871ad0b73caf98bb7541e8724efc, because the driver=
 now
> needs it back.

Don't just quote raw commit IDs, *especially* not full ones, as they're
completely illegible to humans.  Someone reading the changelog needs to
be able to understand what this commit is and why the driver needs it
back.

> -	ret =3D snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
> +	ret =3D snd_soc_codec_set_cache_io(codec, 7, 9, wm8974->control_type);

We should be converting things to regmap if we're going to do this -
we're trying to phase out the ASoC-specific I/O and this makes the code
simpler anyway as the core will just be able to get the regmap from the
struct device without bouncing information around through the private
data and so on.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnRT6AAoJELSic+t+oim9VnwP/0Rm4as9QoXb3GOYVwLWpWQp
E46DtazWxy5GtG53aUv9ty4UXVvpTi8/meVaIiuC+6ATO3jZY7XRA5KIl0CQZ1DM
fxLukmMLFbsJolBrr0Q69ifp5/zkKt9cOx/tIHxOXUgjWel66TylOCORKUtcdNUI
VZWGnriCcEZtrSF35BACydaUpxbPCv+euCPHYEOgFJ8vWDTIW9P8xPx7+YpIsU9E
NYulXihdDNuo+E/u0j4pqx4gYkyuREeWqBsiLv3jHk6eO+cmhLGjQ0Qjj0aQdLUB
ckv8koiMAjzNCO+lMTM0PwemLjR3AON90xEZzxME+yeJVZFhpFJKQQoPjhgD3nU8
1RmWCtsNdtpApPs4nPfebigHDTrfxoz9kVBg98kE1bGb7wYco5lTaq8GPXaSjVwv
xPjaWZgJUt9ePKgoF4MgS4I1nrTkwnXRm28S/G+fp8pMgbGzUfNTURciAUtjBBv/
NZ0qwztz8SgutBEyG7sDLlL/XNzAMKI8EgnUfLynBA9Z+WKcqlqSnG4zDTv3k5Vr
9RlC5PDwBLsmoFJdBe4RNXnHDN0X+dRU+rR31s+uBePR81XDwBwo67Trs8OwR2Pi
aHlRwDBMbTfb3+YHjN2h/Ss3nIxvNdp7kosCr00epoDYnfVZPxmgBnNsTw5BHZPF
Jt/EwFyqqrPL9/YK9YL7
=ZHCS
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--

--===============6419780030256719707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6419780030256719707==--
