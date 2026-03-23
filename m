Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E223DFF
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230884; cv=none; b=WZazXBR0NXabWGVsTLZy8j6aWKuRdHAN4auGpxUnXuqBNrWoLBXs0nNJ3qGDklbkUSFiOUFqZUk+gp8VRGeJovwrm+3tmBwBcqExOPeT1qJQLDM3xqE/hyI0rTaOmFomI1IdaHeXOMKY9IxYHZur7SQn5gVY/SewM1CaERzcDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230884; c=relaxed/simple;
	bh=hPCCh7wVY1yv/Ut8yT6oomhgehBamoMfqj/l4kLk6Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pta9ucknFZFgud/vWUslpYFoH5nTU7NYC+VUGcbCTsnoAhkMyY8zjEnp7oF4A4sjVmHxSuLhBC91mWShpB46Zh2yKLOmZEEBMvRefA/+20mkEk5Yb/NPk1N+0/gUvncZCGQp2gJBDmFbiTVeuMzb8TtCSEpbpnOIwYRzlnXMGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTWnSGf7; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTWnSGf7"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1024177eec.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230882; x=1774835682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=VTWnSGf71UerOR0ORdlnUklY8mLDZYkVyhF1hvFRsIpiSRgbnv0X58ocqWFWzR1OaM
         UEBodOHXlK+jo99NJyUP8Ot7gYnLmPeh7xijqhcoQ/Njlouu4sSIRA9frNjdwSkV5i3y
         xP93ajn9lna/yYGtj3EHYQK2e8UaqJhgKtw1ByLYOUQmILwYOY+HJTlZKf2UfL0w7lwK
         eqUC+EnI26ev4Jmehk5pI9WvWGIdjiPTX2iaCZCKgqIWm+O3tPi13cQ2fE7Rx5YPlO/H
         S8zVLChQTmaBkDKTo40imaxQajQe+ZzyKJR1R37bWBMN4aOcYCKIpqWHEkDZose861XR
         MUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230882; x=1774835682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7X8icAi5hW5PHcS4B3NheItH86dqdd76W8IY0AZdTSQ=;
        b=K0F8IIx5IowGlPzprT0EWlulDQgUN7kqE6JHiDuy7NBZNPJ41EY31MBrsEmwBq7Xcs
         9HRzVlzZNgUryXVw12opyi7cZ96vQmvuoKbX6lLTea3tLNAOXxH61d2K9ixxm+1wna9f
         T3iFaYiHqYgxd2hBQDnbynlBzKQSY7/T03qXvFoXuIdapaHIe8mCc097Ybso9FWhk35P
         257wr81IVTQCJaQQMR4pfHg1QUcJlLzQvcN2TlhC0VNCUdl9gPybuRyBvSMzcaQHMoU3
         Jt4o76EUGDEuECSLDnke/OpgSOBxLu4YMr5UA4GA/gj9iKNxXGiYCylp6OzNXAXEspcJ
         CtXg==
X-Forwarded-Encrypted: i=1; AJvYcCWLvpNz7pLHIMFOAsjlVPBfjaf4EdDqwZVaC62IvGOLrr0KCvQhIrLaVFTGdaH9zzVUXY03zHfXn5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwU4sO/y5YK5+jedg/2eA8p6+/tlU73R+/Y+eDaFIwyER4YV0
	ylCz65T5FbpxJRVtyD3WS1QSCyM3F4tgX1PXXVQb2VOFQtvgybSlookY
X-Gm-Gg: ATEYQzx6LEczoMvYURdzggbsL2acyvFzcGro0kVwm+UO6KcpEcrcFuE588gt61EI/2V
	3Lly1s7nqELu6eVVsTBIiEJp80AgclQpo5sIno3/y/dsrjoJXldFkHFu3/uy7VbQFnNiytU5Md8
	DRifML++VRbFpmZMCubVhnHW4vLH5HtTdGfk9mxJFCb4OPYxfosN0s9aPrrH6YiuWDwUqQg/Fj6
	cGx4RzMA9dpoSasO/3IV5i9agjPLMdENtBD2tKQ0VHRgypNtmFbUSgAZWI0e5Cz/UXeB7M3CAd7
	y3zSzfjzSa2YG1QHJJVl0eWlaQbKh1P7/XVlquYGHa/PQghmHpaYavLTpr9dvC9ntshyYwXy5y7
	IK4jvcmUxO3VaKtLbWtEncKTTSCQDkemi+ppUxkaIWuD5kAJx8kXo0HBqGVUjDcONdn9uDP/2+S
	9nC2rvzsihCiBaakBpHF2+NG7MAks7poNExOGhchxD5xMhi/ZPgEzFCTcPmzkDs11m3svOzyjM6
	U0pUGUI4YiAfaE=
X-Received: by 2002:a05:7300:e7ac:b0:2be:9d3:c8c5 with SMTP id 5a478bee46e88-2c109816b87mr4889998eec.34.1774230881836;
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:41 -0700 (PDT)
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
Subject: [PATCH 02/10] phy: core: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:20 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-2-b72eb22a1215@gmail.com>
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
 drivers/phy/phy-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..57bce6b63a31 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -761,7 +761,8 @@ struct phy *of_phy_simple_xlate(struct device *dev,
 {
 	struct device *target_dev;
 
-	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	target_dev = class_find_device_by_fwnode(&phy_class,
+						 of_fwnode_handle(args->np));
 	if (!target_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog

