Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231991;
	b=WxPH18GPFQVD1aE1Q89L3Iam5pxMMalTgxe+akiH7PxXEKrDG0DU2Il+Z4VJD8uL/N+T
	 ocN8H018x26I+Pqj9xI5BgFaVdGb2d0TIt/jKnMf4ZkVOoTO8x7tI4Sbidfvf+6qWTmZf
	 sz2SKY0G525M38P9oLPshE4PUTYb/1cZcFhJkzN8QsF+zsvg+jHQhVDl/ZnQFP30Vxx7U
	 kNAzZy/uehsZ/OP7/QySxj1tA68a/ke3/yDBeH2dgYTrhnKP45d0DPIrsQRdx2A5V/3kQ
	 2rw6BW7U0UU0OBMtlPg0iHpAKPAb4/5wzbhtTpilcsyTJvJCXw+xuIbSE3GxWtAOI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231991;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gn39k29UXUgZfrG5Ykm3UzP6Qg4ugMU7w2b74/C/nBU=;
	b=n/MWTAzAK0rNinp8DV+7GaG8sUHElSqhb5piKXKpNEI5aOVr23zzPuUQrEkt9OMJyg8Z
	 Iioukx6nbk+a09aFCpQnlUlgzgSDK7j/eFR6KUpYtD6Fd9iTOI1XeD4ZLK6C1nwKm8eOR
	 QvTF/A7U5HzsLllBFX9zop4a5DaLNk3KyMFiQwQRA3g8b6pntDNBPGoUVwwPO4MRxjZwp
	 FjROccwYCZgRJupB1kA/tDM7DMcqgbB9BxnsJ79+9QaO7Otnw981HDzslMAfqkrcn/6zA
	 tw07hDCti4RfpdkrGdfyWn254Su9y4scL6c4m907rSMT4zdu1Fez0AyCuYxaijUIoEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thbo0qWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD0606A321;
	Mon,  9 Nov 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thbo0qWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCA91F0089F;
	Mon,  9 Nov 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231990;
	bh=Gn39k29UXUgZfrG5Ykm3UzP6Qg4ugMU7w2b74/C/nBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Thbo0qWmDoa+48YQg0JZkKyDsqRjFV5LQSlxtzpwPI3ljgfWlFSaqTgKMrd8bFwGB
	 CgBTgVxFOilzX96bOTE7Qyk7BxzQ9Kx/jbttZ/Uv4meoWuUUFslqWMon//5Bs3PWcx
	 3VEyQuZmAF6S59eGYulsEZJ+VTDR9qSjQXW6SQvUKtrwkIF3PjkqG+3wwdUBVU6eBt
	 5J/vKz/JMmAprAFQC2iRSJgQehXi81OwTiCo1oaTskRKQEw7LUX719RpP0mI0MzCUD
	 ChZH4Skw4z2AQLEj5qr9vuT0rUdGXt33VgpV+13Nk1kQpXfprQTuCOPexm3F/zHLT3
	 b+5q+A8sNgjRA==
Date: Mon, 9 Nov 2026 14:46:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
 support
Message-ID: <20261109-vivacious-bronze-leech-a5de0b@quoll>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-3-21f43042dd60@oss.qualcomm.com>
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
In-Reply-To: <20261106-qspi_upstream_series-v1-3-21f43042dd60@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 08:31:21PM +0530, Jyothi Kumar Seerapu wrote:
> Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
> instances configured for QSPI operation.
> 
> The compatible also allows the driver to select the appropriate protocol
> firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
> distinguishing between SPI and QSPI firmware.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

