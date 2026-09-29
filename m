Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7C535FD9;
	Tue, 29 Sep 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700175; cv=pass; b=MpBkJDMvtOVSglIXuAh3wz2v8F4jtEbnfLMFkYhzJiYbcZwV0i62rH06NAzQm9SY0z290WChrUb9NZ6gnW3UEQ488e82idgIyj7qrRIxVIllETt9/PeROZtmZMCNo9zoCV7GhW8f05vWQu+P3r2OKoFbfzetD46ffNcI3f/Srbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700175; c=relaxed/simple;
	bh=EckoOMfTbo+h8H7It7LEYNw5MBDIUSyKAGdzDWnsooE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sut7D773ADg/KDjarbRKdni0xrt2BSnkAqQeDxyqZAxbM/qxLBy1lY12NosUx4QgSHwdPK8T9/olusuF+WUSjjI8SVb1Z1eE1KZaCa+fJ6Ls24E4IkXqlW9gqj7f+6vDI9FZkCtmQDctOXSJmcXVUUYqNQ70Fl9I2+7jLDOlUh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=S6Gp3pNv; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=HUjV3nHc; arc=pass smtp.client-ip=185.56.87.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="S6Gp3pNv";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="HUjV3nHc"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ll88.prod.antispam.mailspamprotection.com; s=arckey; t=1790700172;
	 b=MkLIEvrhQev+MMpS7cpYAmkhxLG/WdoKB3Dzx32nG/l0tsz7NCyYmpiDvIjuD7ghHNyKBPT2wl
	  nLnb4aVoXlFbTAecz0rbJNtdogGKXH4wijeF6Bc4av3JwOf7SB+rC24Gx/PAo24AQnX2xSZsk/
	  vltFDVGoD6L+4rMT1fsLUB4Qo73MuejFDsV+5Eof6tdBe2kFKirSJarMubFasxu/5SID/urFoC
	  IutQN/RKWAxFkh7eHMzPrNrvcN2ilu3Sp33Rj7WLIHjzYrJyIts1RmNb2/3YrgYa7T4sHMIWo+
	  pamVkuq4H4z1uE3gzoYd7tow22SSGjmTqYP2IdlkFHf+yg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ll88.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ll88.prod.antispam.mailspamprotection.com; s=arckey; t=1790700172;
	bh=EckoOMfTbo+h8H7It7LEYNw5MBDIUSyKAGdzDWnsooE=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=OjtiNksoBZQRfazjFTPdrZ3NsFXErN3FG2etOxAjmNVPCFVqwIkrUVh0vbyOqhAdzYz9tvgblv
	  YA8iT4zqeUNYeNjs//zbZa/5JZtLT0c7FKG0xORUafbd6Qc9x6kGCA2ybpoL0+MyuK//cmyLQE
	  KZQEBV9M2o7uLuOVP5Y5SWuSEkqiAcPx/Da3+YwpvPPzcU9Uc6iLHakwiA1YzVn62e68RdPIwK
	  2RrDAR0iJmxZhDhhul2cne/3zHznmydbRGjlr7C/pg37ep9mRXOa/mJhS9TRmgTEIdlLpHYdQn
	  Q9XGZAiemURCTJGkzg1BPyysN9OqLwiM0JMzPrbC+7SJcA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=Hn3f4GZyBeZmtOL1lDhIw8XMvaXDDH0yeUbxeoHAods=; b=S6Gp3pNvbAlsuohSYGbz+f9vrf
	mmMfR9rLEFRfxMHgHFBy0SQ4ruAphCRVwTx7SElZxm+JvlzDWhSGFD9oc0r+oXu2iwbs9kKjUT/GF
	OUTRergmelfYkT2qEGWol431zQVvFLZIqAJwgl529lXWoY2WaxNjbamcR/F5XiLa0juk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ll88.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauh-00000007vQp-1bAD;
	Tue, 29 Sep 2026 16:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Hn3f4GZyBeZmtOL1lDhIw8XMvaXDDH0yeUbxeoHAods=; b=HUjV3nHccZ3Ev+QiwiN8YPHXN1
	rcNXstiT82cqR64CVAzLVffwF8etrTxsXjPXWMoIXD+0DCSIHHrvA0ir25cCaptslbKOFNdMbsqMy
	RxPtiuEI8N8mDQrWyX6pmk4lPQhKdRAh6+hC0JFgK54cHfsybcBjVQTY5ExRz3UVTqNI=;
Received: from [87.14.44.235] (port=61710 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBaua-0000000058o-3ju8;
	Tue, 29 Sep 2026 16:42:37 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/2] Add devicetree bindings for spi-virtio
Date: Tue, 29 Sep 2026 18:41:54 +0200
Message-Id: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDsQY63oVUoXRkf7u4iSUSkE7
 26sy2/xXiSVAFFqskhBdihmn5A/Muq+rR+F0SeTNfZlaluxLuAdYcXMDr6HH5WHpxSlcbYydUu
 pXIIM+P2v789t3dwk3Xqt6DhOiuZZH3cAAAA=
X-Change-ID: 20260927-spi-virtio-bindings-f4e350b2709a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=francesco@valla.it;
 h=from:subject:message-id; bh=EckoOMfTbo+h8H7It7LEYNw5MBDIUSyKAGdzDWnsooE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFm7XyWvv3D5ddFs+TVKQjztQblBR1wVVNU7U75p7LHl9
 Syzu2DQUcrCIMbFICumyBKy7sa9PXPNv6VtYHwEM4eVCWQIAxenAEzkiyrD/4h7kwP3pRWllr3/
 XueVdKwvovFakR7zceVnHhzTTxY53WP4X1gX9Meyf/Hjm8kbLPY3dO5Y/nbO6xcvDrxxWCQYGj5
 7DRcA
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
X-SGantispam-id: b74756d4bc259a85fd59d4959431850b
X-AntiAbuse: ID - b74756d4bc259a85fd59d4959431850b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBauh-00000007vQp-1bAD-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ll88.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add bindings for spi-virtio, like the ones that already exists for
gpio-virtio and i2c-virtio. A node using these would not be used to
probe the device, which is registered by the virtio transport
(e.g.: virtio-mmio) but to declare properties and/or child nodes.

This was tested both with virtio-mmio using qemu-system-aarch64 and with
remoteproc-virtio with a Zephyr backend.

---
I added myself as reviewer for the spi-virtio driver to be CC'd on any
patch involving the new bindings.

As a side note: mails addressed to the spi-virtio driver maintainer
(Haixu Cui) gets bounced back by the Qualcomm postmaster; I added them
here nevertheless.

Thank you!

Regards,
Francesco

To: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev
Signed-off-by: Francesco Valla <francesco@valla.it>

---
Francesco Valla (2):
      dt-bindings: spi: add bindings for spi-virtio
      MAINTAINERS: add Francesco as spi-virtio reviewer

 .../devicetree/bindings/spi/spi-virtio.yaml        | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +
 2 files changed, 55 insertions(+)
---
base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
change-id: 20260927-spi-virtio-bindings-f4e350b2709a

Best regards,
--  
Francesco Valla <francesco@valla.it>

