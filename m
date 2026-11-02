Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637248;
	b=OAjgvph5myjuqA6mLtj/m8P3O1jJN70OcVJeoE6QTbUPGolsQkgLjHePj/WjX6wopCb2
	 /ryQeyoovtyo3wvlatfkM9vlimHxn3b8INM9wpY1ZKE5/drY9PsVJmgBdpZhwvHaHLvf6
	 v4d1m63ee+ukhUBg2IO4qosUC4lzeqrezimzsd13iTrtBbAAGgzE2/oRdhGVpGsmOTHWJ
	 QN0gcoZ1CgN8sdMc7SXIe7nvKwpDTW9Oiv83lShXvcvyC4u5g1HLDj4oG0HdzcCd8RlAm
	 TUzjBiirlQtePAySj3LjteOZAMont2aNw3F8Du3x/JRv7suer9UbYTdCjyO12PBdBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ao1yH2JZHViXk6mXxgVYSKQcFR8mczu4K3ZbLRv3srI=;
	b=MmKPud28ZyjrItGvOkmKhkyIb5Ei8w35EwEzQz+31S1zohWKv/yTbLUOXIpDufjzLL/j
	 QS5EEKUIGME0+ko80DoMqwfNq43OaRoEkhCbZ8GwZ8oWUOHHDpaTdcFg6rryvAFu/hGFo
	 NQX6z16CGHmC4EDNN07OEXfa1QeEZyjoNGWouFI1KCqWL5lIIHp6WzZwnK0km5RFG+Lhr
	 RHYpptOXix8J3Qsnszpqyp7m9huU4d2II6OLppizbPXRZ3IoyxMBkRrt4NOHMZV2xoOtc
	 AdgTwbQDmpYtvL9OuaL6CLK80dJqgsxeAnJwKVuNxkDBgAWJLklSdZPiLWfalAkj4+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuMM2QGV;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37360A260D
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E37360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuMM2QGV
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso1144652b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637247; x=1794242047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ao1yH2JZHViXk6mXxgVYSKQcFR8mczu4K3ZbLRv3srI=;
        b=kuMM2QGVM345RJwZxZOfx27P4XqfegEbV62gHgPzyGMwxadRrt+6I8m3ccrZH8urmV
         zqDswcaYKPqJNoAtFmujkWSMfi32wz3vA6+2VF178xYPl6eGls2Jtu9hMpFJEcT9G9tJ
         I19ICW7enqS936llm7I3hhP5VPeoB65kbnVS/XM29mJT0WIBDSemklIU9jdX/xybNQoQ
         bnlIJ+LYMRH10ZzxVaTorSyOhlCNsW0axh6jIuvsqHYyrHtFmddrpH703Iz5BJRZ8i2M
         ko9Hxvjssa4qtG8wBUqT1uUszc6yn3zSFeIqBxhgopkvsU4hN68r6B3pbcs9+fTE4kzL
         eZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637247; x=1794242047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ao1yH2JZHViXk6mXxgVYSKQcFR8mczu4K3ZbLRv3srI=;
        b=jWlFJO0HN6h7i8SuIeiJ0GIkgdCXWyUGtoXVfBfifTC6t5CCiY6kfTi2Yrv09pdtut
         ursWBWM77uMeZeYFd5KNrUtw6qM9Er34CN8J/YnxoIGcz1UHsANwA/RTFHCX6bG++Rr0
         ADL01ragavWMkWZDnROvFTlBXwrYVhrXuvrYeDNz+6yPdC8Oy1jwvFr9WAqMvfcrPvl/
         LdPIIkxWCDFq/rIinF2gq5vAqhkAlqwTLSauzTOhDfAuvTGQKHyaEhwGjjZqBfLz5GKH
         PgFwb7XiniAllvC8mqqzJIRCy22jo9d5cGNwV3ITtMKJH4j2X0dPavpBt2nIgTEi015E
         ly5g==
X-Forwarded-Encrypted: i=1; AKwUvBzNaU919tItijPpUk9IJY1v6KRHI1rdrTx/eJxqpuEjv0bhNMz51KXuqJDo1WNW5haIkeV5TldXmdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhAJuviNdjWNyhJjWYHK1iL+VVN9Vp97PX11GDjtHQ0yi9wjkL
	kg5GZkCIlWiCQt5g1WtTrtavuD7syIs+oe7lsHLTd4ReHYZRGcn/pNW3
X-Gm-Gg: AYBFou3uFq48ek2lZasdokFEDHvIaQ98EH3CcQEq2/WqjpuoXK0tdqmrstEwg2Ip6SI
	QQvMdSUnMsetaBTzzL2VEnXAoDyuTbkXGGPcqsSPiq8gqBI+c0wpQKlFDJSgBhLf8BkhoGRiB+A
	JLfQNpNFY5zKqi7r6d3dg15xL5d7YAR6bUFgI/Nxnha5ZIIgruxNSKl9rVPfku6hAE4imY4hOgq
	OoGe8s/fIc9lsU4aUCW2dwlNDA7L/xisfu+EqHd1YFdFzuIeol0T/BmgIW2OCiYV4dsw/SnJbnU
	mhbjMGCkmB13sQINRqHjAcq/isrSnTakisLOXYSibqHPscttk2cKOXcvPxZFq4l1pn6Vnontwp6
	Zb88L3EOhiSmkWFMX0c24b9IUN4kwcP5ksdE8vDKfFhePPc5EdiLNhEsIZW/6eFp2KkdDAofnq8
	xZ2oWygphRTDia+awx5SzRVsjYQQLVboX26o4UOeJ7dO3BP+xBDAtawhCi+b7MNg7J4dE8xD9ta
	B2TPGnSnwzXE7TiC9jwuBRqTBeQ7RcuWqOos0qbbDIGxyjzxwEZzOb8owxn1MmQEj6XIYD5zHWP
	qLDXplF4HvNnZsfAiKCrGHU4Ywsqfcs4soCe2+xMn71hg3mVeyxibQglfataspMVZHdQ3xf872D
	TkAkve/HaV+GXHD30GiYRBD5YpMVesKal/V0F3NoJWN4dsSuyaE/RBvhOGkLsCfmzWTXFo1vSzv
	iGWvf7HQDMxNKHPimoEkWUyrwjWDd5Dw==
X-Received: by 2002:a05:6a21:496:b0:3e1:d997:e1c8 with SMTP id adf61e73a8af0-3e928f72b73mr8358552637.30.1793637247277;
        Mon, 02 Nov 2026 08:34:07 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:34:06 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 14/14] spi: Enable lock context analysis
Date: Mon,  2 Nov 2026 16:30:23 +0000
Message-ID: <20261102163023.2574632-15-jctchan@gmail.com>
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
index 9826626995a9..5a4a4f3f77df 100644
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
index 0ec04ecd4d55..a9b804f99b4a 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
 obj-$(CONFIG_SPI_CORE_KUNIT_TEST) += spi-core-kunit.o
 obj-$(CONFIG_SPI_TI_QSPI_KUNIT_TEST) += spi-ti-qspi-kunit.o
-- 
2.56.0.317.g454f8302e1-goog

