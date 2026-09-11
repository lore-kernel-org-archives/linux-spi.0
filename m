Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EA427A06;
	Fri, 11 Sep 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153822; cv=none; b=dpphQ6uUpTIxKUAowRXpclZsjpvVejWnPFqm1EA8lTmirpNh17E0Xaq0kbMv4C+HVQkvy1Z9Xho9x0+SQMGrbfb3KCzkDZlMYuV64igGBXeW+r99oUXRzenGFKNbGOp0jDGXRZvQ+pueH+SHV0jNE4IQny7gGgZ+n7Q1K/Izxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153822; c=relaxed/simple;
	bh=wGejjBh0RyidjF8E3zm/+gp4dnyW0prVCiM4HanGml4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3tovVCSxPxhihL97M6PCE67cCAYe8fI4qA9k14b3KNzcss3lcKKq328u7zR96zJrgMPd+BVy0SO2iS6tchnhOycZk/nazVLPoS7fXkA6Tjl2yqYJ1FxQWevcDU2e/TSlpSJRcRBoU2/x+93y4P2r5fGk8B+lvO0YNdyYN+V/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgfwXFn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgfwXFn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990EE1F000FF;
	Fri, 11 Sep 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153811;
	bh=x8PF0Dw7B9WOGI0dgKC/lQ6SFx581HVewAv+WudZApk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgfwXFn0n86BydycMzknxcPJhdXE8VTJA5js5hebUm8GFRpG7Z+JgIMKyUznMIkr0
	 42hSx1+db7cX6H/GFI23hksucKuXhCJF3qwqyqZW7l9xEJxRO+rrDBezl1ti8yLsM7
	 XRRWahOkZhpZbT7hDSXLvW2WzWO/rKJZs+3m0UC1BMnt02Jd2mwpGty4Z4Mak30Lft
	 fAwE8BwoFIqCz6XKMUlY7YnQ+fBIcJaapWbsDDhMjBWl7u94qKvs901ed85hrrS2ru
	 jyPCvlqOmgJxTrdjaBmp6E6OsoRLztzdgZTj4ZpuS+8+6mreUnlIP+OJDVDPU0Iowd
	 0cU1wtElUb90A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] spi: spi-qpic-snand: drop the redundant ECC
 context handling
Reply-To: sashiko-reviews@lists.linux.dev
To: md.alam@oss.qualcomm.com, broonie@kernel.org, "Johan Alvarado" <contact@c127.dev>
Cc: j4g8y7@gmail.com, quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, miquel.raynal@bootlin.com, pengpeng@iscas.ac.cn, linux-kernel@vger.kernel.org, quic_srichara@quicinc.com, linux-mtd@lists.infradead.org, konradybcio@kernel.org
In-Reply-To: <20260911184416.109790-3-contact@c127.dev>
References: <20260911184416.109790-1-contact@c127.dev>
 <20260911184416.109790-3-contact@c127.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:10:10 +0000
Message-Id: <20260911191010.990EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deterministic kernel panic in qcom_spi_block_erase() when the host=
 ECC engine is bypassed (e.g., via non-NAND SPI memory drivers like spi-nor=
, or ON-DIE/software ECC).
--

commit a97a071d79125bb5db4d55c7d03a5f945fa92aef
Author: Johan Alvarado <contact@c127.dev>

    spi: spi-qpic-snand: drop the redundant ECC context handling
   =20
    qcom_spi_ecc_init_ctx_pipelined() now publishes the ECC context to
    snandc->qspi->ecc, so the assignment in
    qcom_spi_ecc_prepare_io_req_pipelined() repeats what the pointer already
    holds, and the zeroed struct qpic_ecc that qcom_spi_probe() allocates is
    never read.

> The pointer is non-NULL only between context creation and destruction,
> and every reader runs inside that window. The ooblayout callbacks are
> installed by init_ctx. The page read, write and program helpers run only
> when prepare_io_req has set page_rw or oob_rw. qcom_spi_block_erase()
> runs only while the mtd is registered, which happens after init_ctx and
> ends before cleanup_ctx.

Is this assumption accurate for all configurations?

If the device tree specifies ON-DIE or software ECC (nand,ecc-engine =3D
"on-die"), or if a non-NAND SPI memory device (like spi-nor) is attached to
this controller, won't the host's init_ctx be bypassed?

> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 20045d4a46fad..760ee1c29402f 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
[ ... ]
> @@ -1586,14 +1584,9 @@ static int qcom_spi_probe(struct platform_device *=
pdev)
>  	struct spi_controller *ctlr;
>  	struct qcom_nand_controller *snandc;
>  	struct qpic_spi_nand *qspi;
> -	struct qpic_ecc *ecc;
>  	struct resource *res;
>  	int ret;
> =20
> -	ecc =3D devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> -	if (!ecc)
> -		return -ENOMEM;
> -

[Severity: High]
If init_ctx is bypassed as described above, will removing this allocation
lead to a NULL pointer dereference in qcom_spi_block_erase()?

If snandc->qspi->ecc remains NULL, a standard block erase operation
delegated through qcom_spi_exec_op() to qcom_spi_block_erase() would appear
to dereference it:

drivers/spi/spi-qpic-snand.c:qcom_spi_block_erase() {
	struct qpic_ecc *ecc_cfg =3D snandc->qspi->ecc;
	...
	snandc->regs->cfg0 =3D cpu_to_le32((ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK)=
 |
					 FIELD_PREP(CW_PER_PAGE_MASK, 0));
}

>  	qspi =3D devm_kzalloc(dev, sizeof(*qspi), GFP_KERNEL);
>  	if (!qspi)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911184416.1097=
90-1-contact@c127.dev?part=3D2
