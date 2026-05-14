Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAA3A6B9A;
	Thu, 14 May 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739204; cv=none; b=iNeK8O/3MCIfK26dG1vkcDtv4rrDxdo58EAlR0QyMab87GGxVS34NKq6M1GHnvMa/KsJD8uTx+GGwbw4CH9VI4A6g8VX5fCE+TR9q+/9A9CyzAHMC5ErowZQjtTN1G5N1l11kFUCFqZX21VTilX6I1Imy4Q90cNvVhzd6Jj0Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739204; c=relaxed/simple;
	bh=chZS2rUiBIpWBC2uRoaRkLZHSoHbEgiBolH+XFksgjg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aw2I2qFslywjB+rfSPE2RIQOreeADThlO096ilHHo+rJeh9bdZeXI+crry5wFiwGWPx6uw5hxCG6sX2xbQ22srWq8kFNmYMroD0pq/6QTXQwn8Kckdz5Df3iRrhpnurysk8FZogrLGRm+nJfFiwEGzT0B8amT9CkyChMywsOn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KRaHmhHL; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KRaHmhHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778739193; bh=21aVBdvaQKsszvyInmBQte+YnfBHrrR4CG3hkYhZ1Iw=;
	h=From:To:Cc:Subject:Date;
	b=KRaHmhHLbjoz2PSTRo9KNtf9hgVLZTpjHq5YCvX6Qolg+HdMCeUQF793mBY/cti4W
	 AOQIcMpFNSP6PFojyUmZ2Ubsj94G8AJAttrKZGB3w8KR5CtonC7lz3DtcmPgVgeIvu
	 GjmYkNIhVVok+5sOXExA2SJYVY668ms/3ZFifaoc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 34B812E2; Thu, 14 May 2026 14:13:11 +0800
X-QQ-mid: xmsmtpt1778739191tp3ndge5z
Message-ID: <tencent_5C9EA0718E363D0AFFDC86E03AABD362F707@qq.com>
X-QQ-XMAILINFO: Nz6nvCBXF1ZF2iefdtys6wjWE2tPwz+ZRW6tZaD4gh2AN8pYR1lU8a6nq2rtb/
	 LHJODsKZPLQBecJWsZWDQ66YD6R11CUJb+JVIcyjVpwP5mu7fxbnExoMPhJjgzci1g6pdlhqO0fd
	 lpJuGtfbU1qIa/XU74h9bXrwrwatU9dtqT3Kz9FS8lydFvpTn7mABo6jhWV8jIiT2CcXVInq60nt
	 FOMwALSy2p3JVfpJT/lszncwVPrRDSl6xvtmJiod1iI2jebvNdArrg14t2oXltZpJ1sqHCf7NGeH
	 KlhtRpdMfriGAC5+8MYQC+uAmZp0gBwMmlUsBAIofWT0/qFvuBlWcvfFjWtnRHJ651Q0xVXYXg9h
	 7rhZ+xNkAOBHyrBMOIhdTT/QhfH2JeUN7zLLqWVJ+12S4mDH2GQURpOdEzcDqSeLtTJLTiYpXHKu
	 zGCTglEHMOyX/jFARY1SdIhnO/cnIMalpU+Tmp+rjfk+8XiaxbsWQlukTdW4NClguPoBA5bKs5y2
	 Sd3AusS8mSaULr0a4zspwnCN7W8vommO9QO0IFynTVi6B/edkLCs24qB7k3X+Nw30HCztwJWdxGZ
	 ztHtRVfWBSJa1cTr+/IXqkOeLQ0wUWbYjnVoymPuhcUTiMjhrXAkib3aBPolSU5mR+naxbwr03la
	 Y3lllqaxhzzPpEC3vgUdL4hutBLBSCQ5Xwo1wiR76HQO+QhLFAUL7Ioxid855dbXXkz7x2pEU+OI
	 vRcxdl8vDHgGeWBfar6dDoJXJqjWw0Wpj49gy9gV6OeymqU5dt7z8GNvqxXkPNrktDUlsW6y+KKX
	 w3+IpKvIFKnDK+E8eCuL9QNI1JU7uJEeJpyVcwPhTQNZ+YUCVURY8iidjeNxfMjGfz8YB8Wes2SV
	 mnXCc7xQXyNVXz42x9fkOWz0yjUIkct7U0/9m9OBfC3RTuGws5Dbtmb8Wvm5hyUJFudGwWrdNubc
	 NpmRpWZS/mi7XJI/tz1mugrbMbOlzR
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: 958028483@qq.com
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huangchao <huangchao@kylinos.cn>
Subject: [PATCH] spi: Add spi_for_each_controller() helper
Date: Thu, 14 May 2026 14:13:08 +0800
X-OQ-MSGID: <20260514061308.451474-1-958028483@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huangchao <huangchao@kylinos.cn>

Add a new helper function to iterate over all SPI controllers.
This provides a convenient way for SPI core code and drivers
to perform operations on all registered controllers.

The implementation follows existing SPI subsystem patterns:
- Uses spi_controller_list with board_lock protection
- Directly operates on spi_controller objects
- Breaks iteration on callback error
- Follows kernel naming conventions (spi_for_each_*)

This helper is useful for scenarios like statistics gathering,
configuration updates, or debugging operations that need to
process all SPI controllers in the system.

Signed-off-by: huangchao <huangchao@kylinos.cn>
---
 drivers/spi/spi.c       | 17 +++++++++++++++++
 include/linux/spi/spi.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..7cd07b390a4b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5116,6 +5116,23 @@ static struct notifier_block spi_acpi_notifier = {
 extern struct notifier_block spi_acpi_notifier;
 #endif
 
+int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), void *data)
+{
+	struct spi_controller *ctlr;
+	int ret = 0;
+
+	mutex_lock(&board_lock);
+	list_for_each_entry(ctlr, &spi_controller_list, list) {
+		ret = fn(ctlr, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&board_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_for_each_controller);
+
 static int __init spi_init(void)
 {
 	int	status;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 79513f5941cc..8fcf3faf9739 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -934,6 +934,8 @@ static inline int acpi_spi_count_resources(struct acpi_device *adev)
 }
 #endif
 
+int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), void *data);
+
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.25.1

