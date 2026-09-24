Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44647F799;
	Thu, 24 Sep 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252858; cv=pass; b=AN4Pfh9Y71omOAT2hDbt5jGXNfE4RcNbr9SmGprbhccvaANq6nvUATLzKZOXyefI4KWx8TI+oG7GlxqRTKIWDJv9u6MWFw+wwrGc5C0TJzyI5yzMM32PV5jAHAO7touxorKX0g98p7MgkMcILJOF1cCl/0pqYWaV5BGTvD7/hMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252858; c=relaxed/simple;
	bh=FsOiCoqgk9sqBbHxwQg3ISQTKhgG5cEFDgiorPL1HEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlauQe3KBX/NlaQRlxiNfcO1BTMtQ/mNjP6rDsbCU9yhg28FnS5+35SZabRxBRisf3LPP0Mq05oTvGQgZIF9cNFrVMwFRYCK8nsrTKNtixzmEdq8n2c9JHkc8Aa7IW3ygnNX5/dgQHoMtAbd5B9EVXVr6TqUZNB6dIA5Jrmb36c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=MHcdHEb4; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="MHcdHEb4"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 46FD6202202;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tp3u1VNNjhU4ImS/Mffofc+VntsUmU3/xP3xjYA7Ds=;
	b=MHcdHEb4AaxFKOpB92tkdtc6996y8Pi/DPInMFC9uHFeQ5V3+g9GJ0SaXdKCQqCV1DKBIO
	sTpQC9lgQMVmv4omjP5KCvrW9+s37oRVr3k0lKLNo4bd+0fpDjVLUcIq7FBseF5fnCJ9CS
	g6Qm0caCJFvFIulOiAiAH0JHCB6udAbG9oJrG9LNl8gMkOy+KwG7q3Bvcl6w0Ppn+pXjVt
	oTWXxdiQT7uYlwqFfXP1SmT8nKjQoDZtliKx/DrTzpJX30wGDW8mx9gLYuyjXIbdNzvKZz
	bIzSGaIUiuZvHdgm06i+D2kYWkCq80A9XPAlZJwjkTDfSj/ofRM1JikLE1NG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tp3u1VNNjhU4ImS/Mffofc+VntsUmU3/xP3xjYA7Ds=;
	b=d2IKu9QtUQsNxiBbjASDDonFmi31u0xU+8yieSw2qlX0Jp4sgyew1fKn6UnzfMnBSjK7zv
	k6hugyBFNQz3P/+W+vsbQLo9E30XE0OBZVFt8aa3ILfWwkuPNRYvIwRCIQuDwVExICn9qM
	cxneYdliWdWKe4p03uYSubcsKMixnC1cDm7sgv4xZF2IJe7kNKuNZKtXPna2+hb0huVVQJ
	s4oOn1tAaP/Go1bloFQTpygVN+g0fzEDbEggES1UcT1HNKbilgILUgjtIDmtq191yIiTLi
	Jsoulex9IRKcGtgkx3sncU+1SH0oPZUhnRaFI7HgKdDecryNXdHL1DLWur4vOg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=cDRZsemwAVOwGbRjIpfi6iuRqbVcD8udtDcXmKvJFvYIzgJ4PqlsWj/rJdetDfHnTYck92
	atPVZBD0uHAECw5prGVQm9y4vYPfzmdt30jd32TneFTplLW+BNq1frmclMqcUwMtomJaSw
	PDkCY00t8zXLGFrmjKRn+ihXOUiJphawlVgrNx1G6s+3y+/VYiVXAdXA1095smjNwFZhBA
	tHAJ7J9nc+yUPJGTeGhdmaXJ51gtf6kDZCIXTs1QOxL9S6E+IFSglGXRB2rCyuwnIkbbTE
	wQfXJY1DJ4k9lWR5TpgwesOwFTnqOtzLJuQGDHtSq6Tlvq9d2ks6JdN1+7Upaw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EEBC03811EE;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:28 +0200
Subject: [PATCH v6 12/13] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-12-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XZ1ejgzaRlF3a4gm5COS5zWx3J6XTgh1T2kOnwr9AjE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKm4wiUnzcUVqUi3fm/pk5XXVp1jPaVxpXyT7e4HRt
 JaeQ593dpSyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACbyupWRYZk00+HsGQcEjt8+
 8OUp6++VW1dvl3m6RHBSN1Nf4+F318MZ/kp77U0PmLRxtw2fwGmOvY2Sv6+euli0/IqNUDWbSeH
 pJE4A
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump its first up to 256 bytes to the
console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index cce6669d3789..2295daa37b63 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -194,8 +194,18 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
 	free(tr);
-	if (ret < 0)
+	if (ret < 0) {
+		const size_t dump_len = min_t(size_t, len, 256);
+		int saved_errno = errno;
+
+		if (tx) {
+			hex_dump(tx, dump_len, 32, "TX");
+			if (len > dump_len)
+				printf("... (%zu more bytes)\n", len - dump_len);
+		}
+		errno = saved_errno;
 		pabort("can't send spi message");
+	}
 
 	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");

-- 
2.56.0.rc0.108.gf0ef1b96a0

