Received: from 2.mo576.mail-out.ovh.net (2.mo576.mail-out.ovh.net [178.33.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D93BD22E
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374107; cv=none; b=oLSszRfm6f/+ffT6KDYOX/DN4+k2lHG3Gm3rA2azp/oCRafdBQH5bRHcMzozVbT3+DtMRUxTN0RHDIK6hhDhZ3uwRUDupTMykBz7NfQg4YocJNZgO11rndE+evbDiwLik3RRC4KsCPEqg2sfNYKDAMuP90JHbyf5MwrE1eFJaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374107; c=relaxed/simple;
	bh=h8JMm3lG2PkZasKfNow2aML+HILdmmApWdsNUKU/K0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkHhzUcoeqG+WQl+zQaAwZbBKC/5UtMCzeCT6D9JjJfOcWHpXViozqFf1dhRHhhv6ja0jHVbFGVfWBssSPUx+j0VwOXlk8ewCyBgo2rU2Q/HuYgHO7k2/U4o2kfeN1wfKu/haeeHST834kk633lKYrNO3l24SuNFeu7qjUVB9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=178.33.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.254.116])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4hJcJZ5R11z5vLm
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:17:02 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-5z4sg (unknown [10.110.168.82])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 44E7F80F5E;
	Mon, 10 Aug 2026 14:17:00 +0000 (UTC)
Received: from m-works.net ([37.59.142.108])
	by ghost-submission-7d8d68f679-5z4sg with ESMTPSA
	id 4EegBlzdeWqH/wUAQ8H/aw
	(envelope-from <maciej.andrzejewski@m-works.net>); Mon, 10 Aug 2026 14:17:00 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S002f1246bdd-25f1-4367-ad77-4adbbe4a8bb8,
                    ED6AA3D647CD945153C5C800EF75597CE9F2D384) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:144.125.48.245
Date: Mon, 10 Aug 2026 16:16:59 +0200
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
Subject: [PATCH 2/2] gpiolib: of: Identify SPI controllers by nodename
Message-ID: <20260810141629.81650-3-maciej.andrzejewski@m-works.net>
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
x-ovh-tracer-id: 15951186934430573347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEFIaKoSFRHDjlvEiufjoWcD4cmBUs4G1gkwG+emCAn12twDtQ828LrUUBIp6+oc63Pl1IZhTbYYnD9+OcBLoKPOl05sT6lJvvFsfhsoFtEoWhmZjwf0mt1qHt+i7I0F3iSUlydsnJ+BBo+IBleI0Ojd0VNHdKBk6xRoSCjFwoNNNQLnaZ9w1zKAwYl2KhtJHHKmgtMroyXBzf6h8SKyW/0ADno3WUXP2hhaHAogAUdhe+9CBROLDVJASqsWAaN5y2QiG3UsVHAXkCpGwHOHWCu7oQkAHTR9AD4a6kc3GT/DH8buSkzgyHjzYk8tW+uQSdd7AG6INqyqJsgUmqO12ybjo7BBKPfNNu9A38vALzcVXDw/JrFuUV4H84Mwh0S6qdUEYANCiS+9d8y64cgJ1ATHGVzetAMBN0SRHP4ut9MpbX2gZatoahtETPeJU9EIbudlDxq/GHBjdwrdhv7XyBj3tHXEWs+ydZJpsV0CZek3JTouQeRG8hc9/U5WRe+fdReLGU+vd8e0mc8waJt7QMIMq5bxNzgI/sh04EvaOerQsl43w2L0qGT6AR8q7ycZZG2OiA6J5sLZNsyyFMhlBp1m7tDeQeCSGRN6oAG1QOlUzWMaai7stmqzBbrrr7qHaOMVLGTHZi8oPx0FyHIG7ry8bg02jji4kr2SGmZitfNLw

The "spi-" property scan added by the previous patch misses SPI
peripherals that declare nothing beyond compatible and reg, which are
the only two properties spi-controller.yaml makes mandatory for a child
node. Let the controller settle those cases: spi-controller.yaml
constrains the controller nodename to ^spi(@.*|-[0-9]+)?$, so the name
is the one bus marker every conforming SPI controller has to carry, and
of_node_name_prefix() is the existing helper for testing it.

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

of_gpio_spi_cs_get_count() in this file identifies SPI controllers with
of_device_is_compatible() instead, but it only has to name three legacy
controllers whose bindings are closed. An allow-list here would have to
name every SPI controller binding in the tree, 71 distinct compatible
strings among the candidates alone, and grow with every new one.

Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---
 drivers/gpio/gpiolib-of.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index bd9a623f2ae1..959b32b3bea0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -359,6 +359,17 @@ static bool of_gpio_child_is_spi_peripheral(const struct device_node *child)
 	return false;
 }
 
+/*
+ * A minimal SPI peripheral may carry no "spi-" property at all, so also let
+ * the controller identify the bus. spi-controller.yaml constrains the
+ * controller nodename to ^spi(@.*|-[0-9]+)?$, which makes the name the one
+ * bus marker a controller is required to have.
+ */
+static bool of_gpio_node_is_spi_controller(const struct device_node *np)
+{
+	return of_node_name_prefix(np, "spi");
+}
+
 static void of_gpio_flags_quirks(const struct device_node *np,
 				 const char *propname,
 				 enum of_gpio_flags *flags,
@@ -395,7 +406,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 			if (cs == index) {
 				bool active_high;
 
-				if (!of_gpio_child_is_spi_peripheral(child))
+				if (!of_gpio_child_is_spi_peripheral(child) &&
+				    !of_gpio_node_is_spi_controller(np))
 					break;
 
 				/*
-- 
2.50.1

