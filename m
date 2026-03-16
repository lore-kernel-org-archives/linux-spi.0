Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0133D16E9
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681212; cv=none; b=sbSxySB/4lNe668TjuLzl0+oFgmvQwfJqumllK7Qmpg2rhbBQaJXUevyG6XrXo/PcdG2MEiN251tvESYHA8T3Zk9O+fQzKRBszKSvSRwPhwBRI+rUhhGoohPWp3ENf8aphqApTaqHi4ILvRqclSm3YrLf3FC4yRWHg9IlX2AE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681212; c=relaxed/simple;
	bh=b0j9oNMdJdMNOAdm/nemFGVAa/OM2F5Qihg0k+VobB4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fYbRL4qfpagre1Y5JKZsGwX8w33sr5aCMmyQ78JOGHl1k/aDJDnxmOYq2u4qQjVu+CI0lNN8PoebpSTCuyFIqrW2Om57OG3DyGEoROUvwuDG6ZxRea9NKTnsQQbNVFyW07BOAKYBEQBW5Xx3CLNaualBqm0dCU/wiiHvt9Xkz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=FcStwyyZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="FcStwyyZ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so16369116d6.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1773681209; x=1774286009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KKNAuzsfMofCUgk72CAOSiu5PG9m6z3uwFl0PtKhug=;
        b=FcStwyyZ8gyclUrfQjU/lMyplpfjh3DO6tv0bzAzIuz5J52bmArgYiAjNJVJ8zGrxC
         hpFFOq+CQ5tPMhmXYG0I217C4VKSSK4z84+Km1n11moJPyTq/fORMwbo0bGuz4Z6r5zz
         WK6V9uiz5keZg+FtLfLyOuELIjQ1WiGZflW1JcoXKRXCEvnaAWjWaG9RMINThxjOZxbP
         sntcvUt2dlUvE1Iqit3wuShGnZWS30DbGF6O8mocLKrmVQyJUN5lQfsozIpTAdpmDi1C
         0sC3L0QnUvTGLZovq89e17WYx4/3huofjKteYhvSj3ApWiaduQWtqcKkMoVzuC7lSBmG
         0DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681209; x=1774286009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KKNAuzsfMofCUgk72CAOSiu5PG9m6z3uwFl0PtKhug=;
        b=hiByHnfk0dm+XS6CLK34jQHIhGCInil/fYz9FvMv/qMPW/+dFis2jEtMMx5pDntVUE
         QqkYeq3Pbp8lymyas355M1FyfDkRgqrrDFLHPRzyT99HoymuD6t1VxgRgfkIfJh0zzYQ
         tm5HFzNcWnm8j+S237MuBYM+urn1cEuTrM01qfOkuPVnzi7kTIMzgGlKagkQH+lXnuDR
         gBgPdnBzPIqh6o8AYhywNn2g94vZa+9otflQDmEBERSxkQJionjYJK/62gGTiJ344afm
         bfNP2MC64HD8UXPPIRIEyCUrlmyBDH77iqCXc0IJutf44mjEkETnNVmLSvxPESvdO2Wx
         rR/A==
X-Forwarded-Encrypted: i=1; AJvYcCWW57tUj7PKsGXb3AG0dc29RrH2P9yJ8FGNQ4qXqu1pYqTTnsf/XijU17OjgSzQVN9YMRx8Hvyd9Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HOfbf78lF7IZyhSoZixefK6TuRKaHsSwCvpzgwwza/CXNBeg
	OgqE1+7LXza+wvYFUXt0PPePlatT/6F61CrtkANiERV506UtRKPzrV1U9Ft74sJy+tc=
X-Gm-Gg: ATEYQzwhJx3ys3cNFmTSyK3+nS/65H/o09W5DIzgf924UYbxpe1xoyAmCDWjVN9nOAz
	lATTWJG6HG4PZSV3KrIQPf/7RVxL35/eHu3NSNqo1ynZtVYBdKLbPvm6YIRfK4XQ/wySulL8vND
	UReVaVygTWOSzmXmDjWRcgiFQEegp23T9u7t/vdxacOcngxJ0dMX+bekqk33IIdwc4CHefMQktu
	nDPQCFduFf8II0bwrvzXV+F9/Pwx04gP3QwguQ4kBe4FdWnl2PQhfNwVyrMwYw0bYx+p+lUysjI
	qWhh1l9PVgGxWARSMn+Q55ofWA/MLO3eSutCdx8rWg6qo97IAoQ0aHHuF00nQ+bnFWTIzygEFAt
	uCh4ekm333UZ9LRYLzWz3mIsGKT1DFDoQj/3QD5HQGJhqNK/qjJ3WAK0wtLboG+v8FTyGymw76d
	HJEgaH7BV9E6GqMpdiGc/02QPKtIvRaxWwLkVrsu+Out4izulowXdTbUxFkvE8SnuPxEPWPnqJ9
	mA+SM1L
X-Received: by 2002:a05:6214:2aa4:b0:89c:505e:a96d with SMTP id 6a1803df08f44-89c505ec595mr73090966d6.3.1773681209073;
        Mon, 16 Mar 2026 10:13:29 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c440d4594sm48468046d6.5.2026.03.16.10.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:13:28 -0700 (PDT)
Subject: Re: [PATCH v1] spi: geni-qcom: Fix CPHA and CPOL mode change
 detection
To: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 bjorande@quicinc.com, mukesh.savaliya@oss.qualcomm.com,
 praveen.talari@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <4a7d89ef-0f63-a7c3-e996-ff9fc476a04e@marek.ca>
Date: Mon, 16 Mar 2026 13:13:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Reviewed-by: Jonathan Marek <jonathan@marek.ca>

at least it doesn't look like this stupid mistake breaks anything 
upstream (no spi-cpha/spi-cpol in any qcom dts)

On 3/16/26 9:23 AM, Maramaina Naresh wrote:
> setup_fifo_params computes mode_changed from spi->mode flags but tests
> it against SE_SPI_CPHA and SE_SPI_CPOL, which are register offsets,
> not SPI mode bits. This causes CPHA and CPOL updates to be skipped
> on mode switches, leaving the controller with stale clock phase
> and polarity settings.
> 
> Fix this by using SPI_CPHA and SPI_CPOL to detect mode changes before
> updating the corresponding registers.
> 
> Fixes: 781c3e71c94c ("spi: spi-geni-qcom: rework setup_fifo_params")
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> ---
> This patch fixes SPI mode change detection in the spi-geni-qcom driver.
> 
> setup_fifo_params compared spi->mode against SE_SPI_CPHA/SE_SPI_CPOL,
> which are register offsets instead of SPI_CPHA/SPI_CPOL mode bits.
> This could skip CPHA/CPOL updates on mode switches and leave stale
> clock configuration.
> 
> This is a single-patch series.
> ---
>   drivers/spi/spi-geni-qcom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 43ce47f2454c..772b7148ba5f 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -359,9 +359,9 @@ static int setup_fifo_params(struct spi_device *spi_slv,
>   		writel((spi_slv->mode & SPI_LOOP) ? LOOPBACK_ENABLE : 0, se->base + SE_SPI_LOOPBACK);
>   	if (cs_changed)
>   		writel(chipselect, se->base + SE_SPI_DEMUX_SEL);
> -	if (mode_changed & SE_SPI_CPHA)
> +	if (mode_changed & SPI_CPHA)
>   		writel((spi_slv->mode & SPI_CPHA) ? CPHA : 0, se->base + SE_SPI_CPHA);
> -	if (mode_changed & SE_SPI_CPOL)
> +	if (mode_changed & SPI_CPOL)
>   		writel((spi_slv->mode & SPI_CPOL) ? CPOL : 0, se->base + SE_SPI_CPOL);
>   	if ((mode_changed & SPI_CS_HIGH) || (cs_changed && (spi_slv->mode & SPI_CS_HIGH)))
>   		writel((spi_slv->mode & SPI_CS_HIGH) ? BIT(chipselect) : 0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
> 
> ---
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
> change-id: 20260316-spi-geni-cpha-cpol-fix-89126ed55325
> 
> Best regards,
> 
