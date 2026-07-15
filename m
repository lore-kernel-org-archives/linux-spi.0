Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA093D4119
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154267; cv=none; b=Rah/F7a7QqIn5G5pkicl9SyAgF2wl/7E5247tZwnez2nbA4GLVMlWoL0O2sCqzrq1ZTHWvl8csLtnp3DUM+rgvEhpshmgMgyps2+egWnIdp4cEFtxx2Ru1Pb/mqUsnw70d9mMeIkAn39IRyxc6R7UebI3S5tYriMn9wSZWvMIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154267; c=relaxed/simple;
	bh=uwqN8ydh2yWuiSaCkv//cC0Jf+pSP4PQ94Q3elX3Tjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4BWxbR3aeEIFS6zD2ZnbF+JUVv9C8sKpYmXQVgcBscILJtDETRbhv8flkR8Ntpht2C6NSMw6v+cblqpYvQrwA3TF11YnAcY4gEWeI+VST49O75z8syvUXxtQr6NF5fowjNdKncxePPRDaWqLafKcsrTR7pM3Y0ovxJl/eLNNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzLAb8nC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzLAb8nC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f2e39e81so23494605e9.2
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154264; x=1784759064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rx6OgR/abZgnW2Cg5Szzka1rX315tDSAtj7sx/+ljSs=;
        b=CzLAb8nC9/pJJZLt9pRVHDhYDCqfff+rAB66/hoKfd3MlyDLuTuX4CbWHNTOnQD000
         hfRswV278jk+SHRnfpZWBdGdiouhILr1/TSqza0Lye6vy546rS6j7TQbq+FADfg6Kjmj
         JTrx65mVVfVFd1SYky1AinOUxHgtXYoLKVirfkM0NM/5sUN+l+aIV07kpP5pd8irOqvM
         +AqTtc5sfD8HYTw0ZC1yTugf/VDlps39+M4pmMYDgP8hhhMiBqHDXlcGfiBacJuW6zVN
         IJX+wXDNt1EnMH2S68kEH7Xuq67Srp8H2gvIF6qeAJMRgTbxBOebj4sOgQ7Cfmwb46QQ
         +shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154264; x=1784759064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rx6OgR/abZgnW2Cg5Szzka1rX315tDSAtj7sx/+ljSs=;
        b=rD+daOOgmSAGcHqpF9FVV7gaJRNm9U8HV+ffZXL6CSCvaFwmXDPPCvnM1SQueavY2F
         binMRmTPPhgqzExbBmpz6jcsFipTXIEzbZ8dm4jTgDB5usKW1r5IRna+RaK0Ob3KvyeH
         2lNj/dCVIUXVAnH4JB21ZIWV31pky3RM/qquMWKRzypn45I6U0Ztm8pTcfBL22CRsCNM
         WHjR4i1y1nr0KM4AzsCWSTV8428hiMMSAyQ5bcm9zi8kTPiiXinAG72CUAKOEsXnPAtR
         9GXnlMf2McHfQwXq3l2Adis3HKRMpxb+O8+nXYw/nwo1wYk/Wih3ifIm3gJVBx1bXF+j
         8WyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqazFhO9AMO8L9AL4bOq4GcWOVErCfAQQ52LjZq/udFvPc3UJfGhqIlYMixxKGRNcMZNxtJGRDIqxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxP0BGH49+dD59SUeXxgF9Au5faUKWTI4KwmV3tnhnDvH0egIP
	oVaZtgGUhb9iOn7qiR/Wrup33bybUTu9bOwF90D+vXeBHnLEjvYMQ8Ef
X-Gm-Gg: AfdE7clViJ+qLBCBSgyR/XgF9qBQRk55Mcw+aYN/D4V9wRxysexe5X2nfhXZoM07vtn
	aP7NpF3z3pX9aZzmI5H+cvGcWKjYC4dmfzZ+f+mnFb2Nm8NAJpNdbJUOgPHhS/1shlUpJ9nCxjz
	+NqaMDUo5f+uqrJxhQL0scXX6lGYUV+8jAsGiiNjjalA6hWJIeGiHys9CooDdR+JIxwez++nslj
	vtmaHNgXhzAl3ErE0kwHX/fag0VKDSx3K6MjG2e4P7FY0aobZhF3J6NSIcZ7h9+XFuTPVZnfNWM
	t0ol2pBEP8WHWX04ASJzhFs6gb/bHar9CrrBuMTt8Akb2/RHKIoC+/xpHQn6uDjiv2fVibLPN/L
	W/HriM92xlXGg+p4PV32zk3aEg1aFGJdqbYvpURzRZXFRL1sxQNM0uYHj0zMZkYwdZp6NVeo+Yd
	/QAKn9eIXdKoXy9dnsgHGT4Tc4uJtH7dsteAEGLoCE14woVJl/EPdKB2Ww//YHpLKteAonyMcnk
	idbQTxVEzEJm2yw
X-Received: by 2002:a05:600c:8b6b:b0:493:f6f7:299e with SMTP id 5b1f17b1804b1-4953c273d48mr49140665e9.20.1784154263651;
        Wed, 15 Jul 2026 15:24:23 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/7] memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in write path
Date: Wed, 15 Jul 2026 23:24:13 +0100
Message-ID: <20260715222417.2997712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Program the XSPI_CDTBUF0 TRTYPE, DATASIZE and ADDSIZE fields with a
single regmap_update_bits() call in the RPCIF_DATA_OUT transfer path.

The existing code updates these fields through three separate
read-modify-write operations even though all values are known before the
transfer request is issued. Combine the updates into a single register
access to reduce overhead and simplify the configuration sequence.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 50294e5d2bf5..e406afc42616 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -660,17 +660,12 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *xspi)
 			u32 bytes_left = xspi->xferlen - pos;
 			u32 nbytes, data[2], *p = data;
 
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_TRTYPE, XSPI_CDTBUF_TRTYPE);
-
 			nbytes = bytes_left >= max ? max : bytes_left;
 
 			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_DATASIZE(0xf),
-					   XSPI_CDTBUF_DATASIZE(nbytes));
-
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
+					   XSPI_CDTBUF_TRTYPE | XSPI_CDTBUF_DATASIZE(0xf) |
 					   XSPI_CDTBUF_ADDSIZE(0x7),
+					   XSPI_CDTBUF_TRTYPE | XSPI_CDTBUF_DATASIZE(nbytes) |
 					   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
 
 			memcpy(data, xspi->buffer + pos, nbytes);
-- 
2.54.0

