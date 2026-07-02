Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6084A33F2;
	Thu,  2 Jul 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999696; cv=none; b=kpp6j7N+3LuvJmFn76cHwexkPFenV4ZvXKk9on6qqu5KIV+fe8V3cu29HHFh26wOczogxeSPi1UXNRUuneBnAoHwginTH3xoNBvtP5FGe+JZGJ24oHst/vqfGVuTulRSh/Nl8zdY7ZToacMVq76IJmD9Ec9A1pKursZ9xGortI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999696; c=relaxed/simple;
	bh=3NlBw7T5nabuhOxxhmeklPLxyEetO10ugW8lwBtpDek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cm4fX96qX/8yZ6tI9eNodi4ixV8dtJB7Z136mlC1uQ0ES+g/4fgGPq42CBog65VQlC+MrjxS7Vmf/yYmrP1PbM7lFYmIFD9b2vGUZHaBBqhvddGd0OocMFVJJwZ/rAZJ/GxgyKt/XatQqVwWURKK0/iNULiryG2lUNuvXmwdN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tbkQTnk/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tbkQTnk/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 44C8C1A0DE7;
	Thu,  2 Jul 2026 13:41:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11DAB5FF03;
	Thu,  2 Jul 2026 13:41:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 932EC104C9577;
	Thu,  2 Jul 2026 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782999691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3kbHnC3x3hEpbNdF+qEJ6jzcXt/7SmkG5FNSavJE8Ds=;
	b=tbkQTnk/xbfoAM1MziLjXUidjKag65lxh3C+w2AFcWUZt8jrhqRqMPrg+jKMq44qEJjJ/3
	S58xyi4QHP3dVJpYcHhRSTg5RB7KbihIDrQ5kmQtOldRZ1FoU2LtPDRUs+ga2ePuqILrpu
	HXGE46szPIgoxkCSgPain7ryJrFwd0w0MVqwbdI6hw0VKdIw8gxKybMWbny+XRNdvKVnJq
	wqSw7Fcd41VTUVWDrj2UsLksij0fbna6g8CZOSGP7/kam31vZTd3uKs2SYaI6mBZON3mON
	C0/YkQEIrUlgE1+SjUoeisGO3DLktE99SA+6cmrFuolFSxK9mR/L/2k89ng8ZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v4 13/16] mtd: spinand: extract variant ranking logic
 into spinand_op_find_best()
In-Reply-To: <20260618073725.84733-14-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Thu, 18 Jun 2026 13:07:22 +0530")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-14-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 02 Jul 2026 15:41:27 +0200
Message-ID: <87v7axpkzc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 18/06/2026 at 13:07:22 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> spinand_select_op_variant() open-codes a loop that finds the fastest
> eligible op variant by transfer duration. Extract this into a shared
> helper spinand_op_find_best() that accepts a skip_mask bitmask of
> already-tried variant indices, enabling callers to iterate variants in
> ranked order while skipping previously attempted ones.
>
> spinand_select_op_variant() becomes a one-liner. No functional change.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index f86786344d52..b678d0534297 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1541,9 +1541,22 @@ static int spinand_init_odtr_instruction_set(struc=
t spinand_device *spinand)
>  	return 0;
>  }
>=20=20
> +/*
> + * spinand_op_find_best() - Find the fastest eligible op variant.

Should definitely be named spinand_op_find_best_variant(). find_best is
way too wide.

> + * @spinand:    SPI NAND device
> + * @variants:   full variant list to search
> + * @odtr:       true to consider ODTR ops, false for SSDR ops
> + * @skip_mask:  bitmask of variant indices to skip (already tried)

The flag seems to be quite overlapping with the odtr flag. Shouldn't we
have a single way to filter operations?

Also, why are you switching from an interface enumeration to a boolean?
Some day we might need to support things like 4D-4D-4D. That is where an
enumeration is better than a boolean. If you want to drop the
enumeration, it shall be done everywhere else, but I don't think it is a
good approach.

> + * Iterates @variants, evaluates transfer duration for each eligible op,=
 and
> + * returns a pointer to the fastest one not in @skip_mask.  Returns NULL=
 when
> + * no eligible variant remains.  Used by both variant selection at init =
time
> + * (skip_mask =3D=3D 0) and ranked PHY tuning iteration.
> + */

I haven't seen what is the use case of this mask yet, let's see in the
following patches.

Thanks,
Miqu=C3=A8l
