From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Subject: [PATCH v5] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
Date: Thu, 26 Apr 2018 09:28:02 +0200
Message-ID: <20180426072801.GB4117@er01809n.ebgroup.elektrobit.com>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
 <20180424173253.GF22073@sirena.org.uk>
 <20180425134728.GA20897@er01809n.ebgroup.elektrobit.com>
 <20180425155028.GF24769@sirena.org.uk>
 <20180425164904.GA30349@er01809n.ebgroup.elektrobit.com>
 <20180425172816.GI24769@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        <ldv-project@linuxtesting.org>, <sil2review@lists.osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425172816.GI24769@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable the clock prior to calling clk_get_rate(), because clk_get_rate()
should only be called if the clock is enabled.

Additionally, prepare/enable the pll_clk before calling clk_get_rate()
for the same reason.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hssp=
i.c
index cbcba614b253..c23849f7aa7b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -352,22 +352,31 @@ static int bcm63xx_hsspi_probe(struct platform_device=
 *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
=20
+	ret =3D clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
 	rate =3D clk_get_rate(clk);
 	if (!rate) {
 		struct clk *pll_clk =3D devm_clk_get(dev, "pll");
=20
-		if (IS_ERR(pll_clk))
-			return PTR_ERR(pll_clk);
+		if (IS_ERR(pll_clk)) {
+			ret =3D PTR_ERR(pll_clk);
+			goto out_disable_clk;
+		}
+
+		ret =3D clk_prepare_enable(pll_clk);
+		if (ret)
+			goto out_disable_clk;
=20
 		rate =3D clk_get_rate(pll_clk);
-		if (!rate)
-			return -EINVAL;
+		clk_disable_unprepare(pll_clk);
+		if (!rate) {
+			ret =3D -EINVAL;
+			goto out_disable_clk;
+		}
 	}
=20
-	ret =3D clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	master =3D spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!master) {
 		ret =3D -ENOMEM;
--=20
2.17.0


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEATY+KFcrMtHMM+b3X8uyjJIzOwAFAlrhf4EACgkQX8uyjJIz
OwAlzw/7BShRky1etSiW2sexxNjQ3D79Udtwed0gYUv9tl7+vddrym+sE3wGH0Le
ZBVxqRh6TnDAue9KHFKZTl5aoHQIzWCIEp37ojI3qnC/AhiU4zV3h4CYkM4h7f/3
1SOdbNxfFaUxPS7oMbeDiIy7dou3B9I8bz5f8vOpMsxa15+2WbamoS/QG63Yn9N+
5TZLquytaZkuWe33aUvwkImSGH4gIQKIr5wbhzlp0hQH5IGgOFOAm9zFV66fd+ev
OjRhEj6YalbPivTt+gvd8HEvmJ6Ll/kMVCJtqp8zR4nE1pzaIDl8/ozh/O4efOS+
y6TnlWdRp648RFvaju1Pqj8+hc7ymQNy5nwpevtSOEpnTj23ql2+izJf309s9K4H
++XP6yMw26HWEQ4QFfDZKlvmXoT2m+QIzRvAJSthbCX5tsTMP6yAoHtFo8avM0Gi
O5Rq8KLfpQmNu7hMB/a2jjMPFjIl0mrvP+8Q5rdqr+oDPbHG2FywBN6yBEZi0gYI
LwJxcQrwqHF14+HBWRIKG1tlghFH7WRd3fJ8wNeURmdFT6NKJ7RV1ig0G0s48HEi
nQJ4ncADCAHEcuRZb9iVogjrTArlpyJ5Bp8KcLI3bKid555m/dCK7JYCNR46WRsv
T0tLx5UiZWSrYEyvr6FTOYr7tOhzDyxd2/cRlgIej8+/LYaNGco=
=k+83
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
