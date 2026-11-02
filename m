Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618954;
	b=2wTdUrqK3eqglCtbx0AkwvXNRchSNVXf7Ktu74J2h1l4wcYm0CCgvtwQDgZiD8q14693
	 Wc+jsEffy9dcaqA1rMpK2QoYhXbled5D6vR7AKNc3FVLxkrLwM2ZE1NxAurl9CW0gFV7A
	 A2UnpS1xg7115OEc6//m78epHrcc6oy/tU2mUh6aDO4JnkTiGAARjexUPcimZksXSAHG8
	 FEFIU3gQkv5PXfZOcMgaIyJ+wSECueaEyX5IfHThydcju1pBoCHdyUiTFggtFdvzy76jo
	 u2l8EwuNdfj4AJQTktUXaLVSJfBgvwhyIcCnEbh8tCgA2LgB5noHVrCejuZgQiqFzWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618954;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=66uriXcNtXR0yHVDrtRaOlgokO4TMcgzsk3HlRENtas=;
	b=EFWbv9o8GDEiQ0dAbIr88ltDclRbdjHhsSDg/NjS0VaWGa89L84cArGes57CuY+mFEeG
	 RZ1NJ02OtbgjnwCjPe0zbYscyxT17E+80OmsD41WPtwFcCVF1PbFaV9ISy6+doU3JDcDM
	 VpEJUEzoFC4/KsKl2cna/aDJGStWBNf+/zL+zSXGLPVcA/XqiJDSc6mlwC1ElYwnOHI6j
	 RDxfHMj9bM2+VyF0Xc8BBvc+IprBltP2fSXZBtFBCmj+R2ZdNO5Ghn8SrSbXEFBkYdBjq
	 GFCZGpkItfM/akKnYYWR8q60dsOIVcMARUTV4BvLywYcKi6seBOvAzarHSQOW6ceNSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlDYjULt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2360A2602;
	Mon,  2 Nov 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlDYjULt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C01F00A17;
	Mon,  2 Nov 2026 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618953;
	bh=66uriXcNtXR0yHVDrtRaOlgokO4TMcgzsk3HlRENtas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlDYjULtExUlN0+L3V66eobRYjM7Jgr6YEKa4TAReNHzpwoAAbhKKVb0ENaXcInzL
	 mRuKd5X/vphnTIbAaFYhYNGTJRnnxi16XYxkDgvd0ZZGpRaMc3vl6TZm+5DDUPLtpC
	 MWCw7MQmMBbymCEa25y6oJ29Tg3UHaXtrt4OXSQQh9/F9VM2jetEKgRWF95WWS7pHp
	 IX3XWtO3tOTqwdd1wsDeaLj0uconYEpjKXTOu8hd7IoETwSYI0RdBn+dtUxHY9bZe6
	 0B7m2kSdKHbb8uwpQMgkOng4dUO0D56Bau+ziPVSGJIV1u8SB8NYFUX+xkuofwET7s
	 PrH9t/DqGR4Aw==
Date: Mon, 2 Nov 2026 12:29:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
 support
Message-ID: <20261102-crafty-beautiful-lizard-36db2b@quoll>
References: <20261030-qspi_dt_binding-v1-1-5249111cf870@oss.qualcomm.com>
 <f71369ca-5963-41c7-9103-dd39a7369e38@kernel.org>
 <53640a9c-395f-4faf-bbac-20c47013cec4@oss.qualcomm.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53640a9c-395f-4faf-bbac-20c47013cec4@oss.qualcomm.com>

On Fri, Oct 30, 2026 at 07:28:57PM +0530, Jyothi Kumar Seerapu wrote:
> 
> 
> On 10/30/2026 7:06 PM, Krzysztof Kozlowski wrote:
> > On 30/10/2026 14:30, Jyothi Kumar Seerapu wrote:
> > > Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
> > > instances configured for QSPI operation.
> > > 
> > > The compatible also allows the driver to select the appropriate protocol
> > > firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
> > > distinguishing between SPI and QSPI firmware.
> > > 
> > > Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > 
> > Where is any user of this? You speak about driver, but there is no driver.
> > 
> Thanks for the review. This patch only adds the QSPI binding change. The

Please avoid stating obvious. I can read the patch.

> corresponding driver changes to add QSPI support will be submitted in an
> upcoming separate patch.

So no point for this submission. Please read submitting patches
documents (both).

Best regards,
Krzysztof

