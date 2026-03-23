Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFF223328
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230893; cv=none; b=nqNlL+Y3y9xIWu8Fk8MK9HgcqolTd80rfwSR6ENNBKZJCVEuZHIYb7leSxzcRJdtOlv+CUXFAsOf/bPySbrgTrkemEkT1AODc2DjS58z2reyNfEisFz1VkbS7ydTl7hNJLh3wb7RwohUeIBNSep4buuoBxVeLDFakXl7yzAn8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230893; c=relaxed/simple;
	bh=RqL0mTRKkF4hWJurWBewRbPofeTnIMHQam2gd97mUZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRQy1l50EBJk58/7ZtQMimj9k1QZUm8FjKsDBEt+WiSVA+nQjqIMs1N4HJjI02JTaykMsLHJNbQjthcLOkQUE/PumaXsuKk9635K2PHJjG/G1rLKmkYgny+RL46/3iMVNoGy8fGqMmXltsm6K9a8sd1kAe7icMh4QJVgiqEICp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqZ8DMpb; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqZ8DMpb"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3471193eec.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230889; x=1774835689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=RqZ8DMpbb0X5i5GNOEDtrcW3mRPokgfUOj+UjicWP2+P9aSKtHV1EpNICz9hjPr3Tk
         iyi/IWrJ25Koh2vjxA4VysTebsPVDPyB6DW24mihHcF+yHhq/fg74y722ODqj3RxrMjm
         jc/+N41+4+VXaukA/ZQCtSesjuB/buuj4RkpKh0OzAGpfP3Yx9FrbLdcRngwsAjQwii9
         w9+Urz5kDN9jJaQ1Zdugxr+oqbhvVwRH49BQLayYGY7Uk/8XpnbFdU5dJ2A7o8k8HdWZ
         m6vETI6scTyc4cZoUQRltOG4+c73fsDqQwQFt/ZXfL7ugewKbGA7Erx51Ta3jzkyaAME
         2Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230889; x=1774835689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=XofYx8vILfoN3808hK/HQriZQ1EGvX3Cys/ME9G0MJNdf/HZs+P1IU29VdKF0JWTNt
         y1kdA8j4zs8qeJfH3E/VM4EGXywdjoiP2BdvC4up73Hxg8xZrGG0Y2lfOexDYfl41gL3
         QkAnqB/k8CTO7X5UM0atGhvPJY/Am6LBHKrZFrni/jL2TzEKLGuYNJWry1MaLv0scqPV
         KjhD4VOmdyqshrGbPZtBhVtvGSWCjgOnfqmEcDQR9XN9O1fKSfXd3KIQI/etBMm5qkj0
         e2NoVavv/Xag5+Cu2pOQq9OP12pL3y2Xz7vcMMd4xzo7aN8un49+b66oG4IYtHRqdvld
         O4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjAa3YTKaO5dKpa6yONze8IOCDmRmJkixBWfWQW9gWvpS4JO4wZ9l2nagmnTfLHyI4SnTEgRQkiC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAiLNNkYBsQOt5QQl+Id20zMAdfWAhJyuxL81f4UCUK0ErWu6
	fc3zxEbSFKW4RZ0XmAtlVuoDDjnjDI0HS84VpyyzGnpnQ3duOuasQFpC
X-Gm-Gg: ATEYQzyypGbgRg8RH+4CJyTgp7Ts8MmyRlM9Q/r396Ma/5+7DivDjA0uXA6HsnTBvI4
	OlTkZHMFgY5GNIG+DsII41W+jtcoUBKycchWsOjflc1/jsf8kj0ghbgiPJq77oIpziyWKt1wqKT
	Dvn9M7Nd6Fb5/YT9PRd31ZUQx23pPRdxP5sJqK+vK+nl3DiylpJrCjJx7MGEh30kGPCETPCM3cF
	eRTB8P700xnt+fiF7zZR3wsdnW3WIpwz64m5eILuINUUeuy2Jg68oR7obt2/N1IqnxK4HUioYHX
	tPks1X6/Ex/cge0yDWzDyIJw2HMN6B1i5Zf2o49j7eJ5l/7NljSyrlndbIE/hxUB9gv+8ssqfHQ
	wbPdxy2bm27v4USz4HVXM8paXfknFs3ycQIUqIenXLp4neZA012zerdVO20xC4odFgwy07q6znk
	j67qFjsdQPRyawGoJt2otDT+IGfxeEBXaeI5sqWAZszdJ5BoDuhRvfd3b953kkqWVj/a4u4Z27/
	IvRUNBOAqYYvjs=
X-Received: by 2002:a05:7300:572a:b0:2c0:bd6f:42a3 with SMTP id 5a478bee46e88-2c10974f0d6mr5302324eec.22.1774230888985;
        Sun, 22 Mar 2026 18:54:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:47 -0700 (PDT)
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
Subject: [PATCH 05/10] leds: led-class: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:23 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-5-b72eb22a1215@gmail.com>
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
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index d34a19453560..8d7ec9ccb173 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -273,7 +273,7 @@ static struct led_classdev *of_led_get(struct device_node *np, int index,
 	if (!led_node)
 		return ERR_PTR(-ENOENT);
 
-	led_dev = class_find_device_by_of_node(&leds_class, led_node);
+	led_dev = class_find_device_by_fwnode(&leds_class, of_fwnode_handle(led_node));
 	of_node_put(led_node);
 
 	return led_module_get(led_dev);

-- 
2.53.0.959.g497ff81fa9-goog

