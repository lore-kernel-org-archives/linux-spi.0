Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E303B2FFE
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162804; cv=none; b=Zp8eIVL+Tui9yGGDbv5eugwew9TnnZRUabf2zBS9IXnc4O+qvHNzyFFZjszQxo0wyPKzTwZtHxCnD2xiflV83kLCf1jxrKnrEwYKbA7JHsFPwLXK8GqDAkU8zPL8p9iaI/2mZ6QA6I/oKko18x3glT/HMgB3rNrRBP7Z5a3tLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162804; c=relaxed/simple;
	bh=JAjipfKfs51vFrxtJpvn+cv7EL87nK2vfVmeg/wRfSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A+t9v4ADu9bJXvVGPIAfv5Lz0BuR7xO1Qw/5mkrH9GQIhOBcjExj6sp1Iyty0fYCr2RkHcjQ3KxfJyotH65xoY24efDTfgk/Czpb0FWUk32HjuC6A5vzQxJY+EC+6VMLwTlh68+3yGdwxBtixvseRsQ5/20CYcU+4+mrgeQ0/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCXGb2E4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCXGb2E4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba4efedbeaso6316315ad.1
        for <linux-spi@vger.kernel.org>; Thu, 07 May 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162802; x=1778767602; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ae7zwiJIUo8qoMU7Dj2PqtZbUdgKrdvCC7+ALP9ZsLk=;
        b=jCXGb2E4qja5bGRGNaGa1BHj78p2Gua6eIL1R64oB1rtyrRT4JWe4Jb6C24uz3LB+5
         OoVfrHitIqNPUlTb4Wq+moDLtECJoKjxYRI8KwaPpNES9P5MZCbfELKdIwx4sSeELPnR
         0PfVUF8MbZAOKPeOCfS4UOzWlI9zBv+so9wDrZ2+gxqTFP2E5nawf1RlDo6bQQLvXs/U
         8Sh4gAVBuX3VzqYkjg/rwP6/qRXhxNoD5v4/s35oM5ngsiCz7sqmDWXg1AzVwaWys9nm
         wOwX55+GzlH5fVoZw+tN1Neldx9sU5JqgXb7t4H6SslZS8JT3gDX5SPaV1bQAnGfDo+C
         gXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162802; x=1778767602;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae7zwiJIUo8qoMU7Dj2PqtZbUdgKrdvCC7+ALP9ZsLk=;
        b=Ek9yAT331EFJxlycRUqMtrBE0SUCeigZncIO0++zKz++ZlQvcNte003UpxFS7rSHiQ
         zL2xsU8jB5IXLZes8u0zwQhQIcjYilBtqcwLc+4YmZ2CmJFKHBxTPXqwZ2KSTX8XO5Hh
         sbhbZ/Wt3C7Fav6hU/lD5xRO9i8Nlp6QfWF30kH88pQntgSKxUBReILdZOOdSjsIYuY3
         AE7csKySSQP6625iK23HBC1MmayuHYQiaDa8NzcCp4FzugINXUdo7X2QlTThhsbqRSlP
         t/wfNZlJWfGdkJifVEyr/4GbiXgSApDptwHaTmK8217vRU/8NdOVcVY099/F2Iao6jMD
         K8MQ==
X-Gm-Message-State: AOJu0YzZUe8JtNT7qvGpvPQepvW1TpbXyrEu2bMFtJk1n5S4rArTmUps
	+zlRvh4bYqNu8mFYuHXLohv07+P2X7exQT0F1CBq2PZ0vf8i1mlBMDuq2euavv2P
X-Gm-Gg: AeBDietmeoic3Gws7S7uk4Co1WV2dRXTvJEIwHa2xXQYqV0l7Q9ZjUskIpXR+EBJRSf
	tUU6i7LwYq5yzBwpBz+lRfua4m1w4bSiCoMW9mhwH4L21uxPC7RNy7zi0umftevPiD3AgixW9pr
	1/jeC6JSYOvJyK4lx2Nhtfs39/kSwcBkbpd215QGff+3y2vMfyckvrba7kU49lvLUkH3VG7WSms
	Fp0N4WBsLZAUDijgX9RmjmhY0vnyIddxaimfzOo2KqRdfHNFI0AzxMbUbZFeTNW0deZ9KrgyP6h
	bEgCEoji6dCBpinhlfQ7qBG1AtcjhhxGEjW3KMqFlI3rCoDoM5uUYDebC/XjdEFkqEG/5rqSs1m
	GWmCvq9GaQT4oHt1vwnqEB0qWyjR/ZwU8tVA7LB4/qeHhgzEdvJBqmU737ErtK+WSHDhFD2feU8
	ICch5FArsV1WHlHffVhWtBEDg1v1KNXkhAQnMKj5dMDmk51odRWUqdrJAnbSxZ9kTa7C8QgdRKX
	hUm9uWexgF8+9yC541W1aHVt8qfQeA8fu/HvIfX
X-Received: by 2002:a17:902:ef10:b0:2ba:15ff:345d with SMTP id d9443c01a7336-2ba7a34f56fmr90196305ad.35.1778162802238;
        Thu, 07 May 2026 07:06:42 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babb0e487csm29320725ad.72.2026.05.07.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:06:41 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 07 May 2026 22:06:36 +0800
Subject: [PATCH] spi: rspi: Simplify reset control handling
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-rspi-v1-1-8cfa47cd56aa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGuc/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNz3aLigkxdc5NE41QTMzPT1JQUJaDSgqLUtMwKsDHRsbW1AB1JXfZ
 WAAAA
X-Change-ID: 20260507-rspi-74a3e4665edd
To: Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778162798; l=1807;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=JAjipfKfs51vFrxtJpvn+cv7EL87nK2vfVmeg/wRfSs=;
 b=OoEHkLV4K1U3r0I2Y/Z4jr4I1SMIukGgopSvIna3XT9a57LU0Dgq8O/cu7UIyyT+GkLKDXdDZ
 hJ0Jhp4z97TAcMtyO9HbE3uCJhRWmpLyWp6dvLFGzI3yOSqC6raejv2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use devm_reset_control_get_optional_exclusive_deasserted() to combine
get + deassert + cleanup in a single call, removing the redundant
rspi_reset_control_assert() helper.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-rspi.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a8180dece716..a77c0ebeebec 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1226,11 +1226,6 @@ static const struct of_device_id rspi_of_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, rspi_of_match);
 
 #ifdef CONFIG_OF
-static void rspi_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 {
 	struct reset_control *rstc;
@@ -1246,22 +1241,10 @@ static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 
 	ctlr->num_chipselect = num_cs;
 
-	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc),
-					     "failed to get reset ctrl\n");
-
-	error = reset_control_deassert(rstc);
-	if (error) {
-		dev_err(dev, "failed to deassert reset %d\n", error);
-		return error;
-	}
-
-	error = devm_add_action_or_reset(dev, rspi_reset_control_assert, rstc);
-	if (error) {
-		dev_err(dev, "failed to register assert devm action, %d\n", error);
-		return error;
-	}
+				     "failed to get reset ctrl and deassert reset\n");
 
 	return 0;
 }

---
base-commit: 17c7841d09ee7d33557fd075562d9289b6018c90
change-id: 20260507-rspi-74a3e4665edd

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

