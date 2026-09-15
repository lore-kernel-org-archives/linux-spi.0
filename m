Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A84C67F0;
	Tue, 15 Sep 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503903; cv=pass; b=cE+cng0bHqwlp4ZT9/VoFiwhN6arwXYiX7lY/idfwHAZTIGL4CzFAIx3jxxY1B/SEmtl7RGXbgqiT4573Q1bsJL4CqIzsf6k7NPnojUGaC1xX0lvS+E5HYxi/GZDMFKhqmeg7Z3Dyko/g7rmp5XQWvNPLRapXyxikDzY+PtJJCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503903; c=relaxed/simple;
	bh=PFLvBra2f62guqQMvtV3HQxnQZcWO/C3VH75csLcbaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9799zL2gjP6j2w0fl0Le6PHcktNPXsP7E0w8PO6ZmASnGi50RCT9EiK8GrNn9ua70AQ9CnaZWAw7iRXUQtlV5r7rRrOdj9A8M0ZQSfvcgJKd6eMbxfNa7nRDV1UxZV+Pd3aUadM9XeaSt3WzoVvBh7XtrYU91lb82WcjBnlAQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=UPu0YApD; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=c+aDYFcf; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="UPu0YApD";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="c+aDYFcf"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	 b=dXHpWtK6IDbntB88xYi6R80jgW1/7TOd33SrZzIUdfleJrKGTFQ/Y/zuHtJNB8QjjchVlun2do
	  Bl0Q9Tp7wf23/koCntbvMUs4CerSqfS+rxyo3ayFgjAD6Nl4ETPhEN3K9wmjbwObrmq0G65MT4
	  RoxGQpoQnrQAKdVgRkz5DMGlrWHGd645Wm5X1C78PkH3nCuFSCokHzuPWaVdePlOS29PU1vHEd
	  scZ8wujr8Ft3dHIpT3CqwnSdoxxTmdaURa+LndwNEGfRxRX3bzGMmhQRWhCSkDqFuZuOYX/YaP
	  UvC76S5nIyl+CYQ2RIfN/eOBTc60LS3c9IM/591UX4tnjQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	bh=PFLvBra2f62guqQMvtV3HQxnQZcWO/C3VH75csLcbaw=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=S8KgWeZWFMCjSoeHUP4MTGZTGiCRqwQTUfCvO9qKPqFYwyVbA45n1T2ilN7DwDFv2An8Adk21P
	  uCCBK5r0FruHDFScVEqxqoPyubJJbEiCBitdk2ygJP+jd2GfOsqGQuMhokY1WBtuLRDq34uRfg
	  XkKjYs7VnJACLVPNcMoyIONVDPpklcZ0+KyUmhs+RAKTEgME7qHxyeXIrH/UPgOTeVX8MLe0Kq
	  6LfeOxuxnseG28mFRSCjjtosSitQ6NcnuCsd77TTUcyUExGs4Bs21UDKVFP7FYpps2TYb6JxWH
	  ByPZSj9BgylVlF/ikmrAXxTZTTf8PpzQk8cLC1ZfX+6jiA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=OBFNNbrs026e8fcoRZ1G9bvxE3ylTU09E0JtOK5P9RQ=; b=UPu0YApDNCv/MCMEKXrj7Y2B9F
	cF3o7abzT3/lEEKy6N2Ge5rGkjUspPV6DWdaEOoHmZEv/s5Encd+Gt3Bs8JwgF5QAw9BhqxOq45wr
	6ckucnM4gRrDCIZxgSF1rXPJHSsFlaB+R68PF2Bb2O7PF12mMCAAzqJdexrztzi+jExc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhx-00000007JrY-0MYF;
	Tue, 15 Sep 2026 20:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=OBFNNbrs026e8fcoRZ1G9bvxE3ylTU09E0JtOK5P9RQ=; b=c+aDYFcfjAxUrmHEAE4E6NFHLg
	gLt+liGO9Mq8GcA6fHk2etCaAWMOcBgyekkmqP7581i07BWyXl1AkUxEguSEz6nAl/H8xUCFpzSk/
	gSZNHSLE9qVCC89dMCTuaYwbFoAWScm4cITokFMmgf7KydzL6Zyu5cyRJ9s3dgkvk6/o=;
Received: from [95.233.221.121] (port=64541 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhs-00000000HDi-2NSx;
	Tue, 15 Sep 2026 20:24:44 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 15 Sep 2026 22:24:36 +0200
Subject: [PATCH 1/2] spi: virtio: fix max frequency setting
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-virtio-spi-fix2-v1-1-7a474cb1b13b@valla.it>
References: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
In-Reply-To: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=francesco@valla.it;
 h=from:subject:message-id; bh=PFLvBra2f62guqQMvtV3HQxnQZcWO/C3VH75csLcbaw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkrV3bfPf5B0bXD5vKDwwW7ThywuLXUk+XzboEr/JEb2
 BS3dJi+7ChlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmoqHPyNDh9zv0PafjFN6A
 8xskImXsOFfkTDr0ftru+Zt8j31+NbuA4X/J3vfLRdwb/zLc6SrP2rYseWK1j3qhzB0JjQMnO3a
 U1vACAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 78cb5fa39ddd8f5833e8b0fbe0f69853
X-AntiAbuse: ID - 78cb5fa39ddd8f5833e8b0fbe0f69853
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6Zhx-00000007JrY-0MYF-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The maximum transfer frequency is read from the virtio config space but
never propagated to the SPI framework logic. Fix this behavior and drop
the useless setting copy from the driver's private data.

Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2256dfec5407..033268908bca 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -33,8 +33,6 @@ struct virtio_spi_priv {
 	struct virtqueue *vq;
 	/* Copy of config space mode_func_supported */
 	u32 mode_func_supported;
-	/* Copy of config space max_freq_hz */
-	u32 max_freq_hz;
 };
 
 static void virtio_spi_msg_done(struct virtqueue *vq)
@@ -304,7 +302,7 @@ static void virtio_spi_read_config(struct virtio_device *vdev)
 		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
 					      bits_per_word_mask));
 
-	priv->max_freq_hz =
+	ctrl->max_speed_hz =
 		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
 					      max_freq_hz));
 }

-- 
2.55.0

