Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A03D5648
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154274; cv=none; b=sfXVqNEroSapiggJqiIrqjGPMZGyYtNCE3uPokZtNQulqhG0SB8V6va0KFbcLhbIWUkLUmXvOLQwLeAxz01bhppvokmVJZQ9xyNU0l7Wx65sgeFTRrtcbW32NW4CHrVUjUMhzQe7FgygYdfNqAak35sQXzjWr8nkwxcHWfykRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154274; c=relaxed/simple;
	bh=jog5MXQybWdXqzVnDLuVVb/skFCi0MzNrRevHYB5vSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYFsxAaEgU/WDwMpMVMk1vrL96lG5jb+nmFoaCmT5H8LuKN9tQM6VqZY8jru5+moKFfrfzOLsxgfQgB1YjAYwhXOmcDc6nW6OhICEWw0IeyFj5h3/bGrGExjBJoPthkoU4A54PKBPl5Oziyh1bc9IHiZ6NfkO8wq3AGPtMQQcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo1AA0R4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo1AA0R4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493ba701891so21143425e9.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154266; x=1784759066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ta8FA5VKvlFsiauvuV52bLsb+4AF4pGxGi5+gcMb8JI=;
        b=eo1AA0R4DvmdisXvNnUT8KvodHyCO444NY1ufRbDbemKFdDc+XmTqCKCMEbmc1rHuQ
         zJ/xhi2x3nIF2ixAIpvY30Lemc3bu96E94aXu4GnhMHr3RH9R0k8vFvr3XcGlOq62wsW
         fWUBiB6ItSYrDG+prveLJdn1CysRobSLnrmWpZ8eiy80Dlfjn+ZxUrmpp0eZZUbzXYlo
         bWiuA2+VFBw/fVolXJiAUYyeyqviVs0QSWXfBIHhUs+9dyOayCyuoSMq/qDjynMzY6Da
         U5jMT7IwhJr6ci0ef6U1jNw/hp9L+zDcRWSa1CdWIupcR4IZI1KTBbh2art31dZzF+ll
         uIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154266; x=1784759066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ta8FA5VKvlFsiauvuV52bLsb+4AF4pGxGi5+gcMb8JI=;
        b=j9LzqbpdvAY7lI4JF3jMnddiXap/spd2D8KBATuuBPBc+Uvb95NF3d6D5Sduhlqjaq
         6DnGlRl1GevrYkbw0TgfTeh+zO7NzPH9by1oC+s0XhfbifoQDQN74KSZdDvlk+HRM2Jq
         rmKVaPuK0vl1IWu1EmMwAY2vvqfv5IwPK9q/v55Q9cVgE3Yqut0OGRVEhl2XdWxY0rJt
         kR0htQe3GaoRtARIBe/DtGdZ+x8da11aKKd0ud8W/LBgjRr4mwIL7sFXO0V6hMGcunKY
         56YmGN9FvK5pWfOSFyqt4tS0mUk/ePm3PBTBduTABrOU7FyT9ccki49IQb1NNclda2Qx
         0+fA==
X-Forwarded-Encrypted: i=1; AHgh+RrCYCgTOzxqRIniXbXd0aQeFms2T5ou/xYxHVqH6Bo2XiUHjCN1HK9akWwHbkxyzKQ1PzOp674w9tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3KJ2VkkB53YFYBMgi8uEo2H1MIzhYoc0ahe8nzJNZnh9mIaw
	SFMGFz9F/PpNOBlUKr3BZRqSZV2qqSr+zS5qChatVPeDp8e0gn/Ct26x
X-Gm-Gg: AfdE7ckrAFnckgX9nJlI8BHYEttnTTjd8dcHC7lQsgJA8QpPxow8+CDYMpqMluEjHOK
	ZJ6fEosw2h2d2uWstQl+dQmfdAxRBn+8edT+hmcn3jN/NjCGsKRqbxdejBbXsrlKGVB3A/wYKf7
	sjW2PNsygw0oMFSYfZKnEGKM3ka8yQvzWVdaklWpcNIz8x6NGstcE7Svh/oaLUQRRjnZ9CYC1eq
	Ox+Cs4gMFH+ubzxsCjOAWQlg/UKyZT2eRDmvudD77XasZpC5ElqhbtTbHT+w7oZ0jxkCw7uauv/
	RzsiBYxXLCWEb9bQvF1RRoXMLrAI82rWizQQ4QkcBVlREgH+SwgPlB571ybZrbcDfB02vMnxaFX
	nXXITqf/GOK0+RQtSTF+/Gvl7mxmAqVQAT0j47X2dWizvOxI/9Cr30WUzVCOWzFqUIsrQXPXjof
	OCyOWFMFdIcbWEpkjikxAgXmAzKgevoNYoSp6/rxZYx0EnwlgWXbHLtPm6eLt+dmWo/KlASBwDO
	eWUCj53twQrmuHQ
X-Received: by 2002:a05:600c:674a:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-493f87d8bf5mr199394305e9.3.1784154266138;
        Wed, 15 Jul 2026 15:24:26 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:25 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6/7] spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
Date: Wed, 15 Jul 2026 23:24:16 +0100
Message-ID: <20260715222417.2997712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable and configure the runtime PM autosuspend infrastructure during
the controller probe sequence to safeguard chunked flash operations.

The underlying hardware controller handles memory-mapped page programming
by dividing data transfers into an automated sequence of consecutive
64-byte chunks. To prevent the power management framework from
aggressively gating the interface between these individual chunk frames
or during immediate out-of-band status checks, an explicit 200ms delay
window is required.

Configure this temporal cushion using pm_runtime_set_autosuspend_delay()
and pm_runtime_use_autosuspend() at probe time, ensuring proper cleanup
via pm_runtime_dont_use_autosuspend() in error and driver removal
pathways. This guarantees interface continuity across the full lifecycle
of a multi-chunk write operation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index b63c7856e758..9a740342d0f7 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -161,6 +161,8 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = parent->of_node;
 
+	pm_runtime_set_autosuspend_delay(rpc->dev, 200);
+	pm_runtime_use_autosuspend(rpc->dev);
 	pm_runtime_enable(rpc->dev);
 
 	ctlr->num_chipselect = 1;
@@ -183,6 +185,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	return 0;
 
 out_disable_rpm:
+	pm_runtime_dont_use_autosuspend(rpc->dev);
 	pm_runtime_disable(rpc->dev);
 	return error;
 }
@@ -193,6 +196,7 @@ static void rpcif_spi_remove(struct platform_device *pdev)
 	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
 
 	spi_unregister_controller(ctlr);
+	pm_runtime_dont_use_autosuspend(rpc->dev);
 	pm_runtime_disable(rpc->dev);
 }
 
-- 
2.54.0

