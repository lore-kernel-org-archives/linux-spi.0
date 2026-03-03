Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA5373BFE
	for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518428; cv=none; b=Ww6p6V3fJBWTYMWr3u9TUJTgcVnpS4JQmHH3jLntiCBq/0OutpTVie/fpKUDbrFr+dJWi0Y+dRL3c9USvOJJip5Dj34rdrqy3W9+g1Qug0khE0JMcinq0Xq4oIIJmdplMSpzJ5s2ACRtvFwe/kRTLs1eAZQGHT6+g1wyXuuSrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518428; c=relaxed/simple;
	bh=G66u8aauHLh3hv8Ltv8yWkfXW+pytZrpTmIScPLSZyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Znihp1VNkq03a0j+W/cxHlZY8TCK8ww9r510Y8ryfU9nZyrp3VNoELM8q4fC23QcedCZhnmZTnutarbaKF5k2/K6HZfRrILl0SsHNJVVFT37ApoEyva8dqmSFTPXNu+VeFsCT+EUdToPeswwFKEk9VlenrWL8eRcE23dT29xoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YB5gyq+9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YB5gyq+9"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e3e4e7388so2086196a12.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 22:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518426; x=1773123226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBLRd0VVPT6JgeA/gmRFgTBh/C6/jiLo21KLSX9AmXs=;
        b=YB5gyq+9Jx/lm59QV8g/z0+2iozkEQnGdc/kAIsB9JpJTq7as0CQs9EhfBvcGCpD+f
         kTsyDpnRDmBrpTZ2uNx4PYMfFz4jLPCFTlgIe22H0kFOhIaoMzn8fS7Yht3rXY+Km7Ow
         uI8hKu6C18NFhyzz69Q88leyNI4L9GPnKdSUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518426; x=1773123226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBLRd0VVPT6JgeA/gmRFgTBh/C6/jiLo21KLSX9AmXs=;
        b=F8/FpZ7VzNHuM5PtLpm6vxrz/XGndVTk3LuTj6gCzIlDPtKntE0WVXbWmnEpJ6NqKq
         yJutz403RVChZyM4yX+4xozsxgttlB9qOJ8UMEBHHuNnSnvO0Z2RDlt8DHseIV53vqpH
         CVh0o+bPKThlxyI0tvtOnTivQgPhABdFwyG4+vVpqd8hAknFZh7zLBwqb/8jJqbYFshd
         zl8Fpth1lez9nxFNDOP3plAalRrON1cfTKJKa0F7MCrjwsziaZ6PwYh5PwCqjmU3H08l
         2+rf0WgyRRh1qz5DxUCRIEGnvlNT2KWS1dy71/ksHEtGxenomSTap7pzZqJSzjxwAOsX
         i47A==
X-Forwarded-Encrypted: i=1; AJvYcCXWnAfgCnpp3rJgFFG08uHd2+zWeFLf2XTEk9RMKvL6uUPdhesc5nngJ7w5wbQXvr2cfCnGMRTUy1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHpeX9S/Lm90J5IA6Y5p70ss574mhjSJy35Ysa6sIUnQMceKW
	FwbqFgaa14SwOHGkMH5acI8BlS+U5478KPQti2gTF3hNcrxueBiGCyq03fHI+tfp0Q==
X-Gm-Gg: ATEYQzwVZkprwSBX/2mzuwWUCgfrkRSC1uIfVK8ai6e+Sm0BL7dgECKFo8S0JG0e45m
	CQk6x1/nt6NPpJwVf6IGKNasgpGQZJ5sUczu/deKFzpQ0UDofoGzYqQHuUjPKzuxFaciUtuR1dl
	iQToPFuwPdUQRmofnWip0q6s1M/cFWKzHW9nzq9GjR85ZgCWmnvqYPsKemudIu6Lcs7tJ8ER6PL
	YKA4EWJyGLCMznjk6RLk5fapMfIL20gAoOWf495BdWnHZ6s7NsoMnssXlXCElwt7+8t6uXBCSfM
	LutgSMSCgqekZuvgOW2PpB2KWXRrdleaggeFvYAyvXzg/j6VigDS1OstERkYoEt+moneauAgqWU
	WPoZGKOD+e+3eUppAQPuK6g3IvP8Jc/sUJFy8AR2qsbK+9uCu4rYpxkRgQd2uaERS3FvK1k05tw
	WvVMZ8yns1DNzJ8LL5gPmYb1xjcvjbSvNaTp3Se952Eegx1I2o+WP5G9q1PdOXYXGTFzFwLQxWV
	p4IsCuNXEolX5Fe+dJZ+9yraLzDdDztQQ==
X-Received: by 2002:a17:902:f70f:b0:2ae:506e:4711 with SMTP id d9443c01a7336-2ae506e4abcmr61194795ad.31.1772518426248;
        Mon, 02 Mar 2026 22:13:46 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:45 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:12:53 +0000
Subject: [PATCH 01/12] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=1154;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Ko4HAge31pJ3y5sK3I4VHU62kcrFbomkgScSw+0vFnc=;
 b=i1wJDOCOTKohS8sUVAT9KTdbS7usX9DiYzDm8pdpDiH1LnyATV9bgGB6dBKN6tIy1Yav+kyUU
 1E/czgHhZrsC9IXUbBdK9LOimEy3qzdp6R0G3SqQS+y4oZSRJt3mGxQ
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.53.0.473.g4a7958ca14-goog

