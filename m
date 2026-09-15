Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BF3BFACB;
	Tue, 15 Sep 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503903; cv=pass; b=TOmziELSXHU9YahJXNBtNg3MpsF8bXah7nXn7z6Y0ZnG+sB12PFyh+bjFSlfCkKNTUYfRWA4wIl0lDuIWIPO63BSUOnfyTZf9dJr8GQzHAEMn+hFchgnLQaofDtzarfsvlGPqMLtKJ0b5YYfS8Snk1jEWSc1YhAjdp/WDUWq2j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503903; c=relaxed/simple;
	bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h608bFiv1L6IGFiQ3ZqFUkBjJvc+GzFSecHf5EKtouInU17DNH0iOcGvS7Bbi1cvfZXxrfanYxH5Bqtnvpz2LRHhhSoV38cjiSE4qRFknqTAX3cKleoRmcfmFDVM0VCARt1PZ3sJXIUc5yMBmLC/zyBcKpf3m0HBlgr8KOndjfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=rSd8XWmc; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=Mctx5oz7; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="rSd8XWmc";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="Mctx5oz7"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	 b=M8DT2NEBDxpLBtPJupmCdWF4CGR2C7UkehDsQ2AMhjYILRFYS6UYcSrTNDdBCaG7XyaSX9YXpF
	  n7rAwtfNm+vn7xcwHWuSWduwBqL/+/FtchwS0GVs3M67EuZA0ZVf7wZRge/0cBlMVUmcsath/B
	  YYBZ2CwmOCTPGyiod53vV0s4EcX/JfaFj0MbkIzrCwWA8UttrL57EHZ9I8f1/zda8b/XC2qMTc
	  RUrEnK0oFaE0eGo/sCTxRPUTdUmmgaZ1Dp5iNd3gwgK4PEsTaIvYoiCDU/HWHW1+WY0xBlbqeH
	  OpZjyh/8cRBBVy847DpuMZ2C3GC/IYCXHMk7JPjPoC/UHA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=tEeiAIHd8zlctRMjzXJPgp2y1985islXIM3XE6G7ca+b46Xk2exJpPo1MGuYUwtfuPRrlfS9XK
	  F9Wu96dwNj3+fiA5eA9pzVZq7NlWoDXl6R6kbpa1WOGD5JI+zE/6p5iopgqv9hocTvK/qlp9bf
	  99nGon5hSvg/6YmE8JRjKILWKrZZRS96croifnAgQ3W880K3864CbR/KsAyHmG1MIpHUlr/4FD
	  xvL0wZJ9CF0QSp7naZjtFdXC5POO29yI6Z47GFvmCD+vy65nkI1JU04cORgpoBOvotJd6h63M7
	  zCyO3cqXC9uybsSrzaKAqrfeWgjQYmpmsA9jL4Pydmdx7A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=0H1Zt4rRwH8/Itmi8SgfMZVzgpmWywqJ6/D/I7hQCQk=; b=rSd8XWmc8xKDgKTjmJrx7TJWsX
	zNvaXReoyrC8GhnZOuP+fgqCcwYH/k0YbojwI9z2eTXHZzgo64jLPfP7Jq/4s1JJqHiTWZ4d/mika
	sKIwV9ewYPs+A18kmWQO+uZlhGYBpVqYNwNDt/JmUYaAVpxV/yR0/zXvJAM62jG7s3Uk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhx-00000003wZu-0JfD;
	Tue, 15 Sep 2026 20:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=0H1Zt4rRwH8/Itmi8SgfMZVzgpmWywqJ6/D/I7hQCQk=; b=Mctx5oz7Qm8K0GkjHKyeMWCLI/
	sn0lmS3ppopbY+Sed5j/+OSkEQMD/UsuTnc1aaetD+EtUkso90+IQ38XlA8DfaGpb/5ymesijh9gW
	zkyvS0cT1GDU3FEEjpIwqsvZRR78C9mGNdqHmInshTkdOOkdDIXSP0v1PgCj7pbyW3S4=;
Received: from [95.233.221.121] (port=64541 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhs-00000000HDi-0bgk;
	Tue, 15 Sep 2026 20:24:44 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/2] spi: virtio: fix max frequency setting plus minor
 cleanup
Date: Tue, 15 Sep 2026 22:24:35 +0200
Message-Id: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE1SFQ2uIha0g7FAOjQScXfF8
 nvJ+y8Q8kwCdXKBp8DC6xKRpQnYqVtGQnbRoJU2qsoKDOx3XlE2xoFPjeTKXHfKKlMRxNfmKe5
 fsWl/y9HPZPc3A/f9AIykIk1zAAAA
X-Change-ID: 20260915-virtio-spi-fix2-ed832a0c069e
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=francesco@valla.it;
 h=from:subject:message-id; bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkrV7bGThG9rmnzfu3/QzYn5705Fu/yJCHB+I9cynvPT
 wcv5Qe/6yhlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmYiXH8D/xR90dNqbsgAWv
 X7cy7To4SW9a1r09yYv9GzMu/eA2uXiS4Q93eXGWvL5xOef944dbf023L6kQ+FrHEb5I8NCH788
 k3bkA
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
X-SGantispam-id: 26a4798341d810a153bf3d9ca6ae98ef
X-AntiAbuse: ID - 26a4798341d810a153bf3d9ca6ae98ef
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6Zhx-00000003wZu-0JfD-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello,

while developing a virtio-spi device, I noticed that the spi-virtio
driver in not honoring the indication on the maximum transfer frequency
supported by the device that this one indicates using the config space.
Patch 1 contains a fix for that.

While at it, I did a minor cleanup inside the function parsing the
config space, where a value was stored into the driver's private data
without a further usage, wasting (a very tiny amount of) memory.

This was tested against a (still unreleased) virtio device running on
a Cortex-M33, with remoteproc as virtio transport.

Regards,
Francesco

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (2):
      spi: virtio: fix max frequency setting
      spi: virtio: drop unused field from private data

 drivers/spi/spi-virtio.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)
---
base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
change-id: 20260915-virtio-spi-fix2-ed832a0c069e

Best regards,
--  
Francesco Valla <francesco@valla.it>

