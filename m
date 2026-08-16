Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA8318EF4
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900968; cv=none; b=o9ZJuc4+Q5qgZ64Ulw7AHLvV6+MtEA5/KXrQhI5yZNtD0X0ky7Mhafm+GPKqfVkH8S4wY7H/crb4lphEz2WwhWSGxwu9cA0k3qvIYChjOJWvtVEKMjlf+IbAdvKoL3zIG033jgq8OtC9Zp4L9sT7ujDzj5g4ok9GY8GoeahL+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900968; c=relaxed/simple;
	bh=lgumcRrJ8rwjWqiPstt94JVjeTNFgWTtkydtyZ8eNvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHdf8jdO6+Sb9TomX3dHJL6GOju9cvj99n2fx9IbUUCcsHem0coHJ1XjelVhSGbViThs8OSPw89ADvzcxQTt0Sk/TWi0Xd59kT3WwLG2WSueOsWntgL3kKZTBwPJxJ8zwuSC6RJUHfVGYRe0gv/f6bt0zVA+DdhsPz9hmcQGokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nx1/1vUw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx1/1vUw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1988220a91.3
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786900966; x=1787505766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBm1Wzj4BfERzM11I76dZxF/81NgZjZU3GpBir27U1A=;
        b=nx1/1vUwlIcScEmKmb4y7SGw55tE3haYAVqX/6W5ughnqew2MtaXvhimYLby6Fqq2U
         mFGw4r44Ps595ktaaqCFwBCaRqkxRT7NAt0812Y3ToybHw+gQ9TIlLtzoRqTUhH6cv9D
         uksxIIAtJA2JQw9lXC3C1t0BlY4E9cBXOQUhlc4LaU8Cpx30etmHc9s0Mk4yql5pzDpC
         WCPisfpwfN4mPUpDrWXNTFD9VQDtnKAKcDH5sIpOu+beTFzv6nkUnhRMRpmPtzzOc3Zh
         dR5ZrE2UGy5DDQUc9EofdnNvZnyjLn6MNO42844Jr/5jhzv2SOCosjWYjgJS5OVNCbXj
         +91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786900966; x=1787505766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBm1Wzj4BfERzM11I76dZxF/81NgZjZU3GpBir27U1A=;
        b=aikev2+A40wCV6glR48POcIeLfvE+xTWx1WRHaiTSMmwbAM/01QDGCeio6bstTwetQ
         guY6luJldrhJiJWByEQnVUk2WzomoBDUutMi+4vbsvbaDStO1hiIvLodVIwEQ9M9XuTx
         t6bzaPM7FdvHXYhkWzLBNAB45quu/uWLSKEXpB0mC+VYpJvtoKBl6VPNpWgbbcbJrk4A
         ohaL1GtOp+BAezTxzE8lhSmL7U6Ct9usq/CZir7RRJaqr7OWVR47GP1lzR1bmhjNDmGu
         IYptgGgJ3/I+aB/B1QhLS0jiQUPiWs+sx/pBda9jQ9cEV+GvBBwVNCJhzWGwOvcJFwWn
         DkYA==
X-Gm-Message-State: AOJu0Yzz/689lmvjhhG+RiZNwfcLTHgYFsz5eqbcvNLV8vC1xpRxpSzG
	1dPYn5yROuN9qy4JIvAmGkRBpEg0UlSYABn9WBDEwNAywG3xDm5an1u4
X-Gm-Gg: AR+sD13/ss5FX93UyvpwnZvxt9E7rRvD75Fl4lMRla9ZO/AWBXsw3FmPOdgvXMt3dbh
	+PLVmpWMiM+CyM4Go9ib0r4sDfYqaSU+qMCGlMQNGZE9LS4/Y7nG8UAuTjcatlRyitXC20h0CvH
	KBtrXXNK/6Am2MJ/n8ChIoLZ/VrD4N5SYMf2oW89+oF/ZUTcHxCxBPEuhQPvKntJqE+GBV8aV8f
	m3z3eGcINwoWdskRPu+5sPbTnnLISCr5FyUia1zYOs9d85LIPlc8BTIi+pX2DStcsCDb9fClhQ9
	B+gLl5YUVwXNZxXwrilCOveBYCcFptKXHjtR76H3Jgo3sP0t+/EqdzgZs9Gt8JF/n2uVxt5pkLT
	MeLZXWZLBYR7l1eI63kOZMvHdscDn1byMYBeG6Fx5TA33kfsDlKIxJ1IZFAyVgypgkYAHL6uuJg
	0d9J3VmSC9Ztd2ycJqWsI6XlN49+yUQg9Q1AprWeBHoGwzEE/9DiDT4Nf+SFLOLCdM8Q1k6JmtQ
	S+LU/fgInCGmMahnvDEN6udsE8PbWh0m4SMWnE=
X-Received: by 2002:a17:90b:3c91:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3933b78e3c2mr21847371a91.7.1786900966082;
        Sun, 16 Aug 2026 10:22:46 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:403c:f88f:3e17:55ae? ([2406:7400:56:e503:403c:f88f:3e17:55ae])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03f9sm28351382eec.19.2026.08.16.10.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 10:22:45 -0700 (PDT)
Message-ID: <fd81d0ce-46d4-4655-aebf-1387e5b030b6@gmail.com>
Date: Sun, 16 Aug 2026 22:52:35 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ARM: dts: ti: keystone-k2l: Rename
 ti,davinci-spi-num-cs to num-cs
To: Bhargav Joshi <j.bhargav.u@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 m-chawdhry@ti.com, daniel.baluta@gmail.com, simona.toaca@nxp.com
References: <20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com>
 <20260816-ti-davinci-spi-v2-1-6c6f5171422b@gmail.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260816-ti-davinci-spi-v2-1-6c6f5171422b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16-08-2026 03:53, Bhargav Joshi wrote:
> Property ti,davinci-spi-num-cs is present in the SPI
> nodes of keystone-k2l.dtsi, but it has never been documented in the
> bindings or matched by driver. Driver relies on standard num-cs
> property instead. Use standard property num-cs instad of
> davinci-spi-num-cs.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---

Reviewed-by: Dhruva Gole <goledhruva@gmail.com>

>  arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> index 330b437b667f..39a846d7f8a4 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
> @@ -401,15 +401,15 @@ mdio: mdio@26200f00 {
>  };
>  
>  &spi0 {
> -       ti,davinci-spi-num-cs = <5>;
> +	num-cs = <5>;
>  };
>  
>  &spi1 {
> -       ti,davinci-spi-num-cs = <3>;
> +	num-cs = <3>;
>  };
>  
>  &spi2 {
> -       ti,davinci-spi-num-cs = <5>;
> +	num-cs = <5>;
>         /* Pin muxed. Enabled and configured by Bootloader */
>         status = "disabled";
>  };
> 

