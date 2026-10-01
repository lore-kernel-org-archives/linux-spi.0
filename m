Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC845304AC;
	Thu,  1 Oct 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868922; cv=none; b=arY7ujQsSp6wnNpwZcyqYLhD17t9vAHNsIrnw0SQoKsLiV/Wl5OV5DZUINuqUwDgaNtbG50ggFnKkrqVdTV5ysWtgDjijR25jIi16MhvPaE0P8OC5LuLkqxG6kNVPFxHW1YkqV8ONYv0M1BUb8aq55HiHXnO5jj19KCe+njIz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868922; c=relaxed/simple;
	bh=zACx6funMaO4lcuvTlzVe9bYUrb+GrbEWH5ROlj2Vxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcxvQjABNZAQopXhrJF3iYIIrLoLJbHbV46De98qAM3MDoQzP4GewGoRMo1cQtcYUxYf1CFZkuqQf7w4OKwKeZSIBkl2FbDnzlOJrq4IS+gZJrc7riNU2Szb6nOvaNlkD2D+bWWuinirdH8M2uuwlr3R4I5LgpHfkSdqbMX1pJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from albans-vm.. (unknown [213.61.137.106])
	(Authenticated sender: albeu@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1F43B13F861;
	Thu,  1 Oct 2026 17:35:14 +0200 (CEST)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Alban Bedel <alban.bedel@lht.dlh.de>
Subject: [PATCH] spi: Fix ACPI SPI resources using relative path
Date: Thu,  1 Oct 2026 17:35:07 +0200
Message-Id: <20261001153507.2011806-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI resources can use relative path when pointing to other
resources. This didn't work with SPISerialBus resources because the
device defining the resource was not passed to acpi_get_handle().

Pass the ACPI device handle through the lookup context to also allow
for relative paths.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8c..30ef9216f3a49 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2983,6 +2983,7 @@ EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device);
 #ifdef CONFIG_ACPI
 struct acpi_spi_lookup {
 	struct spi_controller 	*ctlr;
+	acpi_handle		device_handle;
 	u32			max_speed_hz;
 	u32			mode;
 	int			irq;
@@ -3077,7 +3078,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			if (lookup->index != -1 && lookup->n++ != lookup->index)
 				return 1;
 
-			status = acpi_get_handle(NULL,
+			status = acpi_get_handle(lookup->device_handle,
 						 sb->resource_source.string_ptr,
 						 &parent_handle);
 
@@ -3169,6 +3170,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		return ERR_PTR(-EINVAL);
 
 	lookup.ctlr		= ctlr;
+	lookup.device_handle	= acpi_device_handle(adev);
 	lookup.irq		= -1;
 	lookup.index		= index;
 	lookup.n		= 0;
-- 
2.39.5

