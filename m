Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4F283FC4;
	Wed, 16 Sep 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571920; cv=none; b=YZNNxRB7Mk0dQhw9Yoo7Bvb5KJF9m7UHfzSYMZd7yXdCv81YZgjGOJ+Cnq7QtQs6ja9x8nAGgjYxRffI7zl/PWSW36mMm04C0e9ZO+n0qQTmOeJyig9k2S92WiYMZkeN0OSjHZNK+u0e5vx7E1bMIMLzDJe5Dm5CPqv9sFGW5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571920; c=relaxed/simple;
	bh=pIhB0hUzlXDg0rfPxRZUv+O2ySpwgJgBpyS0m3KcfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsCutsJOBBVl9NKejn/4xB1UhTJVz47pWkxi5h8bPZhVeH2dCSryeCL+je1AuIkpPywww2lcRTuMHZcLOJW+0OdP+Kg/ZlHf0UV3dTOQ7Ig1i4jR6RPkf32dhbnuvz/7//IcdJewxKlpDSGyIoEV7ok5mDbWegWBJ1tayo3MdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428A71F000FF;
	Wed, 16 Sep 2026 15:18:35 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: dt-bindings: Relax node name suffixes again
Date: Wed, 16 Sep 2026 17:18:27 +0200
Message-ID: <60988ce9c4913014e255ecbe127e93374f6a2295.1789570538.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

An SPI bus node name can have either a unit address, or a suffix.
Commit c4fb6880edc15866 ("spi: dt-bindings: restrict node name
suffixes") restricted these suffixes to decimal numbers.
However, SPI bus node names with suffixes are typically used for
board-level bit-banged SPI busses ("spi-gpio"), which live at the root
of the device tree.  Limiting their node names to numbers is prone to
conflicts, and may cause silent overwrites, especially when a stack of
sub-boards or expansion boards is involved.

Hence relax node name suffixes to alphanumerical characters, so users
can write more descriptive SPI bus names, which are less prone to
conflicts.

While at it, reject empty unit addresses.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609150228.Nh4nZzbQ-lkp@intel.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Other subsystems (regulator, i2c) had similar issues, and numbered
regulators caused conflicts before, see e.g. commit 45f5d5a9e34d3fe4
("arm64: dts: renesas: r8a77995: draak: Fix backlight regulator name").
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 3b8e990e30c4789a..4d817f9e23a5e0b5 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -17,7 +17,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^spi(@.*|-([0-9]|[1-9][0-9]+))?$"
+    pattern: "^spi(@.+|-[0-9a-z-]+)?$"
 
   "#address-cells":
     enum: [0, 1]
-- 
2.43.0

