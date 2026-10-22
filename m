Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665909;
	b=5W1JIFU9s1NJfdUzcQ8QtE8kNUsCQBZcgZaw+6QgKaIPg5/6zPNXs0Of2d6rCSD3LLMV
	 TWtfNY7ertSBSb7yaYcHptZO5xnpLI9Gp6FauwPGkdhs1PkWqNecX2iENjMpLWR5XU6FP
	 QZZCmSLL2MmCw9aXLc/5eda6KhWLDpu7bfIymGIdmuDTSUtnCp52GEfoAOei2srkaAf87
	 0Bg0iKjgydSgO+PUIRI6RSrDXH8uTshQPOgJUO/3p+XBV2HlclJo4Fpr0gfgH3Gbqlyvq
	 o7MjbOa5QM0gaO8p/LbkbfsFVbVS+5l8ip/G0/sHIo3IDHQxjsRNt9DP2GUCQ72HNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665909;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=dCrqHqvHupUGX9Yb0K8VNQTC2XGQqllo1XVHZ6S5VJU=;
	b=DPqYxuGG1GAiiV49rfcP/r/mLJZw2HbrzdDkgkfldRqrXNFHNgdRU5tYP455ZJBb8Z0+
	 QwlMh/AjOhT9gbLXo4+RLL44UdQ0VLDKLLmfDkW60inUDyAq8p0QaQrmHPqmQXb3l+ddl
	 Liz8Pk73o0piEF7aPJrD27OuVbtFzV4cOQLTZzm66Jn3IAaAtUOVf+vLS9hvSqzzoDpmJ
	 /NT+/yA/G5BDD0XiniRnlxXbyAJYno7d33QMj0tx3ZcyteYdLaktJUbJFRTZBKbuqE3Rf
	 yFk776FU6K86JQbTS4D5wpz9pE7+dvX1mLlFi4AKkWkaSqqfqHVw25xWPdmxIKj7Bqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ONl86gl0;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9B606A31B
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 10:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ONl86gl0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA5D7C58473;
	Thu, 22 Oct 2026 10:46:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67EB460360;
	Thu, 22 Oct 2026 10:45:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE36910328E44;
	Thu, 22 Oct 2026 12:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792665905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dCrqHqvHupUGX9Yb0K8VNQTC2XGQqllo1XVHZ6S5VJU=;
	b=ONl86gl0EqNN7/oWlBAo2Q48bwtbfFr8LrXVh74yH/RgfWgm6cQfOWRRu/zzZOoyPmBxCo
	w7tdSMwRh1wXWyE6P4gTbV1e7qTwIAcy6WFYcKYRIluCJcI7CUtiX4LH7s8xo1IkuMkcyb
	10JI26l2sVA49wX6Hcw7V4c2mUNOPsJ5ooN92frULR5ErhU4PZ4hicKOunWIPlVApR/OU2
	6oWGTb7GKXT7RGNQeP839zonHGpwxujfkJ7C2Tjq99tyz8RRaqdJ/aKEftIioHHglYY/Tl
	b9JdFn5fyUY2BObOjH5w4VhGE2hDgYlCpmPr9o0xfp9hGxzqXCO8tbJktVTomg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 2/4] mtd: spi-nor: Support mixed 1S-xD-xD DTR
 protocols in spi_nor_spimem_setup_op()
In-Reply-To: <20261022102614.75696-3-changhuang.liang@starfivetech.com>
	(Changhuang Liang's message of "Thu, 22 Oct 2026 03:26:12 -0700")
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-3-changhuang.liang@starfivetech.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Oct 2026 12:45:03 +0200
Message-ID: <875wyuqaj4.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 22/10/2026 at 03:26:12 -07, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:

> Currently spi_nor_spimem_setup_op() sets all four phases (cmd, addr,
> dummy, data) to DTR whenever spi_nor_protocol_is_dtr(proto) is true.
> This is too coarse: the 1S-xD-xD DTR protocols (1_1_1_DTR, 1_2_2_DTR,
> 1_4_4_DTR, 1_8_8_DTR) send the command phase in STR on a single line,
> and only the address, dummy and data phases in DTR. SPIMEM supports
> such mixed DTR modes.
>
> Split the handling:
>
>   - For SNOR_PROTO_8_8_8_DTR, keep the existing behavior: set all
>     phases to DTR and use a 2-byte opcode (opcode + extension).
>
>   - For the other DTR protocols, set the command phase to STR and only
>     the address, dummy and data phases to DTR. Double op->dummy.nbytes
>     since DTR transfers 2 bytes per clock cycle, matching how the dummy
>     cycle count is specified for these protocols.
>
> No in-tree flash currently declares SNOR_HWCAPS_READ_1_x_x_DTR, so
> this is not a bug fix but preparation for enabling these protocols.
> A follow-up patch will enable 1S-4D-4D for the MX66L1G45G. The
> 8D-8D-8D path is unchanged.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/mtd/spi-nor/core.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 90524c58602e..43e506e728ab 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -97,13 +97,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  	if (op->data.nbytes)
>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
>  
> -	if (spi_nor_protocol_is_dtr(proto)) {
> -		/*
> -		 * SPIMEM supports mixed DTR modes, but right now we can only
> -		 * have all phases either DTR or STR. IOW, SPIMEM can have
> -		 * something like 4S-4D-4D, but SPI NOR can't. So, set all 4
> -		 * phases to either DTR or STR.
> -		 */
> +	if (proto == SNOR_PROTO_8_8_8_DTR) {
>  		op->cmd.dtr = true;
>  		op->addr.dtr = true;
>  		op->dummy.dtr = true;
> @@ -115,6 +109,19 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  		ext = spi_nor_get_cmd_ext(nor, op);
>  		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
>  		op->cmd.nbytes = 2;
> +	} else if (spi_nor_protocol_is_dtr(proto)) {
> +		/*
> +		 * 1S-xD-xD protocols: the opcode is sent in STR on a single
> +		 * line, only the address, dummy and data phases are DTR. The
> +		 * opcode stays 1 byte (no command extension).
> +		 */
> +		op->cmd.dtr = false;
> +		op->addr.dtr = true;
> +		op->dummy.dtr = true;
> +		op->data.dtr = true;

Still to coarse IMHO.

What about xS-xS-xD?

As mentioned in the spi controller patch you must make sure these are
refused if they are not supported by your controller because SPI NAND at
least allow them (and I believe SPI NOR might as well)?.

> +
> +		/* 2 bytes per clock cycle in DTR mode. */
> +		op->dummy.nbytes *= 2;
>  	}
>  
>  	if (proto == SNOR_PROTO_8_8_8_DTR && params->flags & SNOR_F_SWAP16)
