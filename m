Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE122425B
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230905; cv=none; b=rtVcsbHG2j2XyRNalbxCCnwZ7PLNl3F/L2GsRAfQ68QeGScgKv4HJEmlW6/etfPM6lFIH/tvhMPb2rPmBkm5YcKaj3EwhfiioszxWE7YH7zaL+6jc5uZ2UNKngyrIJXvT5R8uBcMVuRdERwkIuRMz8B+0nFIaQnMDT9XXQVEIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230905; c=relaxed/simple;
	bh=oa2EwaUUG59FtphzeTYHy1LbWnpif4xM00zY4CiwrfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPs50u5gnxh60TIW+maOf0FhcwIUJHieXlaTkjZyA7bSaiRjb7gneE4FvE22NyR1UcQphNXsme8oTkT0FveU1smrWMNPhkdr0MSPW1jU9YPmB8/gYHhnF1k/Lr0jSkhqRoL0rzOjWXglWJN+5BNfq58Cb40+wPc+60ZE6U/inzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGsqHg9u; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGsqHg9u"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c107ef474fso4398622eec.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230900; x=1774835700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=DGsqHg9u8PZBheqZmCbwCygye4QFZ5ls7ZTjLNcDdLc8lNWsLUAb7+azOoGrE2fxsZ
         pirnDYbzR3NgIV3X8c7NDwwT3bxsIalIYolIyIkEEVthhG4uEbhiwSJsF4LQoRqBsjWt
         NcPXkgrxG6p8YnvyQOQHlZiJfDqBZvFiNhUbSzVyanppF9lwjCwF37UDljU+sho4aXdc
         kA1QVEc5rNVpmEbfjh4WITCnjpp8qF0r2pOO47PSRdqVjeKbivsv7cOYAzTNJuix2XbZ
         MZmVcH/ZGGbzlAfOMtW1PWao0skp1Z40jqbSpnhHqzzjDYHyjwK+yDjQujbW4A4oNgSV
         dq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230900; x=1774835700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=TE+0mDgm8KvKBgP3ljIP2fhQvj1mP+PQsWTWfjVKvW2ZV87t9pG66hXVeyOeoCBhpv
         BbHVIIYQs6NhVgZZm0Z39B9N1kVbUYMGkadC/3GQ4ayud1XUcKgwsXShtWXyIfuCXZMq
         Sb4ouEOlyFFopVR9ZOj2t2qVPj1t4Tyn5DraeSpoQUgbJjfbdtkXXn3qFzFukDfAcmh5
         AhQhc7m5Lvw2cAdP1BVP9v4+nO8J3qqeSs98ZVAB+v8mm3ttviJBiIPWWFcg4FQxjPVQ
         HkeItSuL2RqD4m2xzDXQH6ybNKw3MhQ6+IR3CYMS2TwnwC9n2nYK1C7tfJUcJzvCwE6w
         Q5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYYU0st8D7Uz1Jgm9UTd+A6PY6+l2hH4vGc0SmrhRD/CrkZELz8nE9aPGnUzoK8W5/CqoRXE6meZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztae2OMC4UOdsNpRuDoycz17YKFReG/5QlFP3Q95cqGczJrLog
	L+gMLnM1DizL/Qpmi8m+oD+O1mEAFV5E0SsUgaI7yD3+FtHE0j/jhzoy
X-Gm-Gg: ATEYQzw2f9jKODloXFQtOsQFxu3VCeEF5lTY/ANdRkm9UPvE+3qX12+o1MVZMKOVK2X
	LOiIWDryGYqgwEtudAfeZyCCjjuM8DMbPim3NDtBCKWPiY8fwjpMK1psiLZ6sNOq7Q3Ii8DrM1N
	1/S4h/q4bni0el1hVGqfiaWlQwUMFIpw9MEKQmYkAAFNEjlibqfn0Ur3lMwBlZhGM2w6E/LoGvS
	5pBBkm2wnu/NG/pzChQw/BHkqFIPym3fimOziA4wnCANrQlJD/r80SbIy4qvmXEsC3U4LJfOIzT
	fBQN1jBZ1EoGSh/gZF1EZiIw3t4YWv6eGWS6/F26frCzHeMeCu4auvoD2Wh5A77OMdNNQAyjJ6J
	P6Mw0Zqz090PHCadtbmhXm66kb/SNu1ng5yco5QG9YyWfA0lcSWJ2lQYJWvkReet/EUPVtOKtM1
	rw73LJFmL3H/dxY0Ce75RIo0qwOUM/9azftwumCOEr3aIxQ43q5uCBkzFSfmklB/U8p5luxvVXR
	jNEVw+H07w5mD8=
X-Received: by 2002:a05:693c:2b06:b0:2bd:c8a2:954 with SMTP id 5a478bee46e88-2c1097b8ae8mr5509864eec.24.1774230900153;
        Sun, 22 Mar 2026 18:55:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:59 -0700 (PDT)
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
Subject: [PATCH 09/10] fpga: manager: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:27 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-9-b72eb22a1215@gmail.com>
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
 drivers/fpga/fpga-mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 2672070ced02..1e7585a4608a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -716,7 +716,8 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 	struct fpga_manager *mgr;
 	struct device *mgr_dev;
 
-	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	mgr_dev = class_find_device_by_fwnode(&fpga_mgr_class,
+					      of_fwnode_handle(node));
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog

