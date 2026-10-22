Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665726;
	b=dMTmQNiH0DI9O9Bj2eXNMHDFSmMWW+lcBfHEvFZEw6B3YByCmyUN8/8Tm0o77sqqx8ed
	 XVtkOdKLHZvKoHekcjd4YfYEFYH6t0w0t4ewt0rqmfS5kI2rYBIQXod46m+UOp10+B9yv
	 p3T0MafhnIk0t1ZGjKZ22udlnndmokvnukQO+5PY5Cx0VeZ5wvj0WQM2vDmm5ipmLjm27
	 O57dqQuQM0JPZzSMufxw5+oVgYTRJidSbr4pD8nbLHEQFXdms4hFRC7+qKG1BB5l0naUX
	 2J8cz3rTDY5jA5eTqF33hAvEn7/v+TiamnTwyEqDKle370p6/SenS6kAvu0BM5URxpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665726;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=9bhyu6Fq5WX64gBWqODlDauOfgdVOt8rSIb/Nnq5zxI=;
	b=cBOXQvYXheNdQir4X84eegj18SqLRxuc/veIw3nqlAjkindVqvngr3XzIAfwzA9YeJKg
	 lcIExeycyrWzr8ksURqdx+H1E55aLsKpfAuA9PM5UXayntSSKSVFqUDK72tAPds6s0wBz
	 gmvvG4TJHXcVplHTQi1OV2iRQBgplD7Ayukxzq4tN40NaVLESLNjUeo5ptc4+mkjSXSe9
	 xI/aCTccVTsOMsJ/cIBF8zKdgQPYMxRQUa4VjR2dXUSmBgz+5lRIrPc0DKoCuxC3u309y
	 +7C5a1tcBWOv/qlf0OkDS/frNpqJomJil1gJKOEa8hZLgULD35eXukMKFV5SkkIFvaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EUEGdVPF;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D7606A31A
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 10:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA0D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EUEGdVPF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1C34C58472;
	Thu, 22 Oct 2026 10:43:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 53B3260360;
	Thu, 22 Oct 2026 10:42:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5AE010328E44;
	Thu, 22 Oct 2026 12:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792665721; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9bhyu6Fq5WX64gBWqODlDauOfgdVOt8rSIb/Nnq5zxI=;
	b=EUEGdVPFTYk5khJc1VK6CVPUbxP0IK7ec4fVAcfzk1qv3UL5Pq3Ssb43xTFvHVsY4zxh8W
	I46jppsRM6ZjRQ9lAKjWgwKOBgfRPqgrWqFwyvwuPtctpexgbwu5T7hQ2WhfDeGp6HXn2+
	GpouL93ityupT0o9RI0zU9g/ys/9BxS+PXEFKxQjjbWfK3xvDA6HzVK8kPOpiKYqrxKgrN
	zM5Ws+G9N4d0gnVH90MCRn1rrsEseq8Zil4OeIbiMQUM6Sf5hFV7Uv7/7prKnLljr8GobO
	aIM7BjP1AFtCIocKOExsQzUuxuzdbvbJw7/JNq+RrTrPp8vAs7qiXCHQ+Byydw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
In-Reply-To: <20261022102614.75696-2-changhuang.liang@starfivetech.com>
	(Changhuang Liang's message of "Thu, 22 Oct 2026 03:26:11 -0700")
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-2-changhuang.liang@starfivetech.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Oct 2026 12:41:52 +0200
Message-ID: <87bj8mqaof.fsf@bootlin.com>
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
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 22/10/2026 at 03:26:11 -07, Changhuang Liang <changhuang.liang@starfivet=
ech.com> wrote:

> Add support for DDR (Dual Data-Rate) transfers in the enhanced SPI
> mode of the DW SPI controller.
>
> The enhanced SPI control register (SPI_CTRLR0) has dedicated fields to
> enable DDR mode for the instruction phase (INST_DDR_EN) and for the
> address/dummy/data phases (SPI_DDR_EN). Populate these from the
> corresponding dtr flags of the spi_mem_op.
>
> For DDR transfers, the dummy phase consumes two bits per clock per
> line, so the computed wait cycles must be halved. Factor the wait cycle
> calculation into a helper, dw_spi_enh_wait_cycles(), so that both the
> supports check and the exec path use the same value.
>
> When SPI DDR is enabled, program the DDR_DRIVE_EDGE register. The
> recommended TDE value is clk_div / 4, clamped to clk_div / 2 - 1 and to
> the field width.
>
> Finally, advertise DTR support to the SPI memory layer through a
> dedicated dw_spi_enh_mem_caps, selected when the controller has
> DW_SPI_CAP_EMODE, so that spi-mem may issue DDR operations.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/spi/spi-dw-core.c | 52 +++++++++++++++++++++++++++++++++------
>  drivers/spi/spi-dw.h      |  6 +++++
>  2 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 47434fa78e4b..6ff142c8a6bd 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -46,6 +46,8 @@ struct dw_spi_enh_cfg {
>  	u8 inst_l;
>  	u8 addr_l;
>  	u8 trans_t;
> +	bool inst_ddr;
> +	bool spi_ddr;

If I understand this correctly, spi_ddr is quite a bad name because it
means address and dummy and data ddr (but not instr). Can you try to
come up with a better name for this variable?

Also, if my above understanding is correct, you must provide a
supports_op() callback which would refuse any xS-xS-xD but allow
xD-xD-xD and xS-xD-D modes.

Thanks,
Miqu=C3=A8l
