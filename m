Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7E35E95F
	for <linux-spi@vger.kernel.org>; Sun,  6 Sep 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707927; cv=none; b=tsLHEgUrIbICmGfB9KZuy7S9goSpAQDtoK5d8RCVURX0ujg8MHZwYqmL62t1jUE0LLvM1cE2PNtCV+3/4Ul8QY6m1/fwUEfrkUEmK6vkRSBT+Ss3DgqOs7AZ9SPd66u7WIwARXKPS7NSGrFoDZyDLkUGctu3O3tQygfNIUGlMSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707927; c=relaxed/simple;
	bh=Bkr7xLk9duK2EuNzLt8zWRidF2VU/Uy1f49CSml6hdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdBIgr4fBcrXw887dnhuNZbP+DT2jZRdhGGV4FbGXF6+6lnm1+qhBrT9B9tT+vsdXdbMSUIi9NhPIfUWgME3Kx9NiGfwuWo4hCjXkJb0vLwcyaHgoTVzbr6nrlx0Alv03ocYYyKCmdq7j1htss6vOendbhocGZbEim2mI6p40u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgfuHUqw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgfuHUqw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d53197d8b5so23297815ad.3
        for <linux-spi@vger.kernel.org>; Sun, 06 Sep 2026 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788707923; x=1789312723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUf+LnPB4ldS07EaJo+nWjVn77vQrtaiy+2Ht3sIcPI=;
        b=YgfuHUqw7MyD/dRuvIgSG4OCegGJDuFIb9bmkDGH4ZkKlYPKWm9TdtYWeuEo5viyca
         cDCLbLttulKzCG3EaYEzHfszN2SwQSSNc+4fpyWBf5WMh4ik6vJLOfY6TF9/WiHU2Tx/
         kQ154qReQC7u1TGhm08q6xmixtSCzvsyKTXBpn2pkY9KG1Kz7tyj7o04K6DqQ94Cibh1
         R+NMJf6rgOuuFeAPuXvOx316ztoPzgPVaPrC5bWm8SC04X8hFrJ6ftjYULuwHnbkiCr1
         z1m2JqkNES9glY/fna2ZRzX4N+k/YzdTTrnwjFNeZqoDXE9sdGMa5HTIy+JCv3dj6Tjk
         CEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707923; x=1789312723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUf+LnPB4ldS07EaJo+nWjVn77vQrtaiy+2Ht3sIcPI=;
        b=JOw0kbkq+Sav8UyV2ZtIKssA9YUtzOVScjIimwoUKTj+K7clnhz3Aua1vtuUFxrDvy
         ZtW6fludL/ISJQXwxrlycbsksK6BVqz1KGFbpT4eQ+B6WXWl82QOTxqagydHRpB169Po
         ufWzjKBRObNBss0TEYr9YNF1vubsxINTrpn98MufqoAhfm0k2Eea/BeoBRBXq7BS/644
         ALsUPhP37KRudYQF0kzMyZatR+Tn1R9/ljqX6h3FzXKKpt3TskCDhjmxJoveX+p32+n0
         gsq9pEJEppaxyG4jKjLMxof24cwYBY6E9S14fjqmDY8ryaBnI+FDg6OorbkWoIwYs3se
         vZeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy45LehblvbXg1FaD79M/WRroIhVzAO1bGtId68KCGPoIjwW1eMfH8JtDWbJuputvobo9DNmpvaTVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nxjLSYsrMoUI2dRrj95P5vix7DYkglX+yic7KEL+Wi2x0IVEuM
	jPosSOA76BEx1LeguM7YGPmBtiieBkniseSesJBOW+fYwefvUPTGr4bf
X-Gm-Gg: AYBFou16/se8W1KpceiJJujM7r3zdeeQTGXbkitijv81YoFaLZnDFQAfXGgmVLt5lKZ
	Aw523Hsg7ZScq8c7FaJti0zMpytrIdMkiNuA6CbkIjLnxCk38tq8EVeBSfuf9ZNF7R4BeSzvTZQ
	7Xpsnj8SFOC34oRxGmUHB7JvY+1GCDIYuMeMg24LorwD7dQqoYlqEi1zV+ad3Vcgi29Omz4bf+q
	/7c99jSqh8SFkbCPsMk4DdqwnBkLkMuubwtEcEGmPbZtM2N96xDwrKzmVcsF3y6tZYtx1C59ZOJ
	DEaLTyl3fVB+vQqSrzDYb2I2A/HA+2EvOMv2juTbz0r8TNUlB7cUBdnMLPwsItHorRtNxzNBcl0
	K0iDKK/E2nYNOsL4gh6g41NEVSpUryCtbK7o8yQfZ8lPH8gN/UUUuFcszqQvTBTESNxeW0nYtIP
	VrbiFCgnJhuY2q3o1fgpIk/mDLALwRfTUtWf6XvsHyV7JrhDcTPV5LfVc6Sm/snlS3MnVJuAOo
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39b2629926dmr28351823a91.24.1788707923183;
        Sun, 06 Sep 2026 08:18:43 -0700 (PDT)
Received: from google.com ([2402:7500:498:f6ba:e6d7:1963:b14a:e4e9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm15800999a91.9.2026.09.06.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:18:42 -0700 (PDT)
Date: Sun, 6 Sep 2026 23:18:35 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jyanchou@realtek.com, p.zabel@pengutronix.de,
	afaerber@suse.com, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	james.tai@realtek.com, cy.huang@realtek.com,
	stanley_chang@realtek.com
Subject: Re: [PATCH v2 2/2] spi: spi-mem: Add Realtek SPI flash controller
 driver
Message-ID: <ap2ECOI5ZafqaD9N@google.com>
References: <20260906145755.1230079-1-eleanor.lin@realtek.com>
 <20260906145755.1230079-3-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906145755.1230079-3-eleanor.lin@realtek.com>

Hi Yu-Chun,

On Sun, Sep 06, 2026 at 10:57:55PM +0800, Yu-Chun Lin wrote:
> From: Jyan Chou <jyanchou@realtek.com>
> 
> Add a spi-mem driver for the SPI Flash Controller (SFC) found on Realtek
> DHC SoC. SFC supports Dual I/O.
> 
> Implement the exec_op API for regular control commands and the dirmap API
> for hardware-accelerated read/write operations.
> 
> The controller is described by three register ranges. The first one (ctrl)
> holds the control registers. The second one (dma) holds the DMA engine
> registers, used to transfer the payload between the flash and main memory.
> The third range is the memory aperture (dirmap) that maps the flash
> contents.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes in v2:
> - None.
> ---
>  MAINTAINERS               |   6 +
>  drivers/spi/Kconfig       |  10 +
>  drivers/spi/Makefile      |   1 +
>  drivers/spi/spi-rtk-nor.c | 637 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 654 insertions(+)
>  create mode 100644 drivers/spi/spi-rtk-nor.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..705f7ddf792f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23011,6 +23011,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
>  F:	drivers/spi/spi-realtek-rtl-snand.c
>  
> +REALTEK SPI-NOR
> +M:	Jyan Chou <jyanchou@realtek.com>
> +M:	Yu-Chun <eleanor.lin@realtek.com>

nit: Yu-Chun -> Yu-Chun Lin ?

Regards,
Kuan-Wei

> +S:	Supported
> +F:	drivers/spi/spi-rtk-nor.c
> +
>  REALTEK SYSTIMER DRIVER
>  M:	Hao-Wen Ting <haowen.ting@realtek.com>
>  S:	Maintained
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 357cebef9917..4b758ca31490 100644
