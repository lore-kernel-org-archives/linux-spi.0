Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D234AB14
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167817; cv=none; b=hh6NCVjAcQoWuqsTVOGxS+tIZCLu4Ru5ulgfDoF0zURFoebubV94ygsQ0plYYguuqmE0/EiClzLqPIPzsLBU53YRvBrGBuXh4xBmX82PxPae1OUr2910D7wI3GkQgqQ457dks04+Hyv5XaGP0PHcaLgFRc5KFFwTwPmLhDTzMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167817; c=relaxed/simple;
	bh=2DcKrTh6Fa5xsizeNBedkFyjjEAWZcTil7Z8r+RgvAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYTQdUBTH04pnxpi5BIPslX5CPjLor0nucS1IyV7jqKn7lwZBJ1g+aOGx0phHB+hwKcYoIJAysd4spPnc4Db1bacH/lGySOEIHq54Ow3fncHRKX5rEDPzpgF4ADu5Cd9ORaUcaDoUzadKIfOUz5WbgJmszCNE/3AwKbGJEVt/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgCtPHsa; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgCtPHsa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so164519f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167814; x=1789772614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R29YYAgyVJQX97ebL5rl2w0MZtUio8U35ZN1MB/U3Fs=;
        b=TgCtPHsaUHLA0FJtO1QBmiAcHLcKRoN5IRyuqMBwie7f6j/3tpy30LkBBPvsLew945
         ShitSxlfuFPJdlPzPB8bSylg2VHRL6iE0BfQ6/a3Copc7EeH8fG9cLNVcuvs1AJvuk1t
         rKBT3w1nW3J0YM9rIlwtei885nWZBb/wm9++xXkUgR4NS5pg5zUGW4OkAbLH6hkkcU5c
         Drfnq6klfom7cGTsAG9QnA7ejz6VoQup08O+LRBL55vTiC20dSegR7UUtr9ERNoNVD97
         +mcRBgj50Fgkx3mp2UCJNUQbDqDLtJKuY8qkCJmJdE3xNnLbauKfi1XpKLs9Bt7sUjA+
         lVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167814; x=1789772614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R29YYAgyVJQX97ebL5rl2w0MZtUio8U35ZN1MB/U3Fs=;
        b=osvvwrDfI35ysD189u2OUZ9cX4m60JQIBAecniQ+tXHOfpxiQ5G0yuZ3VdOvth7/Ee
         lxDTf82C9rzBxKHere+R9tLQmH+HAEhF5SEn2xDf2+TjE4Wl1IfNm2MUseAeuaNVz9h8
         Hc1jT2Na+eEmdMBuhLrFTsdC3NRSFbvYV+IJ3wHZl7/XeWwUK6IC3ydUBZDUSUQlpePI
         SCZmOuyVDynKqmro9FJPZkLnNmTmIZcy/y4AyDcQNLlvub1/pzfsufyqhwXUGpVlA2eb
         MBpiX6Rc3LVaLuHij96fw3GGQZp4prmfpH22bKNGRAvbUFSLz1X4WkoIPapLrEnH3wg8
         HF6w==
X-Forwarded-Encrypted: i=1; AKwUvByvFle+htUT3FUEigRdDwS3c9un54Zxih3rhRj46uibRgKK0OAHBSvL+8/sX5grddK0dbEFZrQ20MM=@vger.kernel.org
X-Gm-Message-State: AFuF++ni7iXVWdXCkKGiorQcXMT4O+bxczVE4rj1Pc+hppmpt4Ddo6wc
	a9+8wPRgALKa6F429Ct1mZaU96my+jtoXPX0mOArWEjPJB1qoOxSndH5lLeksBke
X-Gm-Gg: AYBFou0+tu2J6aqwM4b/yACDJYhJi7vswcNHIbR9hFGSqvzFC9o4wdmetj3SO8Svnzp
	qTLuEF8jXWWbEtPJeJLePKXpDZXjtkFgCrtf/qyEYwjU3TMinEEJYgmpSqRoLiBZxDVNcYk0c7g
	l/QsTrJOyQ3YkNtYhZwD6PTjqxOe3LSP3PRJse1QTK7bFt+UQO6E+7uoKdcti7MESwcuP2RxWyr
	N81hzOW9bZ9RBtqd0ufb4SKLCTV5jE/mJuBDiqw2lohzsWthTFy2/61Z3r9q/9NcQNzxov7lmIZ
	Zo7YD5IsUoDBfHBWtzd+6Dhb3t7TYW25GBhpToBANKJNtMBB/gI9/kGihhH5ffyePqJCFJ0bH6w
	4Q9NnAJtmByln5lsKvMUkVISH+tAW3wm3btZ88cbCbIidwZRh9/rHWmRIYh4AqKFyD6aXqzqTmC
	qSu2gRl1eda7POtKkUF9v3GUISMyAcRswRnAb5D27GrZyMKQAGQMmbgHoJbUszfB5NTd+NdggjY
	A26RHWYPAJWF7+Lm/wAEL88vePlgsu0NZBOI6TT6UmWcrI60jga1c1Au4uSirIG4DfRfPNwQCWa
	zZ+V3R2JvI9pz33jin/erj0u8+xRxIgrDMWY
X-Received: by 2002:adf:f80a:0:b0:485:8a47:5b9a with SMTP id ffacd0b85a97d-486eb3524ccmr5422244f8f.55.1789167814312;
        Fri, 11 Sep 2026 16:03:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm6534861f8f.8.2026.09.11.16.03.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:03:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Fix the return value in spi_new_ancillary_device() kernel-doc
Date: Sat, 12 Sep 2026 01:02:11 +0200
Message-Id: <20260911230211.11755-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_new_ancillary_device() returns the new struct spi_device, or an
ERR_PTR() on failure, but its kernel-doc says "0 on success; negative
errno on failure", which was never true. Describe the pointer.

Fixes: 0c79378c0199 ("spi: add ancillary device support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8cf8ba60a1785acc695710865edad..172141650b648694d4163d0ba00746ed2948ccfa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2893,7 +2893,7 @@ static void of_register_spi_devices(struct spi_controller *ctlr) { }
  *
  * This may only be called from main SPI device's probe routine.
  *
- * Return: 0 on success; negative errno on failure
+ * Return: the new device on success; an ERR_PTR() on failure
  */
 struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 					     u8 chip_select)
-- 
2.39.5 (Apple Git-154)

