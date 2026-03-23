Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20F21A447
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230888; cv=none; b=d9a7la/SnVQkj5bS6Wf4gA/aOUvFuOogHk9spPJSfri1LnBV43tzx4X7uxrpyWydTHWqtDN9emOt2SwqncRm/QheWLEBT04pyPcbnnRBjN156VqEkvhQLS/rDkDvMxzzZ3dxjQzze8U9ciXIHqri+UZ1ZUjnfMR9AfBE+d93UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230888; c=relaxed/simple;
	bh=xYIn8ABDkpyr0YTUtgQcAiZf9GrzpDD84nxgrE/YbUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dakzZ8+hp0Om0rbC7S94rmE+NiKu3Jceiw7DBwQoOQyWU98XSgXn5sTGwAIr73c9kallOXsgrDBAcNyh7KaWerm/mNa7/8uqI9rxm6IYURoWPYwSQlO6PEB4sUrNb5SVPf2PxwyCjGwuhFHyBNg2Fi1qcwFwnsuy61GdwFOaspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuH0ewt6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuH0ewt6"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso652883eec.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230886; x=1774835686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=UuH0ewt6j9doYzRgftaipYEooiTTIkDnwEeL664oX3BBapBISM72bytNNZxMAa4h0v
         smKp+BAMqQWX3Sb+cN3IAx1jyosIzqncLh5td1Q9uOwjBJ90T/rjLttujrT8V1XKlDT0
         uvj2KTy0eGCzCSWlgmzXzSDF+9XDCFr/2FkOqoaayc4xcFv4J3c/r6gV3IwQ5PSTV09M
         pbS+v333WMk01T3Xzm62pIMmp8j1NPCA1fQyT5heASGjKBHsP7b7Hp/aKiugs8PBmfqy
         OkFLzXNcpf8kU0KlAgEoMS1MJ7X8wAWB1uQWR69fdgcEdV3a96R/zx2MHWpHqimVjv5O
         EPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230886; x=1774835686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=DmljwdYZ/aLKwNk+kY1BQ75oHQ9GXpW+A8zfSQhj+VOkc9wSz7Rz1Y5InvDo22/jKa
         cqAOvsUm3w0Y9Q1RzWpyQO4h+14v3TupG9n2DGLap9JiwgiLvt5CvwtM0NYYiB/rJdZl
         sF65tiRtyoDGZzY/P8NGIE931YQjne/RigPPe5gYLiT8O81KQFVmb2xJ9L6Egb7kFwNP
         b7jNSlVdN+gLTWwD6ot8/rRtbxrd84pnY+r1euVm0VildzRNOLgCeTNbL8zpOJaG3RbJ
         VlKVN2ojsTuCMHZF4cPIR3OZ5vZJ/2wl5zwAuWav30F7VrNUAPI3B3bWo5QUzSaYfZaT
         tChQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1g7DPj4IoeUrzkzKHYopXerM7SWwBJUbq14OWtNckrU+R03HsVrK2Ns9x6NAkEjLhTGrtociuYDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydl5xEe7j42zeuP4ynsm5/e83eb37YHYW6sxT+/cSd+AIfGpsm
	ZnAG7xBRlUfRQfcM8RlrZmldfNES6kJOuhXaHexQyr7QynuNtPQROGRyU2crJmEo
X-Gm-Gg: ATEYQzw2CeYQa/I28WMAOrWdyfXRRN5/DHsrCjtx/UyXiVJlnzMIZEuOj2L65u3iTjQ
	TpE2V0/S0I5Mx/1+d0p1bTIQJ7OkIPddiwYu1nuo46QL5ueOL/61psgZYauGbOgtdhns5DozEkd
	ozL14PcihM/zUVgfXJEdZJXmqjgHDqxlNPDIkQ7R4RJRM6MGoDUe/yYOoS4Sg8ep0hV+KouTOOe
	UtxerhIvnktFPG8kBY1N0JKcPsATJfcjE0GkgFgCrnQN0bR1Ez44xx1jVv49LiY7pjpTrvllc4U
	eIyFfGoiR5uFaGaiFPOk4ifXbnWdWTdt4sy3v6ROKkf1hPvh92IDe5FQ06rq01VVVb8QwA6+Hp1
	G9PwBzXqEYNiVUUxnvX+IX+idSjCeqmRlXw8vOUT3IJqEEtrFlAZ+HSa7ARJvyv2y7rRI/L3ZQ5
	LvzlNPyz2aPqtUe6uJOyAg2J/LH9ibdHWDOKuBrhOadytrX2Gy9mxWCNvFgKgFcLEh6+ou1kIDF
	9l5Vo4r0nwLQh3CSxK5NjY7/Q==
X-Received: by 2002:a05:7301:3f07:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2c1095f867cmr4580068eec.8.1774230885998;
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
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
Subject: [PATCH 04/10] regulator: of: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:22 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
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
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..43ec0845c940 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -637,7 +637,7 @@ static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&regulator_class, np);
+	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }

-- 
2.53.0.959.g497ff81fa9-goog

