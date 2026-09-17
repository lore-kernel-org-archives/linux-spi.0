Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D5478E2B
	for <linux-spi@vger.kernel.org>; Thu, 17 Sep 2026 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629434; cv=none; b=C4ETh/lZvaND1icVSc5jayYGbqwTEF+PSC2gBhBZBF1q1VvUgw9016rSnrHQVE7VH8YdZO0T2Rzg1tGwUMN8KX39sKEazUM82y059gOCgIj7SOBjo4LAUnxJum+j4eajOPvRphrQkJ8bHhhQnoPr8eOEVqzSEYc55yP+zKTnu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629434; c=relaxed/simple;
	bh=gbriEj1Y6woab39WAV/2YSR43SgslkII3LkrcHz7PIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPVn7MlppL0mkEVyMQUa4jPgwY+4nr10X/phTON0cBpD+91wBpmEXYb8SfYmKzNgV0Oeo+8mTCt5ViCQB3Q1bG3D3VTNbOi+oNV1rARSocck5VMsEAJqcpUxNovf/wcSgkc3edVXPuAB8W8hmxXpRPFSeOdxviAhoSGNQ0twk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx8qIRON; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx8qIRON"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so2738805e9.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Sep 2026 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789629431; x=1790234231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sjRq5JwkomwjePlQI1kfNhFczaltRdPXNsYjKkX5UM=;
        b=Gx8qIRONf1BkHfTUtSJYYSQDiccQNhmUGB8h3LIbYXB+lnl8/h6ubjVOXCjJKpzOmD
         7gHZux9SbCqq/7rZSRLdWGq9Xx+uDkUTU5ySdrLOH2JfjV8aT/E0Vu06QuLSTot/ikpg
         A1SZ9yQ79EULxdpXfMVOHcxAUyVSIzH5zGpOOrkO70rR0lbdfTBmgDMRii/6nMmwV4zB
         0zQc+wFKYGbGsYtepNIIdNXY5e26TK83AbR7KrNiNoKUFVe4oZ9FHhPuraOUYBQNh2x6
         UZgqIs8AxUBYIIB5DDBqGY7+UHC3bAz8Op+W51bdTAFCriIuM+8VVi529CvCJIXfDuIl
         LBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789629431; x=1790234231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6sjRq5JwkomwjePlQI1kfNhFczaltRdPXNsYjKkX5UM=;
        b=RcW8uknTPwO+08Te13QfPKJ5AcusFvOPAU2PxS7Kigb7/661nMSmTU3zgYMThrHsm/
         n7YxK4dkooF4RM8PzDGS8v7fajm24qV95k+kyNiLiBgB7Q6AVVebPtr07bkx/SdxPxh2
         S0+P6mpRgv1H7fWUcoae02mrPCputOMt1iXfwZASfqMLG2HnACH2bp/tjpZm4kdvsZ1n
         b6cNu1CGLtZSH4/Xq6PWXwcBMcqAGQOWO2WpaE0CoYC7oIaWJGRq0/U2yw0pGm7dGURQ
         ENT4FKi6QaaiL+ZPGlSrw4pA56DpahqMJw1SvudzQG7PEaKklLIX/sHT3mVfFkNsk8Go
         m6XQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBeSDdRUTEy6ARhCTNBreQEZj4Cts6vfoAgiZCczlefwkTD35tyJTl9ryl+4T5G/MQVzL0l56Y07U=@vger.kernel.org
X-Gm-Message-State: AFuF++kjj3iTdiO+vvzzoF9iRX6Y0Txhu8JtQee3sSQkKvrq2R1Mzsv8
	7Xkgk231St4RBnM2P0fT6CPYTFtFHX566GC/TP4nrOIrsi0CsknQIJ9W
X-Gm-Gg: AYBFou1sPfizHKSxUoBKOIHl265Cc6zvSQf9AYGxmMTk8H6eyi3P/9SVAqQ7gf11XlG
	VboES8Ut/8JBCZnLyQ0wpDi+FgmGZWOJt1rRFUvAoq0LPUqU/ot5TCaE0xJS90WfxIeSbQhfv6A
	DFolPCYPdyd75ejgoDqJEBWCjF9Lt4yt2styjOI957eqHyn+9C8Blp9ClfGmoughJ0GEGWvu3f1
	fX3++kYU7UnTqr8r5Cta1aOuDWeaBu9F5Rm0H/3cOHGaHfT1nSf53aTFzFsUOs0mMqMSpbx7pDU
	i1+DOV2H1ic3CSqwpj8aOiggaM5m+y4MdhahIPBegJp+yMhXaxQKrBI7yLoNeEloDqZPoth7uiQ
	UX1u3abJKdrH8yN0Ap8w7jtEBDaiPmjATckrlQuGI3iM9DkrM4ZNYxlDRxTSyAMrTyyJOSi8tcH
	Yioi6ZuCPXa4N8XuCfOXMmJWCyNhdf273/iPAk+GJhGQd0pZHQxurlg+x9wiHrG3iCLHvf9pkzI
	31EkVh5wEwQ3pxuwQU6ZkLrZgyYZLd3ga0ozTc=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr62000005e9.24.1789629430773;
        Thu, 17 Sep 2026 00:17:10 -0700 (PDT)
Received: from [192.168.20.170] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm59310085e9.0.2026.09.17.00.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 00:17:10 -0700 (PDT)
Message-ID: <70d620e5-b03a-48ff-9b56-e787d03b4aed@gmail.com>
Date: Thu, 17 Sep 2026 09:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-qpic-snand: drop the redundant ECC
 context handling
To: Johan Alvarado <contact@c127.dev>, broonie@kernel.org,
 md.alam@oss.qualcomm.com
Cc: konradybcio@kernel.org, pengpeng@iscas.ac.cn, miquel.raynal@bootlin.com,
 quic_varada@quicinc.com, quic_srichara@quicinc.com,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260911184416.109790-1-contact@c127.dev>
 <20260911184416.109790-3-contact@c127.dev>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <20260911184416.109790-3-contact@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026. 09. 11. 20:44 keltezéssel, Johan Alvarado írta:
> qcom_spi_ecc_init_ctx_pipelined() now publishes the ECC context to
> snandc->qspi->ecc, so the assignment in
> qcom_spi_ecc_prepare_io_req_pipelined() repeats what the pointer already
> holds, and the zeroed struct qpic_ecc that qcom_spi_probe() allocates is
> never read.
> 
> The pointer is non-NULL only between context creation and destruction,
> and every reader runs inside that window. The ooblayout callbacks are
> installed by init_ctx. The page read, write and program helpers run only
> when prepare_io_req has set page_rw or oob_rw. qcom_spi_block_erase()
> runs only while the mtd is registered, which happens after init_ctx and
> ends before cleanup_ctx. The controller drives a single chip select, so
> the per-controller pointer and the per-chip context cannot disagree.
> 
> Remove both. No functional change.
> 
> Suggested-by: Gabor Juhos <j4g8y7@gmail.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---
> Tested on a Mercusys MR80X (IPQ5018, ESMT F50D1G41LB) with both patches
> backported to 6.18.44. Five boots, rootfs mounted every time, mtd
> reported 0 ECC failures and 0 corrected bits, and a 4 MiB file on the
> UBIFS overlay kept its sha256 across the reboots. Overlay churn raised
> the UBI maximum erase counter from 13 to 15, so qcom_spi_block_erase()
> ran repeatedly. Build-tested on this base with W=1 and sparse, no
> warnings, patch 1 alone and both patches applied.

Tested on Tp-Link Archer AX55 v1 built on top of 98100d83adc8 ("Merge
remote-tracking branch 'spi/for-7.4' into spi-next"). No regressions observed.

Tested-by: Gabor Juhos <j4g8y7@gmail.com>

