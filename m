Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4A4F30C4;
	Wed, 30 Sep 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784116; cv=pass; b=LFmsSkhipHBzE+U7rLimhrHCiC77F/B3nDQnSV0HLfWGBqLhr4iPehFiDeE79lBraGafO7FNSZgWFh49N2kq2akYey1Yg5VT8gScOVXUd4IUQicOfMHch9Kg/lJ2++5zf7swg6NhJwPKsOcfi1Kau4/KqQCzVUNOS0Qap8w4ZDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784116; c=relaxed/simple;
	bh=uSh6Ndk8HHsadtIVQXx7nQmrmgTpDlhjRHbrdndeFDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igjuGESIdnoGVGQC6qRCI8tlgb7UnGXhp3P20X2PVExUOUO4S9D6sXo1yCuBq1cFjBe/VfgBu4LGhzSIh3KQCcdxvH7aqeggJSoIDsCBygc3nMR47RwF+I1HwXw1YsSvESv8ntuDhu/moypTdReyOXThBdrxuvNAbMv6VPoELB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Urgn5Ebo; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=KL9852F5; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Urgn5Ebo";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="KL9852F5"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-8qcp.prod.antispam.mailspamprotection.com; s=arckey; t=1790784112;
	 b=O3x2bNZEjIgCjhXbVztrE5tk3WDNcP/rHoIfM7o0OjZ0b9c+DPt4613WLP0PES0Was2EWltbyJ
	  jVBl3CFTbN52d5ohk1gvvodQ2NkS4ckvlR3DgDVX5i7hFcY1KtZRFhpwEa2naxiKW3hP4gkRc4
	  Xv+vkA4jCFfxo071hUp0FT5ffQfh5KvkKASBe0jSTtkir2k1htpxiDU4btq9ElehDOEQ3RMcc9
	  SJ0ytFII9xa37V5CXp03FcdfH6s3BmfDPMMmrQrXADmFfyd4x8Dg2ok5z/TdKFlNQVaghPH5r+
	  X8y3TVZpwFHQXy6s97bd0zp0sf+CawM5bMmPGKBBho1r7Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-8qcp.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-8qcp.prod.antispam.mailspamprotection.com; s=arckey; t=1790784112;
	bh=uSh6Ndk8HHsadtIVQXx7nQmrmgTpDlhjRHbrdndeFDg=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=K0j1cZZJo7iR0h4N9N04hmCZTUXGMeSEdnOWv58PsmyduBHNaDrKlbwrtyXRpiyrnO9gqcQUF5
	  /HB+9eWz9dTShqNXTkOj8sghXDZznEpAitXFdMdAENwrAfQe5Ah3/j/eMv3OdKg0pmWkhpafx0
	  AaR4sO8irK+wf3KFvwgtosNQvgrRmdvMGh+LXzmmibrR3q4O8Q4ol23SLz913DrWW46gh65SBT
	  t7yedilcReQx6hDT/Y9vqGBoJU0dAnW9CciIwBDRYPwK2xQfQ7QqBzzT94ZG0nxsdQs5AxDlx1
	  GzTgRUAvp0UOBYRI7n1lRSC/oMQexnB9kA5TtwXt6eaqVg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=dP3jA4xLY1vRZxU2Q34betBGbV5S3gISyd5gwp53GhY=; b=Urgn5Ebor3MJfdfHougbauXTJ5
	B3BXCZR8Wd/yxgEz48v2M/LOdkHisZzfSoSbzuFN/u8xsih+nXEBqooAWD4LFMTcQTMHrM4f80m4x
	pDZp+WayDRx+Me1nS+0fSVok0NFJ1R4/SIfURRSqHmNd79+xUycgduD5xHVdu/lgFc3I=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-8qcp.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBwkX-000000030ki-2WmB;
	Wed, 30 Sep 2026 16:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=dP3jA4xLY1vRZxU2Q34betBGbV5S3gISyd5gwp53GhY=; b=KL9852F57TwOirk5hpKe/6AAas
	Ch7amGbhS2pdRcxtmR8nhoAnhQQveQpq29lAnx1yzEUt937S2L0yqYqrNoWrBiW1o6NWcGwwa5bs5
	qLhD2LlArvXL8SV44ZifN31KEXb6txZ5lJ2z8o652qGHEPo97y3+XqWH+b8JTTfd9ELQ=;
Received: from [87.14.44.235] (port=62882 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBwkE-000000004sz-36Mg;
	Wed, 30 Sep 2026 16:01:22 +0000
Date: Wed, 30 Sep 2026 18:01:20 +0200
From: Francesco Valla <francesco@valla.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 0/2] Add devicetree bindings for spi-virtio
Message-ID: <ar0wnqVFn10MISod@bywater>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260930-neon-automatic-rooster-e2eec5@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-neon-automatic-rooster-e2eec5@quoll>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 3a4e81398d2970218aaee88026770dec
X-AntiAbuse: ID - 3a4e81398d2970218aaee88026770dec
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBwkX-000000030ki-2WmB-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-8qcp.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Krzysztof,

On Wed, Sep 30, 2026 at 01:58:38PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 29, 2026 at 06:41:54PM +0200, Francesco Valla wrote:
> > Add bindings for spi-virtio, like the ones that already exists for
> > gpio-virtio and i2c-virtio. A node using these would not be used to
> > probe the device, which is registered by the virtio transport
> > (e.g.: virtio-mmio) but to declare properties and/or child nodes.
> 
> Keep proper versioning of your work and DO NOT IGNORE previous
> discussions. This was discussed before, no?
> 
> https://lore.kernel.org/all/20260916-remoteproc_virtio_map-v1-7-dac8c5eb4aa9@valla.it/
>

This is correct, the first patch was an accesssory part of a RFC series I
sent some days ago. I decided to drop it from that series as it was
outside its particular scope, as Mathieu noted [1], after picking up a
copy-paste error signalled by sashiko.

I should definitely have mentioned that in the cover letter.

However, I believe this to be independent of that particular series.

> b4 solves the first problem for you.
>
> Best regards,
> Krzysztof
> 

Thank you!


Regards,
Francesco



[1] https://lore.kernel.org/all/CANLsYkzC5DU8j_QJLkuUcV2tYb=G86L_G4yiBZTePKSqiRdd6w@mail.gmail.com/

