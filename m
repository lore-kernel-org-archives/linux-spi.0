Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E64A8FF8;
	Fri,  4 Sep 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546709; cv=none; b=L3zirsrkUPLLXbLu/5b6fMswD1lBRMTq0K220TmldlobQ39/RQdfNNm06jMcqe+RKBZORhnNtNkwzOQiwhYi0fGqfhYIe9zJTKM8jPqdcjRtptKkhRzoemE1SqVQ+f6BUr/WGIoorxo/IQC1kIHJs/r3PV7LWwVpsfaksqkSmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546709; c=relaxed/simple;
	bh=QnsG/88k4AwYZQ1AIOz3tt/8r8BB2ggrWu8fFatvZ9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lbMMftBfrbW1TEq+j16Qy+EW3Wj0yYfiVvAJVP9KhTXVcXrEeyEqp/jCo+bBMRwJHqEG/31XDt1qRu/4jF8UvE61/oNIg+5eZt8mvlV6+f5NxN2yjR3HISqLnCzq8MG7P77JipDKnng22qOnkDSZY0L9fj6/YU6mIU2ciM/+pyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fp7eHj3I; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fp7eHj3I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 303584E4152F;
	Fri,  4 Sep 2026 18:31:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA9476057F;
	Fri,  4 Sep 2026 18:31:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A6E511C78158;
	Fri,  4 Sep 2026 20:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788546699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=P+rdDJwO1BaO3hbIt3/EpCrUPVPc1TD/epdBPBg67zI=;
	b=fp7eHj3IgTf5mmV0IwpYZtRclyXlk0Pu+yb/2whutuBYdtRbH0GGwUk1RFS/YhdBbr6jVY
	11Ldmbf6/7b+P6cE63ASK7GuMYSWSt46SltJ2AZo5+L+S3XgfCsqTlFqMcWn/nuE21Kok6
	R/J2jfDbpjxXqY21hdD9yW+b7ILGSt/xNlFMmuFTzGkPV2FG1Dc+ET9z2d5xZcSNHarRyX
	u2buxRlFFHMBE7SLdKF5PS5Wa1HO+LAEHb/p/ejyaV6iTMRqvzwvZxQ1bEtPnR6sRPo4Pd
	uOjHeAYASW4OtFnszft1EIF2y0/Y+f2BVB7d8KMwA1qnLA95A8HXBJiqMGirnw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: md.alam@oss.qualcomm.com,  Johan Alvarado <contact@c127.dev>,
  konradybcio@kernel.org,  pengpeng@iscas.ac.cn,  j4g8y7@gmail.com,
  quic_varada@quicinc.com,  quic_srichara@quicinc.com,
  linux-spi@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-arm-msm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-qpic-snand: publish the ECC context to
 snandc->qspi
In-Reply-To: <apsKiRC-bn7oPS2P@sirena.co.uk> (Mark Brown's message of "Fri, 4
	Sep 2026 19:14:33 +0100")
References: <20260825013848.1056946-1-contact@c127.dev>
	<178854349408.1467647.16557341714581809344.b4-ty@bootlin.com>
	<apsKiRC-bn7oPS2P@sirena.co.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 20:31:35 +0200
Message-ID: <874ig4zx4o.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 04/09/2026 at 19:14:33 +01, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Sep 04, 2026 at 07:38:14PM +0200, Miquel Raynal wrote:
>> On Mon, 24 Aug 2026 20:38:48 -0500, Johan Alvarado wrote:
>> > qcom_spi_ooblayout_ecc() and qcom_spi_ooblayout_free() read the ECC
>> > configuration through snandc->qspi->ecc. qcom_spi_probe() points it at a
>
>> [1/1] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
>>       commit: 93bc7c4d2f4198586a6dbd7797c3bbf1ca845761
>
> Oh?

-ETOOMANYKEYWORDS ._.

Dropped, my bad :)
