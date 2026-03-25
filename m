Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0116A956;
	Wed, 25 Mar 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437158; cv=none; b=lKP80gVMC8tz18K/Cnh/XFlo6QS8NczwVxZHxaHDHwmzFbIZAd287Sls2OXEZ8lj2Eb7P0z4SGv+bC6LmjOK2yqHHpNq0Qkqhbyu3uthZUCVWi279b0aVjHocJXMTrDnTuXf+1shLUik/G0gN/k2LsyCwC1uJLaKboTH0R3r7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437158; c=relaxed/simple;
	bh=iBMxoKy1QIw5lPnqL0fHy3IICkl0scV4F0E+pd2QdXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpL3R4XMMXxc3GpZGASk5sRbn5L3QWQuhLOmQ0mgHtAXds+5qdSY5zfrnS5l2ejIH8iBpeDv2z8NSnOWWSFcpKbnZixTT6ALkmHy+dBpQSHB5HlyIFNAl8CoGsIDNZmhMY5aEO3ZuZHgaBO1ZqF0/9FBjY+cKChIPxPPu0i48dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1GrC0sB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1GrC0sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D91C4CEF7;
	Wed, 25 Mar 2026 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774437158;
	bh=iBMxoKy1QIw5lPnqL0fHy3IICkl0scV4F0E+pd2QdXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1GrC0sBfucjgfA6UY9iLJUxpb5g68rz+uBhNZEZFQBd+LcGfilps9E66AtbqI8Kt
	 aMEl4OzBdc088pW31VVUtuHZ34SV3rNrXWZ9CEScRKKUXGldr+WXD9dPwv2CIkxWCD
	 vrbIAJmS2itOgA+fodeIN+5sejAOS56d2kp8RSHcqQmMTzruYN/Yv/20QpZalMAKcm
	 Z8mUcOkZZ+zVX+t7H1foR0Jeuj4f+QzW7nD647Mhnq1AVKSL4loCGEgJoXK/xYvdYN
	 9Ws6XmWz9WoWOXCJ0+kBvRFJOKRAtYY9rynjRBrE2jvXZ6uKjjrnCrV5VH4RkeJMAw
	 MDtQdfLTChI8Q==
Date: Wed, 25 Mar 2026 12:12:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] spi: dt-bindings: qcom-qspi: Add QCS615 compatible
Message-ID: <20260325-vehement-bronze-manul-ce6bcb@quoll>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-1-3efe59c1c119@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324-spi-nor-v1-1-3efe59c1c119@oss.qualcomm.com>

On Tue, Mar 24, 2026 at 06:43:18PM +0530, Viken Dadhaniya wrote:
> Add the "qcom,qcs615-qspi" compatible string to the Qualcomm QSPI device-
> tree binding

^^ Full stop

> to enable QCS615-based platforms to use the existing QSPI
> controller binding.

That's obvious, no need to state it. Writing longer texts without actual
useful message is not helpful.

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> index 1696ac46a660..d9aac33b695b 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - qcom,qcs615-qspi

Existing bindings allow flexible interconnects, but it should be
constrained. At least for new variants. Please move allOf: to the bottom
(after required:) and add there if:then: requiring min two interconnects
for qcs615.

Best regards,
Krzysztof

