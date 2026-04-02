Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940330BF68
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095183; cv=none; b=KhkIc4LKKbWM9YtO1frwRpoVvpCo20ETLoCMdQ1pEoChj6oBRlMJ3JMsmwoGxIu5HFdY0/3tNs4Q1PncwmsKs7+9Mwsbz/1RQXeHEtaFvj8Zl+bHhVxOTZ0RtBn9px0ZKoHDjZwwF4jpfl/2iWoNSq6VV6EtWbYF06Mq9JsMPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095183; c=relaxed/simple;
	bh=BDcoGzUEgpCGDfndnWpejoVBe/vKuqQ4SnpVtpHMd0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmFpaKvRSh/k5FMoKooCobSDwhtbOU0rsk5YFwFr/1JCWdY2T4gaSx2O4MAtO7Yb95WhCVB1j0tzsKuTO3/wGNkGJp1+Ez1b+WgTMfJp1JbYtU/JXkcLXwfpunPc5OKjIJkwQsZo3zUU0mi7k3rY2ys2/fbJDQw3kRS7qmA41Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JyUMCfsE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyUMCfsE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24ddb2428so1993535ad.0
        for <linux-spi@vger.kernel.org>; Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=JyUMCfsEzJUvnAMUaH8pFk7JOJz5S6j4yc2RPRMEDvcR7+AHkR2RcjSaIaWqcS1bk1
         pYXgyC2RR8ANzfyWQI2dZu03PBe2k9eQDah7UHIYUoXK+HKo+CrxeS0+HybIbbmEtud1
         M3Tr2cQDeNwYp6bFGqBDUUyAFrSsM5AQoXgXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=mkJL5MuyWggP1rTIfTV1d0QiMhtpkYMA4/llLaFjyWIIlGiUi48RqXmxaKxPXu3hNw
         Qk3D4rEbXdQJ1nIn1pQkPbzfTq4cXXbMf/WA6fvo0ySbFckivN/0QsrFahG4SL9Vu7iy
         HKzP3UaWtOKzaZil1OOGDK9AvyS/yZAJxP7TWgYVYNWu5ld5juFT0mxYvNlGyiI4YTMQ
         KOfmTG74ZNVOErpk6z4Rlt2a7YY4wATmq9KeLndjSrZ+/Mc91LvNbrNfejrVJZNbCowx
         u9OJsf9MWex5wcfHndoG9WryJM+PoHhE5ha99KRpd/9aYLFdPcBL3Ct42rBrapjblar8
         ZScg==
X-Forwarded-Encrypted: i=1; AJvYcCXCilaA+zRX41yVmz5IU8KHJhg+GZ1XI2/u/LdjXflMf53fOS4wFKeKfoCg/G5N+eqD7Y5Cap09NtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcwJqsiRBtfzs/iSyAyDIX+KoFXyUJkeu4PGyNU9AeU8MB6/t
	Q9wgP5sAWyllf8ZOkl3wbJDH5DUJAGgD2SQ23eUkJy0Noobjnx4GHc1g7kTmU/4a4g==
X-Gm-Gg: ATEYQzwc9KKRPqpemonT9s1b7KtoiU6vNcvZC0ltLxwufK12ccccfh6nUMai+TG0i4L
	PEBOQKF1H78ewTVWUYzFG0ht8PhWjUlrjFe2mDTtGyC8+gwze5vx42Oi7FIZcS8eqfsco2qJWpi
	J3chcPmhDZ2AcjC/Apt/A6ba5JqZqe6q7SDlDzEwVRral2n5P06kUMHA0acWjb605VRIeOvlY59
	exDkPJp/SkR2qT6sUK4tIeb7nLaQSeOCv1U7IBqmo10i45O7xp/MvZLPeZkJrxsSxZvGlwFMp+q
	EaxNnnZGfAp1AYzGbf3YF4q/CuJN8g94joDSS0fSLwNDrM/o2W9S5O0/2oqzqs/2KveAZc5mTHu
	S8xLs1tVAIWWd9oVkL4zWiIen2KybbTVLB3jXuYlave+8zv6oWMmkTA9dEkZU4lZwOJTG7OzVZn
	rSERE7dIc8RnL5EtQ07ftbJMhF3943RTeeO4yNQIPDzfhmWjFSVYXzy0LQ3qez7eoE5RSqb+rTy
	5UmlGJe/q5GVJcyZuHs70QDwVJT+QGhdQ==
X-Received: by 2002:a17:903:b8d:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b269c9b80fmr50932815ad.27.1775095181703;
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:38 +0000
Subject: [PATCH v3 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-1-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1213;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=sHkk34xkCVNuYNvgvLM4yfgwiPvB0kDmMlwDb9gzQSI=;
 b=sWAbum2KtSMvIZHpotQFRl3qPX0w5lDPo0wVXGjdcQZ4Iy/Q1lBj1M1z1kObb2Say/DR3abDE
 qMXRcGAYSZjCwmC4SoKf0troiioLGh8ZBZYI6TTyyS5zWbVHFTQHQ7k
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.53.0.1185.g05d4b7b318-goog

