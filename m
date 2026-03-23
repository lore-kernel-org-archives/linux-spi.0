Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B32236FD
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230887; cv=none; b=YiDKF4S/RUqntfwaSRy4qKoseXuIORcHjELpLWFstG3bA6TWiOpEQf+IPFs4UqATMsHRbeHulZy1j1lunttJKVpCEUCW3eFbHfJU5cebLsWf7TOvSYIKd27GCgAX4X9TqVqqey/W2MnbdlNPArBYJ6qatPZP/oZsvJRSd8izbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230887; c=relaxed/simple;
	bh=vhx5QpoROnyh2q914MrL5geRu8AVJM0r0udOxsoTw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkPXlWpr561DPU7f2sBOXjcsVfXpdww8cSN2NbGQB7C7bpK+nNcVZ+i88jtwjMr8x+URAZU9ntfVU7oI4M7t1ShUHhmI5vcNjhFSz4EKev33iXAVzd30JvkB8OmtKlQrkm5M25IAr1g08OkoYTyLslvfDvmqJuCFh89NBPp/FIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK1KsAcb; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK1KsAcb"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2165291eec.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230884; x=1774835684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=VK1KsAcbFk0ksbY+/+vt6XBw+4QjtQuHRNv2SEHPfOltUX5iNis2R33+Du5wZHsRqr
         WrIvRasmCEwSh7fqmeugCo6feE8XtxjYVAWVs/aJTax+83KN+3yRpRiZCmHHN41kGc2E
         76E2GGvW0zof2A8SVr/BVlPkGidLkiOUt0hgfTa+VgwSDTvrIJY6IurRqy40KFb+FtEB
         wko5608F7xyI/q7h8A/GWDyJCZ0HJ7yB298qb2dIQbetqQ8w+Pcud+IFZJPxpS6mn9WL
         8sIGtXhR2VICewq97fNB6oQcilgCg1aGpsGvaPbSi+wk7JHrmVt562VfDZYB8cq9XLjF
         K0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230884; x=1774835684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=CHd0YjENj82OVTKmx8+lk/ZbT2NOsrNCJYbSPH1z3uryjN+dWkxwayCRo2WSF3+EdV
         JKkYNvrAjPEX/WdgavIHHn6F2SQUHcxLlQeuJUxnxqqs+aenzm9c5xARtxOuk5l/EleS
         02T+fA2Gw73pRIE1rmvcU4GIQn67l8SYOZe1Amvt98/C8kMbafVsT8hPusTQq3WwXBJa
         25N1l6dJEU25AMfnKhHOjtt9v43vmv7JHMhH40zwxhJGllkFnNASng+d/m77lWSfXcQt
         t1ZjFNvxM1+9jLnHjBCE2JSNyMWG5rXugEuIDELjy9UN+CKNbTgK9Ib/nToHi75Rn+62
         JJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUjpINDn2ase0UZem+jOdkSdxw0YBBf9YRxAoDavr7KqBmt0J4XSDjMPM1TLE2yOKqhsZSWbGqOcAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Eqcagw3dQ6wrH38pQznUNNkFY7qEEvlzXzuyFhLfMjqQorlC
	LwpnVqWe3SUyaUHnRIKiFUZPOMcaheLgceNkA94uWTdHk4dnorx6JAt0
X-Gm-Gg: ATEYQzwRo3dMrVMQsP4Cn7i10k586zgAFl68BUNdyHLja6mjBPD25NG9UixQzlOq0kF
	RO668mAuoEeDvMG6Fre+ZXyK6jNpF077Q05sM8QyMvidJnhinJfvtYRCnLHPysUGtnDKx7ss0lw
	weLSTyRv6cn4eWtTOeCbdKGtrMYdxXffYQwM7q3d2RlYLKKCOmiZfQ+rcaZQXQXceYs1TLykxFd
	jimQ6J+v5ElX1e8RgibuGXVJjv14WVFa/o6Uf+mLNzl/oi2c7ig4AqgJEXpx5rqZQyP41uPbWD+
	vOp/F31089u4NqGUxLtMj13Zp4hApd28kK5bzuJ6YlzRs/ZnLmgzivv2MlmHnMPXNYV8r89HWon
	XcgSyOgzda+c5CsCD69r5P61GrQuFAz1DJ/5eTB26fO7EXYoaEtV3KrCAwoiffhSzbZGEyj0CZB
	GwrYKijjVpMT0DP3TgGQ6Zck0Iq8FtRkJ687TDt1BLwJ/DAN6XvvGzLpGeTAEqNhAr2MjlsyQZ7
	EgP8tq53p5w19k=
X-Received: by 2002:a05:7300:d517:b0:2be:1cb2:3a6 with SMTP id 5a478bee46e88-2c10980a523mr4129993eec.33.1774230883846;
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
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
Subject: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:21 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
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
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf1df365f795..071a9ffdb59d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -21,6 +21,7 @@
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
@@ -4948,11 +4949,12 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /* The spi controllers are not using spi_bus, so we find it with another way */
 struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(node);
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_controller_class, node);
+	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_target_class, node);
+		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
 	if (!dev)
 		return NULL;
 

-- 
2.53.0.959.g497ff81fa9-goog

