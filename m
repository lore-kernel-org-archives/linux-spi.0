Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C7416D1F
	for <linux-spi@vger.kernel.org>; Fri,  5 Jun 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676939; cv=none; b=FSu5uzMZtBgGmjZduBqnckaaOVTjOm3taYU52iSHh48kre/pE+/c4XlS8etqUYj4Sh4pGssGkFYxpqm5ZuYCQg5/eQGuYRaOkpsDdvX77TJ214cUJ5ydvotgb6T7z7wgHzNWj5jOUqAX+HmBZceTOoXXE6rY0V6rVq0OsHU88c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676939; c=relaxed/simple;
	bh=G2UoaTUBsy8YP1XAK8MC20PbrieDy7yS/loF19hogbg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E6L9MHp4QOgm454Rg93UjTOytVGSyLpKz9ujC8G39AQuMERI0whYAIZ7L8z+v+j1jbUoOeamu9JYvvY84cfRl2YnHzggzo4ueNb5SWiNvsHtZ3SrbRzuytXCQ1O+BRBbUibzyeSKvRz/FI005YtZe67XmnTuJE55IeB3pFFgDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=U31cEtL8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="U31cEtL8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-915ab38ac14so152214285a.0
        for <linux-spi@vger.kernel.org>; Fri, 05 Jun 2026 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1780676931; x=1781281731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keYw8EcQ4PK+W0SNMoTM+wvQ1RmTHYvCycVi3RIxEGs=;
        b=U31cEtL8hb102unwA4N19zq3dZs6hHu2KoOQb2fPXFc4EzSKfLLxyp0NHMfHBo5vaN
         6uUnP0i8qymujvCSA/fj1Hf7xxTCr6nHhwW8ZIP1qgmFpYS+QO3mvhobckR+5cC1gvT4
         OfZIEf9uSHXjdWPHhAc6A2EpeAAuToMnN9nBpIdAbRXRT/+zMa66m64jRfDQCXQe9+Nx
         stdKGDKCm4KKR0a0XWNYEnqccp4t14zP7mzingQqjTMemzIkyaIRapQdbN2oRsk8QF1L
         m1lGBKJoWCaPnWGySGxnSAO2ugJDDCkA1MSaEl6y+jre866A320dm/XqJ6+uzJZdnPkg
         07uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676931; x=1781281731;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keYw8EcQ4PK+W0SNMoTM+wvQ1RmTHYvCycVi3RIxEGs=;
        b=KcFI2VsCtteWaIm+tdkcTWoHj+jfTXLTkohGJ3SHODW9P4RQzmLgc2LA8g2mviTaco
         mDkhNtKGWvh93zRmHi9TV+XzmsgQb7d+ucMr0SpUknb9D0Ruy+e8FJ9nZHYKV8dTGzIi
         7Kf8fzG60qdp+V/VAeCZHrYoTmJChl+3IiOY/Lkli0gXTBKaRloFlsZAXXE2AxPcjZ/L
         MXCv0Hd2p5ZavO32AktplqcCxT07/PMYVQ6qBOSzaxa5NH2npx+IdVy0aCyP0MoASiC1
         joVcyRompndlsec5ldM0d/GWBLV+T/SjCljklg0FUavoU7AkSoUua4atrkO2LOenrV3t
         CaDw==
X-Forwarded-Encrypted: i=1; AFNElJ+Wa5Lebv8K5jLAgwondqrxf9MyGXdvy7hLwL/Rez5vAtLzaviIiYN/pUZYNTL7FKLggQC9ogsKmmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/n4THm6ssbVBaUpibU8zohtkeg/VF9t+kme+sfwNYdtcEDAv
	VGYpGY3YXF1IweJvRKqnFFEGIrVndFMsEtw2s+u3WwaeAjM/iISapf3VSqR09wU8nWFOT3HMaB6
	j7GDH
X-Gm-Gg: Acq92OERv1saXjQWVQQvB109zFLNC7vAlZ2JBUrHHiPAOwo/HF7BIT6GwOpvzKGaWCz
	lFN82tXow9V7fEs18SwrDa2pXl4x124lw+GGCRIDuRr837yxySZmNu2UDQKuWpQIEo6LwZiZy3k
	xpIP/Fz/ZJkXVa2gQ3PYSV7oemXsIA/IXDTGCrfgyeg3Nq6+4RBQzbiksP8m3/qaXVsRLx7HKXa
	8Ogpdq4GHwkeFcnmqAFQU2b6y1KWjRdWv51SFwIYD9WJlEEPXnLDwSQQp8WjSOY48Dcuc4RE25w
	FCCKkdZ6v2Mlp+uDySKsaRI7oYwCn3QnHw0mQrDolwyBqKV2VJJOuZe729sz7lVfFzuZYRLeAIS
	CBWrNE8iB0dmFcmyweoJy0QbtJK8aKPEPoK2vgaeb7F3pdC3ILXFNjB9Gck9D23ayypRweA5Ehm
	SmmypRpwud1zxGfYTelBSEYmLojbiNxnAKZUbGFdjlWAuR1nJE3txwSzaOkjM95PLxby2qKqXCe
	545/9GzfP1mqNvu7XM=
X-Received: by 2002:a05:620a:480b:b0:911:449d:98c0 with SMTP id af79cd13be357-915a9c4bd5emr831113485a.7.1780676930899;
        Fri, 05 Jun 2026 09:28:50 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm989320385a.46.2026.06.05.09.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:28:50 -0700 (PDT)
Subject: Re: [PATCH v1] spi: qcom-geni: Fix cs_change handling on the last
 transfer
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <dd247b87-71a2-78d6-fb6f-663906c8ec59@marek.ca>
Date: Fri, 5 Jun 2026 12:24:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

should have another Fixes tag for the GSI xfer fix, otherwise LTGM

Reviewed-by: Jonathan Marek <jonathan@marek.ca>

On 5/28/26 3:03 PM, Viken Dadhaniya wrote:
> Commit b99181cdf9fa ("spi-geni-qcom: remove manual CS control") introduced
> automatic CS control via the FRAGMENTATION bit, but missed the case where
> cs_change is set on the last transfer in a message.
> 
> For the last transfer, cs_change means that CS should remain asserted after
> the message completes. Since GENI SPI controls CS through FRAGMENTATION,
> set FRAGMENTATION for this case as well as for non-last transfers where
> cs_change is not set.
> 
> Additionally, setup_gsi_xfer() was storing FRAGMENTATION (BIT(2) = 4) in
> peripheral.fragmentation, which is a boolean field consumed by
> gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Storing 4
> causes u32_encode_bits to mask it to 0, silently disabling the FRAG bit in
> the GPI TRE regardless of the cs_change logic. Store 1 instead.
> 
> Without these fixes, TPM TIS SPI transfers deassert CS between
> single-transfer messages that use cs_change to keep CS asserted across the
> header, wait-state, and data phases, breaking TCG SPI flow control:
> 
>    tpm_tis_spi: probe of spi11.0 failed with error -110
> 
> Update both setup_se_xfer() and setup_gsi_xfer() to handle this condition.
> 
> Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index a04cdc1e5ad4..0618f6bd7878 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -449,10 +449,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>   		return ret;
>   	}
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			peripheral.fragmentation = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set fragmentation to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +				   xfer->cs_change : !xfer->cs_change;
>   
>   	if (peripheral.cmd & SPI_RX) {
>   		dmaengine_slave_config(mas->rx, &config);
> @@ -858,10 +863,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>   		mas->cur_xfer_mode = GENI_SE_DMA;
>   	geni_se_select_mode(se, mas->cur_xfer_mode);
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			m_params = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +	    xfer->cs_change : !xfer->cs_change)
> +		m_params = FRAGMENTATION;
>   
>   	/*
>   	 * Lock around right before we start the transfer since our
> 
> ---
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> change-id: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
> 
> Best regards,
> --
> Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
