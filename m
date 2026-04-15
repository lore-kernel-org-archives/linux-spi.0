Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BE364EB0;
	Wed, 15 Apr 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776239816; cv=none; b=BcWTGrcBiWUYcDvDh0DQ5/Uusi2MISbzRFGgKnv2D1FNbDIhc2rybh3DiDZhMc/4h0NjB1kcuXLIV4jZjsjXt9A5LnrR0SdFXA2UShMmjoL2QYj9Exl66EXeaTEck6YS1n5MdZoNI+FVPkhAcDU6P1lZh41tFxVMrasHt8NfoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776239816; c=relaxed/simple;
	bh=JAqaeyCw5PU2u6iz1ihetntVR021RrJpXIaTnl1S7Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvwvmCu9USaXi8Xx/tymhWPsLHxV7s1/4LhmzolB4YTMuvi28Xk47XERBJWioqU7oKrffWu6pwgn6AvZYmkbcxpczPQLFy68ZtiTwEzEcAQbiDBK5uKuBXZQ9yYWcT2QX+pcp0XzinFwc00SGTNvuLTtdyQoKJOGb9zz1b8crDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ6Q3abZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ6Q3abZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C94DC19424;
	Wed, 15 Apr 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776239815;
	bh=JAqaeyCw5PU2u6iz1ihetntVR021RrJpXIaTnl1S7Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQ6Q3abZhY0zbDo01xx6lVG0+zvjxfFz4fvXiQXIuGt8gPMh0Z/QhfDnRDMeobYIA
	 4bPhxMrNyoN/Ja9F/dzu7iajfVp8qp2qVUUfyrZ78mFHDSQ3josQdFTvfomZZqNIEI
	 O1sTG+VDQ9gTU7SjLAUx12IrGzDZdgJFwyMxsNyxyhptAYIiGMAQ/xDXZR6ofatqhL
	 PegVb5tawG+KYJQBddZShXQ2WCrogATfDwSdvGV6qwHKMMC9q4crqk9cqhdf/+RESQ
	 OCjxL1foCtgf8kRSmG5cS9EKYKxUIo4jSQp+bkt68mUDk8sAWIAyggfdJQV8Zx55Ln
	 odbhHQVfMPUkg==
Date: Wed, 15 Apr 2026 09:56:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: spi: qcom,spi-qcom-qspi: Add
 qcom,qcs615-qspi compatible
Message-ID: <20260415-sticky-cornflower-jellyfish-291d9f@quoll>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-1-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-1-bcca40de4b5f@oss.qualcomm.com>

On Tue, Apr 14, 2026 at 10:38:19PM +0530, Viken Dadhaniya wrote:
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,qcs615-qspi
> +    then:
> +      properties:
> +        interconnects:
> +          minItems: 2

Missing constraint for interconnect-names


Best regards,
Krzysztof

