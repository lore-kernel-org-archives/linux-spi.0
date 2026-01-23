Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF62EF660
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200726; cv=none; b=IjESulnywBcAqQ3naQ4ffU3vMrCpC6Iro7A41rE1jCe9gZpH/3eN95Y4Y5y7HtCfxVGTR9bR8wRF7cbCsqkrnPgpQoVDdnwGPubyo1V66vJ5Y+d1NgB/KZFeUCj3ZlGdt851B5m8ojbKICxZYZyvaSkK9+yy8NKt+JZ8pe9MARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200726; c=relaxed/simple;
	bh=5HI91WzF40M7BWTtVwSgdEEKhH3jYAKO9/9e2UnBD7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFVa1er7UYK+wlKEhNT4BfgmqQ4XmwHEuisG3QI4jAxC7HgMxYXz+C/ibmCbVlXLEys5rpZ6UDYXIAvY2Eq7+PLEJfRyY3x9n414N7SG8lRYSNHbg39aZLLrFnQJzlW5rPDDA7YKytKPPuxKL1bpfoFOxgHLFhwwVx9Fjx8ylfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LUj7dySX; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LUj7dySX"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4041b3c1fa1so859833fac.3
        for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200722; x=1769805522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT2w5VHT92aNGbPwdimSOxfLAza15/pSQtaUPTXFgbE=;
        b=LUj7dySXFykxBg4ALNG0o4Pk1ET31gRPGELJeeetN0gyvXE1bPmHm2m42iD+ThQfay
         GvgcEXOug4UoEOZua7AXbZaFC+XtB1vynUE3maTUkFyptpfMcq1K3aC0vcJBEDsmNZ/j
         uSyqlMy06MiQ+cp2f3pO6kvedRxecVkNPyohGNdHrt366GYdu4xYUNtPyCYPczG1MPr8
         GNRvQhpoIvPiaUwB4JCgvgW4eXGY9PRBpMn/MMgOQ5WkdAcj56QbimC4GiSqzfkGTXt9
         gULv47G8EViRzaeRAejrXP/UCorjebm0kzZXaBdpnYfewM/i2bbNXj8JvKOVA22ofdR7
         luog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200722; x=1769805522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AT2w5VHT92aNGbPwdimSOxfLAza15/pSQtaUPTXFgbE=;
        b=fXN+Rbfk8sYr9h/+lgsWivMjIaN07PMzBrupeuPzjnRx1TSTnjjnU+GYPgHLEHszOZ
         7GuGSuLy2nfze4vcHFSslR2ZRsRPLWRrwfTkC+Qju0TSrUzxxps5MuhPpBpZh4kWrpGN
         ygItw6cGQRGzHDnVMKYhbK4D/IxNj5BcbIX7nW8KRFvpnIk4hU620aVNX3tgh8NM9v55
         b3n5mC9nX83amYnvsVyzXNKzwirEeuuZqa+k8cRp1zD45iwVk5VOvtUDdXNrfFkmdxqG
         ztFzd5K347iKCrLrfhKAHDmR7TEChXlK5h4Du40T6GbUjF5JN2axxOB+1Es8A4JIl1Rh
         raGg==
X-Forwarded-Encrypted: i=1; AJvYcCViG/KtbmoEX+vxoCqB2ZiiXM74CsT8UedwBzwJx8D5StFxUvA3g5xbTqHQ9tZ3oGvEY8iL8Zliay8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwEF6+MSGk/tcvWz7vSm6HHBJ8GKZfi89DUVkIDnDic86NrVA
	ujbv0fF4wGM0ePmr9gYQJrIi4HBVFYcnrEh+JIJFjeWJe70ElH7yW/5Vz1eSLUel9JYataEq5+T
	VPiH4
X-Gm-Gg: AZuq6aJh/oqArlOWnNRFYbFeCHsKTDzJQ6Mu1t6Ire9NHJrT26CXtdqXAd8sjcuwYvX
	SbHhImDfaUN5WVQP/XPoCnhqGn9NKpflmyfbm6IWVnPosQsaTlz2cz5Z3T+7Hf14aVq0zGh4WLB
	bAvHFFirIYHWBxBT1/5UGfI6K2NJdj/b3EFRaQpE6I4GDEd1/WJ6v8mnzHFe4g2lanMFBaFHWqe
	F8+47GxKywcU9MEAWjDgCsDs/AO/wVuNOnREREpAJfWCAIXFv8rFncEhCDUFyKD5MV3QbUK8bJr
	bnvkZNht6A3+2TTs/f/5vE5tTq+iC2knziCJLXqTGKD+OJkPkSE1j2iaNWlLsaFxbWn2EpVfTlZ
	9Nf5w11XiysVQx7z0DoaFj4zs8OepBP+JZ9QN57dK+cEprXAE3G5+zXMhkHzSAQfqW8SXI96SrC
	Cl7sBjwKvdgurv5g==
X-Received: by 2002:a05:6870:1696:b0:404:3b73:6804 with SMTP id 586e51a60fabf-408ab84bf07mr1931873fac.58.1769200721878;
        Fri, 23 Jan 2026 12:38:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:25 -0600
Subject: [PATCH v6 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-2-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5HI91WzF40M7BWTtVwSgdEEKhH3jYAKO9/9e2UnBD7E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wWLBe1jCZp5s6jymQtTxnQkTipbYZUFXXQb
 FYZedi+GIWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcFgAKCRDCzCAB/wGP
 wBIWCACaHP7H34XUcv7GCi6yQp5HtmIVaHZLDrDsTmvIqFyB0ooSJnmPXvQMWDLKnsaSmkAZgH2
 4rNPgNqwf/qLj5KxOmCdmjNesLmhLUIGgaziEEQrI3HY6QF8ullBeLOAgmOMTCzUh2Avn6sxLKF
 VTEMluS4IRqhDJMrot96t5roQiJNj4P7E9HI+u2nyEzyLhUmyUTEyAdschkH1RzwtXcWxKFkt9q
 vSxDIcaCY4r6vaI4qX/D6CdbGCXldflboXnz67/YKuBxeA5KfFrLOpbRpwuxpjWZsDAt7BuoQGt
 KVh5zF1+rMtcgT0IzyeJL+9py6glAMB7nCEouFJYD8olaIFi
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
device tree binding. These properties allow specifying the mapping of
peripheral data lanes to controller data lanes. This is needed e.g. when
some lanes are skipped on the controller side so that the controller
can correctly route data to/from the peripheral.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes:
- Use SDI/SDO terminology in descriptions. (Fixes incorrect use of TX/RX
  when describing the peripheral lanes.)

v4 changes:
- This replaces the data-lanes property from the previous revision. Now
  there are separate properties for tx and rx lane maps. And instead of
  being the primary property for determining the number of lanes, this
  is only needed in special cases where the mapping is non-trivial.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 59ddead7da14..880a9f624566 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -75,6 +75,13 @@ properties:
       enum: [0, 1, 2, 4, 8]
     default: [1]
 
+  spi-rx-lane-map:
+    description: Mapping of peripheral SDO lanes to controller SDI lanes.
+      Each index in the array represents a peripheral SDO lane, and the value
+      at that index represents the corresponding controller SDI lane.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
   spi-rx-delay-us:
     description:
       Delay, in microseconds, after a read transfer.
@@ -99,6 +106,13 @@ properties:
       enum: [0, 1, 2, 4, 8]
     default: [1]
 
+  spi-tx-lane-map:
+    description: Mapping of peripheral SDI lanes to controller SDO lanes.
+      Each index in the array represents a peripheral SDI lane, and the value
+      at that index represents the corresponding controller SDO lane.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
   spi-tx-delay-us:
     description:
       Delay, in microseconds, after a write transfer.

-- 
2.43.0

