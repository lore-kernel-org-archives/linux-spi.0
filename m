Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436493;
	b=mIA8JbelT58Ks61i8kaKeLNTgF6DxPYYygYMpvedEFdr1nNb6WAhVl/W0sGzDWhu8VND
	 uEdDYltSURQf5JgFROqjIIGLVKLU7Qk1thBCBa3ETYSCg1tQ1Z21R7zxqOeAG21cAV1IM
	 0CI0dLnQin3OOwLbydE9qXXz5jxGJFX6mWLw8hUkRJLnZodkv8qIIMQJy9+983B/iRNfH
	 prfsxtt4MB3TOF80atBNIaLbqzch1Q4ZDdpmVP0I6CE/TafnSABaEOkiKZBgExAhNvwEI
	 CpIYwM1u706X5H+s8eq+9xC2uAUzCML2QeFFL1AeviOur/g0SxGXDZaSUirLgLR6JTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
	b=WAX+l2xXiHIS+4X6MeBzaJA2pWyDH/FNIovYu4hhxrUkCa7pXbMfmQIzL05PWk6EHYfh
	 2CoJXrf0ZKu3WDmtNlm4Z69fh9NdCLwWYrpvbYI/+l4ds0nEnOc88UpAvQ5MNMPH+8KEF
	 g8fovMpenw0+Kc6Hs/6gXAr8bJrSIY8OLU8Ix+0J1yslkJEm4A9XFz6v9/CybGVotKQ+p
	 f+txpCV0dL8Rjw01FZ8T7+SnJtG7LkIYGvpHlrFVca+2ozNycxy2QHgOOgwQNWDXzdeg/
	 6/yUSnws9Y92mCcJb1zgFxQYTUt/lLAJFXrAGg4yiEb9pH6/Vw28imwXIAqsXMsRL0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68588606A335
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68588606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e946155442so19769915ad.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436493; x=1793041293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=BQq+KE8xOXbY/uqMBJRUuuiRWixMIYgasL2Q6oCe08KuYbbGLBcRh24ixnfWFYSdS+
         dCiH4G1K7vTp7FQiasyc/3m9GP5veIG+hi/bMw6XJT9kgi/wSJmKm372tZ0JKJdfCLaH
         7FoNQeI1qbJzVaYfIhpmC+tqgs9LZRyoUr7go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436493; x=1793041293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=HlWsiNdJpbllBGCfdN4S7YeXSb5tGx//Z4NBRUkYv4f7rktNradRCEHhrp0CoWso7a
         j8Lqov/mq76WjZaejDMxj5xieSKv8uSa9l9IBPY4D8tdqyYFtkjnd+QwEgnjNJVD6bc0
         D3mK4/bU0tVDzockhq5a4UsmI9bi7dhUuKrs0o9GRM2WxbiYe5Vvr7/W6LHM/MvwPDka
         QVbB4+39LFn7trnCp+BwHE9GucA7+X/1CtTUO5UdEB7h50RVlRg6UweUC4FfhjU0RbWV
         imOEfyEDGAKXJk1VyxKoOfw9cbuDRB8UAEklhf7UrtGXuVhD/NzIWpoEVPnJvEyulOD4
         EAwA==
X-Forwarded-Encrypted: i=1; AKwUvBwDTl9vVq3liPcZS6n+8Htmqc/A6yMiemAQtqKmOLdSe0ANHixIBtR5uso/LDacx4SYeCa/PnEw1oA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGNXEJZ+Jb6fwWWu72kbonF+WxDXXnLff07c4qTDlH/iha0fII
	nBJcnEof4yTQeqC/vf0trGtjGOQkKppDKXyNAsMqh1Cv5Bfqgll1/wFvSjZzRSk6aQ==
X-Gm-Gg: AYBFou1H0s4i9UDzO73NZj2ZNGvwjHGY1c+FDnCIMBkJAVAg6+U/9EjHOPDn+cghEpk
	S2vUoB6pecoEUXC+wSP2E+uWGlZpT6UkLYEPBncNnKLL7HsKG5jW4F1wpjUd1BMBUE8b00QawPF
	zDDh2ecOwuAuOuwaYlraHaMWEuXPjxMW356PHpBqjdIfb5SwmdqdHKQaScg44bLSvHwRtSzoEPI
	n0B2ipV/5OXEcYUutbV8ZVTxX+Xxulz8cZ3pDFGL/CXHztCr84AZTm2u8ti5iWu+HdCreoq8eKn
	CrvzG2zwBIFQ3LM5v2pJ2hDR2+Je77mOpPiU2Y5hGEdyOO4y1JNvfw77TElfUwZ0vWrvko8icRn
	i7ggpBs56j+3d7zU7sVmcLlpEgSMqtHSVCI+LdThRxF6CbWFn8VmxDvh0W6KfA8GjU39d9ym9eH
	IgBmF6eNIKPPOTLdKtA/FuuV0Ihbp2cpySmvFNnKNWo2g3hTY2JqOlCpH+IPCWxvP6Cq4aV3JNq
	GeeHgbkdGWBG9bpuNL7Fyq0fPbCIlBTXHpG43AHtFYvDXBtP27MTE+9TFdqsO4DN1JcXfUCWF5+
	d8Prbw==
X-Received: by 2002:a17:903:283:b0:2df:90d4:1193 with SMTP id d9443c01a7336-2e9a704f530mr82162035ad.45.1792436491907;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:14 +0000
Subject: [PATCH v6 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-send-upstream-v6-2-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Z/2OynYTrncR3whlCD+8cLrRCycyd9G1cnZSFD18TV4=;
 b=lJc8V8Nqjo1jioaiCACjgd6Onu1pi3IF5K3H7O9O0Ysv6de+/D34pDGq9QMvDw8mebB528I80
 2kaE6ZZjzlGBGFbwmdNzil47p34PVsQJh7RrChGNGuNtij++kwe8mZX
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cd..1b9dbb7515ad 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2373,6 +2373,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_SDW:
 		bus = "SOUNDWIRE";
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..45f713fe9982 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -821,6 +821,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.56.0.212.g129ede20d9-goog

