Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285013CC9F7
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327974; cv=none; b=kU10/jzsRlLP2jlnQ4XZ91XJLNRsCrh8d6n0hfUOQPdnBgEvHXzoAZz0txMgkleHAv8TWJdKW3+ihoLl5vLouhC0F0+hO26yPv7UMfl1NRch98EKlNYOs2/PjONbAxrr38rg6bUbKLDdJoYjil1LMsZI+aN8xXgQb7GloEy5tnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327974; c=relaxed/simple;
	bh=Z1SDsa40pLRy8uZbCXpxwacAlGX8VoE5mm2vTI4i4hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLPSvgsh8uIcFUZdcSWTZzLtpIZ6odv95iCz6ZWXcxep+YAyXIjOsh7oBrsSUQbqBfsh0bXqr7EPncqNebbvpFDJk4eVtGRiwt9bPHbCzUA6WZS00K36/GlUTJFqpTSu7APBB3wPAltKqiPFy5C9+eLNMdLDUiFTgINDFh5ytRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=VATFKGp4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="VATFKGp4"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4be94eeacso1320974a34.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327972; x=1773932772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIVG0NEGvvMnZSblOn2xrLl5Gb2A5oGJQYQs/ymyUQY=;
        b=VATFKGp4aak13YrbJXLhruQhdO/rD36lriTAW4znYu/KkTRUWYpUSiYpHATgKNhoXb
         6LdSM/1ESXTgjoE96Dbj0VKptBvYsxkdPZd5iykCzyyYgzGniVuvDLvHaPavUCWKAgIx
         IrXgOOCmpUZW9lJ+JgrZcAWGQpdQRyLRsRKg/5Cs1e8AHHWsDPXfPk1JI63CXl5woIaG
         EpX9Ff/QOMqecqp5ET96LKOOVnOVCH+i6ZqzM5jo1jXTu4fLC0tcJ1hf3lT7QRdsJIXB
         U2GpmTE81JDApcrdxDl/V36C+IwHN4FwEAniP1rOjgEjDR6YmVY/w//anI1//37y32Kh
         p1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327972; x=1773932772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIVG0NEGvvMnZSblOn2xrLl5Gb2A5oGJQYQs/ymyUQY=;
        b=i3TsdQm8JaI/LD/SkH5aY2eJTRJUaAbZC1W4nzS8we2Hkhmjcd2ItdagIvHLSfzEuQ
         42/3O+qbBe9XZlTM2/4x4WHc7ZvwlQ0xDf510+5IcGt8Uf46F04LEZs8DkKt/Nt9UtTt
         UW83rPCWq665P8Zp8s+l/4YpuoDC4Wa0n6ucQU7zUA/Eh2z6uNl2/A0JQMqKGJ7eRuFZ
         HBPlg8NDvYD3oTRxAvvITWZeP2iHSg+BISaytWOI/6RioVUNQSGB0o+QkQWM01dQIPes
         ojOfhrbn7ze8bU0Lf5j3l/RMNLTEwe2C7NEAo+koAb7QGC37bqqmZNy+WDaiY23meFtH
         A9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUkjFuaY9P5IUZSl9H4fRSPx79G+DRpupW0KDTSA/IXx4+7qYzMeY/gy7x2Aw2V/CV8xhArVGngdUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBprPAy6zakqE18dvRnG5RsxJj3D/yCivbfHGNSFwPtX8ZIT0
	fA4iM5YnjHAqpwOJogldJpuAVLB8VRgFcmmln5xpO/iVkrvrXwoYbXNRnNDbgLOof5Q=
X-Gm-Gg: ATEYQzz9dNvnX2XppxdWOpRYcSZMFVbOMtLSymimU+4U0Q7s7msjoAYP6mn+IEcHbRa
	o1IINAm7VMJVNREnAZPGjMFPUBHVY5yZPU3NFZMnyNYHvAPsc5x4/gu7tgDxQlWC+IxPko3mn8Z
	LhSP0hOnHgXgzDArSRKuFIhZHvZMagQZvbBWEiIdxz3myw13d8L6TD4phB+2pUtzuz2r578N6HL
	iAuUPbpHeHwGqHz55gdv0k+FKxdUcnqj8rub8JZta9A+aiWF/ryYPHRJ2RYY+ndnRZBKoTD2bNo
	tFmLCtsDbO1trZxkfb7zNvsm+AYgaePqeATOMYiBXgUTi3P/Nsil8fNBhs4+vT3mgJ7G+CD+lFR
	M2eve+M5sblQQTCgfzAjTfFzLPQKC/PjHhxmmT04XXMOoN7VOXcIk0Qz8EZ0iQwdHH69rmOL3tl
	6v6Ri/W5RChb9HmwccAndbabLozdbbSFKfyu/Q7gu1N5OZo+F3quDtdgWU6HN8nbtlpw==
X-Received: by 2002:a05:6830:838e:b0:7d7:5209:34a3 with SMTP id 46e09a7af769-7d76a7c909amr3711039a34.27.1773327972116;
        Thu, 12 Mar 2026 08:06:12 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:11 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:08 -0400
Message-ID: <20260312150523.2054552-14-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 48ee5bf481738..44e618bab2f0b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -953,7 +953,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_start(msg, xfer);
+			trace_invoke_spi_transfer_start(msg, xfer);
 	}
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
@@ -987,7 +987,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_stop(msg, xfer);
+			trace_invoke_spi_transfer_stop(msg, xfer);
 	}
 
 out:
-- 
2.53.0

