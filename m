Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803114;
	b=XCEroEsZGXtN3tHvCdckoYGEYXyNcKsR9SAtLEMMFyZVlu+ZkQ5J5qApy3fTPbNXWqsT
	 JWmx5PH6b7jrLFSopUJC2UKzey1rcDyEtkQJ6DViEmD6rmKA2q/bKK4hIvdcG4JE9jzPV
	 ML5k12qIqptJIuGqi/p6255b4f+8taqOE6x7I8nRAis5UBB3b8MXbtr8jh6ZsJFWMszMM
	 Mz5kd2zU7HbgToY2IZcBp8LyVv0NZhk3/9yiBZf54nhKIsdvLplA398kgDFh1ZRMIyWyV
	 4DbgN9Rw41EoaUAL56UWrRBcpVPTq90D4TfXE6PQma31Aqn3w2Ce+RFKV17cwIG6GAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
	b=FD7fAxr5plPoBPZaSKgeY/30D2hiNJ+xv8Fk1zPiec3s5A3Ii/+rXbHlkw32RRO3TxVY
	 mES6Wl5TEeNe1awcAptpjbNqve34IgVzwXqVZ8N0rNixTtQ18YK1RB76hfqjxm+uEHSsI
	 z7fWc1CZZedrTxy+wXNmsbEPSTKt8QDkJTPoR1gnvvIG7gL8OsCR0KnkcZ4SnWhQGZZQz
	 awGc5SO10E7nom4q8QQHrWo05K7OZ0EN4C82rw192SFuugX79xW8gE1CiakEeDC3XQjsf
	 LK1h4HruKu0Jsa+sU+OdWXHz32hT2YP+WPSvB7ACFVdK9b5PnGHQH323QxN0tUDcuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0501606A338
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0501606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd76b1361dso7696935ad.1
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803113; x=1793407913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=F71mQzNN9Df6I/It3i/2orNrHXqbcP1PQC4xWxfUZUv03/GeKMX0+yP6pW/QSoi4Ii
         ptvSZ1Z31lTqIvQT+c2UUZ4XLuqeRYPIgHONPoesz2XCjoScHRojFWbuVAMtryozroII
         lptbybUDhb+BfNrIIQ8CLpLhFa5OgZPmiEOrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803113; x=1793407913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=jA1DsyedOfRmzTYMNbBdRVXXPDdSrmhsPiOSvP5wDzcbqpK4ENom1T5ny6RplFj+XN
         aCFoTU6ohmSDmGXMdJyqatxguzWHrUfRBPvDBhsjXoxkFVraLi46iwWSlGdawFsDhtsA
         olgkY9i/nq4b9sMlvalrOPSsE3I7B5ywe6mzeHiCbqzntCDAOlqwhnAelTD8jdQw/dR3
         XcqtqFxI8hW/tkwW40AvDt7tg9ZtFLLw4PapmNBeY0Z5QTeHrMY+5C/aSQw73379nR+S
         y8K0hM+mCSplV3nMpCAMglMshA4hx4CJ+wqS1uONfzy6/KjWyVn0Ko+y0femw6HP+Xi7
         rosA==
X-Forwarded-Encrypted: i=1; AKwUvBzX65S9N9ywc8o4GN8Ll4pnAj2QweEoTE1cv3YPvLg+RBNEzUVohiwvHSXueF0IcfyUHEr4IurJf90=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr0cB7s95qXTbT6kbz0PQa0lNtAZM+OcOK/IjMuxhm8XvxbkyU
	6BDV0BMD5dSvRZl7fvO8TbWJr+E3HZRUEgrPh+vYW3nqTqv0o7AMg/7WrQblKmRYQA==
X-Gm-Gg: AYBFou1qFXRbGcGSLxVD2zNAAT8kKqLqAY2pIAJlFxpYs3Jc8oRY1p7T17cC9B3nsvI
	0B+PplHe7K7Z+FqXnLR+UTrfwDth7mnsIkpCpBzq5Wwz0eNLH1gdcg/KLGG0Y82vJQcmI1OJPbu
	qZDu+r+L2feTFcui5P5YiEabuUe++C2s8zen7Zq7O1k15VcM0XfuHW9tBWt5uMsOV0jEEEeoqJr
	4PBAZ9F8GP8Za/teabyKCfiioNGnOcFO45pNlmocwj2kA4mH4I1Tx+NhlJ5Kin3udaFB6Z1avR+
	kYt+WU1HsK168vdrckOwUTtNKTbKFUZ1JM3mJ8qTBH2tmhU920F9HuLUlje0jqTRrkJCy78GGpA
	s8tUdd2usgM8T3vdPY6KYOte7UonlADHUvl0cNAw6Qgd21Vtw4rxcNQoyyN9nUHcRY/VAH6w6Y1
	a7kFTDhZo19b3kt6zJ+AMuhqBiZege7WBMvgrEpS/4dHYXh9QnmbK0zpkcxinjkd9r/xIxU7exm
	n2U/Bj60EeyoHt0RGieeRRAEqOUdpgx5yOM7aIHwjxrLxEF+G8vA9KRR45A5m+IMkv239YK8Sj+
	FfoTW+UHKHo3M/df+fQZtIis9f5Ax417WMZ+DMwY7eAOc7KNnBNAds1zKwSjpZR2+uWOoqehCm7
	29Z1o/WBl
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr812341a91.1.1792803113127;
        Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:36 +0000
Subject: [PATCH v7 02/11] HID: Add BUS_SPI support and define
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
Message-Id: <20261024-send-upstream-v7-2-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=yw607yxfhlGqzMQvUei0spNkHE3rjdhJJTsFkZ74pk4=;
 b=KYERMVr2ZOi6iWqsiLz616NCWFhyAhngzW+obBzlRREHTXw7r+si9gzT5hauuQa2QoLoisRF4
 r+kaho6ZY6bB466JTmNpULLdgLk/5/3ojuz9VXHF+5kjPJhrFfcp5yo
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
2.56.0.257.gf7497c7d27-goog

