Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840580;
	b=TKOBKWGdxrZw0z/Pu11MdpW/jCoIflLMl86CeCNdper6SNiz4GzE3JVabt1UNIwU+gkw
	 2rhEIxqXMpLcLzmEyCTv9RnR0vLRrOl9cS3/zxd3t57KPcumUdYPSz7nJyQLU24amCW0f
	 5Qml4N0mj6zm/yPhWcHBIqLr0NnnYNuTKeYkNTkDDCz+5UomguG5MoW6/I6MMzkfgvKku
	 RYC3euYecxvcmVMSVbZC+Xj4z7r5BUR3edR1b8/lJpJU3vBBs0vc9mOhQm1gqEBS1LEAF
	 xxCOuttjY3qm2k7kj5gluAnI9ThM2XPKVd7OfUynFjvEH2Wgm0QPnLUkv8EBEyX/97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840580;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SznGa8wQxTY3HB7vymMdw3O/52O5jg+K94yzGJBt9/w=;
	b=vlcu/q7IVGYrFnxYE4p7RO8z/t6iJtft8n3jtzADZE2F7YcN/nbi5l61bCuFHgEBYhBi
	 tcTTpVOxDnAz7tHAuSuvng4zwZlT0zQpMrC564KMLHNVgkq2hf8nvgUMQtrVrxc4B1wvt
	 GnwWBhIeFW0QhwolmP3XxSXFM6vRXLLJL8XK2O52ItQhqaEMLRx7OPpKnBjpGoUGzbsD7
	 6KS8PR/xPU24OiaBNWwKYz6Rn/5mRoIpizfc2aYZEofjUDgKhyckD8vSn2UKSijQKRmHh
	 stzKUqzq72pGKIGNar4GiJJVTQUTR8QXFHLzemL7cju1ebq+yb3xWYBIu0XBsHyU6sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kDE8CzIj;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E7606A334
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 14:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4E7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kDE8CzIj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD90F1A169A;
	Mon, 16 Nov 2026 14:49:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93BB76023F;
	Mon, 16 Nov 2026 14:49:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E74D111BC1483;
	Mon, 16 Nov 2026 15:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840577; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SznGa8wQxTY3HB7vymMdw3O/52O5jg+K94yzGJBt9/w=;
	b=kDE8CzIj2lDlbayJjQVsri6Bp+6IEFIVf6swYGiPy5JobUxkRj0vemDbFizMb8MbACHKzu
	W3Dsz1r9I1nS6CjO/xgcdsYiIsBhLmDM7VC34UBOkpDluJFzP4s5zkpn+PDeoheTJf9mSg
	M7Eo2kfLOB6Fshis3Ql8vBR8zxLdaQ5BM/5zcT56mKJVOZ+XtbfcHhlLxi0QKdo+0IrRqR
	X44M82ZZGMoPx3CscQFBu2rmD+L9dy89MYtx1iWFMI3i3lMhKcCBjP4+A2Cm53yJgVxhu7
	MtoxoaOL3eN8xsT65CK0CaY5/htewPo0pNFq8AjL6aUSx0P7eMOjEsXL8iWwJA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 3/7] spi: cadence-xspi: Inform SPI core about size transferred
Date: Mon, 16 Nov 2026 15:49:06 +0100
Message-ID: <20261116144910.44151-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116144910.44151-1-paul.cercueil@bootlin.com>
References: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The SPI core expects the 'actual_length' field of the spi_message to be
updated with the number of bytes transferred.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2-v4: No change
---
 drivers/spi/spi-cadence-xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 43aef7837bcb..6c88116f8f0b 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1207,6 +1207,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 			}
 			cs_change = t->cs_change;
 			t->len -= current_transfer_len;
+			m->actual_length += current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
 	}
-- 
2.47.3

