Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637233;
	b=XlX3fCs9jS7mcNU6Am2gREM+Etu0hsyoFg4KVSPR84OLMwU+fq9IDBaQ+v3wDkilPEAH
	 eaBnrx/A+qBoAju/M64y3cs/UTiBaX+8goY/0jfW+CT+H/n2X8DLa7N2OfPru6FMK1aIb
	 EFn8R+GInBpDCiUQIl+yMgHZGziC5tptxFniYNsrqSNjehEh4zijanV4tX4gl32UV2JMl
	 2l6CuDc4MkZVHHC7CRSs4SrVAz1MpNHs7bRGT6gpP2ZwobzT6ajUcwJI4q+yWDhUdGDnB
	 ZYKMlLrnM+lhdsrYRAOIbc8ckIC5LgD+HZfYGK11ef6e5ltHTb+JxFtlk5mTFW/Hrug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
	b=HxAZmc5Wja3WqpH8rfZzw+PPx9pU5Ri8OnFp9VOvSsPio7GTFGn/m+PX/ciO5gQSGBqW
	 W8Rm/NbV4JPhuzjOse166Urbvbj4Q+0etra9/lfQZwWZV9oZeoxot9ugiTpUzTvHVU+yx
	 bsCm7h5QYKOTsD3siLRXE+6iF2xgZDDtJnYMXb5IIQZn4xVHuDw8hSs3vcMDh2qLnwzuV
	 LXLI4StzJSf/++MgfzCkT9aIi7rTiKfzbJax4hyEjGGLOaDuEKlFalcgRQUo0QjeNnMRH
	 HR+0/JZyN0GxFG1tf++6eG+/62bRWMZ3iqT5MnIMKezC6kuvfDuV/W4jh0CZogh8cLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME3X5PBg;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BB60A0C9E
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 527BB60A0C9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ME3X5PBg
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1351050b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637232; x=1794242032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
        b=ME3X5PBgb9/pAJnL2YDewhmS+6M7BlR9ikwI+RBbGRzyWYHDgTpB5chHHQQcN0jFIg
         D1w1kcXcVHAYGo+MwONSD45Z+mWNPsgzoWG3Rlf8ziRzgyE9bEvgZf1uwDtRlJlev+zh
         OSovjuI/1Lhk4iY2PpLAeqbo8vVApLCg+JJgg749bvAgeXTGDeewKEwha9ovaYFc8lnL
         o2ZevIYPv08r/ystkb0GU5RYHNs49g5ADtibJFEyIVv47QXaq0dKs2QwBA9JWEIfQjVB
         s8p/sAi65VcavWeZ2nKGQgt5s5XLFEElhjyNL8j+J6iVmnPXeowiUgiR9+gbioWqAAlD
         XOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637232; x=1794242032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC0VD9K+GRm0JLEGdvuD2m6j6IAs+ZIVhO0JHW5MmvM=;
        b=AVvdY0REt90PdUftlmYVBuvsPhe2vj7eAKXhz12jfdXV/iRxGycMdBfeCQuwecdxVo
         z/OFCvbDoudkYcEYQhAkmCr+mVPP1eTrj9gjAPUD6oCh+Xt+76YbILps57jwpodD6Gzv
         RcucdpmJJL31Ct/CdV2PJP1FVlsvg2E27djXgypNZ42SdOC+a/pIIbyzXf6gWMivGzmq
         Q9PK35yCjKl9l/T1lWrbTaajpGVHX16X6qvtMiDL5zXMNzehkB/VGlMiYvWmh86aYykU
         S/yf0HLj2r02uccqXbtD5G8yyh1Pt+2THe8m3Tq74+aLr2XTe1wvORaShoSA0NJL1/RE
         SCew==
X-Forwarded-Encrypted: i=1; AKwUvBzHFOS9MQIWFN9K9aKCZaLmIE8aJBaXKCBtXwFeBIUcPVtcQQ4/vaiEC+kcrbnGmc73+R3+8HoYFOw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gWkGid1oouGnZ4U1GhzjEnCd+U1WwsJXc6zLmajGNCzyCtBsg
	xmtRgqLHotBMOj4dSQ/XQ3Ad0fS2FOO74HGlcybyt6JoYDSb9esZ9XKf
X-Gm-Gg: AYBFou3+x6/yO+I89KG92XSjSeTdJ1CO1zIXsdEYX2qelUPdoa9KPuQvyP4KXX3IfvP
	7c6DHRyoSIah2MGNk8Ehu/ut/4LYTESZU4QfjlocZvMyV3tPVtTS8Osv1CxaF8Yr1xttcv+IWYX
	KnvhEFDrRUaUveHmUqBLH3+2ZpCufpEl+TyX3G6M1hWe9IgDWQpaDaIk1uhGX8XFDdaOEEQDTwr
	O5U4PqBdPGJ9gju8oubamd8PZa0Zo7fmHVm3d1eXgHSkXVdkpSl0M/RMHr9jB1+1Bl119N/ebs1
	adL7l8DUha9GH8y2EKedD6H9o0fDSQ2GX2rvhSMPUhAdtBOTju/lApZ5OAH1XoJsduAzZvZEaxV
	gqFs1RDzzQmHGoyKVhbwTSJECDNrw1JuVN687qlTdALgDz26EUj3VBiozvRZlfXeJLKlMWYuKyc
	egC1EjOiW4qNSp+0XjHQRG7U1tnOMNmP9f6jZvrojMZO2I3cZZ8z5XUUbyf0cX/3rKdcMCfcD+E
	R4o/aqRIYhSGhQ+bqqTGsHBA/oueTShr3oBT2FcnbU76EW74ewHeW0lWusMiArzik8qorQIRPZn
	JgJFECR86gRw7j4O20smOuFlpzl6C8B48F349IrfeKI7NUykAyI9kfLPdWTgkmZWwRdm4qUfEFE
	cAHXPG3K+F4BfP0ICN9aAZ8BSrxdCA9bjA9rE8jORH2qbPrZ+bjo1/0iDL7FOzWiHMBMwqa6LxW
	VO/0pTu+u49U23UQKUDNINvkqRt4p5EA==
X-Received: by 2002:a05:6a00:349b:b0:851:8bde:7873 with SMTP id d2e1a72fcca58-8a9ba9f77a2mr8518027b3a.8.1793637231660;
        Mon, 02 Nov 2026 08:33:51 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:50 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/14] spi: spi-mux: release mux when parent setup fails
Date: Mon,  2 Nov 2026 16:30:11 +0000
Message-ID: <20261102163023.2574632-3-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

When spi_mux_select() switches to a different child, it locks the mux
with mux_control_select(), copies the child's settings into the spi-mux
device and calls spi_setup() on the parent controller. If spi_setup()
fails, spi_mux_select() returns the error without calling
mux_control_deselect(), so the mux stays locked. The next message on
any child of this mux then blocks forever in mux_control_select(), and
so does every other user of the same mux control.

spi_mux_select() also records the new chip select in current_cs before
spi_setup() runs. After a failure, the next message for the same child
skips the copy and spi_setup(), and is sent with a parent that was
never set up for it.

On spi_setup() failure, set current_cs to SPI_MUX_NO_CS, so the next
message sets up the parent again, and release the mux. Record the new
chip select only after spi_setup() succeeds.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; that case also needs "spi: spi-mux: finalize
message when forwarding fails" to see the error status. Builds with
W=1 on x86_64. Not tested on hardware.

Assisted-by: Claude, Gemini
Fixes: 5a5fc308418a ("spi: spi-mux: Fix coverity issue, unchecked return value")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 08fe1fa32dea..28d7718138a5 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -66,9 +66,16 @@ static int spi_mux_select(struct spi_device *spi)
 	priv->spi->mode = spi->mode;
 	priv->spi->bits_per_word = spi->bits_per_word;
 
+	ret = spi_setup(priv->spi);
+	if (ret) {
+		priv->current_cs = SPI_MUX_NO_CS;
+		mux_control_deselect(priv->mux);
+		return ret;
+	}
+
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	return spi_setup(priv->spi);
+	return 0;
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.56.0.317.g454f8302e1-goog

