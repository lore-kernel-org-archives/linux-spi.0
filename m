Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net [188.165.48.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302B3FADF7
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.48.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372416; cv=none; b=Ot+BoUKdkTSkEKKSBRhWtpLa5aDC08jNLQ2NIoilmJNTDuIVB30PZSApEzegChcWNkWxBxQrfc+9W/k4AED+tRGMD1n1vysjNmZO3JnWMdNxD0U4PpQyomrXPXwQWy7SXrfNYeVRum27BeBwVFTt93UDLphjUuKI1dBubDlI9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372416; c=relaxed/simple;
	bh=e4kQFCjB5LtFdJIis48BWU7f1G9ZFWIOb2b/rcrqG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdQRj6lPkTuehtVRGjjzSgNNVzjIewZsDxFYSU2uQbZhgNrATnWTauUhbci7wKneNWHVOwqaSFzGEAAn6mCmrfw+ssJ8cO2G6IFx2Hg3A14DimtOmH0c/kh/Nt9dt0SXnJ5zyJiRqxm6YQBMkqQaL5h9bf/vSDRwG9DchT5J73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=188.165.48.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.231.136])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4hJcJT39DWzB8tt
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:16:57 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-7df7p (unknown [10.108.54.148])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5AC5EC0198;
	Mon, 10 Aug 2026 14:16:53 +0000 (UTC)
Received: from m-works.net ([37.59.142.101])
	by ghost-submission-7d8d68f679-7df7p with ESMTPSA
	id I14hO1TdeWq3KC0Alk6qAw
	(envelope-from <maciej.andrzejewski@m-works.net>); Mon, 10 Aug 2026 14:16:53 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004796ca3e8-0880-49c0-a3d2-70d64670ab19,
                    ED6AA3D647CD945153C5C800EF75597CE9F2D384) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:144.125.48.245
Date: Mon, 10 Aug 2026 16:16:52 +0200
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
Subject: [PATCH 1/2] gpiolib: of: Only apply the SPI CS quirk to SPI
 peripherals
Message-ID: <20260810141629.81650-2-maciej.andrzejewski@m-works.net>
References: <20260810141629.81650-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810141629.81650-1-maciej.andrzejewski@m-works.net>
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 15949779557479752483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFkKUw8dTwvfjd4/KP70uzwoCMB5S1Nh1xoCtlKl9zTFZzwWOg+RBpw5P0civI9C611B1wrLGnfL3FNYmECOnjsVZKgynKuLG6Jhd3Uc8cbYV256q4EDW1EJopIsVe6nfKjRwsKIAKDeHxGys67ywGuGjynKrr0p4f+W1tRSR6L8yRsQUchqkYbufFkmr7AL7eeCcTKmnSxggk9Am6xY3yqfHbxzDDXnNa07eo3ri956RbXgeCfNKnKA1gany5tMxKjWt3sHbxNpzbfY66hukbKbQQTBIAx2rECu5ovgOzajdg1Fxma7zv7UmoNQovbLAGQzJu4D89RflMM5EwN9mbnpJbLLOOv0Z2Ntl6f8wUv+8az/XPWQ60dfmggv29njjO6y9FkfPCBkDfQV/6ypK+o9Hz8L80LeEuIphGIn5HwwcG1mhtvh6ZO5aUKQBwp4lCyTAQsu24JSuddnMOMQMFj8mfBA+1oOLoJggXv4d9mf+D98u4NLOSvhfJujXm1inHi4D7ko98vERL9vdySnnv5zrfxFLNa/rEdRCp62qo5RbwvBV3tdLPmdjW/jLky1eXJ/3hA8j07pTHNOAVSchUXi0b/VPctrJYNky5V2otg3/11TM+gxltDE4TCF9ubVFvyVTti99u8AA2cHOCWOM3AeVQMveZokrp56ARGln73LA

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

Device tree carries no bus type marker, so identify the bus from what
the peripheral advertises about itself. Properties of an SPI peripheral
are namespaced with "spi-" (spi-max-frequency, spi-cpol, spi-cs-high and
the rest of spi-peripheral-props.yaml), whereas a NAND chip node carries
only reg, nand-* and its partition table. Skip the quirk when the
matched child has no "spi-" prefixed property.

This is a convention rather than a guarantee: compatible and reg are the
only properties spi-controller.yaml makes mandatory for a peripheral, so
a minimal one may carry no "spi-" property at all. The next patch covers
those by looking at the controller instead.

Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---
 drivers/gpio/gpiolib-of.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 940b566946ce..bd9a623f2ae1 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -340,6 +340,25 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 	}
 }
 
+/*
+ * The legacy SPI chip select binding below is keyed on a property name that
+ * other subsystems reuse for the same purpose, notably NAND controllers (see
+ * Documentation/devicetree/bindings/mtd/nand-controller.yaml), whose chip
+ * selects carry no SPI polarity semantics. Device tree has no bus type
+ * marker, so go by what the peripheral advertises about itself: properties
+ * of an SPI peripheral are namespaced with "spi-".
+ */
+static bool of_gpio_child_is_spi_peripheral(const struct device_node *child)
+{
+	struct property *pp;
+
+	for_each_property_of_node(child, pp)
+		if (str_has_prefix(pp->name, "spi-"))
+			return true;
+
+	return false;
+}
+
 static void of_gpio_flags_quirks(const struct device_node *np,
 				 const char *propname,
 				 enum of_gpio_flags *flags,
@@ -374,6 +393,11 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 			if (ret)
 				continue;
 			if (cs == index) {
+				bool active_high;
+
+				if (!of_gpio_child_is_spi_peripheral(child))
+					break;
+
 				/*
 				 * SPI children have active low chip selects
 				 * by default. This can be specified negatively
@@ -386,8 +410,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
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
-- 
2.50.1

