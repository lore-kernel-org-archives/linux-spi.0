Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252836729C
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011148; cv=none; b=IKPdpnOXGcpbA5ZEdJzW0SbbxZrYnVAQEJHRWNnWeREN+2DDXPyPFkmVzOEmpGD0aO5ufxASEBHJtYsiEC02iYVNV3FltY9hjL3UeTqcWswZ7eWsYIAazds8jbVEUUsP98DDJY1sjMfISy5XMZSxGSNSZreqh5xzi8O9VahEnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011148; c=relaxed/simple;
	bh=D4HunRvKzwgbz3wH3A5yR4Me0etry0KENkQiN7rdUVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtWEzYzfl7zevukcrcm18SlljQKuTwMNL/6n+VtvNO926sb5eumVwrHVb1ojbD2evho+zBpcvd5tEUKso8Ur6iZ7+QVX+6RO4//iKEXgoucTGPJVPFAwJI8FkPoESK6ifOcgEuTyelbcQuFAboA89UYqH2vUBt7HZzXaSaD5Oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbOInQW+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbOInQW+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4869b6f8629so513860f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2026 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789011145; x=1789615945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJRPReMfqlNULQmo1hdhh0WFJsW8FZ4M2mPbCe/HToI=;
        b=fbOInQW+UDgoKHz12Y1wQZPviQs5v37yubpHd+FmrWQ4XNfofN6rGfDsAQfZ1Ote4V
         t+zF5vx8Dr1ZQzJ6TE3WPWWf5U9l16+5cMfhFhzGQDByOLSYY/Fbx0uvjwW1VnsUGMqf
         7jG/EbDKIyD0B1F1GxayKIvdEup3yHWEx7zPDPc9zaVbHwXR6dBPSCvj/1KP2ti6g6hq
         IejpC+3p0HoD3wSwU9qOKwOgA2Grb8+A3YXYjayL+kaq4E0MGi+TZOla1+II2CNJO+XU
         hmm/OkH56vI+TRpN5YLnUPObctRQF4l3ptfd2ZuAcinKLa8rpVIHRWjPAw8OKRBhchj4
         7A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011145; x=1789615945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJRPReMfqlNULQmo1hdhh0WFJsW8FZ4M2mPbCe/HToI=;
        b=iNK8d6M595fDNo0ocyhauaBNP/glB3Ob1IAfaAHxzyrVFjyRotDvgrWWZ2tS57ApOE
         eSjMi0PAbdyNnYZJB4XtGoBF4s30wpvSdvcYxcBFl/Q5kfjLVmpIGmMLHdgF0rtt7nV4
         mL7UvWVphEA1eKcs31wfgGhHGW5ya2/uH+oM9a0JVF/P204uko1MvqwWze/gIBebIovA
         XoBbdu7c2zCcMCWc/r0waR7EtEihsJCUsgAD6mUTbXjK9hnY/c0tCAk75g0uLfjU6tlk
         aTIxkCUxTSnuVk/OJicUAbXgO2OLAlksaTyaYyc0dwfsaYPsbwnm4qs0OLxFYZAyw49i
         ZXmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWTVOlY2sik+0otIYvwAgadH30Ae7z1SQpwh1zR23v6zxVUcjQ42H/Uj6UKX6NE5DVYlyoJKe9uNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kKbCn2MgUmfLAI3PLvMIWtvHba82XT9Ft8jtgimwVSjZJNVxiK
	vh7rzYsxwfiK/KUASyyNxtipW2Ki2oXYJkCJlWXy6X9xo/f5Oyl2CIY2
X-Gm-Gg: AYBFou3RCti1qmmrfhZl8HS1C5vpDpTUmmazIZmxQZJFISVnaZJPsg3HHfAzgkWOWcg
	TzAEOrQOzm6sCECIQVYylErsQomkhxaBoWt6s3fKu3YlarwBUi544L4Lp/vn8FiVLfxkKdntVmq
	dLezApsrNknOYKtyaoXMWkErTMCMKm9bozOyrPxxtXT0gASr86n+/cPDT3ixg/5xbKIOa4Q87fn
	QkR3WshWNL6LFgQGety3hgieHBOpshBLMrs31E12/EJ08WzYx4cN7ZAGV6CPcJ3j7IbsgxrPscP
	nOtYb91mNhNNirC4bUQDuyNtGE1lEeQAvmDNC7vFR6o+7XomApNfGoZ+3dngwCsvU00EX5OKlIL
	R+xMIkcYfDOM9/+cKBkY6PajdyyHLt/t0KaU16FJKIhb8UNsPNE5rsivmb+ol1c3IJuD9u2oqHB
	hUVff12cdOBic9IOVmsK6mULu/2AuOm4TrHYIJl7Txvc9NMqqMSf8e+EeNWwWyUd026OTjTb4ev
	D8nH1yXB1Le8tAN5gSiSaMNSa40tBnwAFLFLOZ8GaVJ9WxFpLmvDxQ69aUhlGyWOO5lxQpfLHpM
	/F3HQPv77q3kJTrz7vePTJUufNY/jGeNmLFXYehoAlR9RVlGjt7Dz9FkuJPltnpZ9qBQClr5Zho
	IwQCoHgXqKw==
X-Received: by 2002:a05:600c:8b88:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49cffde8d95mr350363235e9.23.1789011144508;
        Wed, 09 Sep 2026 20:32:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b3d9-b901-0402-5aad-0ef4-88ac.310.pool.telefonica.de. [2a02:3100:b3d9:b901:402:5aad:ef4:88ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c494basm34734585e9.12.2026.09.09.20.32.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:32:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] spi: docs: Use the multi-lane mode constants in examples
Date: Thu, 10 Sep 2026 05:32:19 +0200
Message-Id: <20260910033219.15996-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The multi-lane documentation names SPI_MULTI_BUS_MODE_* constants,
including in the transfer initializers. The interface introduced with
the document uses SPI_MULTI_LANE_MODE_*, so the examples refer to
undefined macros.

Use the interface's constants in the descriptions and examples.

Fixes: 05c3bd745bb0 ("spi: Documentation: add page on multi-lane support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/spi/multiple-data-lanes.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
index 69cb532d052f..802aece35d56 100644
--- a/Documentation/spi/multiple-data-lanes.rst
+++ b/Documentation/spi/multiple-data-lanes.rst
@@ -127,7 +127,7 @@ field to indicate which mode they want to use for a given transfer.
 
 The possible values for this field have the following semantics:
 
-- :c:macro:`SPI_MULTI_BUS_MODE_SINGLE`: Only use the first lane. Other lanes are
+- :c:macro:`SPI_MULTI_LANE_MODE_SINGLE`: Only use the first lane. Other lanes are
     ignored. This means that it is operating just like a conventional SPI
     peripheral. This is the default, so it does not need to be explicitly set.
 
@@ -149,7 +149,7 @@ The possible values for this field have the following semantics:
         ----------   ----------------   ----------
             SDO 0    0-0-0-1-0-0-0-1    SDI 0
 
-- :c:macro:`SPI_MULTI_BUS_MODE_MIRROR`: Send a single data word over all of the
+- :c:macro:`SPI_MULTI_LANE_MODE_MIRROR`: Send a single data word over all of the
     lanes at the same time. This only makes sense for writes and not
     for reads.
 
@@ -160,7 +160,7 @@ The possible values for this field have the following semantics:
         struct spi_transfer xfer = {
             .tx_buf = tx_buf,
             .len = 1,
-            .multi_lane_mode = SPI_MULTI_BUS_MODE_MIRROR,
+            .multi_lane_mode = SPI_MULTI_LANE_MODE_MIRROR,
         };
 
         spi_sync_transfer(spi, &xfer, 1);
@@ -172,7 +172,7 @@ The possible values for this field have the following semantics:
             SDO 0    0-0-0-1-0-0-0-1    SDI 0
             SDO 1    0-0-0-1-0-0-0-1    SDI 1
 
-- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
+- :c:macro:`SPI_MULTI_LANE_MODE_STRIPE`: Send or receive two different data words
     at the same time, one on each lane. This means that the buffer needs to be
     sized to hold data for all lanes. Data is interleaved in the buffer, with
     the first word corresponding to lane 0, the second to lane 1, and so on.
@@ -185,7 +185,7 @@ The possible values for this field have the following semantics:
         struct spi_transfer xfer = {
             .rx_buf = rx_buf,
             .len = 2,
-            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
+            .multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE,
         };
 
         spi_sync_transfer(spi, &xfer, 1);

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.39.5 (Apple Git-154)

