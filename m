Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DC47ACF6;
	Thu, 24 Sep 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252853; cv=pass; b=C8EQoyU6LWWRye25aouccrRgUbY0lPngUfK3RkusmkIfI1bX1Az4e8rkpQp0DGYe8coggkj0x/JkK6zDdiqEus/cV2SOF13lHI83fBkj8a6SkN1ndF2AsG4pU14kkJwhBuWtNiIkLB4vB16MnwABc0rQVHJfrOruk20MP3D5RYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252853; c=relaxed/simple;
	bh=YL6bGPb7MprYfUaFW/tPvVJKl6Y/8aB1aa+Lk/BBNUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpwkkCvGcyXwEeYHShjus8kt3PZ81bG49A/555jTUyP66QUUuIz+c80K4k1Z4BwhV1dI5Gs7hfRk8TuB9WNq8vexA6gKkFkxEXc8A199WrHdZhPjYvZSA9F4pUM4gWRAXHx36PDeofD/0+10tL2R7UogqHVn5ZJQBGcWnQX+z7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Aqx1lHzB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Aqx1lHzB"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2BE8E201DA2;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CDoSXUgWZ0smyrwuvUxoUgbXYI8V3xlaN9/Q451+sg=;
	b=Aqx1lHzBc+bkAbLM8zji9koDel2ru9aCvVR7TIxn4lhEkjUsmMC2ARe4/9gQbG7cpIjpg/
	SZuhLPiQgQO59jsCyjK0egyKGEvuWCgUshWpD7B9z0gYef795us7vfjV1ObSGKyWDJVCbI
	8LYlsVCkutWFzvlL4YDJbeWiUpovESGwUs8ymKIAeU1bAjSnEpk5OxfjGBsczib6/vK1bE
	WOCoX39+faPfJNfyxWZ/QboNsklyKc7DPtTn21xaM+/w+A+yg9fvUmtKH04dAPfAAbaN6h
	oMTXdgGlDj47WovyFKvGF4tGLOHBJtVxTdIA1sk1+kP3TJXyK9ZOJObDKhsDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CDoSXUgWZ0smyrwuvUxoUgbXYI8V3xlaN9/Q451+sg=;
	b=ApwMSk03kNxt9OebPsEbgDdtVV1+CWe21lmu8DkUOmsUVgO6c+RnMRtnsQr/OOb01nBkGe
	D9UMf/8+EJGz+ovQQBhMOFwZe4Fm7ow8qo7cB8Mtl4G3IcYUgHk8O+Pg3qqsKb2FZ+s0no
	diD3t/qFoWyOX+/HdWWgeOZTKhnJ76LwD3Y22juxdtV+RJK866Qzyi5bVNhxMQ4Sm3xu3j
	4ea5KRxt4uLYq4TlXVVAQux0VKwYIN3grRySv23eD0EQjsLGxNHJYzYNAnmDdZqSzxEBnX
	bz6xtvBdqboq5OnYd0FI6hZtJEGhFyiaV4CZaIJna6tN8l86sj+g8C6r0fiNzA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=QLQtzojdguga7x+u1XFkoQE/vc51dyqJ4d5E+DWcnsBKJVxoRKu5TGo0zVl48ykZBHXGlm
	ZNPTCkbfjjI+53fZKKUCr6QTdbTjv8yBj927GdS/oVtOYQzrnSLNKlwZF/jxdlutRgeLIY
	S7GQUtk16iCiztxOp3R1Xv9Au2SGNaRP5H478EHk0yuJ2e5Iit+AciipgOnd9sJF+I4hCK
	MIs8FcsIuw1vg6GHFGqNj5PW5IHX7Si9r/DMud5noPjxhWjT9beNL4MQK4uamcm6NyOSGd
	NODl0JtYGK6sjPsk2US+du7BP9wScXPR4+Yozhw2tqPugwuxg6O938vpr6d/OQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id ECAD93805CB;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:21 +0200
Subject: [PATCH v6 05/13] spi: spidev_test: abort when -I is selected
 without -S
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-5-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=YL6bGPb7MprYfUaFW/tPvVJKl6Y/8aB1aa+Lk/BBNUA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq5zZELRnjCVBsuGDXmHj/+P0X/KfMGWz+LTtZodX
 fNbpplf7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzkWikjQ7NRTcDsJSYWsxtz
 z78NfCdxO6RGYcEdzeWeMycyybzaXs/wz4Rl5bn67KU7E5aanVi2u4e3U3iX8Eypx8XMDrncMr3
 XeAA=
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
index 908ed038889b..97d09bf4dafb 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -463,6 +463,9 @@ int main(int argc, char *argv[])
 	if (random_input && transfer_size < 0)
 		pabort("a size argument is mandatory for -S (--size)");
 
+	if (iterations && transfer_size < 0)
+		pabort("-I (--iter) is only implemented for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

