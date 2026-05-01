Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA743C0623
	for <linux-spi@vger.kernel.org>; Fri,  1 May 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644007; cv=none; b=FFiNzKXEOpNLN2mlNddfol3+GJtIakl/jg2rwrO/WThd8WqJrOBYiJDzunMt/4yE7ZlZrg0TybDup5B88kEwQquOG/Zjqvv/grO0q8L18O2tGCvc9bU0rl+YG2lCUFX7kfwmQDbC0BynBuTGtslE6tefttItvcRz64W93fkmdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644007; c=relaxed/simple;
	bh=wr1OnFxz/Ai5i4NfAvoS0ChTxZI8nshMYVtsLOtw7bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJQfEYxQi3yyHf8rfxERyMjq4oXmw9E2bcTO1+utkIo9MXcGXriPm1Of9q6hh57aZ9GrhSy04EBzPu93FJlK+zxz0YZwWMa2LVP5wugAoBuJ0Zr9iQCyqfhPhcPB2O36K4mmzRh2q6KQPBB25IKypS3Dma0bQz8fbej0Nww0ueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNsw21jp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNsw21jp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so17615625e9.0
        for <linux-spi@vger.kernel.org>; Fri, 01 May 2026 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644004; x=1778248804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yRGhlBCY/TW5XKeeufbyghz250gEgHu0HIRBXKkoYQ=;
        b=cNsw21jpSnOytV59SVtqkExEglKmvBTMvkjf3Lr6djzZHTAVQD7PA7JWMjZ1hYvSv5
         sAXqMpleKYEgqhLkmEamXLT67iSD+quHviMNEg2UEseHgWkRcWRAH9HMPR3rSC5B8943
         SgSwH/BnuRmAPKdWmex9T/9NEUWbPWlUk3BYgQugJdbE/lWmBuPCRb0dxjKtZCV3sk7J
         VEjlNubKf4C0+DDPvgkbnDMYcdOKxQrp+fKjaxQ6LnSfS1fb2hUJry9NGEypy8laZInF
         jQ83niuLHSTDPpObYCf2xlq15s3AFK58Te1PffIDO30VCpDqL/2NxldQ4Q3V+DF8iMkJ
         SsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644004; x=1778248804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yRGhlBCY/TW5XKeeufbyghz250gEgHu0HIRBXKkoYQ=;
        b=oGxs5kOksijSp/7YLvjbd9TgRQg7p0+kVAODaVn2GfPE/aBH+R0q9oz/wKbcGRc8WC
         4e4/oVdkHSonP6si5k8rZS2NlhQC4KSjf7nh92cuae5nShpxJqr859pnyiP4Tf+yI4ai
         ErALKrACW4UsnX5M3mWzeQiw6hty/1fTbm4+PaqgNIz0WEQEKnBT5XctwkoWdCXP/Lim
         sO9KGLtcTHyzUOiPiM0Kx2y9NiEz5Rw5gXH1RVF4+GkATAqwVMdAzpXSV9CN7PosMXCj
         SzYk6rq4i5RVM2xUcX0NSb/1mSLC2vrTjyXYjGarAM/LoRE+fhiw9DkL7o9lnLB/ma3J
         RNng==
X-Forwarded-Encrypted: i=1; AFNElJ+zEGXQHvp68Sac6cBNjeZh/CdbDYHR3uTrJzQhswRYFufofQmhD32KAAA1qZsfXzOLlpnVaQ0+OWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmL/GkxnGEOVd/apRxYVsXjqlHCgEoAOZgpfgA6+lqF2VZBJjY
	5oHCMnfMEmECYSS5UJtanHIqLRxZ9Y6dG7xzrmfd/699jRs90usNfMID
X-Gm-Gg: AeBDieuWd2Q3VjlVCBP4l/7qg0qTAj5QuTYvut5ZElxAFR2fxdox6yZpGIUX9NLt+bU
	NH2RavOEhSXo59XSB8w3inccYQBYDisDcV8DlsuUWDIY9v6DJnqtmtAKAZyxsjL5h2EtDPMQTfD
	4eHTsJkO8SNrI5hE3Zdl+/fbX1u/lCUC+bpiciJdHAHDCRwZlWWojbdkvZxiVwmKVARftma9ym5
	QiBhkrtNyMBl8fNLmNMgRTDFt8ftcVlwRvs58g8ctT1EYEarBfp0kZJf5zEXfVEyi2xFIsj7PGP
	PGw+1/V4XVKFdQx5Ue4YZNhd4sMLXV4NipnhGyq0ibt+5/gEJO9q6wrIjjqn0tq5t3T7TQ543jg
	wFGHOZX8lgZ7IumpaldxkQeJ8HPzWCvkl+2F8y40BYjc0CSfIK51RzUaLZ0iK1KvuaVRf+sgCoN
	uqqwA2ndEVCZWz9SDe0tBQmUwUQMcWSEWvHP3GVGS9YxYatRpfECwoIgsNGW+cqCoq220/LUNX4
	Zxm
X-Received: by 2002:a05:600c:34c6:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a85e7c80amr105322175e9.8.1777644003492;
        Fri, 01 May 2026 07:00:03 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm4823539f8f.33.2026.05.01.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:00:02 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 3/3] spi: imx: Propagate prepare_transfer() error from spi_imx_setupxfer()
Date: Fri,  1 May 2026 13:59:51 +0000
Message-Id: <20260501135951.2416527-4-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260501135951.2416527-1-john.madieu@gmail.com>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_imx_setupxfer() calls the per-variant prepare_transfer()
callback and returns 0 unconditionally:

	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);

	return 0;

mx51_ecspi_prepare_transfer() can return -EINVAL when the requested
word_delay does not fit in MX51_ECSPI_PERIOD_MASK. The error is
detected after a partial set of register writes (CTRL: BL, clkdiv,
SMC), so the controller is left in a partially-configured state and
the transfer is then submitted as if setup succeeded.

Propagate the return value. The other variants' prepare_transfer
callbacks all return 0, so this is a no-op for them.

Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4e3dbd01d619..480d1e8b281f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1382,9 +1382,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->target_burst = t->len;
 	}
 
-	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
-
-	return 0;
+	return spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
 }
 
 static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
-- 
2.25.1

