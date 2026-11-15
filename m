Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769347;
	b=FoRx2bsW2HeWuNHwnKTnb2HqKouytc3dqvNO0/EsX17xjitwmZBblGYziCqTHOdj66vl
	 FnJ1+H/UDt+D0IgShAaXcgZil5Onzj7HbQGUdKRVQIST/4FZuFCOqpjrqao248khEkrnL
	 7oH0tf450vs4oJozwKGGCz/SxXn/1+n64mKa+KLPJgUBx8eX7BWV0c/QIgIb6opwFT5vj
	 XChlj0NexUMbcV+5WEUREcySXd4Y0/0223kHOG4DmkIJZsPvZVEpdyCT5Ap45v0FCNrxF
	 s3GsODn2TguofYQToPUss31Tcz3KsWfQvsm+VaySb/5xYHAZnNxOb7ne3mxC3HxwEWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769347;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1cTMD6rpl21Vb6HPpVL+YKvnpPXKBaj6/RS9XazGUt4=;
	b=kNCkny8+v/opt9g090/VYp3ontxmUAACdi0vMOnQ7TQoHBQfOXl9E4Z3pgFxVBo5nCTp
	 0YIroiY4nz5/wfGW7grPP8aKheqKh0KpnneDwqrnTAhWk8MB71G2CtACJ1tzevPwdsDxj
	 CRp7w98Pq7Miip4Qq5QfLTk+LI853asMD93Wda5Ovh1thYtpBh3Sq4EJ1BfuwRSaqXlL9
	 Yu+46LWREgwkIBFEbrcP6aYIJJYuveMu+grJ+shVdNg7B+ZwDhuxr0L6y3nvEi/DArQXh
	 7wP2iFyje/IGUqDSFZizjsAsK413CZALC5jdOcRQhNMUYJj7NWYq6vFEAnRzakwQsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4h8+GeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B1606A31E;
	Sun, 15 Nov 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4h8+GeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C003B1F000C6;
	Sun, 15 Nov 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769347;
	bh=1cTMD6rpl21Vb6HPpVL+YKvnpPXKBaj6/RS9XazGUt4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=A4h8+GeTpGoICj8LAusJY7fyz799M81c/p6+2bXpg65MYiGpWPUSzD9EPd4OgGC+y
	 4y+vI2Ye5CFirDmrG4iuoJyfTBS/4NJ4u+YiU+X/nzh1JDr9loQ9KqkYaF7Bn8ggVO
	 MsiOPSGMrMAeH+Dij+bEla8pnhO1SuOT71bJiJVleYsohxs26zlxLfkl1mQKn/nbh2
	 g7q14odkpGRsBP8Mej4Bw7W3ScUmht/p4qn9K95HxvTIumxjT5iRk3MjM1Y4jxc0Ov
	 oxploRytu7zwflW442B10wYsQ62Nx+UTAvtItE8PBEsMtmpfqmDjMhAS6+KuPFW+W6
	 9Apaai/zJYAWQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 489283438C03;
	Sun, 15 Nov 2026 19:02:22 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 11/19] spi: cadence-quadspi: enable PHY for direct
 reads
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
 vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org, 
 takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, praneeth@ti.com, sebin.francis@ti.com, 
 u-kumar1@ti.com, srikanth.boyapally@amd.com, m-shah@ti.com
In-Reply-To: <20261105105832.2134313-12-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
 <20261105105832.2134313-12-s-k6@ti.com>
Date: Sun, 15 Nov 2026 19:02:20 +0000
Message-Id: <179476934046.140154.3805598097732218794.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fwy4hjtJ5n4yoEaGTYcqUt3ywO3A0Q78K+izyy35w7s=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+Me7b4vec11V8Q8r03GluPex6cTdeTmVh2T8hxtrwr
 2TXKWWhjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkcwbDP6uGA3Yr7ZWEAhZ8
 +/b373XZSVO3pUzfZltu7JD64BE/3yuG/wlu/x7MWdqkJvFmd6bIydclPnVzjuT2LpO4LJfk3Wz
 Axg4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add cqspi_tune_phy_read() to toggle PHY mode around a direct-mode DMA
> read. On enable: reprogram the DLL from the per-CS calibration result
> when the hardware values differ (handles alternating PHY reads across
> chip selects with different calibration), configure read-capture for
> the tuned delay, assert PHY_EN and PHY_PIPELINE in CONFIG, and reduce
> the dummy cycle count by one since the PHY data-capture pipeline
> absorbs that latency. The controller is confirmed idle before CONFIG
> or RD_INSTR is touched in either direction -- including on disable,
> since the preceding read may still be draining.

> +static int cqspi_tune_phy_read(struct cqspi_flash_pdata *f_pdata, bool enable)
> +{

> +	ret = cqspi_phy_reprogram_dll(f_pdata);

If we fail here should we just give up on using tuned mode?

> +	cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,

Calibration runs the capture with CQSPI_REG_READCAPTURE_EDGE_LSB but
that's not set for actual transfers - is that not going to be an issue
for SDR?

> +static int cqspi_direct_read_fallback(struct cqspi_flash_pdata *f_pdata,
> +				      const struct spi_mem_op *op,
> +				      unsigned long max_speed_hz,
> +				      u32 post_config_max_speed_hz)
> +{
> +	struct cqspi_st *cqspi = f_pdata->cqspi;
> +	loff_t from = op->addr.val;
> +	size_t len = op->data.nbytes;
> +	u_char *buf = op->data.buf.in;
> +	unsigned long configured_sclk = cqspi->sclk;
> +	bool reclock = op->max_freq == post_config_max_speed_hz &&
> +		       configured_sclk != max_speed_hz;
> +	int ret = 0;
> +
> +	/* Drop to the safe rate for this untuned transfer; PHY isn't used. */
> +	if (reclock)
> +		cqspi_configure(f_pdata, max_speed_hz);

Does this DTRT when we get here from cqspi_phy_check_pattern()?

-- 
Mark Brown <broonie@kernel.org>
