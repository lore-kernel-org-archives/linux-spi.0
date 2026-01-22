Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD053644A4;
	Thu, 22 Jan 2026 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072435; cv=none; b=cpWUqo+CFSrObLos7InXMAkO5uw6Fb1fzWw/9pgxp2xfaQCI8n4diKxmC3AVBBDMWY5+lk19zn5m3woagjYkWCMrp+3npWQSbHEkysbefO8NsbN3ra1BmKR0F8EV1WL4OGzq/giIUjkb/M/hp/Ql7kJtuXBGfQbaxgW3feUcJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072435; c=relaxed/simple;
	bh=5hQaXHrU+ulEMhFvULmKUP25j1Dj68/YkS34BUUdKfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aUsoehcpkGjM2JEf528AO4khuhXfftL1SdztdpkXD6+Qi04LicsgXM5oaVge9FcuU+oTuqmkXlKwcQPRDxhsWPFjB/alwglri6NaOGYRRxm8OF55hZmVLkGg24CC/h1HOC3FkPkBpDB9RIQhP7SHgBNhQbubrF0KKeKwlqHeyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfWnGSG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfWnGSG4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97E35C19423;
	Thu, 22 Jan 2026 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072434;
	bh=5hQaXHrU+ulEMhFvULmKUP25j1Dj68/YkS34BUUdKfE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VfWnGSG4qBJxKcm5ereT3hRBW4CCD3SftXVPVejBdNKLWkv5tkYO21pJvLNboNmKv
	 6u3odb5YV6gn57HKJDNQ7g1Ku0BvnRfWMEbnsWOlqyei23FMavAhXepr+D1hCOiz/Q
	 s6rfYK76uPJMJZUcQnjKIevJk1rNPibqeew5y4PMOxeNYpDheC8rgIe7u9ZxVn0ytT
	 BYHjD6zNsTXRJ4lhslL11GrsbAwy95MgCM2EwH6aoDWQHYC+DtUIFiyVIxM3s67rw8
	 FJUUDa+gPaN33do44xIK/EwUl1VvVrmK6bXxpeQBNDhnewJx6cNGh1fV14jz2N+n4V
	 tn/sJoiaStgxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6BC44500;
	Thu, 22 Jan 2026 09:00:34 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Thu, 22 Jan 2026 09:00:29 +0000
Subject: [PATCH v3] spi: xilinx: use device property accessors.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIACzncWkC/03MQQ6CMBBA0auQWTukU6SiK+9hXBQZ7CRSyBRNE
 8LdbVy5fIv/N0iswgku1QbKH0kyx4LmUMEj+PhklKEYrLHOEHWYFsEsL4kZqe+649D2rqUzlGB
 RHiX/Zrd78ajzhGtQ9v+LkyFLjauta601SOj74a3qw+TjNXJew7zUXmDfv27egTSdAAAA
X-Change-ID: 20260118-spi-xilinx-1b884d5b6519
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769072434; l=1349;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=viHwx+jv2rWkq2BAgRQtX9ZKmm78TjPHuLyAvr0R44g=;
 b=MHAPlWH5Jbo0z7ZJ5RovdK2iNh+yldLOZ1VZvSlym04m9sAfV19Jv40biP9TcdKUKZEdGGZKW
 9ov8hyBh5KXCuoQ2jOiH2lz8DvLRM1hHIi+YBfDnE+J1WnZX8GYDOj9
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Switch to device property accessors.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Switch to generic device property accessors.

Changed from v3:

Removed the patches to make irq optional from the series

2.52.0

base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
---
 drivers/spi/spi-xilinx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c86dc56f38b4..c4b70e95b695 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 		force_irq = pdata->force_irq;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "xlnx,num-transfer-bits",
-					   &bits_per_word);
+		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
+					 &num_cs);
+		ret = device_property_read_u32(&pdev->dev,
+					       "xlnx,num-transfer-bits",
+					       &bits_per_word);
 		if (ret)
 			bits_per_word = 8;
 	}

---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260118-spi-xilinx-1b884d5b6519

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


