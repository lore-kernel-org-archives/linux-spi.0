Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695635;
	b=vpgxoW+LtYkJyvevDeAjTHRWFJ/Yh/PWDTb3rtUamQ9aObMoN9K88yDRP4pKD9pTBuJ7
	 9mPWiGoiIEwAPef3jpevQEAdzgfU7u2zdqwaw5PrvOnYvrtXo26KbKU+rwNFyDAtsOEO5
	 57M6XmbZjO+GFIj7C+HMf6ExIrBGvC8rpx7wwLBqesFIhg3ia1blY00xE2cWPxE4xEtBK
	 wb0NoBxNewQWrTpWxBjWJqWXDdfGGaVdJ2pvPBdmlYMVtAUDtUQk059/TNEEA2DKZAzXt
	 0Q0TnzRGNFEZlp5hRjuimLI2/5K1ED3CQpsJYgezASYlhXY4uuTsvMZldcqIZc+g4SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aKHO6s+vDpsbcy/6pYNvSAfUraC/MEbz6EzD41uF6vs=;
	b=rJ29Q4bLLEyQ5wmyq2/qvXjHdXJuVKunlt2DWijxoopdgpTBPLAioiHyv284FvuSw1xp
	 RbY4WlQETQhPvMR0+uWPxA3YxB3lWWhi4imsGHBSv+fpVNhkzKGIo5+mYZT9F6L044ypQ
	 YV42Eu1AMG3B9dqmoU9FwMVeFJPqCeijgaI1q8dLMlFKZDLJBuu0vy1tVato1OInPquyX
	 GAbiUIb6aXGvHS0ppdzPoHfEi8JhfFfLNDwjUZlbPM7BJ0zt1BfWLr78NseWEWWkap3Ex
	 rim0bW+pM+KzFW6ITpW+IMZUUEdj7KliF1gCm5XLBg7v7Ak6D9ERCIT860Ik0au7d2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnxVS1J8;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC87606A326
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 08:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC87606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnxVS1J8
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1414793a12.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695635; x=1794300435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKHO6s+vDpsbcy/6pYNvSAfUraC/MEbz6EzD41uF6vs=;
        b=AnxVS1J80qJcvRAlxIaGjp7cDqrd1lbtGAUeTDA8+MYBkQJy0p4Rp1MtGhb7pefD+h
         1Cy6S/h4hh+dvemHj4UysWtOVHQ+P4Xz7KtZCBbqw70TkxUGylPv/EZKBMZ+RFd5lsra
         fZRz+DO507tSsxL9TsYtjTM7gDA6kJEt4oSytJM0+bOO36Mu0cKTb+UK8M3xCmhIEjSE
         7YQNKNHd6wh2wyMsmZORNyLz1UIeH5Xipg6iSvUl3NWzH4iOkaswTOyOuholg25XgtQR
         ukuVhQNWvj18SVFF2bBDrELhW6SrmWYZAioH6OtqWZdLZTSZi21dx0cbD3P73oOEYEGt
         rZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695635; x=1794300435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKHO6s+vDpsbcy/6pYNvSAfUraC/MEbz6EzD41uF6vs=;
        b=EaNAzkCBQGKP7bTN7eqLXwVrzTh9s5OQ0OxGxQiU5jJGTrIHND+DC/4tkv410mPAcb
         unBB0OQOgm6VvVHjWqJu4jxkFhbJxlRv4QVPB7V08wX8TlvRKddlGbzx92Rhv6hRCNps
         2BniCNmyGx4QBdZOKV6fXaSlcdyqDfkHXeqQL1mz3sOj1ugpb/1OpHMiWs69xxokgeQN
         bOjfvFoHnoSYwGD/Zkw28a4A5HAAtPCeCrPnTGOz+Pgn7nvaRNGMnm7ls1D9bHjvsJsG
         GZQr/JmYAPHJgUEOPsjCEr9ivxBGY4a24hfNVSyXcy2M2Wv/jq6yLgRFYoa43aDVhs/5
         gXUQ==
X-Gm-Message-State: APuU4Z+MeVZigFmBb+T08v7Dpix+USOeXHaPVaSEu9uT4tyny3PigIUR
	xsDDzLL0KlcnG162dguaek3wKEi/SXQFrOh1tQHMjY//6PfoiIvlK0Zl
X-Gm-Gg: AYBFou3CJlpNoiBBFoNMMJqEllTWDn64Pv2z09UjBdhGKYNQ1ebzjoC5o1ZCekXC6uC
	S/1mcG/2WzMopJ3I9+7PPn/FypT7NfsgpWAkQ89B4PGbNa4IQ1mivV7A2QcosxgBCSIx1BgO17H
	x7JXnNHh55ZJ4aqcMLhOaQwxVzDC5HS0If39xISEJ8MN4VfZ5sBmBmKEXgiFIW1CPzykpNqDScS
	AJuA0QM1ncmpfNcLqXdaonCMOVCkG+nQVpBVRlki1kiY2V+z4mN1+nY5IlOGaQkann1NsU5wwN3
	FbIvhdTbtcHdi10JUDK+hYKx3sZpDM/vdLPOxx110C6E4fPRKpGm1uwLXpvMcN9l6oaolEwA+Wh
	2aGh2KIMir98QcXbWl4nEG9dL/uNRilyaSja3KAkI0X8+xnFdRnxirEXg9V+QSnyAN4d8+C0kbg
	jlCnE+JiZmu6rbMJ7fjiAWUE46U3KgA0Spe1xmpvWFjY0HjfNUjompKFplRfo9G44g0zMhXzu8E
	4bSRSyRzA3hIBLop2Aa3TEe5Hg7HtReOPYyVcQFvf5XViN4vOAd4fuygrJABf35JAUflxgQpFdi
	wYmGoeXctnFepN7t9NmegsDYduin2U+8sjOqkALmNT354vIl
X-Received: by 2002:a17:90b:3e83:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3ae8973162emr10835468a91.26.1793695634691;
        Tue, 03 Nov 2026 00:47:14 -0800 (PST)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c627193sm3537031a91.6.2026.11.03.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:47:14 -0800 (PST)
From: Li Ximo <lixicaicai@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH v2] spi: pic32-sqi: guard against empty BD list in pic32_sqi_one_message()
Date: Tue,  3 Nov 2026 16:47:07 +0800
Message-Id: <20261103084707.1582675-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

list_first_entry()/list_last_entry() do not return NULL on an empty
list; they return the container_of() of the list head, i.e. a wild
pointer.

The SPI core rejects a message with no transfers, but it accepts a
transfer that has neither tx_buf nor rx_buf. For such transfers
pic32_sqi_one_transfer() iterates an empty scatterlist, queues no
buffer descriptor and still returns success, so a message made up only
of buffer-less transfers leaves sqi->bd_list_used empty. The subsequent
list_last_entry() then returns a wild pointer through which the driver
sets BD_LAST/BD_CS_DEASSERT, and list_first_entry() returns another one
whose bd_dma is programmed as the DMA base address, corrupting memory.

Bail out with -EINVAL when the BD list is empty, setting msg->status
the same way the timeout path below does. The xfer_out cleanup path
tolerates an empty list, and normal messages are unaffected.

This issue was found by static analysis.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
v1: https://lore.kernel.org/r/20261026115219.3528114-1-lixicaicai@gmail.com
v2: set msg->status on the error path as the timeout path does, and
correct the description of how the empty list is reached (the core
rejects transfer-less messages but accepts buffer-less transfers), per
Mark Brown's review.

 drivers/spi/spi-pic32-sqi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5d3921e29..ce8d60497 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -391,6 +391,17 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 		}
 	}
 
+	/*
+	 * A message whose transfers all have neither tx_buf nor rx_buf
+	 * leaves the BD list empty. Fail the message like the timeout
+	 * path does, before chaining the BDs.
+	 */
+	if (list_empty(&sqi->bd_list_used)) {
+		ret = -EINVAL;
+		msg->status = ret;
+		goto xfer_out;
+	}
+
 	/* BDs are prepared and chained. Now mark LAST_BD, CS_DEASSERT at last
 	 * element of the list.
 	 */
-- 
2.30.2
