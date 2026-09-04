Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C5503BDD;
	Fri,  4 Sep 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543506; cv=none; b=SFrPf3+O/Hlxalyu8HiibwxuTWle1MUWdScrAeKHfq6n/NwQScIx31z+oIGdlliVb3zxynrpBMyle/MrLk/GHa6v4zWxbO4HO1BCqwQFb15p9fi3DmQ+j4zFbr5nnEEnNsyljbPEB4KLCfpxsGYM8CSszRfu30JBvjqu7R+RAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543506; c=relaxed/simple;
	bh=e64PdfBDY4GOCWxQ91wvOELd3e4fIm4ygKYvU6StGF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b0QiAf0TsMaPithS2lS73bE1lQpaP14e0LcrPpuidrGiYfJ5gN4LqUugmT/sn2EsL0JwYqKPnrnumhLtCqQIR0BSshWSYb1KW4pqWQPpc5z7FEP1pLjlwmOVOkswfNlEGmk9nngGi9Hy7jq0Gtom8OJRyQMQgAVDj+GICQljG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s2ciaPVL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s2ciaPVL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3440D4E4151A;
	Fri,  4 Sep 2026 17:38:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 008546057F;
	Fri,  4 Sep 2026 17:38:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA85811C78158;
	Fri,  4 Sep 2026 19:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788543497; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3E8dPhUGulwBvC2FDqxVtlrQlaozuEVc311pKm8kPdo=;
	b=s2ciaPVL4AVMnm0zd8VU8Qr1pHFD9nt3vipOUcU+L98ZxCJnvEoRGEPmGRW1xMlVzi5JcT
	jRpMACiO6fgvx+QfXLzhDjn1g5iR7EPK9oKeCiid6B222uR96eFOWedQs7Rk+ka6FmDwFF
	YTXoQu/YEZOI7t2MzmDpNdl0ABqO1i2A3opzzFZSMA8AXiH4qFU5/qPXfFlzrYJE2l1945
	cjnjHawKk8uJq9F68SoKFH/7d0lHXkZLmNiiJOQJmBqWsrBJSbjfznEwCjUveAn/xjChVw
	wmfXJOuVosiKc2ZkbzQWqwSVlrUDnmGNdgTO4DhYMlnfJ+BriaIb0jz3iA2S5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: broonie@kernel.org, md.alam@oss.qualcomm.com, 
 Johan Alvarado <contact@c127.dev>
Cc: konradybcio@kernel.org, pengpeng@iscas.ac.cn, j4g8y7@gmail.com, 
 quic_varada@quicinc.com, quic_srichara@quicinc.com, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260825013848.1056946-1-contact@c127.dev>
References: <20260825013848.1056946-1-contact@c127.dev>
Subject: Re: [PATCH] spi: spi-qpic-snand: publish the ECC context to
 snandc->qspi
Message-Id: <178854349408.1467647.16557341714581809344.b4-ty@bootlin.com>
Date: Fri, 04 Sep 2026 19:38:14 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 24 Aug 2026 20:38:48 -0500, Johan Alvarado wrote:
> qcom_spi_ooblayout_ecc() and qcom_spi_ooblayout_free() read the ECC
> configuration through snandc->qspi->ecc. qcom_spi_probe() points it at a
> zeroed scratch struct and only qcom_spi_ecc_prepare_io_req_pipelined(),
> which runs on page I/O, ever updates it. qcom_spi_ecc_init_ctx_pipelined()
> installs the ooblayout but does not publish the context it just
> allocated, and qcom_spi_ecc_cleanup_ctx_pipelined() frees that context
> without clearing the pointer.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
      commit: 93bc7c4d2f4198586a6dbd7797c3bbf1ca845761

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

