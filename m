Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519749E5C4
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584802; cv=none; b=Ymifvr75aj7e93X0Pew0gtjomegjJRtR5W6Qq6bhXnBiLaEqarhdPFj/9ZyadXZppxnTmLw3s0G2aIq8ZpAghennXznijRmS+v6nwrn/wWBC7L2nd+WJJgS+5IeJhqHLL4+dJq1mQzYaC5919TdyTPkRiCGxQkDgcNJs22YzqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584802; c=relaxed/simple;
	bh=KuiQ3IKUB2w9nXq1YX3MmqHIvFA2tKtv5n9Cp1iq7qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIWpbtI6jeq5t9E+GyUTO8qNrtkIX9/evpotzAZYNl7B2wXKrZkQV8qt34IWIWDKTNmJFkrVrWYUdvAwE/sfxuWD1GPti3oK0rTW3P8DLcJr//Ef5UpafYGv47t+41A0dr288eHXvjeYsMcV9rGvAdhu3TV65LqOfNLLQn51m4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H1/cKE/2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1/cKE/2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso975685ad.3
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584799; x=1792189599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5eNaZ9lIvV3v/dwCQY0Acm5f+QB1YMzWWisiwjAWsk=;
        b=H1/cKE/2FGv/Bv8WHfilld0NlAKTUL095Vr6Y3cWSGhph1i5ZT9b20vqmABEF5M5bR
         OcJjWgxNUPmDQyhfiADI9ws6xEhUr+GXFDG9HwCgzUgNNIhqqScYH14LXI9RWqSFINQR
         gXUARLZMgkUWyBdluml5zL1S0EIejjvAMiEfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584799; x=1792189599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5eNaZ9lIvV3v/dwCQY0Acm5f+QB1YMzWWisiwjAWsk=;
        b=KuLzGrKW2WR8F3uSylfNgWNKBAI7dlsW5aW+faeX6o+JBdURyeDkYezV6pm2X6s652
         HyP7GwJRn2rhjrzqU9ZzsiqYlSxRlj4Abr8KleXJlBSkqFnRq8ji3RNrzrSKDbl972M6
         DmuAmgYYpbKrcNm/p+PzABRE7vZr4r3xcQYtOpt0DI2vI168L7ZFLgKDmb6DbzBXKw9C
         9TlfT6+sw7tbeqssC4bWU5LfjtYOX3QR/4bH2E/9zdkZ2M4/CBEbKldf5WaPafFKKkUW
         5ujTxGyqSitchkGCvIJxBup9F89aJU17rNlq8HVwbLQPaw3Sdwo9bBCDM0GjaSen0g44
         seTA==
X-Forwarded-Encrypted: i=1; AKwUvBxXA+LW5gtESGucDV4mU0Is+dPiQ24yuPSxmwHbObmL0GQDRd7/ieS2MXLY1P72VoAr3cYaGoZ5sR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2mc+PJVeJXE2sDSjCzDqeC63jn98/aVdo7EOemxQ+KNBJ/qCw
	QLpqr8ZxUhDHWZYrhJG7iQGr98v1reA/OrMdVpUAeiJjRO6vpLBHsfeSFFwzs1KObA==
X-Gm-Gg: AYBFou20Y2pb44XckrvL9+LTPk924JorkVT8WV2knC2xYol1qgU9vrJI87YWpx4X3lN
	GLV2st4fJU7XXCyK8YoQTq8Ke8UV9xoaekw+2Y9ejtbi/HHzSlkLm1FiybOAZpqetk3xQ3RM4xU
	cF7eCIOvFnHV4kBWKKO2PezdnVw1VdMgGLq//N7FxeSm73L1alva9JG+IwupT9PKQMH40nyxzpx
	S3oPvP/F6wXuoSorfJ6nPmi318Pgivy4cw/kRazE+yU3p/pJyvWq6kVdTqmvUx0IgRTN2XAbw4n
	wuKrz5Utu5vcdpURwErKYOHfVE9IAY4bjI2fQv0Ua8w77CkSi+Je8SwvQBR6SKNDyAqzosyaAn+
	oUqw6WbI7GOfBb7EUquKKas00Xu4Mszacjl4Oe2ulCUJoQUU/05Lh4lYbiM7ndVr1Yq77blMtdK
	czsIc+mDG8B7QtYnvYgyn1ySb6vH8AgJtNXRw2wvfNszfGTZIP29HChYt++8k4vIR4/ISLvK8hs
	JU9T3w84khBk4RIf+qiuWM08gnRTTQNpv90+j2Oj8zEVBgNGgtPBc2dG8R1nqMMyQSkElJLdf2y
	gQ==
X-Received: by 2002:a17:903:11cf:b0:2df:8aea:7d99 with SMTP id d9443c01a7336-2e842bc8073mr26181935ad.59.1791584799610;
        Fri, 09 Oct 2026 15:26:39 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:39 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:27 +0000
Subject: [PATCH v5 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-2-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=K9qWpa5CElybzpEomRWCeuxEJVuPby2HN/39jIN2wOY=;
 b=DAEBq1NSgXCcSRGDgv7mTSvfFXvZQUxWlGT7XyleRhM2NYQY9lknT//0P6rdifesIsq82ZxJy
 juVP+wOX5jeBzOvl9RenjkrrlGZi02gGUzA4gQiUAcSPO6BQhaniy5p
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
2.56.0.385.gd3acb90ef8-goog

