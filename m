Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2043F0B4;
	Thu, 13 Aug 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609489; cv=none; b=ppJWUm2qsEwpvmuIJ8K7sHWSAMYM7BtqNn2eGvcVSTT+sdukEn2XUspiDJNvDxGevX59PU/Vm460gaOHwONctSwb5jbG7zWyeNstlU9bdkIMaIYrtfZUMCXu2JWEJOxOlexlVquMXrK/k24pd6s+/WrD9mlIxGMQ7svxiUIo/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609489; c=relaxed/simple;
	bh=zCmrUfoFVJwXdZazRDmnPM7pLBXRf6epSgmPkjDgOcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLsuO9g4NGwmzgZ1EQK6C7cE+PWLVI7rCGuzwzK5q+TQZDoyhXljgNeOsD5j989D3VIYvBred5lXy19V/OnF3ioeYMZzpcFBARklLocbc9Bd7HI8p7MSJ5VxxMaGwmvbeHZXpQrHOFRlwrvTTj6n2tiqqhfOyvXYW6VzySmt93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rVLtUGg2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rVLtUGg2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 54F0B1A1541;
	Thu, 13 Aug 2026 08:24:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DFC7602B8;
	Thu, 13 Aug 2026 08:24:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EE4711C4DAEC;
	Thu, 13 Aug 2026 10:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786609480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zCmrUfoFVJwXdZazRDmnPM7pLBXRf6epSgmPkjDgOcI=;
	b=rVLtUGg2Dk3e+r0bPCqesTd0e6w3dX7swr7xoa9wFodaKu0BRNLjn4yQOpwgmZfOVAl6cv
	n+zYLuQ8FhSImpDShQifSqqcMy90ELbRV4JjiG2weHHsoHVpgWoUdkWFVDCJLn8CvKzfkg
	/7hW1T+90dDrAw0t4DX/i/eUu/eH8Sl8WBOeXJbM8tzhREOhSHMfBbFW3+s4sON2AiFlcg
	h787fzWXAp0qRHU4EeSzcXEk2qQk3LlyvwSuCpQgWgK+6md3cqz9wqa29I78gpMdfHDppi
	sAxmCurdbD2U/PuGUQFFtXLvK/K77TtIdCkwvl3AVMy7XRHVFT9Q66rSJfie1w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v7 15/18] mtd: spinand: extract variant ranking logic
 into spinand_op_find_best_variant()
In-Reply-To: <20260811183313.1550425-16-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 12 Aug 2026 00:03:10 +0530")
References: <20260811183313.1550425-1-s-k6@ti.com>
	<20260811183313.1550425-16-s-k6@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 13 Aug 2026 10:24:36 +0200
Message-ID: <87h5kyl96j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 12/08/2026 at 00:03:10 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Refactor spinand_select_op_variant() to extract the inner loop into a
> shared helper spinand_op_find_best_variant(). The helper takes a
> skip_mask bitmask of already-tried variant indices, enabling callers to
> iterate variants in ranked performance order while skipping those
> already attempted. spinand_select_op_variant() becomes a one-liner
> wrapper. No functional change.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
