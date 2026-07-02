Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E918492538;
	Thu,  2 Jul 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999155; cv=none; b=LqhGNaNTo58GS3qvrbjKx2NXDdrFYyMHGyzSTD9wwTvKStPrS63vnBZXIcQzwYM4r6ZX+dY05exaEMKrKpqlsKlYm6stzFtGvu893KdBhKX8liL4fjdqByLc6r6DM43nxPDjcofde9+YPlWew8z5drRk4WwsA+UEyaaZcjEtA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999155; c=relaxed/simple;
	bh=/PdHVz5nHkTJ6aPo2Gdk4XwgvzD3Qv3Vyxnp60wgE44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T22+lzAwqvPjKY4t4f42ryO8je9HsP4CfFG6MnsV4k68WDQ7UOyLFW+t4mjhKCPREByZyS7sUKdFvF0+30d0LzKqhc/fcu/3OPFugo9A8m8vedftvkSfH6bIKbXS+hlp3WyWrRbiTMORhh5NgvSbG3hxvLozkaQCh1AjzomoCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gZY3Ibiy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gZY3Ibiy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5A060C4FEDD;
	Thu,  2 Jul 2026 13:32:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA1185FF03;
	Thu,  2 Jul 2026 13:32:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FB50104C9560;
	Thu,  2 Jul 2026 15:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782999151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/PdHVz5nHkTJ6aPo2Gdk4XwgvzD3Qv3Vyxnp60wgE44=;
	b=gZY3IbiyZpfwqeOAiVt1d24yIKnddX6h7B09fgkiquSTNUc76JxJxDS93hNr4Tt4WR4T9L
	mFi0XKzJTlw7SjoswfLDN8xQl3lzCApSnq9S9SJFNPNol9i6CaqoTC9F6QWn07/jLMsgH+
	oMNoMX++Ao+/lW6STMAgOz1yCm98Z9i8fYKO14IvC4rqhQguYCrP6tNpbaHiZV92iHhdhS
	T05t8kEu6hX1gGy+/GbuD5TvZokKTOHo30W8znDGOblOc1fx58h3GYuXM4kJeT4SzehaYy
	8USoPr+2/6jV+TGu346mvaR96ZyiOoVDwSieAdvw/9BIj3Kdy1e7qFpliCQqcQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v4 04/16] spi: spi-mem: teach spi_mem_adjust_op_freq()
 about post-config ops
In-Reply-To: <20260618073725.84733-5-s-k6@ti.com> (Santhosh Kumar K.'s message
	of "Thu, 18 Jun 2026 13:07:13 +0530")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-5-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 02 Jul 2026 15:32:27 +0200
Message-ID: <87a4s9qzys.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

On 18/06/2026 at 13:07:13 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> When a device exposes both a conservative base speed (spi-max-frequency)
> and a maximum post-configuration speed (spi-max-post-config-frequency),
> operations validated after controller configuration must run at the
> higher rate while all others are capped at the base rate.
>
> Extend spi_mem_adjust_op_freq() with a bypass: if op->max_freq equals
> post_config_max_speed_hz (the value written by execute_tuning on
> success), return immediately leaving op->max_freq unchanged. All other
> ops are capped to max_speed_hz, the always-reachable base rate. This
> integrates the policy into the single existing frequency-adjustment
> point so exec_op(), supports_op(), and calc_op_duration() all behave
> consistently.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
