Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B75217F33
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230894; cv=none; b=gCOUgxMI8OX5Rvc/HhZeqvEoDfZpSqXlxr87oo8yV5wl/DHznPq+OQgmRhO8vvMBuGjtW9zpfrzhbIi3KInTX23+4TwFeKXH8mG9nCxomz4tQPLVNyZXIlscv0x0RiBw/4hQbw8h3Fgy3g9kuM3WkovDGXSgPpNK4aJxpdHIGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230894; c=relaxed/simple;
	bh=08I0o88gE8cy/+U/o+AKavzx0eRFU5y0gnDfFw+/PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J00Z+80yuoKBm856V4WqaHiPQciCEPgGUh83Ovy5LasUw9+dYZQplxfTa7lbDiOYCWUCZVOgveAgt1N7qLo6MEjM5NNup39WA2NCC/YN2njzL5aJY0iCu/XIqI4MVfN6+aJCLQPapnM3aUEJLXQF0lBZ9fx2I6H+kggA3EsfLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDI0A2gm; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDI0A2gm"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4b77adso3523274c88.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230892; x=1774835692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0G/uhHXfu21xXv3gnOSiW9nh+0t2XQiNOcz2tPqgk4=;
        b=nDI0A2gmNtS5LgvEVUluvkAX/FWGS575ISd1L4zyGn3fEXrltN5j8VtfW5tCiieWY8
         41nfkoGX88hpgDBQGSDxasP1DdMXRadW7Gi3bWTbS4Yu9FV3Sktl3u50jpSLlO0rYKft
         wuvu/1zVyMnCtN4FkmZVDcRnaso/zar3v5dJ2l8besyL7/GtuN6r2q3Y34jRbJXwA1XD
         EhI1xHP0sRUhMKgdha3XVByYFwiiM8YkVuJaA9mc0VZf208/yBqed+wLu7FcbDqOMJMz
         en5Nd/G2nUaWODtuYeYkxOipEBkqfu14gl6Kt+ii6vqY2P5VoB4zSfmNLnfenZ74Kh6d
         gi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230892; x=1774835692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0G/uhHXfu21xXv3gnOSiW9nh+0t2XQiNOcz2tPqgk4=;
        b=GsjI2Kq1xDWxHyjcDPHQQzqkX/zOk0rbmlfnVaRG+jKwEiWr5k6bl3epu9pj776NWk
         c0gjNuIn5le2C/Ng8DZkcRBG4f2SKuQCnKtnHKb59KaZur0EPMXuhbcJyhxL5vjmV0FD
         pWxsq/FrUiZ5FpkO+3HrZ3yR2rKrSXBHKLPP+RRdLEb4n6lv1Hlb0GYC/Qw0ZEE4ZNrL
         U4R7hEPqpJEyJttvOM1lj9jaPE1iBBNVKUp/WMmDbhyO0J+3mQlRTP5MKoCqwZ6NTo5l
         +Bm9Eq3QcQ+5gxTyHvAcA1rW60INqvC9lzMvxXgufwzb1/NGqs7rEdp1W2yhPXeK5xsq
         oyuw==
X-Forwarded-Encrypted: i=1; AJvYcCUk3+dnV4I7ha49AY7sRiII9BtyITpUxFn5qgyt0zJQ/88iJxbNIzX0lbAKzE1VLtVQbNxlu5PLug4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIFJSyYKxS8vF6TIlAfotfS73wLpwPKuc5mUbpt3hgicWWbA6
	mfJUFbBwE6PpRhjSAHw37uQtCokxFlBtPyaO8UkD7XNc2rrqs/d2Ij2k
X-Gm-Gg: ATEYQzxmWh/0Ui3zt+RK3wbOF/c5jWQHcWGw6+HLTwNfm4PnZM6bajveVQwivZRwNMp
	jG6eW3i310NH88CmYEKSS8Dcl4h1JB0yfFsIFWlufv2o0kVTRpdhXLI4mdINz/C6B6cegPHbaao
	j0PYhM5kwAFGJI+sWy1xKMDax2od2w77mz+++Pe5PgtEKmUiVP+NWTdhujdQv5Yoh1mKO+Mepog
	yBKaEYqu5VPPNGniFgDfEGMxhmkQqLUS0ch75+3yj2q2aJcawF75cy/VYdbpHT06XlW4ztSinvN
	9IkshemRIbs86fqTknFHqufy2tmDBKn/FfEeaN4LV9SQ8k4u6ZUuOsH737zjSR9N4mv60K5+XJz
	QGYuLu6j2PpDEqAubo8KAVv+UMpwSGXjNWJSDWcVPYDQxtFW4uhCll2X64FQ6548BlS1fSXfsBU
	8MMWvM/Yn+q/WRy9GBR3RcW62geP8F2AcgYrb1F+X6MdWaA+bhMfKVp8ynTtlj4I4hX5yyKy1YC
	3YsEOV+YWcjyog=
X-Received: by 2002:a05:7022:eac8:b0:128:d3de:c9e4 with SMTP id a92af1059eb24-12a726db2ffmr4311793c88.30.1774230892088;
        Sun, 22 Mar 2026 18:54:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:50 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 06/10] mux: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:24 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-6-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: 8bit

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 23538de2c91b..774d4cc67cc1 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -521,7 +521,7 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&mux_class, np);
+	dev = class_find_device_by_fwnode(&mux_class, of_fwnode_handle(np));
 
 	return dev ? to_mux_chip(dev) : NULL;
 }

-- 
2.53.0.959.g497ff81fa9-goog

