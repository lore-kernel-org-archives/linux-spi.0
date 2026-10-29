Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793291286;
	b=cgq+LV+Y7+Ai5dt0BcMOhlcc13q+P5OVR7YYrevxrI3Zsv41Uqrnpx8SCxPwsQHnWSBB
	 DF4L6T+9N5dJg+n4PSSD0IMURYqqzg1LkaaFg9Pb8M/lA5g50bJo6beRrbZQoD68E4G3y
	 22zHdve/eJ394g54iobE38NdJSOznthRdqwA1xJrGfNcOkOZJoOYkBamEqoCAkwenNBqN
	 MQfwpmibpZLJqe0vvITKSbxBZdo+9G4HIozbRixoLvRiysrepRz72mmPgHaiz2zeD89vL
	 H/ngFP2NCLzfHMYjKCQLZeGJRR51Ykd8TJT/u0hTzfNbQMWvpRJp7Pr3WLphCJekjBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291286;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=;
	b=ziXYcRDZp1N7QXtd/TnTjDdmtXn7mRDpihVM7kPp07lUSPvwH5hbV+oUlzjvwO2Yy4AO
	 WDMxMP0ZPGmp7Px1DIJf116+TkkuxhHydDinK86hPA+Qa8GnCeg9ry8/zh5DSX4yomkfD
	 iuGLzAFIPW9x64OhnU5MBa8+ozOjDR+JC71mPY/3mMQS7SRCaiIYQFkX+WDLQ0IGmeYct
	 /EhwuPz3oNag/XuVeacfk5/ulfwN9b6WG4410QBcdhtI3HHpj9W4jPulP62ScXsy1ZFIl
	 6DTg3BZByQVWGWg83w5NFBWBEwuA/8Yq4cvwnZzKrKHMNys6jflMf0RHVwrtzL+arZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="1M0/YZ/7";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=hAVzwnPs;
	arc=fail smtp.remote-ip=185.56.87.6
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF9606A332;
	Thu, 29 Oct 2026 16:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDF9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=1M0/YZ/7;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=hAVzwnPs
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; s=arckey; t=1793291284;
	 b=q+NCV1YPgbdcHPELoSFOFdJwadT6DoGSNtKKrX4vZa6+IiNzAc5Tt4hNIAfA8gwbuA2SEGdtsO
	  SulkvBKNUhMbBBv7jBQkAipTxBGYwGhoCFUSjQr+X/EiQ+wBq8CIDGLgp5YqWZxGryx6clRqMl
	  HpDRHoz7zUccPJmUdOOSkEpithQyraoExPUne08a+vOMMEblayDQFfvlEcstscWAEds7bpSWGD
	  KXkDYE2BGlVFKZB4sGIaocgZbVc1gPFXTs1fv0zahlT6gGcV1uXz71zdTVzrSOb8mXLw0BmIoP
	  tmmg48h7ySalrdhUIu7TiJsX4/f72o1JV/4bOWw0I7yovA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; s=arckey; t=1793291284;
	bh=X6S0PLqxQcZ86t8V1FtbHEUMXPAUo0p9pqPUdS7OlH4=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=lE0WcLac9+K4EVRUJ3PXrKd2I4BS7jmUhnj0oZcgiTxUMsHPcZRqH8ZyC/g92oPAmpcil/ouKC
	  o5WdZtWDJVU6og+XPtRfTsmNshbeB3l0zOcyjyUtBiI6tJZLex11W75UPlsllCZXcuOZb9d6/H
	  bDTVG1MEZ6t2iohjgrklNe39xLgygHTahJhjxNIT7VGEywcdst9noW+HQ+OighxHZNpciE/G5y
	  vyNbcV/irFpGQPgMnZGXzPDTWD9lVY0uPNlCEXmI6rrbuAkZvuJjAUeKTpkK+AWxE686M1CuKv
	  md1YMe8FZ/KrCQ28VlMsSh7Xsw8tMOmz71V0c5xkbS5FRA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=; b=1M0/YZ/7BNTWZrzVR24nflpDlE
	Z6eyEQD+LlZ5vrRrToIvcMEfuWEq4SaTagOEERZrWpjrYpnHqQkRdp0ZJ003PEARyegNG/lVa5I51
	poTtNUBP8gb/gGvt7Ys7H5YJ3rg9w+NyzdmHLB/S78pb+pKZE+9zdzYimJ6TwNIHGUFw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-k52m.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSyr-0000000AHxc-2xj9;
	Thu, 29 Oct 2026 16:27:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=; b=hAVzwnPscuTIF6qcGIZyE97rI1
	OIT4l7hkBehenDGqpdO8rto1+f/TVE/7s9iQ4ye8Suh7sn1Z4tL4chb9w9gvMU82IcPA498ouI19V
	KVpNZc/afShvPuabha/LEYkXv9ym8UmwTeH5kMVc8725QCD0ppYf2jHuciwt31bSB2iY=;
Received: from [87.16.26.129] (port=60224 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSym-00000000LSm-36Bm;
	Thu, 29 Oct 2026 16:27:52 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 29 Oct 2026 17:27:44 +0100
Subject: [PATCH v3 2/2] MAINTAINERS: replace spi-virtio maintainer
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
Message-Id: <20261029-spi-virtio-bindings-v3-2-ef30217abefd@valla.it>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
In-Reply-To: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=francesco@valla.it;
 h=from:subject:message-id; bh=X6S0PLqxQcZ86t8V1FtbHEUMXPAUo0p9pqPUdS7OlH4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmPS9iWuvQayt8ridKfMmvezl6lL2xzFmbuuzF1WXT5n
 C6FbUHmHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBEZkxmZNg870d2WhWPmZLj
 fucLnzf/qf+uLLT21PR1m+3YOZs+xt1k+F8a73vYaNErr+0Nm3grwy548mQsuTPl1hdnnjXRNyK
 VDnIBAA==
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
X-SGantispam-id: 2d112615748a9416d835cc53ee0e8491
X-AntiAbuse: ID - 2d112615748a9416d835cc53ee0e8491
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xMSyr-0000000AHxc-2xj9-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The e-mail address of the current spi-virtio driver maintainer bounces,
since the owner (Haixu Cui) did not update it after changing employment.
Take over maintainership of the driver, which I am already working on
with the introduction of its devicetree bindings.

Signed-off-by: Francesco Valla <francesco@valla.it>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5724645bf703..c0c12d18401f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29672,7 +29672,7 @@ F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
-M:	Haixu Cui <quic_haixcui@quicinc.com>
+M:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.56.0

