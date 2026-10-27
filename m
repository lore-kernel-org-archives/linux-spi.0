Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086028;
	b=hlBS7tWI4MBnMvFYe7YYPnDdJGsFFcCM/7zmGlHOOz6Ul7w+A5Cv8XvQNY+aoHo16N39
	 LL4+KpS+YKT4I74f5KOFEm980Zme4Y69LK/HrhTvpbUHce7AVQkVT65IVZiAlmvnRnTQe
	 quTOCT0kZJzFp7LIXsJP13s1tCxgyE7E4verMKxVUj1E5lmveyyCWBcuKunXAe44u67cm
	 u4qWudZTfzs0tZgDB+8ps69Q28InK1Y1laJJkd9k4ijPab9lVtxsRQI1KYEKrfQ7paq0y
	 tGFlKu90ZUpaP3RnBoitOGm41deqTg0R7cgZyL5LnwNb9NA9b8Cz69JSCFGiNtCnRRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086028;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=;
	b=tgTNAE9yh0Ho/2Do1fXGXd46bCIl1RoxxVnFXrbo6Gghnw2Mf1eo5a8XCtc8pLDuFkLL
	 44fQf0EgYchaQgpz/Dy9PoHQI421u4wl5UUFPxCrCL4DLhA1Ei+8ZQKk7weHVL/2fapFR
	 iyMMnq5HL4g3hWFBFOam2n6PujCJrzWuJk4p9qG2XHqBJwEKS/UWq6Xdg7rPHJ7JAYJkK
	 JOnl8eWUPbqzQI5q6efZf/Xf+sscm/QL6O6QxgZJqj+ynonzBbSNrhfqodT9h8AQc+CTm
	 iVgfXilaMA8mkvoOCHMr60uFTt87S//b3S1F3L7IEmwvAiMu0xWqPrcZBJL28nhnxEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=jCw+G0pl;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=L6Aq6yRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.12
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CC606A327;
	Tue, 27 Oct 2026 07:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2CC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=jCw+G0pl;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=L6Aq6yRi
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086027;
	 b=aiLno0WPtqW/YfAK8iwFRPhGsejQt5wQk5FME3T0eb/DS/DqDK/D2LHIrXNjOlYw1Yooc2DTzy
	  M12VQjsxqyRJu020xNV/haHMXne+q63oMJP8qnnZqPJ7nYpAhOYmycUkLtHwUQxkvoiNvP8qts
	  0t91erSvZ5mBuX+2/6M/tKY0HsSNaurBaoMHlrjBngLMhim3+fsEoSFWlHwa05a/qKFpEZkzGF
	  b1bY2N1h36ZpDfZa88RtaEPTPC6KELqJtCclVV2XcbkObFdhHrBOViocPibpgvDihHcI+6iIUh
	  WrTNSlfCv4i3ChUf97+gOOBsP3a+QT/byQEUT31MZad/Dg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086027;
	bh=kKoqQLDluHNjJkFcEbygMkV5J8AlSinTWWymUCWvRyE=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=RUSU3MIdOYMqBOeo+uQtLUzcH5YlSwNpCBxF82LVPxTBWezwqwjX7FzGrXRTjMITyWFErW7/EM
	  Xjfe6yt7mi0x0exscKCQ8lxpj2xHY9ErrwHlhSwsRCV2jiULUZztYPRyA16iWHwGEqiM0YLUvS
	  KiZcS7VIeu+lneP6naX5PWNAxlNZf/uuJGCCZfWW7xWE34CHTRKoB/ev9opbk18eBPJds7TTjc
	  Wsq98FrOQWoI5JLA0hxmu650QhNu4ls0G3pFsz9s386tvlioqLsdmB/5hNM0bLF56jyrZQBfuT
	  RMAFua6K8UVpISaqrIEuX0hwlBcov5SgTlFgCrsOkyC0lg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=; b=jCw+G0plxBrGo0k3VKQxU2z3no
	ezA11l2H4Cz0Yj75Zy5jzXJkvLC3eI5XHiALs/jLKKUKn+N1cOo7zyp2DP+Lps5yKgsQ7I9xs3tHo
	1dLiL0CvVTJ0PCCFJtXU6UgsY0dotTaoJ6B8qJiK4MR1ejADtpGc9Xm4gKBgUJ5jhxXY=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-l70q.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLbaF-00000006vF0-0X34;
	Tue, 27 Oct 2026 07:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=; b=L6Aq6yRizkC5hLpz+mF34kln9n
	90V06ZJ+0nbwoiyoYdJtksk0JJzBFp7dA0MKthGg6OSufrlEvnrOEbjZHQhqTan06PTxKYVRsR2Kn
	brVB/LfI9XcMgfZHIjjyFwBA4ImfG6YK8hh1941qU7o4jVbwmB2Jp+7iK5ls6SI9/Vt0=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba5-00000000J9d-3lT6;
	Tue, 27 Oct 2026 07:26:49 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 27 Oct 2026 08:26:34 +0100
Subject: [PATCH v2 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
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
Message-Id: <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
In-Reply-To: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=francesco@valla.it;
 h=from:subject:message-id; bh=kKoqQLDluHNjJkFcEbygMkV5J8AlSinTWWymUCWvRyE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgsy/lE9I8hDqymbesanJPuL62+nzu9ySGwqL2tt2H
 GCqWH2no5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZjI7+sM/xMEeOQO8WR+/aK8
 7em1XvkHh95kTo4N5da3YLK6lpjjn8rIMGXxKc5H4UsftXb3291bzhhZlb7ae3r5lOkxOvWcN7R
 OMAEA
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
X-SGantispam-id: c794247af465d656732227b6c280eaf6
X-AntiAbuse: ID - c794247af465d656732227b6c280eaf6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLbaF-00000006vF0-0X34-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com;
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
index 5724645bf703..45a29ad08096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29673,6 +29673,7 @@ F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
+R:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.56.0

