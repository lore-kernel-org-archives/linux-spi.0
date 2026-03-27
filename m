Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0C346A08;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608197; cv=none; b=b/XDl/9hRAXu1q53j+jp0MfdQaUIC5avvGvH+Igw5Kt8a3jOitehig2b4oqFUJ/AdUgZ4KZg1qecjr4/XKfH5KlirCZnzB08fyJJlkGcilgtsCZxByRyMDaHtdrFR6cSnoRgbB/6HUZXS2oRjVe+JdM6AdK+5xinNufjL7n6KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608197; c=relaxed/simple;
	bh=P+b/76Q5D8tsdfUser9wn1Tp9CUID1FpPhgoB3vBf+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DudaJBjpt6qhiTVefH90WKwdvE38nEYEQ8J5d3ZWbpWl8gp6w6+LdrS/DS/zx3YUR2GukA1fibpnKxMDLUdNQgTewG0KA/JVMCW7a5eDeIwXYtjSzDnW1/e22vHsLFU4TvU9FAOZdvi4bvlcS3kJ51uLN3FOTuXpVysMrBQ1KFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6gHhpXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6gHhpXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36816C2BC9E;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608197;
	bh=P+b/76Q5D8tsdfUser9wn1Tp9CUID1FpPhgoB3vBf+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6gHhpXw0ojhHKTb/cqpZmmwNF0wBYbuoAJI/wDPFobq+BXzKd36JC0CbESFeVOxP
	 qxz90DR1CrWfaxV/u0YcekHEgxKCjFWJ5u898ef+rBabbGzM0MIUUBhj2/5ki1RPQJ
	 cajf69iViWkKQgNTyPOhhDmhdx6mLivlTfcJs9NbSHQOT7OJeNARW8JKZh9wV0iUqj
	 T/whun5mzP/4L2nq3szNCGR+PMmxdwu+oZkoZyEuAtYpRLMzTRqzMqiLc0NHbf4PB2
	 lLY38lR2fs5e95ynRFbxCzDNiYbjhMin+IibbmgkQdl3uGc4XN0JUY0acWJqIVFyv0
	 VgrbvzFDLHxjw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64eo-00000005Um8-3ePF;
	Fri, 27 Mar 2026 11:43:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] spi: ch341: fix devres lifetime
Date: Fri, 27 Mar 2026 11:43:05 +0100
Message-ID: <20260327104305.1309915-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327104305.1309915-1-johan@kernel.org>
References: <20260327104305.1309915-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB drivers bind to USB interfaces and any device managed resources
should have their lifetime tied to the interface rather than parent USB
device. This avoids issues like memory leaks when drivers are unbound
without their devices being physically disconnected (e.g. on probe
deferral or configuration changes).

Fix the controller and driver data lifetime so that they are released
on driver unbind.

Note that this also makes sure that the SPI controller is placed
correctly under the USB interface in the device tree.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Cc: stable@vger.kernel.org	# 6.11
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ch341.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index ea92ba986201..0e71a32900b3 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -152,7 +152,7 @@ static int ch341_probe(struct usb_interface *intf,
 	if (ret)
 		return ret;
 
-	ctrl = devm_spi_alloc_host(&udev->dev, sizeof(struct ch341_spi_dev));
+	ctrl = devm_spi_alloc_host(&intf->dev, sizeof(struct ch341_spi_dev));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -163,7 +163,7 @@ static int ch341_probe(struct usb_interface *intf,
 	ch341->read_pipe = usb_rcvbulkpipe(udev, usb_endpoint_num(in));
 
 	ch341->rx_len = usb_endpoint_maxp(in);
-	ch341->rx_buf = devm_kzalloc(&udev->dev, ch341->rx_len, GFP_KERNEL);
+	ch341->rx_buf = devm_kzalloc(&intf->dev, ch341->rx_len, GFP_KERNEL);
 	if (!ch341->rx_buf)
 		return -ENOMEM;
 
@@ -171,8 +171,7 @@ static int ch341_probe(struct usb_interface *intf,
 	if (!ch341->rx_urb)
 		return -ENOMEM;
 
-	ch341->tx_buf =
-		devm_kzalloc(&udev->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
+	ch341->tx_buf = devm_kzalloc(&intf->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
 	if (!ch341->tx_buf) {
 		ret = -ENOMEM;
 		goto err_free_urb;
-- 
2.52.0

