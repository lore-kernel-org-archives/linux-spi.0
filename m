Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793086022;
	b=ZRxjR9Eldfk81DseNmTeIWKpGJ4m7AuyuL3VKOr5aK9e1b3OfBbGiSt1IWugA0Q7r0Y7
	 b4d9A5Fnbww+bKM4yv0mXNwo+4XKO4JYijdz/0m3hDfNGFKKpC60U+EKCtXkbZpL81Pq3
	 k+GWtjS/+aHoNNWxl1VpknvT39nQxvKqCDwssm+EHTSy/fhr0h3CKw1H+Ag94NdHaopsc
	 BP2m0Ax1qbNH+KpPNrhr7IqKqZc4xmEvebiuMR24Fo1dzVLi0ayF2cWc5R9hNn8/FDrvJ
	 Zces+NhPh2DlzAZ3r58STXf+EYhx5+l362+SHpigzdvTKy70BxHP/RqKeHi9jPoqa2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086022;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=;
	b=q3zIg2qkBrB+DesF0eZhJJtfrFjIyTTqIlQHoPk+/Xa5KlgUQ431YhaZ3TrKU3vKEL5g
	 xUNk+bRGN9AYFL1Ig/0WgMmVYNZcT/oN+9tsofXmOR2iqJL/VbCDYzgG+T4L5II1Pmfm1
	 P6/6obi8j5l0xB3iEWJr0fLVXmdfqEN6/dAGnZqQ+tL74EZ2Bb4Sfs55IXl3rW2i+YpZI
	 Tl1rX+NMfh/FZ+J8PbdLYTUubi3T+7y067WYmcO0z3DnP7YfJktfN472L2KDvpUXML/bg
	 l1OD4fwfXe5/4mOun2T90jpnkGcvjZ7sXAl8PSnaikvmWozzApSQrQaT86x4s7Q0awQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=Lg97Q3Hs;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=THd7U1e8;
	arc=fail smtp.remote-ip=185.56.87.6
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87298606A31A;
	Tue, 27 Oct 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87298606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=Lg97Q3Hs;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=THd7U1e8
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086020;
	 b=C1cik91F0FfZV8CNUfhhaBz3fhKiP5ZhWANElFQxbdnYlJUY3yH5hXSYY5yAMsyRPywWN2diKl
	  qeBPzWlAS5/ID3RlHkS3zMgvIIAe+BAXemT9kYanDOPdL7NZyEh9KzlgGyIVmy9UxEJrjoz9nS
	  Uxak1YAg3r7HEPDXgBcDWKl6fwtNRpK/cqRPCpHbx7oWsxOq5M7Io4LTIjwGqzZiiaN8WUHg1F
	  BfomrCF66GkemB0dYO5ZXn33fLc5rU0iFZ3YtRrassYQeaJka2pBQlO1wzQKzFd/VmOLAHrHCZ
	  tQTUEcr8QSd/bL5G7kGwQgofTEr7qDPSCL+sazydoTK+YQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086020;
	bh=QTK7KrPu2P6hFh9JC7pq1+BhiXAD6x7kBDIU1gAKmDw=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=VhHnxZ38G2mcyrZcjPYhlFtVtbd0+br56LpTXKzWzp+Ei5J/TazmMLXd1ffAGrReiTKmYpjsho
	  qUObh411XtEBhIpF+oM5sjmgbFfyO/1qChmAWJW21K8CuiTDBDMni/fTqSfR4QdKOoFFURz+V0
	  ce2PCsIHOea7mbFd3GqZ390tAxhj/iRFktkVtchJiDOT9I/+zRlOhFbQ7NImpWStasOJT1AIhe
	  e/eIFwQ9bOie+cTKyT3csQf891tn1aqPjSN2vmbQP/BLtxME2clAmfhEd8VC/HDc6zc+50oXYz
	  twg5dVCET626kVDcfKza0QXZbf8nL3FNOlu9fNGn/CorIg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=; b=Lg97Q3HsE3qpRwFiQvoCmw3Kgg
	7+zBuU3qELG1tskBq2+4Myzj2esl7fXKEWz1NwS7yjUh7psRwdHjYBBPQuLOK3AEVlhxMB08h0ioL
	VjUvvHkfTbM4iTZdrO9GLVpPOvzc2hMFvTMoc9DujOrkrRCbsBTqJMLUf/szURgWxSuE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-l70q.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLbaD-00000006vEO-47s2;
	Tue, 27 Oct 2026 07:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=YvrNepu80f9cFpozwNcGaYtrGlqF8wlvl1fpjkfzFEY=; b=THd7U1e8Ot2Xu0BT3NaiWJ9PWg
	UGZKiEexHkquhH0KeMCA9TAHTvwte8KXijbw3h6xSZHrK4mCBS0ZTu4wtm1rq7eZqfdJlK66DHHvc
	39ZBnCfc/fXUxzYV2atTaoEksrwFCtdMamVEaGMYyx+YZCjCp11IuQtLG950fyG1chbY=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba4-00000000J9d-1J1C;
	Tue, 27 Oct 2026 07:26:48 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Date: Tue, 27 Oct 2026 08:26:32 +0100
Message-Id: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr2Jm7ZjSKgRX3sOwaGGAMaSQTm00h
 LsLGHcuX/L/ezMIBSaB62GGQImFR7+CPh6g7q3vCLlZGbTSuSp1gTIxJg6RR3TsG/adYHsmc1F
 OF6q0sD6nQC2/duu9+rI83YPquKm2Rc8Sx/Desynbdr9C+beQMlSYW0XUGp0ZZ27JDoM9cYRqW
 ZYPXbeTfccAAAA=
X-Change-ID: 20260927-spi-virtio-bindings-f4e350b2709a
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=francesco@valla.it;
 h=from:subject:message-id; bh=QTK7KrPu2P6hFh9JC7pq1+BhiXAD6x7kBDIU1gAKmDw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgrSOzmX4rOs6b6ukbtJFO4EHPVt3Nci9XLJsQ4UU8
 +bnrUJJHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBE8mIZGU7npT3O3XY98IVi
 6PEDe1k89bb++dnV9Oma6PonzSKPbGcxMjSsv8M7uVni8vWF5/fw71uQeNh4A9s0GZE9DkkCtpc
 7P3IDAA==
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
X-SGantispam-id: 1f2d376749ba976fb255cf91fd782c98
X-AntiAbuse: ID - 1f2d376749ba976fb255cf91fd782c98
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLbaD-00000006vEO-47s2-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

When a virtio transport exposes a non-discoverable bus, the devicetree
can be used to declare its child devices (if any) and/or other
properties. To allow for that, the virtio framework searches for a node
with a suitable compatible in virtio_device_of_init() when registering
a device [1]; such compatible takes the form "virtio,deviceXX", where
XX is the hexadecimal representation of the virtio device ID as defined
by the virtio specification.

This patchset thus does not introduce a new functionality, but allows
proper validation of nodes tied to spi-virtio devices, aligning SPI to
what is already being done for e.g. I2C and GPIO virtio devices.
It was sent initially as part of a different patchset [2], but since it
complements a functionality that is de-facto already there and is useful
beyond that specific use case it was sent separately (also following the
maintainer's feedback there to separate it from remoteproc-specific
changes).

This was tested both with virtio-mmio using qemu-system-aarch64 and with
remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
parts still not not upstreamed - see [2]).

I added myself as reviewer for the spi-virtio driver to be CC'd on any
patch involving the new bindings.

Thank you!

Regards,
Francesco

[1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
[2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v2:
- Expanded the commit message to better explain the functionality and
  the chosen compatible.
- Redundant pieces dropped from bindings.
- Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it

To: Haixu Cui <quic_haixcui@quicinc.com>
To: Francesco Valla <francesco@valla.it>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Francesco Valla (2):
      dt-bindings: spi: add spi-virtio
      MAINTAINERS: add Francesco as spi-virtio reviewer

 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +
 2 files changed, 48 insertions(+)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260927-spi-virtio-bindings-f4e350b2709a

Best regards,
--  
Francesco Valla <francesco@valla.it>

