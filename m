Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746552;
	b=NdgChZLYglU/ctZryJRP9qBDzdquazwslWvPLxGNcFOsIj4f7NqWrz1FCzY0+ICib+tV
	 Kg1mwtB0wLHQjo6VdFbou/ijG+r7lJUnR5hSAGlRfX+sVbEeUucGn6JSrJBAyeAw2kPKf
	 wnybcp4s++yCYTisdRtfbEw+qq826kIfiOGN6m1y7oJAzqIXZ2zEMUwvqYJdnlT+dUC67
	 lMIPcNKFTN/dwfQWE7IpkBYLzWq3YtgK0XMjm8Fqjf/DD/hFgd9fbB8jgpdjSRa8XW4JF
	 d+UoFBp0eZmC9epcD5UauVc4GKaP6Fg4uW0/J7sjRrtd6De7raeOq1YTbVOZh2UCkJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/D394Ecba967amtQqsxb5O0eSOcZtWIV6LiZuDDoTE=;
	b=Oua+NMegObzLjPedpDeGQdkBZ/2UZSTGIo32bWDAVXjv9+AXIaW4x3ZUMymzXe6z2/kv
	 XOwxhbUvgefhZRqBS4I/8kKhGD/+8qe5iEVylpTK8ezRVbalhEa7qZd2NVKttK3BjNcqT
	 SBzm+tzemUQce3uYMOfkar4WUiID17FnTeksfG5HlWEU9lWxTKTctS71MeD0wDW/KscL0
	 o2bQyyg1+LM8YesAfSD8hxa3AcLLdIUJ3PM5bCj5gx4rmM3h7GiZFdTbhvWhwjtY6+Z8A
	 VbuyrMjSkJajRNc0hXnQ8BBEAkALmeBThQ5+3GcZK804k/f7L8/XB2Gcnvl8153i0Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVhGCuM7;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE29606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DE29606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVhGCuM7
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso63560b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746551; x=1794351351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/D394Ecba967amtQqsxb5O0eSOcZtWIV6LiZuDDoTE=;
        b=VVhGCuM7iUG5tYPgXFnXKv5mU3EkTawKdI++3aNgYt4R2LaphFgBPR2zaKnqmg57XI
         zfbIXqrAIYkpv8HBjTGiMbn9HKXHRDeRW6wVbYZWajcKfn7H6ca50r0EdxSzZ+RHY7zx
         B9Z8Bqh1dgM3Bc1e7KrLb1ua0loc/bV4sjp4kGQ/LkfQ/4ivXJ9VvHdaPqyS/HMHlIEa
         IQNnpb0hOGTCMTqunP3qsbGgsD4+wjc0INyAX5kFJDriYbBp6BeG8SgYw6qj1xrtDmGL
         wM7DIiVgPfF+Aq9dJtGMFdDCWHn9CIdQDksqU7qJN2jthXSObbU5e4Y5sDv3g5XidvjQ
         Hd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746551; x=1794351351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/D394Ecba967amtQqsxb5O0eSOcZtWIV6LiZuDDoTE=;
        b=CRwIYpgmEUl+mpbpQkW4KwAr+fqU7/tKEBdgPHzBoqydIRcOGkDTPUwICV+/+XX/Ml
         mhZ+DBbKIFKB1QuOsVTQ481phHprItCcQhNjqbMVtNM0ZVzNQyJGHWBCuzrup1gRE2BW
         7dLemRa6AzhzewEooZeZDg7BeDmDruSozTptpOWJ7S97u6Z4XHoCR3NnNO93jItTRLQj
         l5zE0V4EIxBEwjN4Y1//RBIPQZ1yNrSZUaKNPIqbm7J6sDwAw/iUwai7/naZoXEuWe4/
         a2YAlNybkYhFBCSoUCAUnfMHKst/ef4QPy033+xBT8HAeXoKUiZ3l045uZ+ToT3waDVy
         UemA==
X-Gm-Message-State: APuU4Z+ZBsyw7341b9ezwzM98R5MfRCKYCFbVJrkeGAG50RQeJBQfEzD
	NSgH1zEXczI4Ba5L7QmP9pVYYCszxS69yOE9tNw5aRzEhRSBGI2LzKtQ
X-Gm-Gg: AYBFou0bgLur3RE1/sfk+2hWQMwvDlc8RmRiqHAXOI77VUZbrzwYtH8hxSvZt+cg328
	p6OqDpzbWX5ruk5Abd6bmwHS16BVYdn0p3xBqUTiHLeQPwRvKnfFiXof/RYmpFKIf03e/142FA+
	q0QZ3+j9cxhP17v5+o6uUhMsf8GM6w0ZJgHzTL5MMwj6V/K9wTJqQlegTp7j+PAR3xulNhL1mrY
	e9UuCftNE8+u5dXRRqSAWqk45WyJIaC0XJP3jyXX7H+mfY1xvj96Z1qQtSJ7pScNs7Uv/UVC6WV
	3Lx2d8/atvRtcKBtzw9l/YoRFbmp9DzJXsxFnbB1vfsiH4BV0ZJwW/EIs7pEyR95k7MP6HTB/l7
	ZECOdF7QOqc4mbLlwkRuK2KtdRvMn2y10+9CVJOopTjq/yNuL7FXWezMm2xWWo3Wz9iEYgZpJQn
	RPC7pEs/GvHy0Q20qBEM5aicS+KkE8AX2seP9pDbbW9Y9o/OpIuygmTJz0sGB8Q+HTPlX5ce8zd
	zx9qwRymaLY6VD5SjiOBSuBnZdCK28Y+NUafW/1EDA29Q+PXuNLPrIPDvqAXjd33NZ3cssremWI
	XgQ6+x27A0X5EjIxAnWmsvmvwFmvnsHAKW7MLaRKy62He7G9/lHeYs+CZV67ucmrTtgUOoqo2SZ
	Y1uI+xUnepnB8cMTM3Z4M4HUTbb3draD8zsIFB3NmmWAYTky2lZq4wSIite9/7DJnZxhH8dn0R1
	KvAZdpxAznFzX/RPN/+A50ZJZH0yet65U7kHmKxbGbCkmeI7vGMwqoW7o7dHc7RQcbZw==
X-Received: by 2002:a05:6a21:3a82:b0:3e1:d99a:8e82 with SMTP id adf61e73a8af0-3e928aacaa2mr12204042637.3.1793746551491;
        Tue, 03 Nov 2026 14:55:51 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:51 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 5/5] spi: Enable lock context analysis
Date: Tue,  3 Nov 2026 22:55:22 +0000
Message-ID: <20261103225522.3643901-6-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225522.3643901-1-jctchan@gmail.com>
References: <20261103225522.3643901-1-jctchan@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

Set CONTEXT_ANALYSIS := y in drivers/spi/Makefile and
drivers/spi/tests/Makefile to enable compile-time lock context checking
for the SPI core, controller drivers, and KUnit tests when building with
CONFIG_WARN_CONTEXT_ANALYSIS=y.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/Makefile       | 2 ++
 drivers/spi/tests/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d4a806b46b2c..60112e379bd6 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -5,6 +5,8 @@
 
 ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 
+CONTEXT_ANALYSIS := y
+
 # small core, mostly translating board-specific
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
diff --git a/drivers/spi/tests/Makefile b/drivers/spi/tests/Makefile
index 6dbf53643619..db716eaf8c43 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST) += spi-core-kunit.o
-- 
2.56.0.385.gac671c819a-goog

