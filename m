Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223D3BF666
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982816; cv=none; b=pW3MLmktC9xocXVTjAmXq17/n6qI2iVFdCUNJNaV6hkYt1MkIesefkV1E9jG2l7HRjzNXLgf/jMOuO0Fc+ktTwyUubQ+VOHoMsiPjJw4xhU+tSRUdVi+tRgivVfHhmx8d0U7O4fCq9iKDoF64sdQypD7nWiPXkj5qD6AQmo902w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982816; c=relaxed/simple;
	bh=zdzZZWSAE4fs97+W2zNJ/zcK5e29/VZ2OnLKUaXHvtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukAUaIdNcTLiSQAoR7TyxGd3kSxxwgTYjyBA8mfIKlFKeGtF2M9J/f93KoLgmpHakoUSJdQB3N79TUip9Xi8BSkVbOY+Vxb//k7Ao4zHFdLlzg6ofUGeHrQ3hUsRFytVtFRFqGPLXqu3rPTzUGIvffdg/8SeB7Wny/Ap4H8iV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSwghVD/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSwghVD/"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423b08b293so2187809b3a.3
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780982814; x=1781587614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsT1Zt8eX96C5Vy0ysyPoJWLG8nBvHsoCwEXo1y0+xg=;
        b=hSwghVD/eMdrgsP9cy378ip/0AFk2Xy3PnLLQ2VDuIZ7jFQSeYrPBrMeulw8uBYHli
         7xpU6Y4yEis1sn+x4QMFDZbgistbxgVEv6a4fNZD/Qi4FPXZ0niJqvLzGSsZdhu8U8E/
         MYyTDxa+41TANOYhYfS6yZsenRlbxbpHf9P0WaCZA9DPbM1W1ZaEv8gWFsDMqUANTG1N
         Ym1748S4mBcE2ArZLA9yMWUsymgIvad4nMlm4WCF8DJZBTPPEUcslQ0tNotp4cuJdajI
         TcdOaZSlZeYnQKUn9wJM9XXqOo+4qxISdigPjzz9S7RHHzXRznVnfTCM0V7NO+HLd+On
         w4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982814; x=1781587614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsT1Zt8eX96C5Vy0ysyPoJWLG8nBvHsoCwEXo1y0+xg=;
        b=mfR1Ao3U9k1aKSrthLeVUfOPeKGOib4WYkqegfO4mDQZ8y43g6se/lATreZqhxXbLI
         JcuM+8bqIxqobAWYq0Rap3fNPMur+N+z/lzFGBrt1vN4W9UaO9f+zswSe0xIFrTyjeLF
         OIHZHbQCR8H5NhRn5rrGhx+S62BeRaLfnwty8Jv0BE/bONagrBpXHxqHAuZE/Cg78BBC
         0vMj0XMOe8SPFCW2QflTBYDRIO/9u4H+cPGD1D/BXSjG7No8gG/YqwDPciusfvcEVS8u
         cSEedt+E8zzi+mNko4j9O5HHQDhHGyQ1eV1VT2isRe76HAITP+RPo58dJG2g/q9LwMp7
         9jGw==
X-Forwarded-Encrypted: i=1; AFNElJ/1gd5ddshObhwaNn7bGnmtrVPIXqjhmgHIRfcicdQJ+k3rrV4nX4tzPQqRqRqya0lrgfRS4DfWxa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJGAB0znXy/LvDVcNmNw2Uk6UC+od0hggQwl3bfSJmUj4Xmlz
	Sa1f3wk/AVpDdcyQZEDGPNQRw3Sbwf7iLccdAmt20Mi9t8iO/p7yA2Hb
X-Gm-Gg: Acq92OF0nSKzYx31x3N6kdTdEyh9eVPXt/xad9DIpeiTQTsXXEf6VnQFLSMj4VDoGNp
	ACM80UMQ6eJvuPuVsj/7z4CLghl4hM1LkBio4y/t8d1JB8+1vGZodV5T6xii6uNGC50bTj3Wp5a
	LpyX2sHo5yjem+Uy1MlitcHjVROvXbZfs2C7y1RhijXlzPkh/pVjhtwl53wojG2ywu5qti0vc7d
	u/BPi1lkUd/7URN8MNwXWZR86VRsNd2SlvciouK6pQyM0KxEIjOmcwr/RfXjdoDREYepgNwg351
	50rQ45mvrwM9ePJcQev7Lb8NbQ07ur7njJnVBrUMuLVnfhowoVq951g6BZrl/428kw+77wjJ6rI
	aPX5yeGR/uprsjEhW746LxnzagGLABR10lsdPX3WZF5+R8WNcOrCBkukKXKmGLx928E/8KQuyES
	sug4V2nwlKZ9UqYdCpJwmZELdh6lGZ01qYSrQZoH+OJUojOjbWDWtBdw==
X-Received: by 2002:a05:6a00:1d84:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-842b10b2f1dmr17770012b3a.40.1780982814465;
        Mon, 08 Jun 2026 22:26:54 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm23445657b3a.49.2026.06.08.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 22:26:54 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] spi: meson-spifc: fix runtime PM leak on remove
Date: Tue,  9 Jun 2026 13:26:47 +0800
Message-ID: <20260609052647.5-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() increments the runtime PM usage counter even when it
returns an error. meson_spifc_remove() uses it to resume the controller
before disabling runtime PM, but never drops the usage counter again.

Balance the get with pm_runtime_put_noidle() after disabling runtime PM,
matching the teardown pattern used by other SPI controller drivers.

Found by static analysis. I do not have hardware to test this.

Fixes: c3e4bc5434d2 ("spi: meson: Add support for Amlogic Meson SPIFC")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index b818950a8cb7d..e2d19c3873f71 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -351,6 +351,7 @@ static void meson_spifc_remove(struct platform_device *pdev)
 {
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0
