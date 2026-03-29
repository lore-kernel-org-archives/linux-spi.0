Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A527FD75
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794715; cv=none; b=lRiOFu5huauU9/ht3weAR7XWYWtNtnpRGAJIBEBqpJ0y4/tlKOSHkE//Mi1vr6XOeY1cN/MtgceiExT5bQGj5bBphZW78K8DZKxyQlNX1melyvzgQIf4iJHhcrr5F1iBqaRENdGR0MH6IUxC1swoEWxgKxNPVnHH46arCLoji/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794715; c=relaxed/simple;
	bh=8Mk60eVl+dB5jKyjdUQ03s5Lx40a3eGPQVHoD7Ugcvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPpyabIWe7GNEOEWqwAMPTaKqoOXioKjxMjZXCKD9znKaUXXsh6KcbWwHR2z18sMekKdRVIc50cdC0iEWem87t5VFq2JfuEBHBwRNy2b0x43D4O+PCzR5Q3C5w+unBxLltiUEsUyTgpdfot3BeEw32k8X+LjWsgA0E77Il+BZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUVhYOFc; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUVhYOFc"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56cf45deb45so2812205e0c.2
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774794712; x=1775399512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdYDhOE8OZqYxhSczZPWR/m9/1jZD7ZOGeIOm//D/jo=;
        b=rUVhYOFc94N8TXweiccYzIRuw54E9kz8JKCEFmbsOl6Tce/P8k1Wmf5Ad8009bNjWQ
         j94Q/N60U+XEzKDkH3vCFnWasO66AvHkQ7pG3nO/my2GCJbDPviyq9KmaAj5MBDaAOe5
         I+s7FB7gydVvPbW+5S3IWlHwS+DBixx/tn4YM/LA2jvrtzyXzZ2sidX9dx1m0qMBmEH/
         YksRVg+yVAxelZSRDecKz93eT1rZIACh6mN9p+xBA0SA/r0/IX7B2D7h223Bzq6czhje
         nRhl+ledZY2ZeUgO8cwct0jSU2tk1xka1VlWuRvFEe3PjSjGWSqPpD1zggmBjIWecsZ+
         CvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774794712; x=1775399512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdYDhOE8OZqYxhSczZPWR/m9/1jZD7ZOGeIOm//D/jo=;
        b=FWNijSn+RXrF3+UTpZgmoW+oCwIyMs+SKrNppyD8y3u0TtFzkhq7Q0rQxUaEMsE6GZ
         g0zuj7Aqn+5bIDtPckIIpj6PFY4gbGdYzHIxMP26lHmMHFuf+JGuNiAHYtWKn/p/mGwD
         zoDBYdOnzmELmRRo8BqAraYh01qm2T1Zr3IRDLkTBnYuFBn6o0krpvnhbmUKRUPmk5wl
         NYxQbhdPrC5HiJq16xaUGK2I8c8397PFUJhqVyx35Eet8VtIlz8di3wX8s0Hea0EFNZo
         98jhcrsQNG55ga4kbcA2N4XbRbk3qDSU14wu3YnxeXEOCOsbHa5T6QtA+9b3AWscfAHF
         yCYA==
X-Forwarded-Encrypted: i=1; AJvYcCWittOZ5nMEYDpozXXm4U78/IyWSCdvqb/SqK1rqzdvm+gGuNM+HBae5hmO+tdxKIlI/prqrMdaFoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkEdSI9RVW49KvTXoBwaMnatnbvAHrxHyZ+U+371uzTljy3ZE
	dSej5iM3SXPvAR/fhFkeXRFzX0RP2vo8DGMSsMPli7onbYzN3u0VSbci
X-Gm-Gg: ATEYQzwvCnuehbU/mALBsj3m+asMn0j2qxmcVd9eEuYUkw5U3LouxCfwqvbBiZcVtnC
	7GypbaIXSvwxC8YqhsWy3FTU6mNEYbYDAGPaoXe81fAB4vyfPNoQF1A3w2QyZ5I0YjTYiRux2aa
	9UG8jWw+qlRJau2D12qk4xVUnL5oC3AUsksjm+Dln8AcrLvSAaYJk/+6/kOpy5g5Bk1fERnODpP
	Wlrn7Tm4p1bwT6lhHyTnSuVPF0dzwGxnRPZFh5rTtyxS7WTVYe88tUtoBXi3Xds3lGfQ5lFMlTA
	mMBavWjw6NG6r71PdQNzppooXysGa6S9CHUkO5Qucq/K+c3hphV695abe+4mVXcUYIZvsiP1SXR
	BbPA4ayul2rHooFRoQmU8/wd4JbU0YT+oP9gflgYAv6qnmPq58lnLHzA/a5WSZdy++YKPamW+BL
	zHSXxPOT+wVoAEpV5iAPLlB8DIDl0165g=
X-Received: by 2002:a05:6122:6e0f:b0:56b:7ec9:f54 with SMTP id 71dfb90a1353d-56d4a60af4fmr3772261e0c.9.1774794712267;
        Sun, 29 Mar 2026 07:31:52 -0700 (PDT)
Received: from localhost ([2804:30c:979:9b00:9cc3:5a7a:e884:2060])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d589fcfcfsm5510916e0c.10.2026.03.29.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:31:51 -0700 (PDT)
Date: Sun, 29 Mar 2026 11:32:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: charles-antoine.couret@mind.be
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] devicetree: spi: add spi-mosi-idle-low property
 support
Message-ID: <ack4AWGeblO5hvkM@debian-BULLSEYE-live-builder-AMD64>
References: <20260329125832.2985115-1-charles-antoine.couret@mind.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329125832.2985115-1-charles-antoine.couret@mind.be>

On 03/29, charles-antoine.couret@mind.be wrote:
> From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> 
> This flag means that device requires the MOSI line to be low
> when it's in idle state.

Same question asked on the other patch [1] applies here.

By the way, for SPI bindings, the patch subject uses a different prefix order.
See submitting-patches.rst [2].

[1]: https://lore.kernel.org/linux-spi/ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/submitting-patches.rst?h=v7.0-rc5#n18

> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 3b8e990e30c4..5f5b143cb27b 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -132,6 +132,11 @@ patternProperties:
>          description:
>            The device requires inverse clock polarity (CPOL) mode.
>  
> +      spi-mosi-idle-low:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires the MOSI line to be low when it's in idle state.
> +
>      required:
>        - compatible
>        - reg
> -- 
> 2.53.0
> 
> 
