Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039C37F002
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957137; cv=none; b=COFXlQK6POy4rUvsdb2Oi7CMpAIoSjgcT1PPGfKl5qXLsaCSgYF7tnGjVvyhzVXSDxWbUu9jdXZ7lNjgq0MrfzJ83XHTyz+UzJGls9jYv+IJKmjJUZIBLTi2A6N076TV3oYBvSaZx/t75pm46G7LvHvDctLzxkj5YKc4RV6ygdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957137; c=relaxed/simple;
	bh=gidRamgj8eDUV29xH6yqYbCKwqD3sPaJu+YvLyMkSfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RhYjVtmTebIUYyqpbIvRk6UncFPs9kQT1g1roCZUna0k3gffIi08uEwqwjOTmpkdl+amHgtUe6+GH66O6FIOcHgn4CC3o3qnChasXcToMbXfS8ETZwfrANNHTMVB3YMLAb0vMkIxTcDiUMNbQFNvbSJ2291yeM4+p8KQI70BdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1hSr5TXV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1hSr5TXV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 482264E42D66;
	Thu, 28 May 2026 08:32:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D79960495;
	Thu, 28 May 2026 08:32:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69D5B1088877F;
	Thu, 28 May 2026 10:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779957133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gidRamgj8eDUV29xH6yqYbCKwqD3sPaJu+YvLyMkSfY=;
	b=1hSr5TXVmnTbPtQJKgkpYV2a6Ek9sgxLDA/SpJIuDB8+3FqniU/CttkWAwfZNa22p8tXNN
	SMos1Jy2TqWsZ+IhlVdlAWXGO7ry+BLa4tRRISyytzxH0cRnxQ82DbvDfxvbwhcbW316SZ
	spCHpG3/xXk/cdeVVKP8yvQCJRlDW2EThFLlmuV6R5SdQdkZG2YzaIWJmZMe5iZErbvbIv
	pyoi0IFqjH40+GkKa7b4XP2qxKmjy0eS4BlQKLrZbgG05BbKXQCkslXYIjuT61HcoEOREb
	19rZRbaWUB6t147UqyddLmGN+wgjPD04DippIctN7RVYUPvknSIsBmw0JB68zQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
In-Reply-To: <20260527175527.2247679-2-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:15 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-2-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:32:10 +0200
Message-ID: <87wlwogcj9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 27/05/2026 at 23:25:15 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Some SPI controllers support high-speed operating modes that require
> controller-side configuration before the device can be driven at its
> rated maximum frequency. In these cases two frequencies are relevant:
> a conservative speed usable without any such configuration, and the
> maximum speed achievable once the controller is set up accordingly.
>
> The existing spi-max-frequency property accepts only a single u32,
> which cannot express this distinction. Extend it to accept either a
> single value (retaining full backward compatibility) or a two-element
> array [base-frequency, max-frequency], where base-frequency is the
> conservative operating speed and max-frequency is the highest speed
> the device supports after controller-side configuration.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
