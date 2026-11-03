Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707229;
	b=GlqzFGVdRDyFp2ucF6U0brAxgupXcTmyBGLVR2s1MmQhyT9l/6Wnhe5AUkpmMdqvK500
	 Jh8PK+MDh/1C6LYd+QFjObDwK/LEcW3+BqeP0jPAVzKg6zMpbjnFHj/KjW6uC5o/hAPJ6
	 TBJwVFhACiOyFQLhYg7Of1lrD7f7zFt/IyNJWD24NxSOoM2YCX/Kaic5Dpyc0nw+yStSe
	 4pMbt/jdQZv3OjZZXZJgnaHIKtKpU43C+DN22V3VxX0WYrF80zwTy5lixfM/Wj+wuKXJQ
	 cXvZrH5G1vvqb+1rraKPXP0MnqT5k7CC1z+AFTw/6+JuHI2vaGgIC1k9g4IOcU+tGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KOSsFUtr1KSHLpBlpFa20dTmSBuxFD793ZpB+9kI2sY=;
	b=day/6j4fyOT5B2vPiEYNhRHn/LgpyyvJBe/ljMJaCX4Ty0zF0HOlTlbM3SjfgcoSjE3j
	 StVHnMa7h621NPyC9Lw4coP/BPFHRyFQhq5s4uPirB46qT4KzgMWedHZ884yPmwadgrkw
	 tRkgogT6EGikODsynZWC7Abpsw9BE/XF6N71MUnmpKzAU9g1HX0kEkw1BznlszVT0z3Qk
	 uf9/s2HxQaZOayEjbsTwKbsbMqhMlT72hex1lbSxg4XbrR3cxgedy8gsk3QbeWv5nU/UZ
	 ECGPNPbzkpL1J/+1SFR6AvXB2s1KpjrOvhCg0AX8r3OeAsJmAqY1o3OdI3iAyErbXTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au6hcklr;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E9606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 12:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F3E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au6hcklr
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8b20a899fso27852055ad.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793707228; x=1794312028; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KOSsFUtr1KSHLpBlpFa20dTmSBuxFD793ZpB+9kI2sY=;
        b=au6hcklr3QBZU+LXEdJAxpiFGog14HjaTfceoc/ey56229UuFVwWarln5wh5vqxhKz
         Dm58tTdlhHSiR1pRaS4VlbzNGUY3d3lVQivHZ0DKIFi1UuWhYoUptHUG1ngxgBMrrXhe
         86NfV6tP+PLhHsX5bwdmIcyz+5mPqoBs9uTs3ans7lV107fxCsWOPR+5ShiCAzN8elM7
         xU3iesI0h47NqK4kGNCF6zZBr7BSsORbOOT9ugpXb66JlmysBFKjkn1MPFvOdmf5x7DN
         39UqYYyeemf72ggxHRKg6FLNNVG8Pr7walPMuclA/6cVsz9vV0KR0Iv1CBveplgURMPG
         FeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707228; x=1794312028;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KOSsFUtr1KSHLpBlpFa20dTmSBuxFD793ZpB+9kI2sY=;
        b=s29hwxbRSAYLms7txDk13Ya4xERXnVaJmHjV7lv0CH8XRqKmAdJ5PBwmnEDjwUDaEb
         Ceo72JoeBUWP872QL9JKL5l2KX99ASuab1R+gUXmwrqDAs4x/j2yRfvybUYR6A0adDWa
         KCoA+fMWvTw9X+RswrIiroyIMZ4vPk/VpSJ01ovphAzRDnulNVnO71zax5tt5gwbrVU2
         LcspLQrth252tbpv8nRAuKtuYh6EwqPYK5zJ1Q4nZrm0ipfS+oMDz7eo5SvypneciQLj
         maT8Sleov2MSmvuZloH+LJnEoNhLFCSDRXuQNK8+Hhr2CIyJUT9cTPt58FxrTNjWh6qp
         UCqg==
X-Gm-Message-State: APuU4Z+13JgakGSSR5QGxw/yU2+83NsBK9+z3zXJIx/Ht8q+b+4cHr7d
	0hfkQTZaywr3jKesyawyNmsKCJroHbTCMC0rFaMkBK9G23WTP70/tOMfj+CicA7S
X-Gm-Gg: AYBFou0yX5VmdyZzH1WCiCho8fmu4SYiK2qyk9T0EJq6AzFiEj7rr/3mb2mHktHav1m
	7aJhsnTm5czUaS+QyAjfuM3RM9JIhDpgH4/eZexpgblwchjgldHv74dOKOe0S8ThYjvTovH3H8a
	1h/0/kOeGaM70vcI8Kg+jQl2GlZzowoaHcn6A0IylIUlG8CkMY1w5kXlJ8KKINxR6fbqvMsNHVG
	ZlFqvJvrohRj9r/FOPh/QNMFpOjfrLBKkEo80WkswjyEQVVl1A6Nj4+QSybRUjJKPW/bIpraS2z
	iDP41VZ+Y1Hvd/BBIDFRgGVQZxDZ7tvxuchFLbAhPmGLsygUwonio7tYsloYxhjBWMCdqbsA+Zg
	/Rxcce24ZYoWX0mwyZy3grxDAjxEwHecKkHQk9+VPRGoKx+hfnp618dmv+w9+k6l5ZHhEzQ1QI/
	qhJq6CHAC1RxfT9HhhyeR9w8xDvczlmfDZaPvEQCPblPmACy1ep3xsFv46rWJO5hfiahVSgAofZ
	rDmEodvpCfEyviSyaLDst4klXJn9sm9LEtqdxarrZZqibbfpVwVwBsyLzelzred8B5UKkLeayPc
	06bAdiHDxlKJ2UYp+16WMIOnOkSwZ3bB3yeNgmLdVV9QJa1iNwQF4f6314WQV2eN/RBhVpsbbkG
	B2Wtcl0P4wvPBnIGd0rG/2W8=
X-Received: by 2002:a17:902:c405:b0:2df:8733:f229 with SMTP id d9443c01a7336-2eb3649ebc2mr124108195ad.24.1793707228351;
        Tue, 03 Nov 2026 04:00:28 -0800 (PST)
Received: from junjungu-PC.localdomain ([223.167.147.108])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2eb39298543sm39539685ad.60.2026.11.03.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:00:27 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Nov 2026 20:00:22 +0800
Subject: [PATCH] spi: xlp: reinitialize completion before each transfer
 block
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-xlp-v1-1-696d0a50b84e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNj3YqcAl2T1FQLI8Nki0QLyxQloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0ALHBY72cAAAA=
X-Change-ID: 20261103-xlp-4ee821c8a89d
To: Mark Brown <broonie@kernel.org>, 
 Kamlakant Patel <kamlakant.patel@broadcom.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793707225; l=993;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=/Zp9BYzE803PHdrBqdW++igX3lavqnQFG9kEQamNq0o=;
 b=11ZP8pDW6OoxD4sgNlI1sIETSojh/2JNk3i862D4U1h5lKemQGV862kzVvDymp3VRz0rf6AUw
 hNjJXRq/0U/CGbg41fZlHUqoh8gNHh+c6YGOpc4+Rv2igJozJPcO2Hn
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

Reinitialize the completion before each transfer block to prevent
wait_for_completion_timeout() from returning immediately on a stale
completion count left by a prior transfer block.

Fixes: d8c80d49cfa0 ("spi/xlp: SPI controller driver for Netlogic XLP SoCs")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-xlp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index d014955e6d4b..fce8f50cd2a5 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -279,6 +279,8 @@ static int xlp_spi_xfer_block(struct  xlp_spi_priv *xs,
 	xs->rx_len = (xs->rx_buf == NULL) ? 0 : xfer_len;
 	xs->txerrors = xs->rxerrors = 0;
 
+	reinit_completion(&xs->done);
+
 	/* fill TXDATA_FIFO, then send the CMD */
 	if (xs->tx_len)
 		xlp_spi_fill_txfifo(xs);

---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261103-xlp-4ee821c8a89d

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

