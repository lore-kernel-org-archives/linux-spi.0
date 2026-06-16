Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AF42EEA2;
	Tue, 16 Jun 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607763; cv=none; b=PwLH7/FwqPqfMS//C3FN03mzmxPjWAMH0YFoPJMGOvqhTln53uwSXxEmr5YJnVgIkyNy4NGJim9en6+Vk1/amLmK+W7+KJSgyvo+Ba9fXobNzsSbB4zR2VHL9l791SVn3JnYymM/f12PlcXIHfK0yBNYo51NT7kHx7TjUtmuj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607763; c=relaxed/simple;
	bh=Na/0hInjZlFy+f86HfBHZHKRIRVzmWQctb3rA9JSGr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R29D2e9+JOBYTaJOja0Ov+JoleHAV8PQDpapkt8jRYTKA5RGM+AOwMLCdtKWl9PekBrN9WRG7Ghu9PBxHJnDgpcoOU7BoKhIHkW3UauGJThFKXhUd2vz7pwRAu/b1A3rQrkEJ9R3D0nBTnnCvzLU217Llzl/qSItz5OtxJqnMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mPy30zjs; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mPy30zjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4A
	lWpfHRD20svlbvEuxneUYoPiBFZmx61S/n6SJjTfA=; b=mPy30zjs09WS31OEV7
	nzbWcMTJ+EsS9arQMkVs5am5VICCXhSFXaDCVbj91U3p5qwfLV1/DWKuYMKX4EP7
	Gve1IScyEYSthxKKWUZEAjQfhzzU8ez1ERj1kiaukb00IV6aau2oCJWFfTPQNJuk
	l4ZJlElW7tNU3Qv0gphPijXQ4=
Received: from rlk.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnlzBALTFqGfcGCg--.41239S2;
	Tue, 16 Jun 2026 19:02:25 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guoqi0226 <guoqi0226@163.com>
Subject: [PATCH 1/1] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()
Date: Tue, 16 Jun 2026 19:02:21 +0800
Message-Id: <20260616110221.110781-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnlzBALTFqGfcGCg--.41239S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Gry5GFWruF4ftrW7XFb_yoWftFb_ur
	15ZryxWr1fKr97JF1Fqr1avryfKF4YyrZYvr4vqF9aqws8ur47AFWvvrn8AayDuFy0yr1D
	WFn3Xay3Ar43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtjg4DUUUUU==
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4QFCqmoxLUH4qAAA3v

Prevent NULL pointer dereference when spi_get_device_id() returns NULL,
which can happen when using driver_override without matching SPI ID entry.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/spi/spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..079ac01a2229 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -355,12 +355,16 @@ EXPORT_SYMBOL_GPL(spi_get_device_id);
 const void *spi_get_device_match_data(const struct spi_device *sdev)
 {
 	const void *match;
+	const struct spi_device_id *id;
 
 	match = device_get_match_data(&sdev->dev);
 	if (match)
 		return match;
 
-	return (const void *)spi_get_device_id(sdev)->driver_data;
+	id = spi_get_device_id(sdev);
+	if (!id)
+		return NULL;
+	return (const void *)id->driver_data;
 }
 EXPORT_SYMBOL_GPL(spi_get_device_match_data);
 
-- 
2.25.1

