Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CA3F1AB5;
	Mon, 29 Jun 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747823; cv=none; b=pDLfueoEhlZR9MZWT7ltNiV2xdm9YSTtPa2dCnseSgBlR9PsVQpKJhLDZkHMcczCkHItF//vV9/7RTuT4LsnfJldb1i2+b5gBLHJgdNfiuhkDclXBjvKk429xxlx5ToCGEQcAAceyJTFMFA3jNI0kL8uj7z5qHtGFYS+k1AvDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747823; c=relaxed/simple;
	bh=ufUECX5xmH2+iBPhNbY/6S75VKUiQXYWWuVZ5F61r00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/QwCKtlynQ4IG793gOVQ43rMN10k6xs/ra/mNGzfCrmf0IN+ZQiUjdBfVh8cO6uLWRUZJSgMfkc/qbYvdPP451FaxfxUPhTj+/lS1XN7wVYKh36C9kThSfuVHA0V+OeDSC+GKx+zIRClsyHgZT4RRlASrca5CGiT8G+XCP9g40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B7NblWrx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B7NblWrx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13A431A0C88;
	Mon, 29 Jun 2026 15:43:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9DF35FF96;
	Mon, 29 Jun 2026 15:43:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90932106F190D;
	Mon, 29 Jun 2026 17:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782747819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ufUECX5xmH2+iBPhNbY/6S75VKUiQXYWWuVZ5F61r00=;
	b=B7NblWrxpwTHjtajkuPoFZfqR6FzekKleuqAVcNoqsHAIpJSYEoMWJFp6y7yw5vgcQUH0X
	BCWWKwIlCtn2JNl/fBU2FR7xMNQt5H+1rjjnyBB3o0GOoZM5DNmCp6XeMiREKO/XJ6mXwf
	+3yiBB+FnenAuyDSAzUJxqDr/lvHYum+4/zFdbwLK7NlvIIptqe93E3HiKGClm+iZrbRHR
	1FQnqcybEpgrCT6J7UVkiFIuHFBM5T17Tvhk/K9K3wYp2nZi9H0rplS5s33DuA95zn478M
	zd9GnDAVt9yFoqDpEyprw7XOJRP/LUPAgm4RvZiC80nRd0tijV6mg3POprzUNQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v4 03/16] spi: parse spi-max-post-config-frequency into
 post_config_max_speed_hz
In-Reply-To: <20260618073725.84733-4-s-k6@ti.com> (Santhosh Kumar K.'s message
	of "Thu, 18 Jun 2026 13:07:12 +0530")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-4-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 29 Jun 2026 17:43:36 +0200
Message-ID: <875x31s66v.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 18/06/2026 at 13:07:12 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Add post_config_max_speed_hz to struct spi_device and parse it from
> the spi-max-post-config-frequency DT property in of_spi_parse_dt().
>
> This supports SPI devices that operate at two distinct clock rates: a
> conservative rate always reachable without controller configuration,
> and a higher rate achievable only after controller-side configuration
> such as PHY tuning. With both properties set, spi-max-frequency gives
> the conservative pre-configuration rate and post_config_max_speed_hz
> carries the post-configuration target for the SPI-MEM layer.
>
> Zero when not set, preserving existing behaviour.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
