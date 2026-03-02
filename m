Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0924361DC9
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450526; cv=none; b=dTKoa5WBTCCSMMtnJBDoRrdsXnhQ/eaTrYFRvSAKeIMpov6/OJESSj50NzoWKfUemESeROu6FhmFsba+HHepphAIhR+hvn/r+adsNo6tpCZKAbii+wimuYWBGrwPd5G5FfQK74MLpWx+qhEvHG1DcrONbadM7C4lKy1jyMDMaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450526; c=relaxed/simple;
	bh=oX67Uf2cuE1+33M2za+xbEhq+YUjBZnozzKI30MQNUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBlXHHFkCjGJXI+OiQBqdxp0F5HbKB3aDiiUbc7JUDlxQSmLWGsl5doGWUqpMRPAR08gcNXvpGYIFBJIzHs59gzXd8iRfvYgbx1UST72izyFeue4pAol5bEDl0OmRwYA49qE1fjeMtacLntoXlmM6AYKzQ2FeeKShwGxGCAItYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=LCeKqbO1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="LCeKqbO1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483703e4b08so37977465e9.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450524; x=1773055324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5eHw3BS810lHNeg7f4xIwnSQSat/sp8IElQzLbapwg=;
        b=LCeKqbO17rP5109OTJALG7smNOybvBTsEVgvkM3TcmGnYCcAzUN5fSoAOK1zB9IkmQ
         WeEeXt1F1GMfZb542AAlvPWN5q/DtUezGrgHUpwtGBrMw/rlyQHPclh5dFoA6h+K41jn
         XEM0uGw164ChBXSCR/q6znMhnkdqqPZlWBu7Mkq7+YbSaJtH+ULVDYO7G3DajKhF2Md0
         NNj1G2CPYwGVQ+9IqnEeU3Gv7oVuhJLyHQpbEKUKI0+uR+YqgSqXFhfYsNWPZzn2sMcN
         25nSYvtPqaHgedcPA8CIx65s1r3ilq/EnNxbcbzOL8eJhQJJqnlwOgqszGl24mP31upQ
         L2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450524; x=1773055324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5eHw3BS810lHNeg7f4xIwnSQSat/sp8IElQzLbapwg=;
        b=UNgFe4xGYwi+H7dgketX9tlnzp7xffUPoiTtjJ9pIvAD9jik8sbeQnr2GZln6pC+uD
         bJhdpXlhk7WZ92si0ZQYzQeOxBomj53hcmdK/qxHW2m0nswoedY7mly8/Amc3MjIyuue
         tQsc01COUK84VZZjkx4NlFtcEdfbGeCU/N3bv6gMdcYl7v4eHg8ukAmF8yQHeJW7Ss6y
         0goyk7HqncH/ZeyZXg2CiG1lXC8n8gkVhN7Rd+AfEfWRDYeYp4KqnoC7TbFl4Cx8ssWu
         qBdkCDBZcFd7TQQBauvPy4zZ2QtbTovTZu34+FFsOabebI47lTfFoHXuSq/M0B6Wsxqj
         l6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCURz6hvfOcQUis1t026nK58f9PbJtIaqDNU2WoHcDEEzYU5eUPUUIBjtpLwwvs+OgNwq1fFsyzpYWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4qGwkWyFvYXXkCFjiQRxnZfQMAl97ld963hWUw/e4SyjapEU
	lINtLgCMJu+9fGdebsatgr/sc7yBzysk5/0nHuDcyu6SBDkZAPi4IP8/oznAPTM1yHM=
X-Gm-Gg: ATEYQzxGlgCcgpnofCWnJdTcdUDnDZWMvADIOmz3pHifcxB9FGtov7Lq/Rvcc80RcZP
	H+DnH+GiOoH4o1MxMNjvzEtn9AHfVgm9CBowpgTw7eQ9UXX6SG22Bg1gt42azwEA7XTm2IXpY7a
	K0Adf6TMUOZJk72pTZV1IurFAotRj7ocJw8IHi0vPzpQpAQZqvNfU80sk3iaAX03/rsZz7iHiMn
	hNWdN00trE4JCC51XRE2j71yFHEPJA5BObNq2SuspPZzhfslqi5rfyfgG5tX9/cLVYlZ93ESNPa
	lSE9Yu0kjClOhqD0N0kclEskvoCij1ofYA5m159DZK55zhn6cB/rdWbCTRLVUJMSXEMt5WGMQ8U
	Fv1GXWKbE7dbBMUYg1Dk6ZA8m9qj0Vwqgw9HULZkgKWYw8O2jRTz83QBmYEzzw7JQZI43WzwS/O
	aHZZ4Jh30EwXiojhc+p/aPMCNZ5h5WxCp1O0YZtJfAufWgSy2lFKdMiFEhhZgrccK2D9nzYs8Kv
	czHWpuIhm6U4eyUYS2FV8/HO5B6xTat0rIwulPwufE=
X-Received: by 2002:a05:600c:c8c:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-483c992e3a4mr192566935e9.9.1772450523941;
        Mon, 02 Mar 2026 03:22:03 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:03 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/6] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Mon,  2 Mar 2026 12:20:09 +0100
Message-ID: <20260302112153.464422-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.53.0

