Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231868;
	b=j9A82MCNbyVEox7A9XrJzfDiCdZ7qaC9Z9tcYbACRap+wahkOIEJwPowekrzaHYzSS8a
	 DdqjfUrWnD6sWRNPVs4kRWzwYgnbhDPtTkZ+0LBKhUyCyKthRsGdzvGLUC2ySjLcuscuT
	 K6CvRizpRReW7ayQlt1GN0vTw+Eyb0QCxlYQBuQrE7QIvq3mIu/ESnqGd8+7hTNa2siFM
	 AkBkAeGktkmWOuDRYb48+NGxpcpLqLtuSbV5OtccBmw4Q22bfQ2zySI5nbv1ssDRNFthr
	 X/xDOoMExl2wLiu6JbY9OvvRCmCxwPswB9haS/c0tl2wspSEM+a8oMG7pi9xTsFYFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WN1g6y6hSBMG7NkhvZAsIV8X9TkToGPJmfU42Pxk1aY=;
	b=m37S0V4JxCp2UDYpY51/XspUBhXvDEIGgmXmNfu5LvM2rushvVqGU38UeSYDAL+vB1PM
	 3uDzPOgKQJeZXitgmn7ygZGhYlB63zvcHTzzPjeZzZXFZLmedBrQRDwSqJagt6apQZSYM
	 7PenDwR6esIvmHfx8pFzBgsvocH4pg67Zf9SPEMr7VDhatqIhEazmfZ0vZOqMh7Cv8Ujk
	 CWyFc0bs5KZGY+YYNLtoBjfN53TlccGm8mX6jOqLRfEtw3ISs9nzBVb9A/MfuWGYPGVz1
	 ykuG5FbhPghl0eSTO3lbgp7qxvtFN3sg1l2vJ8TL6vT6UfC4Yu7uNyBfr12KgjAZzLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGtazB+R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF26606D822;
	Mon,  9 Nov 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGtazB+R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F51F008A3;
	Mon,  9 Nov 2026 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231867;
	bh=WN1g6y6hSBMG7NkhvZAsIV8X9TkToGPJmfU42Pxk1aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGtazB+RE0s53RkUwhnDYqg5WEwfiYRenE3dzm9IYF77BmvGO7ukNrm05/TkiZAF+
	 Q+EKAhYodYwX6BYji6/iC70rBTHmTdXByWFiPOGSyS6euNxs7Zm2hYnrT1bgkNQpjx
	 VUpE17T3jeA2eec37tlymcTf3qoVI78+mHFY3TUOrHZTt4Hq/XsyaXnJHgCCHRVjpp
	 GJ/cPkSZgkI3MrSGCzd7RVjT9K+BpLUuRvTWFqMx49FDQcLk5H9zJQYLLpvLwLfHeW
	 Pf2PYvuTLf4E8TZJtmH5WpJYmPlouB4vrptk1D/hGEGbU6YKlKZ8OgE4hInMGoijM8
	 JhGu0DaBdk1cg==
Date: Mon, 9 Nov 2026 14:44:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
Message-ID: <20261109-stimulating-oyster-of-respect-620b7b@quoll>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
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
In-Reply-To: <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 08:31:22PM +0530, Jyothi Kumar Seerapu wrote:
> Add GENI_SE_QSPI with firmware protocol ID 9. The GENI SPI driver uses
> this value to request QSPI firmware and validate the protocol running
> on a serial engine.
> 
> Extend the firmware loader's protocol-name table to accept QSPI.
> Reject unused protocol IDs in the sparse table before looking up
> firmware.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 7 +++++--
>  include/linux/soc/qcom/geni-se.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 873bfbd6b2b7..396f3d81d292 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -122,7 +122,10 @@ struct geni_se_desc {
>  static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  						"qup-memory"};
>  
> -static const char * const protocol_name[] = { "None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE" };
> +static const char * const protocol_name[] = {
> +	"None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE",
> +	[GENI_SE_QSPI] = "QSPI",

Why are you creating holes in this array?

Best regards,
Krzysztof

