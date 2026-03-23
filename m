Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA6222580
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230900; cv=none; b=lo5mNlRzRWUms2GV5Qk+EG7LEigp+EZ8OY5A2I88JJQdVqyEtGQckKm/ihbTHGCXF0Jr7J6yAvaLHfawoQhmzN/fiIrsaPo/PmpjUFqGeSWtLHa2uJLrUNCKVLAntj7U5320+6hxowKYVGZPRkGExFgq0eSsioknJ9SF1bzE7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230900; c=relaxed/simple;
	bh=I5fS+FwbEw0P5vASCqinmGTcQr2XqJ+MU7isqg4KgEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP6l3+g2uZKHjrrDu1Dg035QQBQB1ISj/qv1fVhCRXLs5geMY+KvQscRQbAKT6FgVLlHraqmv817Or3pvETQbJEcs+c3uc0omN8JeZayYDg4RxN1BiIEOtw9bBTHuH/QbRWeMUxVynMwpHGS0Ax1UWRKZ/Ffvo2wYZasJrowUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Secbzmgi; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Secbzmgi"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so4065071c88.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230895; x=1774835695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfkDMRyvNYwOzv0q3wBq2OUYpD97VO+f6771zL+oLTY=;
        b=Secbzmgi7FroaLb8xUHxJ3ELfo+qQW50YJN5LWVovKu0WNnW7nDa0O+BGf4+xaGS1e
         kqrKUjisgWI5BSxWmT2Ehq7RV5hHqHqLiF2xkY+ehbrkgQf6DganeDhT50esg4bb4jMN
         tI578Ui9XmqBrOTg+b3gAqG4O2px40fpv0eEb0W64hVfs4MZXo2ldAxN1oyf3s0/fxe3
         oNabLBfyrbu+7lciY2xzfYmjvWUupfnDLSWlSboP6hTK7lGxPqoWalLXpm0et3y2RbY8
         AbAtMbtLoKYOOg/IUNvTk0vFR+TcalivVeq6THQszgdUKZ82qPnAz43pcdGV4P/dPapf
         HSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230895; x=1774835695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mfkDMRyvNYwOzv0q3wBq2OUYpD97VO+f6771zL+oLTY=;
        b=ro1UgNDdHRyTEx7d/VCqE/3u20bDNkuNDlLwnIPCjBaa4Nkk04N91/ltjYYDjUdtOi
         5OrLpknhoEpg+k1JkHSbjOPAD0yheKwlYA9zSl6sXFYkmsCjevHhoOhmt/CcK77L/zqf
         hcI0Uy4h3OiigimK9DPxHRVHw2ytG5znvG/8G/w6MiYzbacglBnp4gsfDKQ7N1teoDMd
         9NB3tBJw0C18+/QQK4kCn8QX1ckMlsnRhP7wYmAJB0ca77o5evKQjZldDRwUaW+H5bZs
         bgKisHZ13PV9qKd4GISfeP0jfuLG95Q4IInBBEfV6LraXj/BEW3ov3RWE7ZXVVrCHGrb
         tgeA==
X-Forwarded-Encrypted: i=1; AJvYcCWsfXfolfOlxrELyAnRQ+IS7bdD/FnYNBHu2Z373vuX2nABNZltQ7MZ1OlQX6TDPnpeWh+nswG96xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5mgTVq84F/DBzV4N0Cmkr3IBHEvA5hcYxakKIHdo0Xlk71JY
	NievK/Sczk0OkKAJS7sXhvisOSPrumac4IJKdvs4QVcrsl3fOhWl2AP9
X-Gm-Gg: ATEYQzzh0A3b6WI9u2RMhpnAowPxQLtlGkRp3LGyPfAGUYQkw3Zw9xpiqPPXoCp+AIH
	fdCVMWKkNTXTxyrFKn+Hx4ze/lS7Msm6qufHehvFemQviKOuP3BSjNTbiw+6m4vSKmjZBGThbPB
	ExLK9bXn0t2FvFA5pU7LV8Rd6+UlPMbeS9Vz47+vu2VMXssemxeYOw3gLkkRGJOmoumva8J2gb6
	IfEdpCkn/DaILZgKfxuwjnEgRZA7qHnoYWW9jbVsjNdwhUvyCRd76mUfvOCQuSxQA3zwk3gKOWR
	gErd82LjITGLuc1BOW6LnU8FVkEczYfZD1VJpuBomsnHU+LZ3LoBhe/xesZgz7HppRGJG21bo1/
	GB9JBgj4zyDLZ1De9uBTGPkVwmEGvI23wLg309Ltv6SjbvG4KUdvTxXzAbH9GosS6oQTKlCODnm
	nLF9aFQC0IelmqAQHxqs+vCoWFYehPd/fOYiC8jAMeu0BqwwfmuaKMal/HC/ZHSDbu0yx1E5hT4
	+K15A320R6h/qQ=
X-Received: by 2002:a05:7022:3846:b0:12a:6b99:1ad4 with SMTP id a92af1059eb24-12a72684aa1mr4380934c88.11.1774230895127;
        Sun, 22 Mar 2026 18:54:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:54 -0700 (PDT)
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
Subject: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:25 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

In preparation to class_find_device_by_of_node() going away switch to=0D
using class_find_device_by_fwnode().=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
 drivers/net/phy/mdio_bus_provider.c | 4 +++-=0D
 1 file changed, 3 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus=
_provider.c=0D
index 041576eba47a..ed3cd9a37c67 100644=0D
--- a/drivers/net/phy/mdio_bus_provider.c=0D
+++ b/drivers/net/phy/mdio_bus_provider.c=0D
@@ -21,6 +21,7 @@=0D
 #include <linux/mii.h>=0D
 #include <linux/mm.h>=0D
 #include <linux/netdevice.h>=0D
+#include <linux/of.h>=0D
 #include <linux/of_device.h>=0D
 #include <linux/of_mdio.h>=0D
 #include <linux/phy.h>=0D
@@ -754,7 +755,8 @@ struct mii_bus *of_mdio_find_bus(struct device_node *md=
io_bus_np)=0D
 	if (!mdio_bus_np)=0D
 		return NULL;=0D
 =0D
-	d =3D class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);=0D
+	d =3D class_find_device_by_fwnode(&mdio_bus_class,=0D
+					of_fwnode_handle(mdio_bus_np));=0D
 	return d ? to_mii_bus(d) : NULL;=0D
 }=0D
 EXPORT_SYMBOL(of_mdio_find_bus);=0D
=0D
-- =0D
2.53.0.959.g497ff81fa9-goog=0D
=0D
