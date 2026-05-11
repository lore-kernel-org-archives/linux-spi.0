Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0841C31B
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515108; cv=none; b=pejPt/cogwCZQEJ5icO6UbR1Dn0cqLb4RjsTEuzrT+zqhCdJFtjrCGtrXkqAum5urdPCH4YdPreBGTNZBav1gpnt+/Mq67+tb3ZgB36aUJMoyLR8yJMKwkOOGtyt+/Q7Qeruh+YHDSJHiXTGeOZOsxLMjz48e7vo5px4lhYO4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515108; c=relaxed/simple;
	bh=faV48x66qT9Y451ucIdOMrXgpUrUv733nxGN+U0gWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rY0qptxL4UyKkggU2xoCrH/PbEA4hi6ez/sywmOiXyNEGNs0SS4r3Aq/qwkufgdkxxy96r0jt4magoRgCm88ozfowKleRxACLhDm0kmz8nEtwwrADZXPagqBH2JcjS1lrJQNd3DlCvPTeII0/I3TEEjv1l30DP6hXi3PvVAhQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jYe5/IyV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jYe5/IyV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6D7274E42BF3;
	Mon, 11 May 2026 15:58:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3184760646;
	Mon, 11 May 2026 15:58:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FFCD11AF9F17;
	Mon, 11 May 2026 17:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6PvZiJbdFgg6CfVXI3ZnA/W5wMYdblVvpzZVyQN69HA=;
	b=jYe5/IyV4+QQoPJhoH7kASCQK5hWPxqcsQRvqBqCShiZy80aw0NHrK/bRUrBiV5WbDCiry
	/8JLDvNB6TNUw2z1KYOuG43u+dnPBL+j6KyU20SWwuuGIoIL5/ZMss7RWIzfc5fEfQogdg
	91P65zTkGl/3A8bCLa9FlGNWKPYfQa/+wZyNiB1SHEXeKDXurNSCCJMEgXABD+4FfSoyfH
	s0DXPDs0iJXUUlljvxnUT2JX0EVBicPQHfIgDilYiACGtiqQkfba7QGiIL/DJViqR86wdY
	ZPlO2RSX+fQp9jT8ff+AbeAyzZPKUEqiD2ypxBO1MjuQe4+VmR9cAexa5Vtf8Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v7 0/3] lan966x pci device: Add support for SFPs, core part
Date: Mon, 11 May 2026 17:57:47 +0200
Message-ID: <20260511155755.34428-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Previously, I sent a big picture series adding support for SFP ports
available on the LAN966x PCI device [0].

In this series patches touch several parts and sub-system in the kernel.
Reviews have be done and it makes sense to split the series and send
parts separately.

This current series is the extraction of patches related to driver core
subsystem. It fixes devlink issues when a device-tree overlay is applied
and avoid a warning when a device is removed.

It has to be seen as a continuation of the big picture series but
related to this specific core part.

Patches 1 and 2 fixes fw_devlink when it is used with overlay. Those
patches were previously sent by Saravana [1].

I rebased them on top of v7.1-rc1 and I added a call to
driver_deferred_probe_trigger() in Saravana's patch (patch 2) to ensure
that probes are retried after the modification performed on the dangling
consumers. This allows to fix issues reported by Matti and Geert [2]
with the previous iteration patches.

Patch 3 avoids a warning on device removal.

Those 3 patches seem ready to land and so having them extracted in this
current series will help having them applied.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
[1] https://lore.kernel.org/lkml/20240411235623.1260061-1-saravanak@google.com/
[2] https://lore.kernel.org/all/072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com/

Best regards,
Hervé

Changes:

v6 -> v7

  Rebase on top v7.1-rc1

  - Patch 1
    Fix conflict due to commit f72e77c33e4b ("device property: Make
    modifications of fwnode "flags" thread safe")
    Add 'Acked-by: Rob Herring'

  - Patch 2
    Use fwnode_test_flag() to test fwnode flags value
    Add 'Acked-by: Rob Herring'

  - Patche 3
    No changes

Older iterations:
  Patches 1 to 3 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (1):
  driver core: Avoid warning when removing a device while its supplier
    is unbinding

Saravana Kannan (2):
  Revert "treewide: Fix probing of devices in DT overlays"
  of: dynamic: Fix overlayed devices not probing because of fw_devlink

 drivers/base/core.c       | 86 ++++++++++++++++++++++++++++++++++-----
 drivers/bus/imx-weim.c    |  6 ---
 drivers/i2c/i2c-core-of.c |  5 ---
 drivers/of/dynamic.c      |  1 -
 drivers/of/overlay.c      | 15 +++++++
 drivers/of/platform.c     |  5 ---
 drivers/spi/spi.c         |  5 ---
 include/linux/fwnode.h    |  1 +
 8 files changed, 92 insertions(+), 32 deletions(-)

-- 
2.54.0

