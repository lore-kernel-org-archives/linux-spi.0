Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB9380FD5
	for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254697; cv=none; b=Wwm2QE2wvXmucCR50DODMY9EKbWkYJqOM3wpF8lYgsxsYSPK13ZPZyjHbukY3P5TPuwGtWe9NEYXMKZ3LLjUls6EoV46V5S/d/ez4zCgwsfHYgMIxxOfX5tRyYruF72Qg8QF+ydUA/vCsnbfZf36ByzmQ03xuJotomHKMvK6CL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254697; c=relaxed/simple;
	bh=C78Tw2rhepnaeZ3lIEmbsTlgf0Knl0PRNB/z53oGoSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CgKWlQLHY2dj1m0Mb3nxXhzklEfUNs+HKdhvztF0qQ0fO0Wqpa68fqMTzEEsYa3Sf6goSQ/r1xSGX6SndIaQ77oqj8m0RxjGBmtEQp+Kb+zJB3o1+bV/gVj+rBnOruzf3LK9LinlC73C101hX3PKgcDptHcI982APH+2Q6nIsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KQFt4507; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KQFt4507"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A2BCF1A38C9
	for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2026 08:58:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76CA260012;
	Fri, 12 Jun 2026 08:58:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B77106C8346;
	Fri, 12 Jun 2026 10:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781254691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vUU7RlEgkz1ff8Psj7tiNb2Kk8h97Vm0P6TjdDZ1aOE=;
	b=KQFt4507EcpB4vfthhhQ6ZOQ22I1xuPT2vgOvq3IfVvIYcEaIpPnE8dGNv6WS8vBQbebN6
	IanuBKllsV+6q9CRjLCQVstmTQ89PLoxZxEaKA/O2YADPr/35yCWEMZYt1uIW4cH97irLA
	z/r3xZoB14KLk0FqoOr6TZ5s8myJvf6sX14HkHACYN0Ljh21zS9A9/Nvqvo3a/bgyz2mp3
	0AVVkZqRME0Sg+/Wm5Zh1dnPT4opnh+g37/PjrMfmYHuu7nyvq2M8pmczKT3Vax1aKOqzW
	YFCx8SBFE77qwvVQtr0n6Tlq6c6J+wVgm6vFtau+zUF0RZgU+LwJCaoYPPO+Xg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 12 Jun 2026 10:58:07 +0200
Subject: [PATCH] spi: spi-mem: Fix spi_controller_mem_ops kdoc
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-perso-fix-no-cs-assertion-kdoc-v1-1-626b2d6d0d9b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqAMAwEvyI5G2gLKvUr4qHWqEFopRERxL8bP
 A7Mzj4gVJgE+uqBQhcL56Rg6wriFtJKyLMyOONa01qHBxXJuPCNKWMUDKKFU1e4zzniZBdLnW+
 8NwE0chRS9z8Yxvf9AKUeUdJwAAAA
X-Change-ID: 20260612-perso-fix-no-cs-assertion-kdoc-b1f1e795990a
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The secondary_op_tmpl kdoc line has been removed accidentally, add it
back.

Reported-by: Michael Walle <mwalle@kernel.org>
Closes: https://lore.kernel.org/linux-mtd/DJ56CDMRVFQ6.FOZRIQTF3VDW@kernel.org/T/#u
Fixes: 38fbe4b3f66e ("spi: spi-mem: Add a no_cs_assertion capability")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
The faulty patch has been applied in an immutable branch merged in
mtd/next and shared with the spi tree. This patch shall be applied on
top of it, it can definitely wait one or the other official PR. On my
side I will likely not be able to send my PR before Saturday 20.
---
 include/linux/spi/spi-mem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 722abd9aee3c..f660bb2e9f85 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -385,6 +385,7 @@ struct spi_controller_mem_ops {
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *	    Octal DTR
  * @per_op_freq: Supports per operation frequency switching
+ * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
  * @no_cs_assertion: The controller may automatically deassert the CS if there
  *                   is a pause in the transfer (eg. internal bus contention or
  *                   DMA arbitration on an interconnect). Features such as NAND

---
base-commit: 4f2692a5383e4bdd43ae940cda012360f7217a2d
change-id: 20260612-perso-fix-no-cs-assertion-kdoc-b1f1e795990a

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

