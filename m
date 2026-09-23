Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDD581220;
	Wed, 23 Sep 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194524; cv=pass; b=PuzTj3uVzCj2PdZEJpsfAPBgsVDJSxU4pYF+0Z2TyOQMgwojaGc5DUHE2KpbE5KQSHw6Sbk5f577eWBWY5aw7PDrgtWpfVCfjlncNwc3lM+wNze6jxjm7LWQV56KY8Bqkpeo+MBPAJJ+KGPe+uqR06w3H80HqedCpt4SAzSKsJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194524; c=relaxed/simple;
	bh=yKHXVf0rlmLPieDo1F7hObmmvAWpwiubbPM2GNGMS30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QA+NeXmUpV/17UFv/bjSDkiMg0ST6awq5pI+W8GEdIe9nhbIBre8kKk4l1FgcGDdODOdk3EkPQiRczNKLUiBYl5jNm0gJblnjJikPMyaCOOyy6syh1F1lKRiWTSTWZL+3XUHay9WgHp5aAHvwOQ0Y+xGEj+teKdWIztl2i4IVDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=I3VGmClY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="I3VGmClY"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 50CEB2001BD;
	Wed, 23 Sep 2026 22:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKW6nixYYX1XEsUvZ+jFCRJuPBDJtlf+ceOhHX+95uY=;
	b=I3VGmClYcdQ4tGA+9vqMF+rRxrd7TP9u/XWPzKgxtmUKA8p7D1eu5fvzEtoJggxiX5ZNaP
	6BYthLY7br2jDxREBzs47z65C+qvs//sqNo74VURdmWZMitVoL2KnM0CyTNHRWzx6MB8Ro
	MUN+Nayvmj+hL4a4ytqStJsxHShTHAue9Xz0L7z0e3GZrjibjU5OsmrvjNbVNUPxSHj8sT
	4T1raVx32qQc1CWzylB7TJsjrw8iklaMhYXuMJA29n+tvixpeVAg0LKXODUSWC/1HNsPPE
	ZQcqqLPAkqzECkoH6G+YIEcz5mMfYF+Cb3PBwaV2s+qg2qQWrRq+xyt7DWXy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKW6nixYYX1XEsUvZ+jFCRJuPBDJtlf+ceOhHX+95uY=;
	b=SHabDAkwVMjns5no+DvOT6icxuDILVaSMk9LkEbbJbgfyJbB0LqRe/NtsZPVcyJjjdF9A8
	fytqw4jFrQdk1izXnln84Yy8SdC00KXTTU6CNURas3VPHIQqHNESOd+pAril+2Trz2H80u
	m/n/xNrvZyrsOJFgy+eHQmO2Iq9rNFjY1BuBohh4kda04dsKF65SYfZGrGpZZ0JHjFzMLV
	AkWPLL+LgrMzauEUtdAhqmczcN7cXSF2OjApY4ya7tZfOlnVUEhVAD4b00Qy2MOrEKllxR
	yQqoJ+rjAa1EtgFjyYCgNq5i2JIqcPFfSMu1Lft20duSQ7esQ0/6zFtxIWUi6g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194511; a=rsa-sha256;
	cv=none;
	b=O3C+EgWE3GGkO8zmUUqW80yaAV6BaWBhMUp2gZ7G3DWmpf39ABVjEzp/jdbBIT5m0Li0Ff
	Gjf7N8mywjoYAnio6b0DVvtyoJdwndD1FSDedce4eTm6oSK7rEN6NSH6QzzzaPNC+3G62x
	u7Fdtkv19EmkY++pRhdLgBn0+wb1TlbGS3gM09QU2c5zsFihnJ/ROGE6NulIRLwGZyW04q
	v9h1l5UkUsbZSS9KkPaFSShckxYDbCcNuKoBhxt51XbC4eBfqdVlbbCqnYSkeQo1f+0BDw
	jIxrRvain+j2QqM7ybiJyuUs1yrNSe2noa2qHfN8jH+3DrUtMZVFq2Hz5qHE6Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2q;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:07 +0200
Subject: [PATCH v5 12/13] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-12-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=WbdnroP0MRBQPwqrrhFPYqHSfzvLvlzyeOGFg4QIKp8=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiQnFfA1bsL9RysOcR6arvWV48Wrquc7g6YEzuN44
 qF8QmtSSUcpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAiK8IY/sqL/OcRN8jreRPC
 uWr78oipk+IOrt3/51LMztMnAj8sfHKXkWGz1CnTOz9b/pwIZDj1R0i7VNa0RG/5Jlvxc6YNs1g
 T/vACAA==
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
index 32dc7daac21e..6f9e04acee9c 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -181,8 +181,18 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
 	free(tr);
-	if (ret < 1)
+	if (ret < 1) {
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

