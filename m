Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E23822AB
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957884; cv=none; b=dTsMJL6eXbP9ueYuKaQcYpUyQoIceIT8DtLEP4ZxLtvwnc8kPVT/T0XAz5fTnh2Dto3bo80+BhMA4xY4/sPwBLMUeVaqGVKTXMzleGTX9MDdLtcjwZIMQ4sNQo6dnypZQfgtFm3ByW+O7VH2OmH2ZA5ePOSg/R0U3ijz9RIjmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957884; c=relaxed/simple;
	bh=gB60yIvdllqSTxzVmv+2Jkcre5pBJLowX9gbXUxQDJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ElieUCjrCNrhvThyyBjRWO+/+CAIjXdh+mu1xVgxTWH6566udPuzVIvm1oRLyIJQezXpUkDkI2FqG77t5iM+CvWq+3Q4dNVe1tYZKbfTPy4GfFZTJ4uO2a3hP/S6JJlI2kFSzKl6/9K/zBNxzp3R3aMQK13jZLN0jQh25Z0BiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kdm6bCSH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kdm6bCSH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA66EC62447;
	Thu, 28 May 2026 08:44:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B4BAD60495;
	Thu, 28 May 2026 08:44:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B7CF1088877F;
	Thu, 28 May 2026 10:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779957880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gB60yIvdllqSTxzVmv+2Jkcre5pBJLowX9gbXUxQDJU=;
	b=kdm6bCSHoHGgTlHbCd1B3Ar9CfUWv7ncS+50PMakeybZFMBuWQJ0RU3rcfPuQbEJKoUAq4
	bznED1MDr2LJ3l8x0zFlI0jG3wtsoSN5BesVH6za7YI3ZJDoWszE+d39mw/StJx/jWn8ox
	Py9LwHqcdPUpVsz22rfsqrC3A4f2jEJRpZxzsNq/+Tzn2Y2ZSPhPlPyMLrg+d1r6DxDGRF
	J8CDLq7p+sHq4x+oH78TG2UJj3KITgXdXcN4In7qYxlcCUJV2CVywlPwef6Rwssih3nVOU
	SB7QqqpobhdEDsmBxe6ApRQTchQV1k8SCLN98DW+65p+FUmlCmoM9jX0RYAvIQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 05/13] spi: spi-mem: add execute_tuning callback and
 spi_mem_execute_tuning()
In-Reply-To: <20260527175527.2247679-6-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:19 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-6-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:44:37 +0200
Message-ID: <87a4tjhqiy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:19 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> SPI memory controllers that support high-speed operating modes often
> require a tuning procedure to calibrate internal timing before operating
> at maximum frequency. There is currently no standard spi-mem interface
> for drivers to trigger this procedure.
>
> Add an execute_tuning callback to struct spi_controller_mem_ops. The
> callback receives a mandatory read op template and an optional write op
> template. On success the controller sets op->max_freq in each provided
> template to the validated clock rate.
>
> Add the corresponding spi_mem_execute_tuning() wrapper that validates
> inputs and returns -EOPNOTSUPP when the controller has not implemented
> the callback, allowing callers to handle controllers that do not support
> tuning gracefully.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

This approach looks so much better.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
