Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F04AD4D4
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152288; cv=none; b=QhWZ79mFyNPCs6x4AciKC260vv7yWtSoIeGWZFJooVtA6/HZx6dqOaKRsFDJfe2tY9qVRMgmg3bdXpfy+l/nJA3QtilM/BnSnpeSnWoAWQXp6vXyqG/raNl5fVs8cX6fAeCHDBDU8zWuGAonviQyVhY78wupr7XRq8NSJ57U7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152288; c=relaxed/simple;
	bh=OdyIaFHTfKbXWj6XRC6rk9Un0vCTcVZlLONiQQ35BAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xd75eI/NrgcWUq1RG5o7NdS8Ycn/76u3xxArsw52z0N7r0Rz8LGVgC1gi57hM3NLUJU856lQVeXjtHNLyur032r6e622DhHVC+5FQR0GrwmV7GwKrnluaU/dL5UTxd4JJxQ9K4HIyFl4ulUUIW94siWGc9M6GiFsgclw2Ff9r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=fu24JMu2; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mB02m2EH; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="fu24JMu2";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mB02m2EH"
DKIM-Signature: a=rsa-sha256; b=fu24JMu2LMFoXk897ztzdTR8oGDiO9ShsCIYIcrA7O8us1CEVIy8+8v4f8nFE17tZMHMA6ARJywOj3/k7WJfk9gakGG4BIOlUp/zn2N+4bj8cErE2Z2YDs6G2UR4fa7vi4sVRxDe7l6t5h41zC6puBCLNBTOgCTm2+X0O1knSgXpgJUr6jM0i+1a64RCmUkrFyUIvtdXKCR4J4TSPCW5O7MbW6F+vZpnYftARjXgRFCb1HYki4aW85I6uRHD1tqi3hrr9ecJORcLhnVkzhzB9MA0igMYCeyieAzTEvN0cWBzLxBnz1UZ3kmR7dOWEqLQItkUSC5AJE4pTRoolnie9A==; s=purelymail1; d=c127.dev; v=1; bh=OdyIaFHTfKbXWj6XRC6rk9Un0vCTcVZlLONiQQ35BAk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=mB02m2EH728+49IdiolSZCE4m+rrnEqTmoxFjva7xhjSTyrIfBF12YAw/WHwXpmQwjiSYB3M+gfwijn5d2O2deQIRdJEXe/EGeUWz5ejGhqXU+3BMqwMcZ1DPUArS2BmC8D12Nh5QlY43VWSP0AwkiXK9Tkb3sL/lK2LrmD+AzZHUPKx541UBtM2v4Hb/HDd24HOdrCfDmjAdPFEC+4fPHN1QbiKlrnsNea1calnNh+/72YOMgb3+t4eYog15ndEwxJ/reEwmdXXojh+Vh2ouy6ZNDIEpLov2dqVKq0cjoEVsF5RIhplrSO9eZizIv+ISnLh7/ZVmglJmwpWh/iPnQ==; s=purelymail1; d=purelymail.com; v=1; bh=OdyIaFHTfKbXWj6XRC6rk9Un0vCTcVZlLONiQQ35BAk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: linux-spi@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1066090597;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 11 Sep 2026 18:44:22 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: broonie@kernel.org,
	md.alam@oss.qualcomm.com
Cc: konradybcio@kernel.org,
	pengpeng@iscas.ac.cn,
	miquel.raynal@bootlin.com,
	j4g8y7@gmail.com,
	quic_varada@quicinc.com,
	quic_srichara@quicinc.com,
	linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Alvarado <contact@c127.dev>
Subject: [PATCH v2 1/2] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
Date: Fri, 11 Sep 2026 13:44:15 -0500
Message-ID: <20260911184416.109790-2-contact@c127.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911184416.109790-1-contact@c127.dev>
References: <20260911184416.109790-1-contact@c127.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

qcom_spi_ooblayout_ecc() and qcom_spi_ooblayout_free() read the ECC
configuration through snandc->qspi->ecc. qcom_spi_probe() points it at a
zeroed scratch struct and only qcom_spi_ecc_prepare_io_req_pipelined(),
which runs on page I/O, ever updates it. qcom_spi_ecc_init_ctx_pipelined()
installs the ooblayout but does not publish the context it just
allocated, and qcom_spi_ecc_cleanup_ctx_pipelined() frees that context
without clearing the pointer.

spinand_init() calls mtd_ooblayout_count_freebytes() right after the ECC
context is created and before any page I/O, so the ooblayout always runs
against a pointer that does not describe the current context:

  - On a first probe it reads the zeroed struct from qcom_spi_probe(),
    so steps, bytes and bbm_size are 0. The count then returns 0 rather
    than an error, so the probe continues with mtd->oobavail set to 0.

  - On a probe retry it reads the ecc_cfg the previous attempt freed.

A retry is easy to hit. On IPQ5018 with the qcom,smem-part parser the
partition parse returns -EPROBE_DEFER until SMEM has probed, so the
first spi-nand probe defers. It defers inside
mtd_device_parse_register(), after mtd_otp_nvmem_add() has already read
the factory OTP - that read goes through prepare_io_req and leaves
snandc->qspi->ecc pointing at the context that spinand_cleanup() then
frees. The second probe allocates a new context, never publishes it, and
computes the OOB layout from the freed one. Once the slab has been
reused, qecc->steps holds garbage and

  oobregion->length =3D qecc->steps * 4;

goes negative. qcom_spi_ooblayout_free() only reports -ERANGE for
section 1 and later, so mtd_ooblayout_count_bytes() sums the regions and
returns that negative length as the byte count. The -512 below is
steps * 4 with steps =3D=3D -128. It is a byte count that happens to
collide with -ERESTARTSYS, not an error the driver returned.
spinand_init() takes it as an error, and because it is not
-EPROBE_DEFER the driver core never retries and the NAND never appears:

  spi-nand spi0.0: ESMT SPI NAND was found.
  spi-nand spi0.0: probe with driver spi-nand failed with error -512
  UBI error: cannot open mtd rootfs, error -2
  Waiting for root device /dev/ubiblock0_1...

On a Mercusys MR80X (IPQ5018, ESMT F50D1G41LB) about half of the boots
failed to mount the rootfs, the outcome depending on whether the freed
memory had been overwritten yet.

Publish the context when it is created and clear the pointer when it is
destroyed. Clearing leaves snandc->qspi->ecc NULL after cleanup, which
is safe: the mtd is unregistered before cleanup_ctx runs, so no
ooblayout callback can follow.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Int=
erface")
Cc: stable@vger.kernel.org
Tested-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
Unchanged from v1. Both hunks are untouched by 44d39535cd4f, so this
applies to v7.3-rc2 and to spi/for-next alike.

 drivers/spi/spi-qpic-snand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 9eafaea74f6b..20045d4a46fa 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -411,6 +411,8 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_=
device *nand)
 =09dev_dbg(snandc->dev, "ECC strength: %u bits per %u bytes\n",
 =09=09ecc_cfg->strength, ecc_cfg->step_size);
=20
+=09snandc->qspi->ecc =3D ecc_cfg;
+
 =09return 0;
=20
 err_free_ecc_cfg:
@@ -427,6 +429,7 @@ static void qcom_spi_ecc_cleanup_ctx_pipelined(struct n=
and_device *nand)
=20
 =09kfree(snandc->qspi->oob_buf);
 =09snandc->qspi->oob_buf =3D NULL;
+=09snandc->qspi->ecc =3D NULL;
 =09kfree(ecc_cfg);
 }
=20
--=20
2.55.0

