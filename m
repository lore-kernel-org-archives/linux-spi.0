Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC74A9D6C
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152290; cv=none; b=IJ8EJCZ07tqH8jo6RuQmltCYtdRDmIYoJZN/5F6x6BcQSWKzsmQ11faMCcSt8et+ZP4f5YlYoNAPVBr6krk2g9WHWj/j9LD+x3A9ei+eqs/uI8atviugYwG5BPfgU8HypTYXgzHitK6VK7TFYv/y3qdWRBbxaDN297OAfHyxHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152290; c=relaxed/simple;
	bh=evRXY1mk5e/9hRx/q9vBneumWgfTsFpYy53xJcSfcZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssWwuHPcJqb7hAjZnhdrU7wNBM5ST6TQg5Sdzva8GHVMMJc22SQBZKddjc+aeAao8kf+7/YMNaaJJOxeHlmZofdkpPE9GdfhFU8s3PdnJocCCz/MVR31d31z23pa6gPZ+aR94302zelPCfUHZwEwED1CAajhrobmoWCHl07thBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=JpgbrNCe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QjbhosZZ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="JpgbrNCe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QjbhosZZ"
DKIM-Signature: a=rsa-sha256; b=JpgbrNCeSQJBslh55Wk08xA5t9JT6G7+2iKRF09Hd+iX9MZVTpqU03GGjOf3OrwJV6rlRQIUYaO8r4y3ZboOj5FIK3CrPqA0ZQ4OWNOLmioH/tFi7jWQvw18vNJluwbW7kym1zyqImrRkf3SASnpVmdto/Elv//sjw8G6jtSSVz7TBvy7dg7OgvrFGdI83/kjg7+ROAlSgG6lRktRN19hPIyYLXzTjnTj/ZgkMj74P+IxSlZTpsvJaOToSLv6aRoRBSJ8Ki4Has1F3l2RV1t9897O+OXbFZESPF1w09sPrIa3yH/uqhHjqWlfF/8vOq9qlNzpgqrxCAJaGtcVzvrbw==; s=purelymail1; d=c127.dev; v=1; bh=evRXY1mk5e/9hRx/q9vBneumWgfTsFpYy53xJcSfcZs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=QjbhosZZiZABYiEvmMoAGwKXFzDrVx0xFKjSg7XEXUepn8k4P6d8vaPL5YpcYE96uGjPKyUO1TNqj4Z4i3vaS5jztnM94GbbyrcLeviMy0w6lPoSiBSktM6zgJlRCEF13qgeWKkr3ooO75Mqq0aqRwnq+gyHKhDyr3iC0GJSTdOV/5yYya7WcW8Jep19PlOOqnowEKTnVGDN9vW5U9hRzLU0aQ5lzrHcp5c30BAMpyW76L2L5ijpQTeVnhqtVcG8euzCIn7bJx03GAAiaO559Bjv9daCe19Zfjuq173t/3t3NaDi5ChQWC6E0K7Y+XWanUEWc4si6KRcodvt85Io9g==; s=purelymail1; d=purelymail.com; v=1; bh=evRXY1mk5e/9hRx/q9vBneumWgfTsFpYy53xJcSfcZs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: linux-spi@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -894114220;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 11 Sep 2026 18:44:24 +0000 (UTC)
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
Subject: [PATCH v2 2/2] spi: spi-qpic-snand: drop the redundant ECC context handling
Date: Fri, 11 Sep 2026 13:44:16 -0500
Message-ID: <20260911184416.109790-3-contact@c127.dev>
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

qcom_spi_ecc_init_ctx_pipelined() now publishes the ECC context to
snandc->qspi->ecc, so the assignment in
qcom_spi_ecc_prepare_io_req_pipelined() repeats what the pointer already
holds, and the zeroed struct qpic_ecc that qcom_spi_probe() allocates is
never read.

The pointer is non-NULL only between context creation and destruction,
and every reader runs inside that window. The ooblayout callbacks are
installed by init_ctx. The page read, write and program helpers run only
when prepare_io_req has set page_rw or oob_rw. qcom_spi_block_erase()
runs only while the mtd is registered, which happens after init_ctx and
ends before cleanup_ctx. The controller drives a single chip select, so
the per-controller pointer and the per-chip context cannot disagree.

Remove both. No functional change.

Suggested-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
Tested on a Mercusys MR80X (IPQ5018, ESMT F50D1G41LB) with both patches
backported to 6.18.44. Five boots, rootfs mounted every time, mtd
reported 0 ECC failures and 0 corrected bits, and a 4 MiB file on the
UBIFS overlay kept its sha256 across the reboots. Overlay churn raised
the UBI maximum erase counter from 13 to 15, so qcom_spi_block_erase()
ran repeatedly. Build-tested on this base with W=3D1 and sparse, no
warnings, patch 1 alone and both patches applied.

 drivers/spi/spi-qpic-snand.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 20045d4a46fa..760ee1c29402 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -437,9 +437,7 @@ static int qcom_spi_ecc_prepare_io_req_pipelined(struct=
 nand_device *nand,
 =09=09=09=09=09=09 struct nand_page_io_req *req)
 {
 =09struct qcom_nand_controller *snandc =3D nand_to_qcom_snand(nand);
-=09struct qpic_ecc *ecc_cfg =3D nand_to_ecc_ctx(nand);
=20
-=09snandc->qspi->ecc =3D ecc_cfg;
 =09snandc->qspi->raw_rw =3D false;
 =09snandc->qspi->oob_rw =3D false;
 =09snandc->qspi->page_rw =3D false;
@@ -1586,14 +1584,9 @@ static int qcom_spi_probe(struct platform_device *pd=
ev)
 =09struct spi_controller *ctlr;
 =09struct qcom_nand_controller *snandc;
 =09struct qpic_spi_nand *qspi;
-=09struct qpic_ecc *ecc;
 =09struct resource *res;
 =09int ret;
=20
-=09ecc =3D devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
-=09if (!ecc)
-=09=09return -ENOMEM;
-
 =09qspi =3D devm_kzalloc(dev, sizeof(*qspi), GFP_KERNEL);
 =09if (!qspi)
 =09=09return -ENOMEM;
@@ -1613,7 +1606,6 @@ static int qcom_spi_probe(struct platform_device *pde=
v)
 =09snandc->dev =3D dev;
 =09snandc->qspi =3D qspi;
 =09snandc->qspi->ctlr =3D ctlr;
-=09snandc->qspi->ecc =3D ecc;
=20
 =09snandc->props =3D of_device_get_match_data(dev);
 =09if (!snandc->props) {
--=20
2.55.0

