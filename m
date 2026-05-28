Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082A30C34A
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957303; cv=none; b=gY7nGkjwuWNb17C3fTTFvGKYVtYbhr8/ZCaeG+W2fH7pFJ8jBaqoabu5m6pxG/ckgXM9wtrO9CjaBQ1v2Zy29hCWIrCtE69cRfaQNfVDnlfmXWrRkViOlr3yPNQ6gsCz6J1IICIC98x6b1L4h6aRuFpZZqoDN9YJcoMk6sRR5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957303; c=relaxed/simple;
	bh=UA50EaJkn/M+baib7en4Ja04922HFuQSGb68SuS6usI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DI1w1FgY1FvKOTv2WqC2fTJsC3UNPMGRH0sptmO3cKBKGi18Jr4V5ZNoswJN+hUZ95OClWJJLv2ORvfz/F764Qn5b9HOFT6EZVAn2LrxvdM9xDp2op39gv+Qa1Aq2WWbgYJXx6o4ZegExfiwXxLBG0CIJRtG9mu8dfxjxAqYAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cnpE5h7M; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cnpE5h7M"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B37A4E42D66;
	Thu, 28 May 2026 08:35:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2947060495;
	Thu, 28 May 2026 08:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D59CB1088877F;
	Thu, 28 May 2026 10:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779957299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M56eRJSkoeZGYpGwZOTyQ5aXY21sscvasyo7WERYLoU=;
	b=cnpE5h7MRH8sI7n622w/jjPJPNGinPbr7SiiFVDEFKXLeNtHiLl4SAxNmVTDEhK9sLql7R
	mxGKrjO3w40kqbIJTC/zZTsTROdrql3wbwQV2gqG8TbH7UTLUZ4CLNxOYyuD2ld/hdHekc
	HTzKvx7EcdVdWfY/rg7a17VIByb0nwthLx94vAHNnhWKXzYzSwflch4C0UnKlB/h+UvtX8
	zardFwSAcEyD7F0/d8fmO+ZAmoGD4Sl97I8OFysY7P6zcdKeQDl2liZ01to/2Q6238acrP
	v3SXi59qm7DE/sstUFgY6EwNK3VAvxFo4cE9O6Aj9cKCOZFt8tVAiCZWRrHc/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY
 tuning pattern partition property
In-Reply-To: <20260527175527.2247679-3-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:16 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-3-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:34:55 +0200
Message-ID: <87qzmwgceo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:16 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> PHY tuning requires a known data pattern to be readable from flash.
> When no partition is explicitly identified, the controller must search
> all available partitions to locate the pattern by label, which adds
> overhead and relies on label naming conventions outside the
> controller's control.
>
> Add cdns,phy-pattern-partition, a phandle property that allows the DT
> author to directly reference the flash partition holding the PHY tuning
> pattern. The controller uses this partition during calibration, avoiding
> the partition search entirely.

I would remove the "avoiding the partition search entirely". While
thruthful, this is related to the history of the feature (how it was
implemented before) but doesn't give any useful hint to the reader of
the Linux kernel mainline repository. I would just drop that mention,
and same below.

> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../bindings/spi/cdns,qspi-nor-peripheral-props.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripher=
al-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-periphe=
ral-props.yaml
> index 510b82c177c0..0ffcdf5b00d0 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-prop=
s.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-prop=
s.yaml
> @@ -39,4 +39,12 @@ properties:
>        Delay in nanoseconds between setting qspi_n_ss_out low and
>        first bit transfer.
>=20=20
> +  cdns,phy-pattern-partition:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the flash partition containing the PHY tuning pattern.
> +      When present, the controller uses this partition to locate the
> +      pattern data during PHY tuning

Period                                 ^

> +      instead of searching all partitions by label.

This sentence can be dropped.

> +
>  additionalProperties: true

With these comments addressed, you can add my

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
