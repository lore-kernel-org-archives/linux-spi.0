Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92E489FB7
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939303; cv=none; b=hdE0pDKZwJ+GVOoRMJTtL0WMs3+si4XotkTfyVAELUEEf5HU1DagAiYBpl3gih0ulCwwup5vLGyG/Cmq+MIWuGkzaxSsdVM4ol4tSvfHXuZ+3JaZSsIxXYWsFuCXj0RRbcfbkqlaiWVGQRMJZPbPbSZR6X27xR69GxAr6/mQJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939303; c=relaxed/simple;
	bh=WcCYelFSOhbeoMxtjGueNhLN0g0ypi6G7QGQ89YUic4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsp2mFaVUghh23vvFr0ggwFa171rBwA6i6XSu5EpEEKl+YO/4YzyOeR/dkDEOX1QlIKEi5A8EXBPGfpaYQiZhmllKUJe4ft0q9X5aEAKjbCflBVPlwyDTZ7/MX8qZ1idJOftlt+Yft4At1KxHuGPnMfxcbQ8N9YsaJWVHGyQr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJDh3NHu; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJDh3NHu"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad59dfd3a7so502458a12.0
        for <linux-spi@vger.kernel.org>; Fri, 02 Oct 2026 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939297; x=1791544097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/U30FypKXGiK+JknnhSRfyksD6iky5csMYxiBRiMgs=;
        b=cJDh3NHuYRLE5NHQCTjdWq7syE5si5MGNZ/L6+lARtOex+Mz7AGrkOFGF3Rfv26fkh
         9gT5/J+C0IVjouiFqa50Qw65NCnUeCLvPfdDHew5Tb46snFzM1dLoZj2wdaZF1n+ftOb
         uPZJKLgb9HXNipE+x7Jw2zHT982b09d65VfAEFj3r3PgSLlGhn1nLVas8zJ7lPKb/pcD
         j6ozhq/kS4T4aVNhgLpqzhFhMgPMvUfaaM7F1yoDwqGovygAyzwMCG/suFyzNBQhCUSl
         ZQoi9jx0zf/IKDMh+0Y+bYd3kVsjOBZ/OolPc5dN6fVf78Jtb+I2hSRzkousR/53Gs7F
         21xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939297; x=1791544097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/U30FypKXGiK+JknnhSRfyksD6iky5csMYxiBRiMgs=;
        b=CgUAXIb3aZp9BcckpOf8CLF6HLLz6A9fVd4qeau+ERJTuBiWbUjXzMUSCsJM/u2wQ1
         XGz2oQu/i7v/WEVksc+3CJHls+sMZo4hSK31E8M/wf6HFdZnwQi6TdkFPbBcLVLHb1jT
         Xq7bEYVYnycXH8MRnBEUrY/jh0kF3XiUX4sicXJoDJ6Ptc0AbmnZD4o/CgyH3diVC2Qe
         /rSPBQ4N9OayZs7+kqG+nofmeTPpgfu0Ccdtb7h6JMSedC8YDgw8gB8eIodgcIB0moud
         kdzCF7+BrMVEFuI6L7mHLYQQYflPgi7mfX+PQojuw+6lzybH/4kkl6k2v/CgIrdC6We9
         RM6g==
X-Forwarded-Encrypted: i=1; AKwUvBwcD/HxHoxsRzxYyqzi7Wg/AfwZYLcBPw+fVrFTZMnP+Z7EQEPY0g6+cLqvu9RkECyrB13KjORlz5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQdUsZ+m1Y3qcNdtM1KBpe5bScFbJpaNqAmt2CbWipf8CFhBs9
	+HdR1FIow7jtlHS9+aqyPR9ueUGAq1rPYpr1wTfUtfWJT36VlAlWsdxZ
X-Gm-Gg: AYBFou38KeyKAOtghi+F/iVqU0u9mr33JJveCxCIVQp1YldtzyRM1/OtHYSywmUkHLM
	k+N0EFW5M3SkcSH0yzSkjCie2KgCW1GU7OS/1iUxavRbB8uPFlZZGijKrK/FdG119V+tCHUJOzg
	GnsSWgSEyn340zeTZGZF+32/xXGzNBUjUhrtll/cKDIQNNlRcw05zxot75ZZ1ZmCTFrMXf/V8vU
	+FcAiTCpmk9P1dcGh5pY2Pj9jN5HXba8w42XrvkLP/BIdiBcptmLUzP5h0vaU8+gMlpiFh2vVD0
	NFxv5NMOF0r1L5ebznhOuMQL7XkzpxRKbNZqSBxIdht0RQZVkku+8B/cLKXuP7TTSzhqvoerOFt
	1+MRvi1UyZTxkqCxYkfqS7fkNFv9D8U9DI60duS1CH7SH0aLhYrbGMlVWSa+5BehtD/4hpaC9aS
	8/tgQewILTDectlqh33foyYna56YROdeEml7PjN4fmOuWOfCZIGAajs8UU2LZVSMxEqGrU+o2sl
	zBOyyK0DeuuB1+EqF3f3tw/7dxhSnKnAVaPcTOFK73khqroYijqIzLt235tZ6gHYdd32u/27+Ar
	r+JL
X-Received: by 2002:a05:6402:210e:b0:6ac:c1dc:fa1d with SMTP id 4fb4d7f45d1cf-6af9de987efmr1696666a12.0.1790939296938;
        Fri, 02 Oct 2026 04:08:16 -0700 (PDT)
Received: from localhost.localdomain (ip-80-113-107-207.ip.prioritytelecom.net. [80.113.107.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9dabbe89sm846216a12.34.2026.10.02.04.08.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 04:08:16 -0700 (PDT)
From: Jesse Jeronimus <jesse.jeronimus@gmail.com>
To: broonie@kernel.org,
	corbet@lwn.net
Cc: Jesse Jeronimus <jesse.jeronimus@gmail.com>,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dlechner@baylibre.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: devres: Remove non-existent SPI register helpers
Date: Fri,  2 Oct 2026 13:06:46 +0200
Message-ID: <20261002110752.89529-1-jesse.jeronimus@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9b894d65e978 ("Documentation: devres: add missing SPI helpers")
added devm_spi_register_host() and devm_spi_register_target() to the
list of managed interfaces. These functions do not exist and never
existed in the tree. The only managed SPI register helper is
devm_spi_register_controller(), which is already in the list.

Remove the two entries.

Fixes: 9b894d65e978 ("Documentation: devres: add missing SPI helpers")
Signed-off-by: Jesse Jeronimus <jesse.jeronimus@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5067500ded5c..4f0b90e7e138 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -460,8 +460,6 @@ SPI
   devm_spi_alloc_target()
   devm_spi_optimize_message()
   devm_spi_register_controller()
-  devm_spi_register_host()
-  devm_spi_register_target()
 
 WATCHDOG
   devm_watchdog_register_device()
-- 
2.54.0 (Apple Git-157)

