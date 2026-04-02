Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918E31E834
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095184; cv=none; b=RcmB7p1DlqKM3xjDgtXZNSC6akPwiDipCDB8BlnLYALigG+TSVdfK5G7/zLn6diAg53NCpDudPShFl6jlRHbAdjwxW37HuF6zyLOIww2NZbdzcTvyNguw4cYPJ5yP2hInq+wVUhoMLb5Gg2GqE/tOQ5YeVHnd4HHZHYNaA/tlyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095184; c=relaxed/simple;
	bh=Tpi0yK/iaLtS44lW6KsA/vacKkKe39WvD034jzj5Q1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr/4bFYSbF3tlq2Fc3sq/VpSKW73BeVoFMG9i79u5jtcodbB9oUwyElAQDs78K8b2JBViFgzDg6ThiA4KHkyFre6LPO2Xo4rdqjwsIUT/R6Jdk5gkfxrOT95YTs3qY6o3okp427J1IdRJN1p4oydi4K9ItvGxhMZWWdNCvoZKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9wyNuW/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9wyNuW/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab46931cf1so10497485ad.0
        for <linux-spi@vger.kernel.org>; Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=l9wyNuW/X8GoaB8VBjCO8tdBYvh9Vd24nXum3SRwu6fQJxDlm/CtMGE4ey/u9w4gC2
         lyhdGhqTpfrcZDtYcsz0v2C/zRcmt+KuCg3lOlEuMN+KSh1jnbq9M/JTPr89FuhnHFvP
         +ndaRXJ/LQIDNlyR1IsjvnKRHp8RLbNI1ahoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=g/Y+rY755pOtEazLsvq3Yg6cbolTH4F8mkxSxUNUhVtYFEN0KQk/4MKgoNgzcQau2X
         S3aUY2hIjIw6bQXIqsR77qFZIc773K5LFpcemmw5n1VjsirR4eQSL5oOEEeGgDLs7gM6
         qQh0A9Yb4/S6Xly98vx4mQdz3tbayp31ZDclt+KJ+EPZYF0xtmrf18R3Iwh6oMQWeDfR
         RRRCgVozwrKMy/22guH98Daf8ogZy4e8aHB5tW5r2j61wsoMi3VX0rHJEPG55BJHVJPD
         NHmeC1hnv8+lYf1Ca30n1OiMqLi5OMt+qzZmcJZ1BwRxS0wiW4jaEPHWPxc3CTyMItIB
         SXbA==
X-Forwarded-Encrypted: i=1; AJvYcCWWdbv4OKOI878t2fOxIA6X5vw0lbCLv37tyrXJpvWqkyJafXyCxomrDu+ZCzLfZctjSa1qSTmtllc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwZJ83Lmi0FvdlOLPgy5aDqYwEXiHXvkp5KZv0GGPxPadhO6q
	Ax0maX4CYq4LoSmnjpDVES1Z5EU5iYnnMfP0cPDyX64ciRZI0RvrKCopX/WOwXCusw==
X-Gm-Gg: ATEYQzxPA/4JKimr+14l1b3hHHWl45JM0uVI+e8GvbXJbsCIfMhyyKc8/TE1XC4CH5N
	vakrNrKHjAH91wJUbK7q6p4d4BsOZx4s2iaOLy4EhoDUO2kB9HdNp3Tk2WeLRn8miO6WtQDE9LE
	TfUESLfbXZACH5mLhS1tJ33vbg8/1iO48/ohifYcmtjvVM+vLwA1D6UjL6DaHG+Q+BuhmSqW1/m
	5URG+W/qhTsfed0JSzZgyKvb5YpxY0Px+2Bc79fNJzfoDNr6BPVLNGaCBmtgi6c7BXatVT4ahdn
	FY/GpNgTE9JxGHBf+xYqhjEax57BbdJtkScyG2ASo3Iq9+DNE1qc8N1s1DMsKLwGvPUnFrf1Bgz
	+6NrBAdHfTmqVofUicR3XbzHp6YEfdor7kFg7hFaOueTapiE0OZ7OADzr65fJBWh0kffYQSqrlM
	h+90IjxoSMWSLTWvliwpe2nWeeK/uB/3FxdTVLLjqjlMACGU5TWZxs9Ayw/zY6yprnWgbNjaEyO
	fOSUUrcnLhaIoXBGUiVR+0rycKdReaDig==
X-Received: by 2002:a17:903:946:b0:2b2:5293:f415 with SMTP id d9443c01a7336-2b277d8ba21mr5711705ad.7.1775095182367;
        Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:39 +0000
Subject: [PATCH v3 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-2-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1402;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=FjzRhH7/ErE4TnsMI+7AvjihWBkT/xpCI98HMGNLH6s=;
 b=u4Lc+txBMvZJgNMm1YnjIU7DFBygkIoEJquBuEPB6zFCxqo5mXw0HAIQJAzTByC+gO06+zlwJ
 t0bqPyaLh0nD1I0sai05bo1y2ot0KK93bqPfmYAxaNKepG3FQdXBoLt
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
2.53.0.1185.g05d4b7b318-goog

