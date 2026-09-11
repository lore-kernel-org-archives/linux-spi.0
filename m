Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835E4BB29F
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152288; cv=none; b=ktjgDWPbnH06+Fw7kGst+ajFV5S+RQ+/3/Q1PtFUtDhZW7ft1reSlysEny2vopvP00B2dVNc5GIpqwErkamB6Phrlu6NPzfDlWQA853Y5LyZynoyuujgyCXBRlIEPjoq8Q3XqNHiligHxlxLFKekt+BtPMCrBslbJDawgMxKR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152288; c=relaxed/simple;
	bh=bJUwiUIJZTg2xrplNNc6KqeDU7Cp83zq+iS/Qhrji1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uD+2OIQaVrKTDHQ8L62PgctUATuKrT0W7adqGC7YuvsYWJx9M4Okg5rgikqArm3N0j4cUBKPoBlMXmc6Ij6W0nk2LotcsOEcF6Lyy3mnUTndD8ZVwJJfhpHgCg+G1H5HHgH91AMyw+7bdtrqQnOn/lOh4dxapYr1NUnoWhjBPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=duTQ74Yj; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=U1AVAIUx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="duTQ74Yj";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="U1AVAIUx"
DKIM-Signature: a=rsa-sha256; b=duTQ74YjWQQZ+u4oM2wsuLy3Vx8sfSV5pihsXaM2Bb/z5AzRTKJMUl6SXzstBlkS9PR6DX9xvYiOcyx7aqFrJiBPIqZNVoIUltuQgfaMyHiKFQkJxzZyne8b3EcZku2wlMJ0ht3D/KwfexpYNXALt800xf0MzO+fY8XNVVIXiUbT+/YlG8QaNvHM0flQhgy7XBDJMQeBi3yC6rd60ZjPAxTkM1j+Vi4EYc7JCyRP0Jp41iq3oja0RKAvXzF7o6bE723b7MFdgL6ZIX+MDhsdmWcrDOSUTI3RbzNgw8DybZwcaJm9M+MGSRDWS0yrxPQbjdLc1n/pG6KF1nez5oRu4g==; s=purelymail1; d=c127.dev; v=1; bh=bJUwiUIJZTg2xrplNNc6KqeDU7Cp83zq+iS/Qhrji1E=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=U1AVAIUx67SC8KPYWPwkeNFInTUOE/s5Juv0+KIWw1L/OP+3lu5lySYOSC8831n3RXM3Y3tDIt3xOnxjMD6aNWOOKz/JIMrl5LRPCuSOPOP3EFZ24AzSV27Kw1RA4Un4AMYX3qM/BVUL5CpIzq7o5X30Y53prr7Mm9iHCcvgv2NXSyYFJe1U9F0bh/SD0mhFwsW7iCfPiGf4Z+yJqw/er4cs2GW6Yv2oxDYzwnxT11FQppDlvlqOf4Wsk17rK9xryYPELKsUvIUlWKrFOOjIVFMjZlVHvi0VjDWw7JpIpVxOzUTMwQypNnMOrP78yU37jgTToNoJUs4d1g1j5rvl4A==; s=purelymail1; d=purelymail.com; v=1; bh=bJUwiUIJZTg2xrplNNc6KqeDU7Cp83zq+iS/Qhrji1E=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: linux-spi@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 51783469;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 11 Sep 2026 18:44:20 +0000 (UTC)
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
Subject: [PATCH v2 0/2] spi: spi-qpic-snand: fix the stale ECC context pointer
Date: Fri, 11 Sep 2026 13:44:14 -0500
Message-ID: <20260911184416.109790-1-contact@c127.dev>
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

qcom_spi_ecc_init_ctx_pipelined() installs the ooblayout but never
publishes the ECC context it allocates, so qcom_spi_ooblayout_ecc() and
qcom_spi_ooblayout_free() run against a pointer that describes something
else - a zeroed struct on a first probe, the previous attempt's freed
context on a retry. On IPQ5018 the qcom,smem-part parser makes that retry
routine, and like half the boots on a Mercusys MR80X failed to mount the
rootfs.

Patch 1 is the fix and is unchanged from v1. Patch 2 removes what becomes
redundant once the context is published. It is a cleanup with no
functional change, so it carries no Fixes: tag and is not marked for
stable.

Patch 1 was applied to mtd/fixes as 93bc7c4d2f41 on 2026-09-04 and
dropped the same day, so nothing from this series is queued.

v1: https://lore.kernel.org/all/20260825013848.1056946-1-contact@c127.dev/

Changes in v2:
 - Add Gabor Juhos' Tested-by to patch 1.
 - Add patch 2, dropping the now redundant assignment in
   qcom_spi_ecc_prepare_io_req_pipelined() and the unused zeroed
   struct qpic_ecc allocated in qcom_spi_probe(). Suggested by Gabor
   Juhos, kept separate so the stable backport stays minimal.
 - Rebase onto spi/for-next, which carries commit 44d39535cd4f ("spi:
   spi-qpic-snand: remove interim 'dev_data' variable from
   qcom_spi_probe()") touching the same probe lines as patch 2.

Both patches build with W=3D1 and sparse without warnings, and each patch
builds on its own.

Johan Alvarado (2):
  spi: spi-qpic-snand: publish the ECC context to snandc->qspi
  spi: spi-qpic-snand: drop the redundant ECC context handling

 drivers/spi/spi-qpic-snand.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)


base-commit: 98100d83adc8e17606605d131e685b1fbedfe092
--=20
2.55.0

