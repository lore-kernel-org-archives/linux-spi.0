Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7211F4631;
	Tue, 29 Sep 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700175; cv=pass; b=HdDpcKZRw8DWsqkLsupCN2wj6AgsvXTrlq8aPt+pqqDwrPsKk3o/RjiMDWnDeDHfaFK1ob5bwtWBozzgezQbU5Hh+0CZeTx4hxP6nNzhzsyOrGQ+G7rJ2Et2wy2hePNxaKeT06Jb7xlemb5AxRIht7lBOoamKBIXy20n7Ck7oOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700175; c=relaxed/simple;
	bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGi0mhvluooPf7HpoMxjZ3y6zkcEugoJz7flV6O6+aXXCwLGgW2tMLuG+5XxaMvoKJxXHZNCX3AxTOl0Y1aZ2Zr0UKSU1yHsFC5vebFjc3/keRiSmjsN1ZQDLTNqP6VRT+miVXBiyU5LYfoiDGSSCt4sNWD/AIiGfDy172W4oME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=ONexZbeh; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=WsH+tNti; arc=pass smtp.client-ip=185.56.87.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ONexZbeh";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="WsH+tNti"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4cc0.prod.antispam.mailspamprotection.com; s=arckey; t=1790700173;
	 b=U3MlT4RHVX8nA15yoF5dODiMovnEvziKwwsYL0FyWKS9SAzC4hNuPlWioFrpDDmJtgQwFyBH1P
	  rvVgdziplanv1z5Qbaq8tM/8EpqMwBzwe8kDu99LEz+igj9K5PdLFyo/8NIfGy53lo2ng+aacL
	  VqSMy5C/ywai3oE/XKi4BoX/62VWbrqCDjYVaZIYbBOr9Esj0jBUa7dhNxnlNEy41X+gISL1ui
	  CC+8rt8TZ8ZtTcsSArjOQBfs54JTsj+TmVNrmdnVi2F8M5P8Hu6i5oZgq8nTs+wV7B9Vf6N6qT
	  2G/h/YXiJY9XIbpv1bRV+9MOFLlmLQnA+Ms6rXZ9E8h8lQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4cc0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4cc0.prod.antispam.mailspamprotection.com; s=arckey; t=1790700173;
	bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=fWdOsv6DhCUxR97WxfD6I37iLHWgGPrw6grMhL+H3AaDHBlIyVhNsRWtMcSuxZqheKZ+NVZEo5
	  0ZmgBuRYfXbpheCzrkKb3wjapbI9VXLI6QJnJTQnrTgxeX6I06oO0MU7K8lUlDYPd9eFGPseYr
	  nT7HnyOAj4/6xPt9njFSih5gJ5rc1d+O7OmSTK3mo4IvN723eHbvN6NkfZpOrVwQQVQiaHCeJe
	  /+6dHj2ELFGurVN2fX6pZ4xDaEa70ep9dnwd0CbrVaZftAVcs1IjIV5lqdeZ2EE7UrPgKQtdkx
	  9IbcXmPgR5ypuYkPUwmpqgxYL7DqAtEWBv3It8eVZa2crA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=OqVG4Putd/h8cvO7RMuJK3aCSwZhVie8fm2yjbsDtQ8=; b=ONexZbeh1pMJb1jwElTZhHOvQ7
	t2V7iulWGD6jcMTAEn1zTd7eKn6TYq5dyqNtuTVdjxFruj11yKvru6HBrz0GvU4L7PXKg5fPrmHB3
	FWoxq/bqRa23R+QmYDQjDqKiY05dXC+xq0c577O84kv2DdRDkkTZwv00vU0dKHHMUrgQ=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4cc0.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauj-00000000N7B-1dEd;
	Tue, 29 Sep 2026 16:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=OqVG4Putd/h8cvO7RMuJK3aCSwZhVie8fm2yjbsDtQ8=; b=WsH+tNtiVB94RP2yhRT96NGkgG
	acBqAr3MHWCIoaVMvFYXRsas0EU5jtMy9TywqOFOoAADe85AX0cDj2nmAiPEBFw44l77YsI9xMdNO
	V2fKkDGTmeLXVHQyVKDsLQy7KaMpC36psDt+RglUUJkQhxnkuGmzFDyV+e5KRlYGOf9Y=;
Received: from [87.14.44.235] (port=61710 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBaue-0000000058o-12Ne;
	Tue, 29 Sep 2026 16:42:40 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 29 Sep 2026 18:41:56 +0200
Subject: [PATCH 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-spi-virtio-bindings-v1-2-6a0eef3213b3@valla.it>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
In-Reply-To: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=francesco@valla.it;
 h=from:subject:message-id; bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFm7X1UHLZD5tMT6fOaeb7zfYmfeWj53W0tKSc/di6t09
 x5S+M/6rqOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYSMoXRoYb9z5m/c6au1Dj
 hqNeQk6zstmhetNNC3dUMS1VMV14I/s3I8Mpz4dLCtSyFI50br65NeNql2HOmYvqEVIzZk21MM6
 4ZsALAA==
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
X-SGantispam-id: 3c9f59348f2847f002dbdb8b64998213
X-AntiAbuse: ID - 3c9f59348f2847f002dbdb8b64998213
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBauj-00000000N7B-1dEd-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4cc0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add myself as reviewer for spi-virtio, following the introduction of the
devicetree bindings for it.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f91340fc6e7f..ff70479e99c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29060,6 +29060,7 @@ F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
+R:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.55.0

