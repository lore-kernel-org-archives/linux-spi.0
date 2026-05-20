Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE293E9C26;
	Wed, 20 May 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286870; cv=none; b=He9HDpaG4sa8f+Yei5+hDskGrXazOLzZHP+QwRDSle6B7TRCSHaj8xFacPr7wc3nT8xoPVXJ3Qg2LQaIxa6sADPpXB/Q3DlTwsvOWdwoc1Y4RkY/Kya1I2w4Wjxw7b2Ycuq3GbGzjM7jvpCtn2NiPPBDZsvKXqgjN6IghbiRuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286870; c=relaxed/simple;
	bh=o80hkq12hOv7CQPqQD1IVh5XcVb6g3yssgV/Fs94Xn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMdM3+OSk/1pOtfVe4+JCnRmcCQXtxsOByAQuXnOjnfwLM8+oFINioZVLDklKC4EYmtnhDjZEpa3qxc94bmMZBPJpupF8mZ2vfXOxMNAMOl4EGPk/ge+smUx6aMy2Fjl2VGP2lbF1W5+pPegrrnEJ/mxdhg9B+9NER8oK59cggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1gP1izC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gP1izC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35151F000E9;
	Wed, 20 May 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779286868;
	bh=dSkU8KGuf/aJKSMYjpXAmPN07Ebv/tBk5PSaYaKcXw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a1gP1izCH1gFkaBAfxYL/OKky9tykxq88oQ0xOsm60nhGJyaDqmaHdK2qWe6tzV3F
	 7se4PhhKLhSfwXvzF+TqemmAu1xcLD2RcUyjoBQJJnRtNx9AtGz5MFNgCMQtzVEQEJ
	 56PARB2/72wrzzrBj3Km/TH9bypwxoRtGTaxNlbWVFJVAYBSeYmvuisziIEmqBtG3P
	 oiXaXQ49+jZ98tXVzi/+/cKvzSEFs7r9APAf5BggSgcFpk7VZIalEF0AJKPvHSKT2O
	 3rytpDaXkagwzn76yl7jOcVZhmCR3KeaLKWEl3hrdkDhn2h5d0FgoZP4EFxIjc3/hC
	 otAhKdBKYQuCQ==
Message-ID: <3eaa70e0-4284-4c35-a5d5-42afa3087eea@kernel.org>
Date: Wed, 20 May 2026 16:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll> <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org> <ag2fjCX0DuSVxubv@xhacker>
 <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>
 <de325dba-0b82-4808-910b-68f0f6426c5f@sirena.org.uk>
 <37a3e9dd-88c2-4d8d-8ae4-6037a1eeedcc@kernel.org> <ag20q5CuB2XsqKS_@xhacker>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <ag20q5CuB2XsqKS_@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2026 15:18, Jisheng Zhang wrote:
> On Wed, May 20, 2026 at 03:22:07PM +0200, Krzysztof Kozlowski wrote:
>> On 20/05/2026 14:30, Mark Brown wrote:
>>> On Wed, May 20, 2026 at 02:16:21PM +0200, Krzysztof Kozlowski wrote:
>>>> On 20/05/2026 13:48, Jisheng Zhang wrote:
>>>
>>>>> If you mean "Why this cannot be deduced from the compatible?", I think
>>>>> the slave dma port is part of the cdns xspi, so its io width belongs
>>>>> to xSPI device property.
>>>>> From another side, we have seen such property in other drivers such as
>>>>> the reg-io-width for the dw spi DW_SPI_DR port io width.
>>>
>>>> So you mean it depends on SPI device? Then why spi-peripheral-props is
>>>> not applicable here?
>>>
>>> That will be controller side, not device side.
>>>
>>>> If this is not bus width, but DMA-something, is not really then SPI
>>>> device dependent, but rather DMA controller limitation, so either
>>>> deducible from compatible or something else is missing here.
>>>
>>> My understanding is that this is a connection between the SPI and DMA
>>> controllers so it's not as obvious as it could be which side of that
>>> link should have the property, eg:
>>>
>>>   https://www.cadence.com/content/dam/cadence-www/global/en_US/documents/tools/silicon-solutions/design-ip/controller-ip-qspi.pdf
>>>
>>> shows a separate direct connection between the DMA controller and the
>>> xSPI controller, the DMA controller isn't interacting with registers on
>>> the CPU visible buses.  The width is probably a design time configurable
>>> option on both sides of the link.
>>
>> Yes and that sounds a lot specific to particular controller, thus should
>> be implied by / deducible from the compatible.
> 
> This is IP feature, so if we couple the IP's feature with platform
> compatible, I would see some unnecessary LoCs. For example,
> Let's assume the IP has 10 users, they all support 4 bytes io width,
> other features are the same. 
> 
> If implied by the compatible string, we need to add 10 compatible
> string support both in code and dt-bindings.

You always need 10 compatible strings in bindings.

But driver would need only one, since devices are compatible as you
described.

> 
> vs
> 
> If supported by "sdma-io-width", nothing is needed after this patch
> 
> IMHO, the 2nd sounds better, what do you think?

We answered this in writing bindings. Properties are not replacement for
specific compatible. I don't know how to write that sentence in bindings
clearer - it's exactly this case.

Best regards,
Krzysztof
