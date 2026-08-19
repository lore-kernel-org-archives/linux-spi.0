Received: from 8.mo583.mail-out.ovh.net (8.mo583.mail-out.ovh.net [178.32.116.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32844499B1
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.116.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155270; cv=none; b=QR69+qTUYZBaJq5sKOzjGFrQSNReK36tSHDLR9frbQ1+rlyqsrI67eIol+fJcgfdcUv9dMUy4wiM8VpUV/YX8YqeQFaCf0uVfrXEqwNLx3LDs/9MW6+8SUTTwi305mzUgts8KKZ5HF7voyC40FU/x8HLDbErGMu4QW7WEzu9Qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155270; c=relaxed/simple;
	bh=KMLsRVK+EzvJVR5ecRQN+03tOF1++T3dvDYN/+2a29k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hd8cfe4MK6Ak9szddXEwsgXRRncgKcEKDwaWKF6WZ6V3zEq5S55tbztFiZ/nPwymXbFrzRTVSEb332LVAGFwFH/cCG05Wnmw25AXz6e88Z7aXZCrhwdVFySRv/Xllqbogw5iEnTjVOJ6GUgVdw2S6eaAdRqnzGFiveLxi54MlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=178.32.116.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director9.ghost.mail-out.ovh.net (unknown [10.110.58.221])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4hQB3j5jQjz6165
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 15:55:13 +0000 (UTC)
Received: from ghost-submission-c7b579475-qmpb8 (unknown [10.111.182.117])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 400A280F90;
	Wed, 19 Aug 2026 15:55:11 +0000 (UTC)
Received: from m-works.net ([37.59.142.98])
	by ghost-submission-c7b579475-qmpb8 with ESMTPSA
	id U4B0At/RhWpVhQgAnxWi5g
	(envelope-from <maciej.andrzejewski@m-works.net>); Wed, 19 Aug 2026 15:55:11 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002097c834e-995f-4593-9af9-82024c194b7a,
                    2A3487578DCF8463843C7ACF55D5B1810B364AD7) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:144.125.48.245
Date: Wed, 19 Aug 2026 17:55:10 +0200
From: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.andrzejewski@m-works.net
Cc: linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Subject: [PATCH v2] gpiolib: of: Only apply the SPI CS quirk to SPI buses
Message-ID: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 15123369026046468899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF9k21hmIan4VvQbLeAxtSPkFz4BFVv0/ZuuaLGCBw3aLomndbMIiPUspiFHA+W0he0Kw5rPEXi69qs54VJpmnf4gkae0hs0bfChRqU8GicP3HAw5iJ2Q7s0E0PCuyEvIouI0nyeGd8arENzQqanwf7sx9i3YN9w0WgIM3g1t4dZLZCTB7lA49WPF415zT+d1O/3YS3mZWobh1IY2Mu82oC4igEBqk+3HdnswYujpj//kocl16H9Gavk8Jjlcg5EBTGewvQPKzc4Ts1pZE1SmGMkFYEapRiLhe/r3Cq5/NmMEx1CfiEM9tev4Is2NmeSTGKfgoA0ozOGl2vVkZZWimTqvXWUWX+1mLpIBucnyfMD+8p6jU4eBHnclGFEwcPrqnCxnvsOxREgMm3jUOidGD1M6qXCboVzeCKLNyOzDk7uEGohAxfhpFmdkFC6d9uloN6LPPeTDBGnQUJbcqf9ccRWgzt0zPpih0N702HBzm14Q8sX+pbDMXCMc47gNCClGOBsMKlVblt/lN+gzoXD54mxrUJdz+89c157OufmcZazfyoW+4mj68sOC7lsOBZhQuZsLNaVUOtTh1/9NSmuQqwXeKTucGecbt5oIJg5KsjgOCdSpBGuiH5abZje4uNTIsBcmq1lA+bN7rOC58IB9j1aSFACw+VBZdnHVKsHk34rA

The legacy SPI chip-select polarity quirk in of_gpio_flags_quirks() is
keyed on nothing but the property name "cs-gpios". That name is not
exclusive to SPI: nand-controller.yaml documents the very same property
for NAND controllers, and rawnand_dt_parse_gpio_cs() requests those
lines with gpiod_count(dev, "cs"), which gpiolib expands to "cs-gpios".
A NAND controller therefore has SPI chip-select semantics forced onto
its chip selects, and any chip node whose first reg cell matches a GPIO
index is silently flipped to active low. The NAND core requests the
descriptors GPIOD_OUT_HIGH and drivers assert with a logical 0, so the
inversion leaves the die permanently deselected.

The example in nand-controller.yaml is itself affected: it pairs a
native chip select with a GPIO one and gives the second chip a reg of 1,
which trips the quirk whenever CONFIG_SPI_MASTER is enabled. In-tree the
collision is real but latent. 36 board trees, all Atmel/Microchip at91,
give their nand@3 controller a cs-gpios line, and they escape only
because the sole child of those nodes is a partitions container with no
reg for the quirk to match against.

Device tree carries no bus type marker, so identify the bus from two
hints. Properties of an SPI peripheral are namespaced with "spi-"
(spi-max-frequency, spi-cpol, spi-cs-high and the rest of
spi-peripheral-props.yaml), whereas a NAND chip node carries only reg,
nand-* and its partition table. That is a convention rather than a
guarantee, since compatible and reg are the only properties
spi-controller.yaml makes mandatory for a peripheral, so let the
controller settle the remaining cases: spi-controller.yaml constrains
the controller nodename to ^spi(@.*|-[0-9]+)?$, which makes the name the
one bus marker every conforming controller has to carry. A peripheral
that carries nothing but compatible and reg therefore keeps its active
low default through its parent. Skip the quirk only when neither test
matches.

Both tests were scored over every board device tree in the kernel,
expanded with the same cpp and scripts/dtc pipeline the build uses, at
v7.2-rc7. All 3620 trees under arch/*/boot/dts expand; 503 of them hold
at least one GPIO chip select that can reach the quirk, 765 such chip
selects in total. 761 are matched by both tests, and none are matched by
neither, so no in-tree board changes behaviour.

One needs the property scan on its own: psc@11400 on ac14xx, a
fsl,mpc5121-psc-spi named after the hardware block rather than the bus,
whose m25p128@0 child carries spi-max-frequency.

Three need the nodename on its own, all peripherals with no "spi-"
property of any kind:

  - panel@0 under the spi-gpio controller on rk3566-anbernic-rg503
  - can@0, an mcp251xfd, under ecspi3 on imx8mn-vhip4-evalboard-v1
  - spi@1 under ecspi1 on imx53-ppd

The two tests are complementary, so both are needed to keep every
in-tree board working. A tree that names its controller after the
hardware block and gives it a peripheral with no "spi-" property would
still lose the quirk. No in-tree board does, and such a controller is
already outside the nodename pattern spi-controller.yaml requires.

of_gpio_spi_cs_get_count() in this file identifies SPI controllers with
of_device_is_compatible() instead, but it only has to name three legacy
controllers whose bindings are closed. An allow-list here would have to
name every SPI controller binding in the tree, 71 distinct compatible
strings among the candidates alone, and grow with every new one.

Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---
Changes in v2:
- Squashed the two patches into one. The property scan and the nodename
  test are complementary, so patch 1 alone stopped applying the quirk to
  the three peripherals that carry no "spi-" property, which would have
  broken those boards for anyone bisecting through the series. Reported
  by an automated review of v1.
- Folded the two helpers into a single of_gpio_is_spi_chipselect().
- Said outright that a peripheral with nothing but compatible and reg
  keeps its active low default through the controller nodename.
- Rebased; drivers/gpio/gpiolib-of.c is unchanged since v7.2-rc7, so the
  diff itself is the v1 pair verbatim.

v1: https://lore.kernel.org/r/20260810141629.81650-1-maciej.andrzejewski@m-works.net

 drivers/gpio/gpiolib-of.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 940b566946ce..d73114166f6b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -340,6 +340,28 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 	}
 }
 
+/*
+ * The legacy SPI chip select binding below is keyed on a property name that
+ * other subsystems reuse for the same purpose, notably NAND controllers (see
+ * Documentation/devicetree/bindings/mtd/nand-controller.yaml), whose chip
+ * selects carry no SPI polarity semantics. Device tree has no bus type
+ * marker, so take two hints. Properties of an SPI peripheral are namespaced
+ * with "spi-", and a peripheral that declares none is covered by the
+ * controller, whose nodename spi-controller.yaml constrains to
+ * ^spi(@.*|-[0-9]+)?$.
+ */
+static bool of_gpio_is_spi_chipselect(const struct device_node *np,
+				      const struct device_node *child)
+{
+	struct property *pp;
+
+	for_each_property_of_node(child, pp)
+		if (str_has_prefix(pp->name, "spi-"))
+			return true;
+
+	return of_node_name_prefix(np, "spi");
+}
+
 static void of_gpio_flags_quirks(const struct device_node *np,
 				 const char *propname,
 				 enum of_gpio_flags *flags,
@@ -374,6 +396,11 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 			if (ret)
 				continue;
 			if (cs == index) {
+				bool active_high;
+
+				if (!of_gpio_is_spi_chipselect(np, child))
+					break;
+
 				/*
 				 * SPI children have active low chip selects
 				 * by default. This can be specified negatively
@@ -386,8 +413,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 				 * conflict and the "spi-cs-high" flag will
 				 * take precedence.
 				 */
-				bool active_high = of_property_read_bool(child,
-								"spi-cs-high");
+				active_high = of_property_read_bool(child,
+								    "spi-cs-high");
 				of_gpio_quirk_polarity(child, active_high,
 						       flags);
 				break;

base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
-- 
2.43.0

