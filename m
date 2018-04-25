From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] spi/bcm63xx-hspi: Enable the clock before calling
Date: Wed, 25 Apr 2018 16:50:28 +0100
Message-ID: <20180425155028.GF24769@sirena.org.uk>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3017803263062288662=="
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Jonas Gorski <jonas.gorski@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3017803263062288662==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 03:47:30PM +0200, Stefan Potyra wrote:

> +	ret =3D clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate =3D clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk =3D devm_clk_get(dev, "pll");
> =20
> -		if (IS_ERR(pll_clk))
> -			return PTR_ERR(pll_clk);
> +		if (IS_ERR(pll_clk)) {
> +			ret =3D PTR_ERR(pll_clk);
> +			goto out_disable_clk;
> +		}
> +
> =20
>  		rate =3D clk_get_rate(pll_clk);

Isn't this just showing the same problem with not enabling the pll_clk
before getting the rate that you're trying to fix for the main clk?

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgo8MACgkQJNaLcl1U
h9C3mAf9E2wT1z6BVSR3pGjn8VkIqjK8tF4v/fW0OUJoRejY519N0LtV6wkA2ikU
H5eCOr7VNNu345uaFdzIXqKWR4jEyPCWkzHj7baall1kwb9wSA1tfMoFG36FW38G
Kbg2hDQXS/vuIvfBcaNh8XtAftIuKxyWv0W0HnvoKfAJyntdkgCyamRzMgraTNrQ
oHziqpj2Nzkm8wwtk7HnjyvvnfW8ErCT92pTjcoki5MWeVExDYpgqHseEyXYm+QR
Oeg8Gch4CHPQfJcvL3njThXkqFIGHqZl4xddXSi/kM/1xOtTY0ibY48GkmSUjjNX
+4hRjKR2e+ZLj3Jmnbg5tOCwi0IcBw==
=PbX0
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--


--===============3017803263062288662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3017803263062288662==--
