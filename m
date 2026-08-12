Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7B446829
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568537; cv=none; b=c8h8hC1NLyYzwfA6KsdyDb9hgcghJifHXbGbP45r7WakfF+AMCUWqfUMNM5u/1VOVTsF0s/QNidhNf9CN1Wodyx48npfYyVooEi2Kw0dWYVO1vtGZ6aHwSI19iWR8saYr8ePghlGWFUlvi8CWvNP7Mx6wqGYNP1gyIIai1143qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568537; c=relaxed/simple;
	bh=0CBhCBU2Ye60x8lfkWT28rE3Pec6oVMCAnjppoXmg0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mTC7QwyXOQ98ZrSXzPQzR8lACgrf9yBFs8SxqWEBzygyg6a/xYLLV5M3j57bAtszGD7x/RWj8CTVXvQnxKcbgOHP82/QlGNIczr0j3CQVkqt5Jmo+H0NJofwODy4TkGRCnPdhFSFNRkU0F6T9PiMlcGbGtZR5C4XXeLwaiiBRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kk/gQIzU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kk/gQIzU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fecbb7000so1017f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786568533; x=1787173333; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eS0igH6p3phd0yMFsnOQZ+4mmHdJrMcSmVlciJfLpEE=;
        b=kk/gQIzUHUpRuwetnUkg2zd8+218xzQZ0cWpq0Z/kYjdKBOv/vGMeqIYJbSfFoIe8W
         xpsbN063ic6uZs9l+buUsF9eNNLBsh5RCmVe8/nz9v0qgzpxL6Gp8TvdUbfX/Yn0myI1
         JpToS66CIkXPh32zWxh2NBL4FBhFbMqKb3sZSCEzja6O4lLJuQwAQqWlDOKHM1gAm1Zr
         m8X0lNZcWQ0r0ydC9Od6rU6XPNZ3uTL2QjKQGjQPHj7h9Y0IDa0PbJmqYT3jof1mWu+i
         XlKeWZNfKdl3nZfh16RdynpyAIAsglEEwPsoTT6hOcLs2VphyJIE5nVPUaxyJUO/wQ7c
         r8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568533; x=1787173333;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eS0igH6p3phd0yMFsnOQZ+4mmHdJrMcSmVlciJfLpEE=;
        b=IZ6RgaMAt4tWIZFDYBOJ+xqWClWkJoDdOhNp5wEOt0v1W+RTcVmtx+3xxQWySqBFn+
         cQsP495wbY3txB7qxaLE6uRnqaeg5DGE5nPwQlk+LZVGF+M6W9KScNGWhOuHI2FfYMg4
         cMQVdiwz/n+LoDlH6fYqjkYH20zVJKpjrim0nw0aD1TnJE6zHYcpv5EtdfD8VuxlYGBd
         PN8ZASm2t46ymB5/b3vaTqbRw+xWdfBIqvDYkK+8Ud3D8xUbustOMbM9EGc/+Mew97A4
         BFszYGRHgKbZSVzvtPQ78Vl2YPFR9TilEoki1r0EhVP9oxu5P8JGgWrRnluJmpeNjfDx
         beiQ==
X-Gm-Message-State: AOJu0YxJJaV51D1mxMuJMiETbvzUCqlAbq9fR3KmzRG2s0/nCSTEMw0r
	odyPGZU45H2CMW/cRm7SvJh7NSL2lWRI/OWnxEJgczJ9wTaNPiiadofhlycQVBerwCw=
X-Gm-Gg: AR+sD11yB94ZYpsLvMwxVslJYWZ18LedVyBNkbSea6wdQqyIPfTDYr9EiyApRk8Eo0f
	UDQGNyQJLSLk7SmXKtnxGI5Ogm25gM75aULofLI5O6ZoCzFzeKlQA3PQS2mvxPd6ADvioCnNGQN
	MDjNG2Srd75S3GtXfs6YAxjp70ZMRZROSDcbgHUKQMwH4qtCk8REj71BqciQOIkR4xjzKzKHk7a
	ywa8FH6XHTkQBQk8YbwcBL/3FSX15EWjPvZeFs10ZkpP2vHpRCQwDQ3YdhVeGR375H+/o1BHKUv
	Dr0qvCIzw6Qo7voMRNebgEv9/XYZKR6uXLNfORz2PI4tTuZmB/bOMnTz39m6+oHp1pGXUT0x9kq
	FeYifAaJ5V1ItLKgM1+cjjuI6ieRynnpb7yoJ1x+yrpvzXEOpl0MjgkssQrOcAOCb++6Gi1mbM9
	H593DKc9Pb9ompiSvp2x8M/nMEgsTRD0YAUd9s5xHC/rSsPziF6c/92OY/tFQ=
X-Received: by 2002:a05:6000:2a89:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-48159ca6049mr1024076f8f.6.1786568532369;
        Wed, 12 Aug 2026 14:02:12 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:282d:879b:d1fe:f977])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815a5c2769sm426055f8f.36.2026.08.12.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:02:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 12 Aug 2026 23:02:02 +0200
Subject: [PATCH v2] spi: dt-bindings: sun6i: Add compatibles for A733's SPI
 controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-allwinner-a733-spi-support-v2-1-937bff0fa78e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEnffGoC/42NSw6CMBQAr0K69pl+RMSV9zAs2vKQZ7BtWkAJ4
 e4CXsDlJJOZmSWMhIlds5lFHCmRdyvIQ8Zsq90DgeqVmeTyzC88B911b3IOI+hCKUiBIA0h+Ng
 DKq5LbXleaMXWQIjY0GeP36sfp8E80fZbcTNaSr2P034fxeb9NRoFCChMUwtxEmhseTN66shEP
 Fr/YtWyLF+qmJyj2QAAAA==
X-Change-ID: 20260805-allwinner-a733-spi-support-e30a9ac057a3
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=0CBhCBU2Ye60x8lfkWT28rE3Pec6oVMCAnjppoXmg0A=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqfN9Q+u0hwY5bmCREf8SoJGx0s9FOJ2i+Jt28L
 XwaflMwzwuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCanzfUAAKCRDm/A8cN/La
 hadkEACsSQx6tBKrNKoNPl56rW05ntzcDV4ES4lN835wpmXCzKW5YfclSB1Hw3//6dDLcCm+Wzs
 SMFe4WKJsIrxRA4wEPiP4qPgbmG4Didsxhp2jc/A2i0Z0LeIDz++zLcvBNiqqYHDE53HyhqDANn
 QGkAootOt0gQXUrp6jB2BkVoNQFjjN6vGJd/5ciuZUmzFZ+YiK4KtBcCXQOB1ylzuI+/LzewAae
 xNpfs5uJ5OOLVeHDcpVRfVoN6t/uFLg15IKlRlCb4pqjl6X39UZXdpYhAyTRl59bdIzNcrI+3Ln
 sX2xVa69TcxRFX9PWs36m1XaWeVPT39/1gvadDYPop0UT4NBAC9hQ+gYFKx2Os5dCbNjofo0UXI
 ZuXD28tFriBHAtukty38MySAlJ/nYz23qImyc0obgyHDnzGBfH99+cZGX7LiD4ACLbHZ29OladY
 NfSavowucJuOI44ngpXIMBgtXq7TbBDoi3gXFz2ulpM4F4yNbESQfP31e2p7goeR1Szq07jr6jw
 LKk7CF/sTnqzJfJj5qYPpekMDgJoXlC+Ol+Ht4O0wvQ7CsrwXRAsUAjOoGJ5arFpaBVEvpt1saR
 fef9Tvm7vJDQVtnc3zVTtzN8QVYFtx21ZncuvU7vXTzQVI78dM1/2v5i5HPdz2bjtaLhy+2JRaA
 l9uFYaAreYhPgQw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 has six SPI controllers with the same IP as the A523.
Like the A523, one of them (spi1) also supports DBI mode.

Add SoC specific compatible strings, falling back to the A523 ones.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Combined allwinner,sun60i-a733-spi with allwinner,sun55i-a523-spi-dbi
- Link to v1: https://patch.msgid.link/20260805-allwinner-a733-spi-support-v1-1-7bfd1141ebc9@baylibre.com
---
 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 6af4ff233158..14c2f318dd04 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -34,6 +34,12 @@ properties:
           - const: allwinner,sun50i-r329-spi-dbi
           - const: allwinner,sun50i-r329-spi
       - items:
+          - enum:
+              - allwinner,sun55i-a523-spi-dbi
+              - allwinner,sun60i-a733-spi
+          - const: allwinner,sun55i-a523-spi
+      - items:
+          - const: allwinner,sun60i-a733-spi-dbi
           - const: allwinner,sun55i-a523-spi-dbi
           - const: allwinner,sun55i-a523-spi
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260805-allwinner-a733-spi-support-e30a9ac057a3

Best regards,
--  
Jerome

