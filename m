Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CA39FCB4
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743380; cv=none; b=WNG7EoUckCDPehawtDVIbWfLmxryztstrK8E7g7pwLcgAZyrMuw69X9HsDkGki/nXf5Yrgq2pRNiOoJjglSGXwhaFonCUgw0yF3x2Cma1j/AhONvRqbHwLwn3wLafwNEJ57skIKU/XB6XeSes5UYm4fGpmrmONiZ2ACwX/L7GR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743380; c=relaxed/simple;
	bh=lpNjW0A4H86kFIRK+2Ey6s8T/jaWVaEc8oAcNIcvbIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siNCIrTfbKMFvoRviCRaZWmFhDlkgYbhtCBYIJ65IXqT8tc7yo3pRY0OFf5aZvPEH0Ep8lYFwTx5Af01yzSgKut6mfn4jLCQuFcSkGEZ0xxSObMPqlTkYOurqQqR6o5wziBvqwarGzwVyrgxLKB0txCjRF3UDq5vnesTUXbKVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa26u2qn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa26u2qn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacf197759so44182145ad.2
        for <linux-spi@vger.kernel.org>; Mon, 03 Aug 2026 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743378; x=1786348178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LX9tJPPybQG23QnWol+WkuZghQpoeotorNVxrLWGsFg=;
        b=Aa26u2qn1W7x1RVAgO7kbMsToNHPcQuyYbdAVIXPwynf4t4QxtI75W2oEMtizWAkhR
         57c5Qx68qYmNk7rPrF5nvs3oaLkHW9iuq3I64Inhs6zHIMXm09pu/VUPiHcLKAlftK7C
         Uc8RTZrfi2/hBkIIYZNAebnOHheVPATOEJ+YSPASizaa1ztsEFXBNV1P1TsMNHnoEq9K
         yyd6xDlFT7G6x3AJktrluExOyjK7bH46Vz/tLLhaiOsoJNIuebuF6Oktf1leq51j5OrE
         9rSq+2/JRe5ENGyTkegQRu3Tmye58VoOA3wp8PDUuXVv7L4ldwIm1AlCP/keL2s8C+wY
         yp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743378; x=1786348178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LX9tJPPybQG23QnWol+WkuZghQpoeotorNVxrLWGsFg=;
        b=OZILdS7kUcyVzuQtV0lQwDjv9nLzRuMassKIL8LTRAng6pN3gnrDY7PykjkIEvq++r
         6C+1W0/UiCKe2snf5UCo04RZ0SK75ve7xryzFFfYhkJE4eZOM/D1ocF6Rg6F12E6bS3j
         1yG3AgCmwOEGUIoSAUR9IweNLfSMv2GWVB6deUvzoS9UAnjtbqCFoFv8kNPeBitn6ww4
         gSJOBmgaVzrIOANboKBR6SURfTYn4SKLed75Hnuq7D9Z/ty6GcvV5sz5pS+11YmlvZi2
         b+cYv9twOpYfUtKDSGr5ZG5AGeSGU8pxdfZ8YlVv+uSPu6LRacn2288KiVJ2i8YodDG2
         uRBg==
X-Forwarded-Encrypted: i=1; AHgh+RpBTOvMbpqMJXFN3RZJjFcf58k1EPuSEQIMF7h4nwxaEpinFzrLmMioNn6oQSPMJN0mbZqr7Ye1rTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0G1orfFBnbYR1FBF1A+JON4gwCXzby5/OEhAcoZqvSe5xrsL
	xbxD8HzZ0m4GoLWtpw1gD4ZmEc0kWD/XB0sBDFDLZtx5NhvU9foWlrpp
X-Gm-Gg: AR+sD12IPMDYRAhTznk6wD30WZ3oXIKOTmakaOXN9a/lTmxOSjx9oLANqAA82loePaY
	TWljWsmYSE6qe+/FxRn60AJzXC0TbteReD/LkUXrNDOPyJltKjkdtEr5QPGQKD8DhFpFFSUSN7Y
	h7JDOpQ0+qz9kEZTZsgUsF1BouqqVwBB26+2anJ6xfpBZU3MfcFVcQbmr5Y05MV5c3jwyeMNupi
	1Xm2l7Zpqx20ClbTNTUJgX3sbjeUTWMGn0t3LNImZ2OHI9gt30+Pb6mN1xWeepK967OprrArLbQ
	DqAnQ4HLRfzUfVhzR1eO06H2WNa6iOGICVqjekKqnqD6suxOR51oG+kXcRouVkU40ysZnCzt1k9
	nkR7eXXQ/7tU/6602Ye3je2DUq64We1zruUkbhsoI02HEpuPxLwNZgVHV/a7al3Zr/rjYkGwA1G
	UR+4xYctvUD5aQ6k/DN+MolA3HlRLHU27KQVSziq99w8yNCyjw6e0tNSWQv0P2nXgc5gqv2Uccx
	DbC09ZzSCpW7OXQByB/0S6SECBg/ktBKLHAo8MQnCtW6bwB0NtJGKH6hLb/Mw==
X-Received: by 2002:a17:902:e5cd:b0:2c9:97a9:2098 with SMTP id d9443c01a7336-2d052421484mr95275985ad.44.1785743378231;
        Mon, 03 Aug 2026 00:49:38 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120f2fsm33679845ad.64.2026.08.03.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:49:37 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Allow additional GPIO chip selects
Date: Mon,  3 Aug 2026 15:49:12 +0800
Message-Id: <20260803074913.1656675-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803074913.1656675-1-cwweng.linux@gmail.com>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The MA35D1 QSPI controller provides two native chip selects, but the
generic SPI controller binding defines num-cs as the total number of
native and GPIO-based chip selects.

Remove the maximum value of two from num-cs so that board device trees
can describe additional GPIO chip selects while retaining two as the
default chip-select count.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
index 377ccf4fb224..f837367e6d5f 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -30,7 +30,6 @@ properties:
 
   num-cs:
     minimum: 1
-    maximum: 2
     default: 2
 
 required:
-- 
2.25.1

