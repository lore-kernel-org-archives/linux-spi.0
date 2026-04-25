Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837543148CF
	for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109435; cv=none; b=DCX/AQ89HC1tn8wzBb8kEc9sDW2R/1PViM5H045fkXCVcVq7L18URg4uAoTIGM8Iu72tINSmjPwERou6mXlaflVZIaZZdvOj9rMcVTICtNhT0lECL1orwehvBDu1FaaAL5szj6FL8HOotlTUy6EvTxGYDgenIMxsfWZYrN8Vnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109435; c=relaxed/simple;
	bh=N9ijW3AsBy/p+PwIdQE2e41ehaiY4fwBhwF0z5uyDWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADz/mnnMbA0t+/bAuNSI9T+QXYeojo7Eyn+oCT94wAokLmt7q69uqfOtSFlvOoXFkd4CDhChsg+lRswCpCjLrKQ1GzFV7lHvOHk8j0X4VQrmfQ78FhvCI+CpkUDKmvcYBDVta8SPtUXkqz/X9wFRP8+s2azgggAxWjG0VLLdvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuWsAWxP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuWsAWxP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d03db7f87so5876331f8f.3
        for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109428; x=1777714228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyL6eQDTOa83HsK8N08HXtdZVDzA0HoYcQ2NsR08O3Q=;
        b=fuWsAWxPkUdjkzeiJ+pBcluWKajhMmK/d4loORNHDQ9r6NHUCuzOfVthwCYYErxWgK
         S6cSYUUFSFBulw9BnswZ5A1IG3LlkKGUuEqqKdmJevs3f+VtspJ1izJ1tZ3ZTaJCE4nl
         DT5zL7+v1W4KcksmIiXEVvFti2VdkuTm5mkVp0NsvHqATNio1wiPFBG2InkrUKeoivS+
         DJSr2vvMtKYdWBjYoXLdG9sxGstPXq8M9wC9sRlg1fDGMd5yXkQRSJGxMUljD1+Jg1fY
         ANyqEABVleHZdYybIfgL2h6fUNScop51w7yme/3c07oKtt7NQtXxE589bs+QW4NGlU0M
         R4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109428; x=1777714228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xyL6eQDTOa83HsK8N08HXtdZVDzA0HoYcQ2NsR08O3Q=;
        b=TRqSgtLW/3cjh+1Ry7yhMEnWz/2An0MK/b5upeZWDdakQoFDgD5IMQ9eSs++zhyuv9
         r0jOHmYtBmcYPpMm750+2mh4KXgnB7lDfJCCXftfqMLXpSHd7XeUhyWOGw5nxqhcfHEi
         b/xJXR+ENR4irsy9EGsWD/WH1zYdwc51NhYYtUkVtNGJOp/mgcQYAHuPOYaY26LJ/Hy0
         8+N+/ED09Rh1RYfubNQN4uW1hHXJJWTpu6uSqby1rDusu+adEMxi0LunslEOSAqUmoWo
         GdLDfpJf7cAUb4Z8JEvxlEkAhjvEiN+UeYf8d1w2XhHr/dj48eMooGdqaPzxGD0fabnW
         8EZg==
X-Forwarded-Encrypted: i=1; AFNElJ8c2ZwoNcZ0ZqpqGJZWQ/BpmWnAWdw1vgAqwwHvoNum3TXHhyGzuvLklU3qRUEPlhlqk1Dh+F8c+YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/t3sz6F89fuyQU0mgrRVJPnbgyQ2/Jg0TdiQ3Wkm/VwVHlqJ
	SDoQDm1HdEB0McwWd6yZuY6DGqUx35hJyDe6kRIw5FVIeBXV2R6QBHmG
X-Gm-Gg: AeBDiesmvH8s4wNRlWZ4LPgVMet9ZVUeC/ufNfBAGjRp3lj1VeNrrrN9PW+UTGyMFW2
	H7i9cif4edjpZMzixANYmN8dzCs3xCwSs8i1isRcEWm5rHJJ3GjAVaH1pVWHrXi/v0FDNU6ocIq
	w2Vl/3yvx5TNnzfHI1T8pAhM+3K6fMdMnzdTnxPb2STvsXQh98MpEGdgdXE9I/yCwvXeIUzPvFq
	2RKxKwg8cjA7IYGadK07chBxFJDa22yhVLbfpc2myFLjqYWao+R4igBSSvdnOf0hSui1SR4aoNp
	CXA+PjITABtzIdiHHR1oVzTvWct7Fwa9CZh4BsoF/lD1r5d9vXt47vHYAWGoWySpBR4o7q/+vVa
	AWYOAiBt8kJKvuHPdXaN/3kh92TxOVX5VPMSaE7CSM9rnKLW1PI+pyz8sWll01oAAO8hrrxuaEL
	uWR+SBV75aJ71tc172qR0kf4z5+Yq1t4ohZLVyBA/RwzLAEmWnmiPDMUttaoK8fGjyRhEgb9d35
	u59
X-Received: by 2002:a05:600c:468f:b0:489:1cd2:610a with SMTP id 5b1f17b1804b1-4891cd2624fmr339312755e9.9.1777109427813;
        Sat, 25 Apr 2026 02:30:27 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2716sm204422615e9.30.2026.04.25.02.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:30:26 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de
Cc: jon.lin@rock-chips.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 3/3] spi: rockchip: Drop dead zero-check on fifo_len
Date: Sat, 25 Apr 2026 09:29:36 +0000
Message-Id: <20260425092936.2590132-4-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260425092936.2590132-1-john.madieu@gmail.com>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rs->fifo_len is assigned from get_fifo_len(), which returns 64 for the
two known SPI controller versions and 32 for everything else - never 0.
The subsequent

	if (!rs->fifo_len)
		return dev_err_probe(...);

is therefore unreachable.

Drop the check. If unknown controller versions ever need to fail probe
explicitly, that should be expressed in get_fifo_len() itself, not
through an impossible post-condition.

Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 231fbcf0e7aa..1bd48376498a 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -824,8 +824,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	rs->fifo_len = get_fifo_len(rs);
-	if (!rs->fifo_len)
-		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get fifo length\n");
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.25.1

