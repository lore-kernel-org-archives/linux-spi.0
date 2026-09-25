Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384444BC92;
	Fri, 25 Sep 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333504; cv=pass; b=a2inAnm/S9KlrCrlxLEJqtrPig0WTc3doZOtxKdPNXjhPT3LZVXlTDcBrS0pc8ccF9jU4/10w9yce4JGv0rJkYdHa21xFCFb1fB1bcx4WGI4NoNDqimF/GRVbC9uB0CJpKgaH/5/LbCCBTUMXQ3unZJDZXxBmtDp7puhBtGdmks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333504; c=relaxed/simple;
	bh=xewz4+ASv6C3L0rxS5UUI3SZ2y1KCpscPu7AZ65SEbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYw41j7L0MXiQDf0WTsq5NxOERWnKFHzwoR71bAcUdP0PQ3O13+5+IfRh75hN7QdyCEYb/0FArYlWYDcy1ZfTw+eAqxBJrjBDxrWAg5pbKPp7eE0dXgDmd+HaKLGYZOKk0VlIXSq7EK1OW+1PVwZlsVOMvCPm0zrpDdgixRM92g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=epFX+VMo; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="epFX+VMo"
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EBE0B202012;
	Fri, 25 Sep 2026 12:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790333499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSDNOs3KvAulStyJRCUpvAyQYkjbgkE4Kuux/mn+0/k=;
	b=epFX+VMo6LAkqURbBv/ivJBE4Zo2IUTUMq3Ip+YRLeAxZc2AAFvTyBkAo+wlev9/mAzbBX
	e2eFP1Km6+9pYnTsOP21zGKaSwcf4BVhd4tvGLYLoNwgzl+8JsL1WiKyxJswFMl2LYtHRc
	8tnh3JnEY1vy4n+GDS1m7OhFWKtDkQXrJ9FAbT7nXbd3mPtwEnk5MCY9QRJOrQvDQ57SAM
	mBhIlymVUQjsFVh4BuWjy8cS6MV3mIqejItGUUUJbM5EPzzybZjBBUPvs1lZuV9DbLXtxv
	aEYZVKFz3PQ8wEDLiqyagNUMWIxO3SL/G3xKKuuvSNPsL8P/+ftvJKXC3UHh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790333499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSDNOs3KvAulStyJRCUpvAyQYkjbgkE4Kuux/mn+0/k=;
	b=K3SPZ9vHUmeZsyQq5K5zvNvKnQOll+uRIJ5owhBTXY7XCaXgUyjLAI4hxVwFIYJQ5YATL1
	ceDrzZqVKqaIRKOhngA95hk5DrbxCaiK6CIJOwXtn3t9PRcCWfYI17nsc/OsnFzvwYsO2O
	A8xxHR2YwbWBO0edOkO7XdWHHXQ/TuBeIb4tLQFswuDgPrIfHw0zNno42Iu5JaDnRlcpFt
	mUI2VHbBmbFQ1YiPukPqxQ3upJvxtr4NRQBWbDFaEaimYeGRbz0mZ2PArjnr7b0hcrKs4J
	y14G4DOY/qmP+c30ffrq9Al4m5yWBBJxMrAFyBn49/lLg+xqjITvgmg15nrkvQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790333499; a=rsa-sha256;
	cv=none;
	b=At9lMhN8XMc8pMboW1Pqluap9FyJo2YpS/OciLdOyrdzmAR9zauVWO37edlJBgK0hmuHOG
	OLWEIF5cM5hRRMPNcXQp8cHpxX3M0jkHxbWAnQfwiSs1qWzAkXXHZanofjHOqQem/3mrK0
	XZjINNI+6DSZoRpEIwmjTOS+DBSMBLZb1R/88Oox6neJLOX6BkPnUIGGhU1qwomVAQE7ke
	MsOi2Xo/II4Kv9WTp0JH8w8+wbgn5OFakDByyrdTXdmHs2hQaK2Xmxjo+11PQBtR6N5Z1V
	1SVvYsReFP6yR2XLs8PP3EbRl71KmgrnIvWF85Koe4uZTW8vkodCy7mqvF8K7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
Message-ID: <039e13d9-05bc-47fc-8d6c-83bc39578e30@pengutronix.de>
Date: Fri, 25 Sep 2026 12:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] spi: spidev_test: new features
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
 <179028361909.149798.4722443728698354015.b4-ty@b4>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <179028361909.149798.4722443728698354015.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-24 23:00, Mark Brown wrote:
> On Thu, 24 Sep 2026 15:43:50 +0200, Jonas Rebmann wrote:
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4
> 
> Thanks!

Thank you! Have you managed to take a look at my other series from last
week for sun4i yet?

https://patch.msgid.link/20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
