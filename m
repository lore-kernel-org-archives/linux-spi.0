Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B438F935
	for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2026 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268613; cv=none; b=CKfnCyZFTvcZAArG51IgzQjA9SfQF8yUTlAH2b/1OYrEYIulD37J6hWCU7M/jhcCe5HOKijcUvU7nS4kKIEsOrNUu/DQ6mR8VSy2LOTaOgCE/Sn8nnDQKT730TY2o16yb0ZnfCLhKDYd7Fe0xq925inp/yPuGVwADKQeDf4IgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268613; c=relaxed/simple;
	bh=DehrlvGFJbgB6EByjRUCSsgYcA5AqtbttJ75nffiJL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DPEfMIIRHkymFTsus+RAnMWIx5+Sbl+J2JTmPBZtLYqQN75CvXKQBrOYpa26Fj/wcgJl8vDXhF8s5qKSbFUGkOCZBcvFcx0ZwbO1IsUT6wPo9y8kjhGA2xHFKvGgtkZekUU4klFctnblsrALvZsMZXqmknUHFXSS0FSKHd8if7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dct/Emr8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dct/Emr8"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8899a204034so167887b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 05 Oct 2026 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791268612; x=1791873412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zokyqVAZo/3wOkzS2UYtFNTlUvQWqnfGSA9wFDnc6s=;
        b=Dct/Emr8TYxbWWRlwrxQ98zQoy2taOIntE1DT7W4M2qZf4d3amQ+lylqSnkxLClTKM
         n0eCRd8aSQyz2oXZhKDcW75A1GBbWXlIpC2SfTwZPB1GNfpofyj8vYQPVC9aG9ezqk91
         tJlqk9Adrdr1J8Slquo+sidBPe8z2+YG7nW/WjgvM3AE3ZL2IbJ/8m0PLlFGUsQZfOBp
         53rRGMSeQfPpNLZBLDABu9DURSRPyyI4TLCz8IWw8TzE6lhcs55tKwn3/xCXMHWfEUAp
         8l3z8eztgd4/N7nwSkuT9W5vyaAu6LQVmtSJonsRArdKpfoQDAlyKI4j3s/4SI8EBDh2
         FpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791268612; x=1791873412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zokyqVAZo/3wOkzS2UYtFNTlUvQWqnfGSA9wFDnc6s=;
        b=LNkip+Ml0JfMQOvIbhjWjaoZlMgWJPHfKkNsW9o1iA8d07KoA1ptKAjiBOnKDI/xh+
         gS7XvWLK5nd7IvRuMzIqf+1KCRYzBbNZwHJSfTZ5P5Hm5HnkPxsPp21zSkv+F61c7FUU
         l6Krn6T8GOkbMX4c099h1Gz4eI6kWmguiMgdVQ1wlnwGFJ430+uQez44zUXy2WP2TV9d
         /gaRQQSHRi/NkovG4taTf9tGT0R+kVGdRpJP5uLOb+/lBU2GfSsYW0QqTxnYU9Jy37vC
         QxXpS8590JLf9SMEfC00xy+kKaw/v+ospy5zeXRHHUmp974F6vseTWl3Ga0KJDU75V7h
         mdQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpOAZ16JCGOpXfv/HRcbANmhw9QszgSJTDEyPKTCHR0jQbghIg89HBfYaK3uugR7Pmow+HVw0Nsuc=@vger.kernel.org
X-Gm-Message-State: AFuF++nMYGBGH9aYn/3Bh1TbgwCe5uli+yTJDzxk5dzTTXNSIOMtajHe
	26PwMg2x6x/id8DuvU4Ne5NjdoKB6WvJIqMuDlRzPzfy0o4SQ2Jo+YbL
X-Gm-Gg: AYBFou0UZYE152QwhpVUhk5jIH6BYXM6peLjmaAvRpXIIJs5FD9XKXCjatTegWmYJ1M
	PQFYsOIXEog1aQez3Px4kri50O6Qkbn6aGkL/dP6e8E0eXHatGyOCsbN16v2NWH9jIeNf9K2uKz
	OSYA33ZgmUoCpIvK9h6mhv6Weae4rDv/Xh3wUiZ5zNnuwZEFOrbp8bP0Pi+12Z2JkyjOHk+DYNm
	CuVohG6iP6TobDFLr79QomS9KZkUGqTEDYKUa13feBp0FgMjPK28Vj8NdFGWJK0ntkfDoEsRImb
	ZlACS39SKzeurdbBx677SYJNlPJmTtoPRIspanyArK/keZLuPtRmSpHT/Gd0PijjhMNQEnQ8x/j
	RqsHE6NOMF2WJf96VytFjpq1KZFfIrO51tjEEvwfB9HxdV1dwFV1ugTdesW9rFiwLQgQIOxnFRH
	HQDJNT6gLZYitZGbbq/94cTEWpo3bZlvLV8XjUKpRuiesSP9Yu+ie8s/zNYXSLkMmgX2PnRgDdB
	VHE7arL0YKeUJZ6/2Dq5TF+dfQj32aW3DWUaCohcOFfWbmvkXD5VEDUw5aTK0UyTU+sbSje
X-Received: by 2002:a05:6a00:3689:b0:878:6ee:672b with SMTP id d2e1a72fcca58-890deacd37bmr383696b3a.35.1791268611801;
        Mon, 05 Oct 2026 23:36:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c792ce7sm4340790b3a.41.2026.10.05.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:36:51 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH] spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant SPI example
Date: Tue,  6 Oct 2026 14:36:43 +0800
Message-Id: <20261006063643.198830-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The SPI and QSPI controllers use the same Devicetree node structure.
The additional SPI example only differs in property values and does not
demonstrate any binding-specific behavior.

Drop the redundant SPI example and keep the existing QSPI example.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
index 72f2e1e1219a..9ee61f8ac4d6 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -75,24 +75,4 @@ examples:
         };
     };
 
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
-    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        spi@40600000 {
-            compatible = "nuvoton,ma35d1-spi";
-            reg = <0 0x40600000 0 0x10000>;
-            interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&clk SPI0_GATE>;
-            resets = <&sys MA35D1_RESET_SPI0>;
-
-            #address-cells = <1>;
-            #size-cells = <0>;
-        };
-    };
 ...

base-commit: 4825287f6d2346e9273f35a928d1ef40e68bc58b
-- 
2.25.1

