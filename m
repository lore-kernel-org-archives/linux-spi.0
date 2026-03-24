Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9C3C5541
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334409; cv=none; b=ntIBD6r73ayccXgTl53xEcrd01bYrB+g1XtPZKWtGs9ZdESn4LSmtM9zZ9tgLZsoxPTna/xTPBvNgKCgMqwXs3lYUCEqr8OSQGX8JPFHHleYkoSi9M3ln35OewRPLdPNrMAWSRK23xmhC/UEugtWCMZY5mufDqFClNARmRPRFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334409; c=relaxed/simple;
	bh=qznTTsH95JMiWz2KpE1aJItnwW6ycamhHq8hzhCMPB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFihndDBN48c/LZrU3+OsWsPAT3vdWuAymh6v13sVX8Age8gtps9AjsRlaXqi258qQIJv6rolQ9zh52MNmqbfaqTY3wPcSwBO9RZBrcO+8va2DXjsoMZv7K/mrFzpQr38TbYDjl5mdo1fTjPULaJAtGqqcyXSQll0qUnXOl1ERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9aYIaU5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9aYIaU5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad9516a653so4543845ad.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334404; x=1774939204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=f9aYIaU5D8+n175pz0sVt1dDRcFNP3LrPfin9laH7FEGhusp3Jum5kWNRAryiFQSA2
         ASiCLsCmAb7iuq404pHLcbvo4pcOuGVJJFXChFM8+VOONN16R6/8feAvlAiqj1d/doT3
         q2K3lltJ27gylknDg9m+qxUjhX10d7KONwdtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334404; x=1774939204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=L3faypKgNKta8+0rUs1wIMY0a5OUnObjhneqgkCzpgZ7jNT+0c3d74Vla3hFnRfsjx
         x6dlYX285Agd+m83JRvn9VeqXzxYrEhS8Gupfy2tFim9zGrLo2+eoN2VB5N1YjEnvmMR
         urZtTtPWXUkFOHgGrvsZ1bXUR9a3KmPSrHzWy++fJhCcqO3+mixZbXKz/CCOidAJb4Kn
         ujomNE0G+LE65H//zEJaSc5J4FJch7p5OCJkNueFchkoCA3tLp6WBu9dF5unJei619o/
         HYa8PIW6kP+Ip9aKYls94IlgfU6YlV+NcllQcBSLBMoS8xvC9/QehWeCPCP7rAbfubkt
         IfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdCtqAXyChXV5hbvnh9/Dxr209vOiMaHE04NdeWlIsnMLgL722cJVLFGhg/CVRPzvzhCuh6f+z4uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cGHSJuERQ/UtRaNsWnUHPPt+Xce7FaESa1SunhXhIMFUl9xx
	Ycp5lPoKuqTbcW3EDbDE68noV6fY7LyRSyTga4xAQagozg3T8ZaguM91aN+NL5dk3w==
X-Gm-Gg: ATEYQzw4unx/qN/O3xDLq6CD0t72MVedm9m/nFXZnQKSArI64RUamVCrNdR1gCgnJNR
	9/5/MICpyB4rEBIHCEyztAhvEE0qs1GbiF5eA/St77wO5/+crpJX47c6WVemQtFoTYhKgcbVoeb
	unsorE8gtQn4CtQZYrq9jPzmvRHpe2N8L32Vx9i7fdQnipMwKVzgpUV5PyhcpZK5SeMMpHzS0fI
	KeVk04vf44YdiTm8oE0Ob7QjwOoSC3XDW2A3ep/l8FpAE19XjYA6GVMmDNg8EgTzCXrw3/9fLhR
	oM6QGyWzS48BdLaXzoThcNXtMSSIB6b8hKPC1/fI/gcgOJDtafkJ9jqtKWs6/3baSlyk3akUvPU
	LQT0mh8RHqxxKgHgDsuTQ+RrXnVHWduIRt1s164IfgR7rQvzaV/mY+rAWTPKXvyJNFeSyEXIwit
	9RkzRwiWiFVn8u02V2WOAlRd6ClYO2xS2iQJS+KXLGgNroBJewEnlIXEB1Jqt9jht6pz8MF/6TB
	WRDCGBW2MQmdB93kFivH/mGVBzRK9esTw==
X-Received: by 2002:a17:903:94e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b0826e2f0emr127644455ad.12.1774334403691;
        Mon, 23 Mar 2026 23:40:03 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:02 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:35 +0000
Subject: [PATCH v2 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-2-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=1401;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=uFPHOo5tVahmnQsO+3HulhbmLaF0uQlDRKXTc/zQ45Y=;
 b=FzRz6hRBlzD7ymlf0UgsS6IIaaR2bkVOGVToLSaLqiBXlBFUdjUt7+8GdOcAKeSszYW95MDk7
 /3ijkLg5nuzBKxgO95bX3yQFQEwML0ujPgq48j85CrKspcQ4tbxqT5x
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..813c9c743ccd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2316,6 +2316,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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
index dce862cafbbd..957f322a0ebd 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -786,6 +786,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.53.0.983.g0bb29b3bc5-goog

