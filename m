Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58E52BE5E;
	Thu,  1 Oct 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867701; cv=none; b=ZgeIPFG3NM1DlZ2u3+ve4LBvbmKHZ6eRcFrvjoKdTtps9NkRn7L6zmDaJ3apJzY/iZFXfe03HFIq3fOJDs0x/6bbMU03xuto5liyVQuuFh65eg7ZL02d2HmO6rVWnOWssHfdH1zpJq3WOdCk+Dk4HeEifmiOywxu6E9ywWLDevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867701; c=relaxed/simple;
	bh=Jk5EHpC0ehwHq4dIlq/8RErHW8LAznoWqX4gkVFIMCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e/pghRZLdN5ji/JHJsDF1LKKu+K8XXoh9gKZ/6p4NKiC86nLOvndAALPv2yBNN65Gp1Zsgs6ZwHgXoZvh8+kauaPffNm7kJWx/2/mNxvA4SxQvwHOyZkXyAZkbgmbCrpD/70hPXebXxKPiCED8ug4Rt3H8GMrfGXBmVErdEXNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dp4Yh7FP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dp4Yh7FP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D7924E421FE;
	Thu,  1 Oct 2026 15:14:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBD9B60341;
	Thu,  1 Oct 2026 15:14:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A09AD1032826A;
	Thu,  1 Oct 2026 17:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790867691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5oyRTIPWiL0zfhwJ7INFmSFs6JlUlft6I3AP6wUrgMY=;
	b=dp4Yh7FPKT6CzPlEjVEOdMsTsAarJiezBygokKRYBRPAIw/kVmNRlqkcQFruKNNGwS0rsE
	0CmvFNFlb+1z4cfHbH+KGUi7oLSmQNPvBPyTq3pQG1OCF9HnieQze61+S5GerjYS6OQfmk
	BzHbepg9o/o8b3FwgO5uGD4P28uesuhSL3oWhf8BbZINWE5U7c0vdJMGWg5xzAoKXEiaoC
	XVpXqmDK3PMZBJ1gzil5ynGgwgJqEQ5kxfj2XoRvqPPmDl3L4GpLi8pMvegQ8HYphjY83+
	dbX5fWtagRQ/ugU3OZSDcHMdDclX5dYxQXKX8TKdMXH34k0T6PdyIzREDHvn1A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 01 Oct 2026 17:14:44 +0200
Subject: [PATCH] spi: cadence-qspi: Fix status polling with octal DTR chips
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-winbond-spi-next-cadence-rdsr-fix-v1-1-ec5ff594ba5d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDQAwFf0VybmDXFgv9ldKD7r5oLlGS0griv
 3fpceYwc1DAFUGP7iDHR0NXa5AvHZVltBmstTH1qR9ySpm/atNqlWNTNuxvLmOFFbDXcBbd+Tp
 InuRebgKh1tkcTf8fz9d5/gDt+fO7cwAAAA==
X-Change-ID: 20261001-winbond-spi-next-cadence-rdsr-fix-36f1bf7c4fef
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghanvendra <vigneshr@ti.com>, 
 Steam Lin <STLin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Most SPI NOR chips today use 0x05 as ReaD Status Register (RDSR)
opcode. After almost every transaction, the core will wait for the said
transation to be digested by the chip by polling its status
register. This mechanism has been automated by certain chips, such as
the Cadence QSPI controller. Unfortunately, the feature has been
disabled for various (relevant) reasons. Disabling this feature has been
done by setting WRITE_COMPLETION_CTRL_REG.DISABLE_POLLING_FLD, keeping
the rest of the register intact. In this same register, there is also a
field named WRITE_COMPLETION_CTRL_REG.OPCODE_FLD, which by default also
contains 0x05, as primary RDSR opcode.

As a result, both the SPI NOR and SPI NAND cores, primary users through
spi-mem of the spi_mem_ops interface, do send their own RDSR. In this
driver, such command goes through one of the fifth possible data path
specifically crafted for short register-like commands, named STIG. In
STIG mode, the opcode of the operation is written to
OSPI_FLASH_CMD_CTRL_REG. This means that the opcode field of STIG
configuration and the opcode field of the automatic polling
configuration contain the same value.

Unfortunately, the TRM explains in two different places that this
configuration is forbidden, without explaining why it is problematic:

$12.4.2.4.11 OSPI Software-Triggered Instruction Generator (STIG)
```
OSPI_FLASH_CMD_CTRL_REG[31-24] CMD_OPCODE_FLD bits should be set
different than OSPI_DEV_INSTR_RD_CONFIG_REG[7-0] RD_OPCODE_NON_XIP_FLD
and OSPI_DEV_INSTR_WR_CONFIG_REG[7-0] WR_OPCODE_FLD.
```

and

$12.4.2.5.2 Configuring the OSPI Controller for Optimal Use
```
When using the OSPI Controller, the opcodes in
OSPI_DEV_INSTR_RD_CONFIG_REG[7-0] RD_OPCODE_NON_XIP_FLD,
OSPI_DEV_INSTR_WR_CONFIG_REG[7-0] WR_OPCODE_FLD and
OSPI_WRITE_COMPLETION_CTRL_REG[7-0] OPCODE_FLD bit fields shall not
match the opcode in the OSPI_FLASH_CMD_CTRL_REG[31-24] CMD_OPCODE_FLD
bit field.
```

For some reasons, this is only unveiled now when testing in ODTR
mode. Plain SDR modes work flawlessly with the same chips. One possible
reason for this, is that the internal data path in ODTR mode is
very different due to the extra opcode extension/repetition which may be
interpreted differently (this is a wild guess). For sure there is an
interference, as even the TRM states that there is some magic happening:

$12.4.2.4.13 OSPI Command Translation
```
The WREN and the RDSR device instructions are the only ones that are
sent by the controller under the hood.
```

I cannot probe the bus when the problem arises, so I don't know exactly
what is sent on the bus. Practically speaking, the chip was driving the
lines low (reading all 0s), which is not the usual default state when
the chip is not driving the lines (all 1s). Other people on the mailing
list claimed successfully using ODTR chips with this controller. My take
here is that either they were using a variant of the IP without write
completion at all (there is a quirk for it), or they were using chips
slightly more flexible about their opcode sequency or maybe with
different addr/dummy requirements.

Clearing the WRITE_COMPLETION_CTRL_REG.OPCODE_FLD while disabling write
completion polling entirely seems the best compromise.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This wall of text has been proudly redacted with my own fingers. The
issue is subtle, so the explanation is lengthy :)
---
 drivers/spi/spi-cadence-quadspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..5a5f1a852cbe 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1056,8 +1056,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	 * care of polling the status register.
 	 */
 	if (cqspi->wr_completion) {
-		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
-		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+		reg = CQSPI_REG_WR_DISABLE_AUTO_POLL;
 		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
 		/*
 		 * DAC mode require auto polling as flash needs to be polled

---
base-commit: 05538caf13d7f6d3b802705d345ecbfb3dfea6b1
change-id: 20261001-winbond-spi-next-cadence-rdsr-fix-36f1bf7c4fef

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

