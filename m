Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079173;
	b=vcFp2I8CVU+ePI+8jMtwMoWRvfUfJeexHtJkjLm2r3LCsb9Bx9rzgbKQuQ1FeharOmq4
	 MQ7dYyetzBq4pAvZ/xoR9lp04Tx2GiekXnk5Irs7N8TBqVhonDV3aXAzznvu5K4xyiUZw
	 8xuLulaNxUix9iBS9qIL/JWtsWbLO1DqpZPcv3XbS3JS0PTO/R+9AUlihEGTLENPQ9TqC
	 iZrV18Y8as1Ypmevi5ljxBTfnY9iPokdQPrn2iWsjhW62k1+b62LoIl8DuLAkJDD0gQ4T
	 gdXF8jmExnn0dlsIykHjpMxWt0fY+pveBgSvlAolZcTifaGrWgPSAD8F7h//5gfmbQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079173;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:X-Mailer:Received:Cc:
	 From:Subject:Mime-Version:X-Lms-Return-Path:Message-Id:
	 Content-Transfer-Encoding:Content-Type:To:Date:References:
	 In-Reply-To;
	bh=4HX5+/MoRFuL5friO42awFlJeeVyzzPj59afEXfj3X4=;
	b=BKlY3/YlvHpdqda758SxLXTy/ULSff2WAlcwTJ539cSD0Grfgs9RM/uJ4fEx3jUQE6R9
	 TOy7gu4aA6hMYkH309WNvdCksbVeK4wB/C3VX/at1WqZqtSs+2sRcf9m7r+qyRUEsoAaQ
	 64S+IFZaXVqv1d+rHFT26fk4IxYhkrNTOJGDdkQL17937rkX68LUMkIwKTmcNGIWkSIPp
	 xcAzBDNLU2euZrKeQayTeNVfnlUtd5Uhd4SE90wjs7tvjpYwe7hrd0VR6aujmN08kOqbD
	 lgPWonMxCNS6Dx7YQPlfHBuQHV4HMgnCxAzRF0TWoDdzrhD6vuytSMCe4INNHMpGkVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deepcomputing.io;
	spf=pass smtp.mailfrom=deepcomputing.io;
	dkim=pass header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=grjpUPxq;
	arc=none smtp.remote-ip=209.127.231.45
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1628606A337
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 09:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1628606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=grjpUPxq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1795079166;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=4HX5+/MoRFuL5friO42awFlJeeVyzzPj59afEXfj3X4=;
 b=grjpUPxqeB05GIa1dPz1KJ9Rbrca6OpaoKotakoD7K3u5Yb3UX0SyVmQkUH8ft8bPaoy1Q
 7JzTCIsAwNlQYLTeYnFHnVv2n2GBbtfAmLO4YWi+GWGJldsjpEX8JKGZL1w+gYzEGcHQee
 tw+CLuKJejl+sKk+3iXjU0tjS/h7FSLqLLukiFb4hxRsYMQ8xzym9o++8eeRW30QVYvi0y
 YrNf3Ok4ZCFfuxPdO8xU0MVxZbxxjnzXeonBG4rWUxIp/wIyvXuMWFjjexsi09teMvSIWO
 jybF2WA6Ag12mHLIPmJNUWjpL5Y4z+ak1MAMgufr5w+AlGg7L/NQcHKbm6jqEw==
X-Original-From: Wang Yang <yang.wang@deepcomputing.io>
X-Mailer: git-send-email 2.43.0
Received: from ubuntu.. ([183.23.99.162]) by smtp.feishu.cn with ESMTPS; Thu, 19 Nov 2026 17:06:02 +0800
Cc: "Yixun Lan" <dlan@kernel.org>, "Benson Leung" <bleung@chromium.org>, 
	"Troy Mitchell" <troy.mitchell@linux.spacemit.com>, 
	"Tzung-Bi Shih" <tzungbi@kernel.org>, 
	"Guenter Roeck" <groeck@chromium.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>, <devicetree@vger.kernel.org>, 
	<chrome-platform@lists.linux.dev>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<linux-spi@vger.kernel.org>, <broonie@kernel.org>
From: "Wang Yang" <yang.wang@deepcomputing.io>
Subject: Re: [PATCH 1/9] dt-bindings: bus: Add SpacemiT K3 eSPI controller
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26afebbfc+389efe+vger.kernel.org+yang.wang@deepcomputing.io>
Message-Id: <20261119090553.1886090-1-yang.wang@deepcomputing.io>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: "Conor Dooley" <conor@kernel.org>, 
	"Aurelien Jarno" <aurelien@aurel32.net>
Date: Thu, 19 Nov 2026 17:05:53 +0800
References: <20261118085742.1817536-1-yang.wang@deepcomputing.io> <20261118085742.1817536-2-yang.wang@deepcomputing.io> <20261118-backdrop-scrap-1bee34e06336@spud> <av4iWQb33bya48G1@aurel32.net>
In-Reply-To: <av4iWQb33bya48G1@aurel32.net>

Hi Conor, Aurelien,

> How is this "eSPI" different to the eSPI described in fsl,espi.yaml and
> implemented by a driver in drivers/spi?

Thank you, Aurelien, for clarifying this. K3 uses the Intel-defined
eSPI interface intended to replace LPC. It is a different protocol from the
Freescale/NXP SPI controller described by fsl,espi.yaml.

On K3, the controller exposes a CPU-accessible window for the eSPI
Peripheral Channel. The EC client accesses its command, response
and memory-map regions through this window, rather than exchanging
ordinary SPI messages.

The proposed controller driver handles clocks, resets, link
configuration and window setup. The EC transport handles the EC
register mapping and host commands. The distinction is therefore
the protocol and access model, rather than the use of MMIO itself.

I will make the Intel eSPI terminology and this access model
explicit in the binding description.

Regards,
Wang Yang
