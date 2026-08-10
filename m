Received: from 5.mo575.mail-out.ovh.net (5.mo575.mail-out.ovh.net [46.105.62.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7D400991
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.62.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371711; cv=none; b=mQZchAZ0QGd9okE55RSfySGlX6HxyUxz28EtdoXEau0BjfdfPk85YrQ8yYsL3+I5Mwr1uVGCpN+/iAGmKLK4ZM0BN5+YYdfEn/ul8d8A6AKVJsiJ2MFtXvfZ39/YfU+siahOgH+saJbI8BIQVUbOME8Z1Wpxvghv96+5Sdr63AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371711; c=relaxed/simple;
	bh=khtKjUjkFdnLjRe7hqxidH1JU3UV/vwbLf2gEb0XDxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qy3MMLaiyQQ0FmkxY7SJeX6QIP61n7zEous7XjedTHNhLDdXAoogj/yr94fzbkrzXWck0utjuLvstGWkNKx74csR4WLilwlnm30rgGJeLh19RJzxlVUPzNL+PfvM6yoEAtruXWx4igpDxX0favS+x1rbrLaWrgQZ6uB7lCMjwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=46.105.62.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director6.ghost.mail-out.ovh.net (unknown [10.110.37.160])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4hJcHN5kD6z5wk4
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:16:00 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-nv62s (unknown [10.111.182.119])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id BCA8080474;
	Mon, 10 Aug 2026 14:15:56 +0000 (UTC)
Received: from m-works.net ([37.59.142.108])
	by ghost-submission-7d8d68f679-nv62s with ESMTPSA
	id PxmDHhzdeWoT+wUA+y4jow
	(envelope-from <maciej.andrzejewski@m-works.net>); Mon, 10 Aug 2026 14:15:56 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S002b9938c9b-5063-437c-b380-4c4edae5ac1d,
                    ED6AA3D647CD945153C5C800EF75597CE9F2D384) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:144.125.48.245
Date: Mon, 10 Aug 2026 16:15:55 +0200
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
Subject: [PATCH 0/2] gpiolib: of: Scope the legacy SPI CS quirk to SPI
Message-ID: <20260810141555.70575-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 15933735482169893667
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEP/idJ4lNWMfRTNA5bt6+yShru4F5S1mK0jnWkEI5ocbjzIyrNRvm9zG/q4g91bfcuMv+NNBM11kZYEjVEPchDdmdUyL8MjlbGk+5AEHdkrpXZljPNc93lPHW5lc1wXdjxOF4ewXdqNMKK/HPv/XcyAdS/4dWpWSHnqLpDOX6wUOTeDrVCr/YxdecSCH85qkeroEGMxrMgV5eWMNLmgkN7i0a0d8uu9H0cQnyeerCr1c6b0UhLcsXyDX4dpoEqMlGPxVJYUVf2fkL5vkAnc+S4KQkq3AAZxv/y23ylCX9gr04qNO1UapptwjdxKA9kfvlSKPk/UgJDfqCmMvh/p88YrL19C/odMjmUFg9LneOmax4CWUyrlc9hWU+TT8HkYpesds4xMAu30SwRTmRQRqjZY2AVnisan/3HIem7lwIMUNaxT840CuOew76/Rbto7HRD9Imj0383pJDqrG5PnAuwNqbKmJBvsryv9clVtfnxG7FiM1B5g6cBPM7P0B5t2/OpylIm11BusU3u8Trqhx8OmtALcpUJXNP5Bd662MYVEq+DNU0G8l1UBzGSXc6WMIKNuc4vowjr4azh15Y2bW4zhZKW5MFv2pi+aAA57P88jN+aPmK1IitMnMcRFcdZ312kHKMc65yYYc/M5yY04JgvQHu+FP4Umcqyj8bYaSc2+w

of_gpio_flags_quirks() decides whether to apply SPI chip-select polarity
semantics purely from the property name "cs-gpios". Nothing about that
name is SPI specific. nand-controller.yaml documents it for NAND
controllers too, and rawnand_dt_parse_gpio_cs() asks for those lines
with gpiod_count(dev, "cs"), which gpiolib expands to "cs-gpios". The
result is that a NAND chip node whose first reg cell happens to equal a
GPIO index gets flipped to active low, and since the NAND core requests
the descriptors GPIOD_OUT_HIGH and drivers assert with a logical 0, the
die is never selected.

We hit this on an Arasan controller with a GPIO CS1 and worked around it
downstream by putting spi-cs-high on the NAND chip node, which is
plainly the wrong property to need. These two patches narrow the quirk
instead, so that it only fires on an SPI bus.

Device tree has no bus type marker, so the series uses two tests, one
per patch, and applies the quirk if either matches:

  1. the matched child has a property namespaced with "spi-"
  2. the controller nodename has the "spi" prefix that
     spi-controller.yaml requires

Testing
-------

Both tests were scored against every board device tree in the kernel.
Each .dts under arch/*/boot/dts was expanded with the same cpp and
scripts/dtc pipeline the build uses; all 3620 expand. 503 of them hold
at least one GPIO chip select that can reach the quirk, 765 in total.
761 match both tests, 1 needs only the property scan, 3 need only the
nodename, and none match neither, so no in-tree board changes behaviour.
Patch 2 names the four exceptions individually.

The collision with NAND is in-tree but latent: 36 board trees, all
Atmel/Microchip at91, give their nand@3 controller a cs-gpios line and
escape only because the sole child of those nodes is a partitions
container with no reg for the quirk to match against.

drivers/gpio/gpiolib-of.o builds warning-free at W=1 with CONFIG_SPI=y
and with CONFIG_SPI=n.

Note on bisect
--------------

The two tests are complementary rather than layered, so patch 1 on its
own would stop applying the quirk to the three peripherals that carry no
"spi-" property (a panel, an mcp251xfd and one ecspi child, all named in
patch 2). Only the pair is behaviour-preserving. They are split because
the property scan and the nodename test are separate arguments and I
expect the second to attract more discussion. Happy to squash them into
one commit if you would rather not have that window.

Maciej Andrzejewski ICEYE (2):
  gpiolib: of: Only apply the SPI CS quirk to SPI peripherals
  gpiolib: of: Identify SPI controllers by nodename

 drivers/gpio/gpiolib-of.c | 40 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.50.1

