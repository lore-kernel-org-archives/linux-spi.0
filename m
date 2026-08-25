Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2421257F
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621965; cv=none; b=oE7/r/ldAobCXOvF3oYau3/LqlmN60ZahSlWX/3qhRnfCxPQmaWlmh1BsYQ3v288u5Yj9MVR9BSTTXJX3g9upysbuozAFHbkJMDGyWYFU58onIWuDYK77KAc9+Y0Tr43WmXWI1RviKl/kI5zi5zf0BmxIRdyKvis2PaAKK98FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621965; c=relaxed/simple;
	bh=S41ebfT7xo/qZtIIIBZyOORVT3DUlpSqNwSmIUKtTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mIHG9SxG2lbP8SGDkHI5LH5GnjVL3GLOxE0c5/W71VNjCi2JCYLuzIGDZhhvaP/zem89S5K2MxC5Zhwju31DjcYT2dxy78agftI3HoHjSHWQIfH5Sdz7sn5snqF3JP43X+wzkHGczJS6U7qhDuU6rKgvlP+/nrnbdUKNdQ3PGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=e01QFpG9; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LPJQDrx/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="e01QFpG9";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LPJQDrx/"
DKIM-Signature: a=rsa-sha256; b=e01QFpG9Gq3786qtZIww7tX6T1Ihw9j1szgJSJhkyyw2oFtXg7DTeSV7KNzgSTsdbhr3kPiVsgMZMRv9qbUrLsjoeRgEMmudMiXzYxKfZDn7yJcZAMpph+10eg16xHtEXAXnMWthmQfN9BV7ZBye6jLNJmpYkcjGQditZ2sz5xrlI41J6knNY/DHp7MsKbnjDjCzWMI5AljOOKghyBpkF/IpQXfzyoALqrOZduz+C8MU+RaMa2kVNRmoWiVYFCcXdHeAC3HA2us/G2WQLRBV7jdxnNp6C6p9X4dbNDcyegHYd895I5qg8VFtyZxLT/48C2Ieu2Sq4vlgeeBtyE2S9Q==; s=purelymail1; d=c127.dev; v=1; bh=S41ebfT7xo/qZtIIIBZyOORVT3DUlpSqNwSmIUKtTl0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=LPJQDrx/fajOg6CYdhAOYtztRZMC3ueqX9+tgZk1ZEbzKPbE0vJjjSLtgLUEwzbYbLasHIUGo+veK6dFFJhtTHhlc7hPxvXYRss2OkTIysm+iou2onk40qcpTXEaVKbVwWr699e4Tqw6jRWRfthWO1YOAmu1O+EUYFcWUEyu/BVGj5j3yzXDvbzh0UAP3qHCXxnnXy4zTW3rLeUOKMZbQLuIqobqHXsNnT3Gh8nkKaZ0SuGpGVD6XcdOSSDXPtI7QdKZnfGblpNDbqURBHu7LbHNCIdl44s3gyzTcxEiaZc+g0rQ7bhRTx/ai4Yf53NmF4YZuFwo4igsaytn5WlZ+w==; s=purelymail1; d=purelymail.com; v=1; bh=S41ebfT7xo/qZtIIIBZyOORVT3DUlpSqNwSmIUKtTl0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: linux-spi@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 936311042;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 25 Aug 2026 01:38:52 +0000 (UTC)
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
Subject: [PATCH] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
Date: Mon, 24 Aug 2026 20:38:48 -0500
Message-ID: <20260825013848.1056946-1-contact@c127.dev>
X-Mailer: git-send-email 2.55.0
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
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
Tested on a Mercusys MR80X (IPQ5018, ESMT F50D1G41LB) running 6.18.44
with the equivalent change; mainline build-tested with W=3D1, no warnings.

 drivers/spi/spi-qpic-snand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 61b1f2eb19ce..0d0ae93ad4bf 100644
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

