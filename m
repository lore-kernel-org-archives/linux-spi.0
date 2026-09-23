Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B357982F;
	Wed, 23 Sep 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194218; cv=pass; b=lqzxtvMXbyPzDGtYPmrdZVk+j/amH8nbqlGPJoUKeuNH20JlwG3V3VEvfHZ3vGg90WQzEvdkTs7WRT8auydeC9TOFTXymXCu3xNA2IiiqghxplnaFvCQPkVfCpXNr3wiZ2W3IKTXmkPe/csOIF9UUDys9qgvWmVU29ck3yQ7D6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194218; c=relaxed/simple;
	bh=NqupNA8l2xmS1cpwOfwWWtJLLwFj1BSCT0Q7IYhmOjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PB1MWN0T251POnM8d/h60afnuIuxVkGp+wwkn1UMW7bWUIoGV1eLXSA6zqrDTNfQjb717O3dUUCf9LX1XNM4iAngbNzvgJhAtMyzKI5E4vKOi8mB9xyoL2aJLNEy6N68kozD+xQXbV9mC4nA6d7sLCR54hbK55TLUx/cYEWAnIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Mygvy0/b; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Mygvy0/b"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A0D9720203A;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dbKnINREIm0XXUOBxcc6md77cUF0gCRPeKqFRl95zQ=;
	b=Mygvy0/bZ/8+t5WiV+6sw7R3g+m2jfbNvvGdJ+nrL151u4FFqa9PICOMWxkglH3t+hZL0a
	4t7WFAKY/gxHctotc7vRHofQpqPGye310/8WZxQICqEtJQyi+ayRrln59R0pW2vzg/THPT
	9uMkoLf+dtROH/QXsM3r9b8u5Jf79DlClFyDwzZISmra9ag9DdZBwTqKentaiBrxmskbfP
	HhzfaCkEhJJmtPgXdMH1NeU9zJaFfcWkXwqg3/RQUFWE9HK5O9Ih9079D/3gJsNA5Y/Yh+
	BSOLDVTpBMol2EdDp/0ydaVWqO8qPPn7yHPdgnyfqgoK9pUeWGcbNfAO3Z0RZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dbKnINREIm0XXUOBxcc6md77cUF0gCRPeKqFRl95zQ=;
	b=aU5vEQ1BylAF0QgrGkSjpgB6J4eDeRmHklRVqFrGt5jr5D2Ys8/HeIQ0eFw71FUE+cLJBL
	krTxqFe60JpHXu7PC5hqcsZKwUecFIhZERUkNa8ndCncwr9aSglcFTcbbcl6YtN2FmQE1x
	kIRRGp5I+Wns7wmLF+Xtu50OcWp3d6R66VXdfD790yi1mDGdX06uQIldL/4HV645dVG0J/
	PMiV/iGshwKAFJrZpZMI1BHWUZc22IduWJlmUvkSeqqvlNtEorj2jjn/JdltSMPN+1ckMn
	AKzP74Vc2cKVjvOMWZPihxL9qs6Dw/C3lIaoTiI4g4kx+U8rX7QN1Rvr9rpmTQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=Gzd7v0zeCfxHy1tzj0/TxuNkPGbVBWHKKfkFqCCpqCP2A1BqZY1DSPHsBcucQtS/aJT89B
	Qqez50Bs/umRmI+DH93DEMWa0XfO4I+IAW8AsnOdOrEyp+XKdKqYWyu+TiP5O2v0AG3hV0
	vZn7QgDHIdGxRPFqAAJYZqcKxWFsJZvXhuv9DSCnSzmPfyYCwL+bhpF3gfSkBrBr9sR+X0
	MzGh9KlYYDqcmLDRvpP2SLL4RKistdbttI4ns0PihqBgcCWzIRcwq0vCBvscBJOWtdDZ5k
	DJPef5BH5Jg35Xi5dSWReBeVGerOF3x9y5vF1zVj+x6isaT5StBHT6T0IOTN5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1q;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:00 +0200
Subject: [PATCH v5 05/13] spi: spidev_test: abort when -I is selected
 without -S
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-5-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=NqupNA8l2xmS1cpwOfwWWtJLLwFj1BSCT0Q7IYhmOjw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiR1OtnPdXIwl+7RNF7h/EcGr/evEYq+Zii058QWd
 bOH007e6yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExkMhsjw+TV7906GvLU3dl9
 5z5PDWq1vff//T2e1YnVTyt5rD3jzRn+ly37Hfbl2MFZV68lP7nCOWfRw1eM2yTY6/foVmilmfc
 fYAIA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

-I (--iter) for transferring multiple iterations of the selected input
currently only has an effect when transferring random data using -S
(--size). Error out if -I is used without -S to avoid confusion.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 49d40aa6d0ec..45c2b691bffe 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -461,6 +461,9 @@ int main(int argc, char *argv[])
 	if (random_input && !transfer_size)
 		pabort("a nonzero size argument is mandatory for -S (--size)");
 
+	if (iterations && !transfer_size)
+		pabort("-I (--iter) is only implemented for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

