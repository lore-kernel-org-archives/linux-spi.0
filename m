Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115411;
	b=0UQ23jirRFJ0f3vO8IZU1ddeNK+5e2uFPmLVxL5Tmli+nYzraKOWL9HnP06A8naHqf39
	 jQoWa2BOlcq3ZDxSjbrCKrTpORDph74cgS+b+d+JLS9MCfUJGRix/2JYE1MQhBRTHTMzE
	 hoLojUsfbyveqeOeKuOhNICrz4k/EyHeWaXtjJremST3fNFzIilYdL7PZU75lCuLSAq0G
	 eAR4LoEl9wfxpsPw2RcYSp4BdIOoKkb+CP2TbSyGL3ZMGWvSr/IKQr2/Jd/o3ll02/I+U
	 xHSeWkCYnIqwPo54c4Fncj/McRCIHDRZUPzCrf8rayPVQYcmynegw7LjXSs3fZMEtmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OOGm/OGnweTp3p/0hw4L1KLssC6V4d42QGR03NLyNdc=;
	b=pQhTM2uFOgoimVZcHRso6hX60eJBuSKsrFG/JR77/DZTod9cMZWXwHbY5/7RTMDtIJAg
	 RPZI1gB1czjk2o4rLYUiUS+rst/9izFtOj0gNzH6/gV3NFI6yuPP3T2umnY4FNqZbqf/J
	 HafFVgPN4xljLxrhpTw5z0XyPdYB7xnGaHXNbLGvfBGs6gjRWurePrlVR5yjJe2psQXM7
	 xrmrtewyjU5LEFZ62RsSuYdj5oyDbxzHm8QliAiwALpK0QNPleAT2fyh8r32JI54HD459
	 sud7TXlhdLC+HIXY2WPT0OH3WzMg5Pb/2OLlFQgL1J5RYI/pEWXTwNGFS3C5di6Lrww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMYFG6hC;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D360A2601
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 19:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331D360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMYFG6hC
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2efd824d492so352215ad.1
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115407; x=1795720207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OOGm/OGnweTp3p/0hw4L1KLssC6V4d42QGR03NLyNdc=;
        b=KMYFG6hCXxcv3H1qA1fSN/GimvRZ0tx9zkvoq/gqoluox3ngg3aswbpMA17sSI2oMr
         mtjkn1JfsDugeQ8C+8/wm5xYfSYiLeJaM+D7ICKFr6Ks88jrPOoZ0CHVTecOD8ZRqvp6
         ynV/fUnPM1+j3VItZnXfaL0Guc2AGkWy+t6xulBncAYvq2ZpCx4ua4QLK7Kk8DpAxFH1
         PwVv3zdglzZbn0zXVRp6TNCoaYGdS9V1aLAn2y5fWrrVTnlQcMYwzNVhdsRWRQrQyFo+
         oi1ioDbw9aqaUdqPiPABNToba/h5p2uWHddu8HtaHDgN8f3e8Uml87B5eGuIwznK8Qzj
         wO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115407; x=1795720207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOGm/OGnweTp3p/0hw4L1KLssC6V4d42QGR03NLyNdc=;
        b=qrX2zBZsSl6JXLhxNE/qvCn+lk1pf/YNbWBGUsvybdUpe9XuTfnn80gEaL1BhgM6QT
         jakyduzGqZROcoGMXwqIiigMv+i4GaoZQtX6d9s8maPrpIi4PmY5Y6+2wbbtrMF6mEPd
         bEB6PdnpTwWjtDE7ztiIzI/dnEN9JP5lvtYdAY3USYOJNdIVx6VwC9nl2Ij2I+fY/D0z
         qtJVrSQs8QuzWhzOtyGVSUIslOOyYQd3BbLddpbPD8DVW6UwCNU6HzV1HVQ6HLKT98oM
         ywswKDFsH2Ng27MzU0EnI436MRvtOmLOIDuawOquRORS/aC7GUNoNOPthNVdBDL7Iz/T
         uf6w==
X-Gm-Message-State: APuU4Z90mRGMVNsVuPGt2rEr1KPCdHvgW9/i7WfVNzhdnAJ/tJTGRqWe
	fAe33OWDn5fLzjtowO1shZ6swPFHqHn8zVjLJhSURZzHCh6Hafq/tP1D
X-Gm-Gg: AZFdTZea+/PnehmdcDQBUa4P/LAIkzxRlZcBNwh6rWaUEuKjz2v/tmqUtGJZMOYC6x7
	QApOylI/jZEOdEvG3gZm9r9AbvZAa4IHHCgb/7taDPuVDkWf3RKiVLetK+Hxyf7trDwwATt6JVy
	7aatSLT+EdNbwqdxAAl/IFTgKQe43lvWbs6L0bC1A0vLY9LacOBbbHeM8mjAFaxaObhDFoipLP1
	yIBdSv4/Jh92nfCufUhISi3ih8uPOOZPuWRxOS/TbBcEpz4KWhgHwvMi00P424p7x1fD+v6rMUL
	4c7BdtSgFyHfaHp+rzYP0GsKLtTo/qzHbzsk8FNSDUutAezS2y8EbHSMXRzmxe2i/x46sMIOKgN
	8V92ND/aVYZnHNJCdIIA59cMeWB1mVeUXz52EXLlHoLtjVZ2wOYniTzxUC5hCXyQpXs4YC4GrP7
	c1yroEVX5ztWA6//xztG+N6w92VB0lkBp/XuCcjy/QmnvrDW1bdL3C4oi3UvaT5sNqO5s1s3+JC
	TvDZ52UVcYLvKO0f3qTmovC6lo2i3kpSy1LVAsB5As2rs93y4Qby/AVFxOARVGYknbZ8AIKappK
	kEU6oq7+CM/Ni9UyQ7pOWejSoIm8sQo4iAyOf98I99CAMjVrXYE8pwDTAYZ/VcJWEadfhSZXOI+
	yoPhqCOXTLe9PMYGQBHSGl9RMp2Qbx+7/HDZP9rkzKxryTRygOhj80qiLZXa1UCprd6NCqapOq0
	Ucb0JLTdNvZLfG2JaOnq4T3Cv3N46v+yePWaDQqaAQtAlGsb9bvq7JRt/9eUKmFOPXrw==
X-Received: by 2002:a17:90b:4ec4:b0:3b3:bf8f:9ccb with SMTP id 98e67ed59e1d1-3b41c8ffa94mr291505a91.18.1795115407479;
        Thu, 19 Nov 2026 11:10:07 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm3678174a91.6.2026.11.19.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:10:07 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v3 0/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Thu, 19 Nov 2026 19:09:59 +0000
Message-ID: <20261119191001.878454-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph CT Chan <josephctchan@google.com>

Hi Mark,

When a transfer fails in ti_qspi_start_transfer_one(), for example on a
write completion timeout, the driver returns without finalizing the
message and without writing QSPI_INVAL to end the frame. A queued
caller then waits forever, and a spi_sync() that took the no-queue path
gets -EINPROGRESS instead of the error (with the message's optimize
state left unreleased). Patch 1 sends the error through the existing
exit path, which ends the frame, sets the status, and finalizes the
message.

Patch 2 adds a KUnit test that emulates the controller registers with
logic_iomem on ARCH=um and calls kunit_skip() on configurations without
CONFIG_INDIRECT_IOMEM or with CONFIG_HAVE_CLK enabled. The test is not
added to drivers/spi/.kunitconfig because building SPI_TI_QSPI on UML or
x86_64 requires CONFIG_COMPILE_TEST=y, which would change many unrelated
options for every SPI KUnit run. Run it with:

  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/spi \
          --kconfig_add CONFIG_COMPILE_TEST=y \
          --kconfig_add CONFIG_SPI_TI_QSPI=y \
          --kconfig_add CONFIG_SPI_TI_QSPI_KUNIT_TEST=y

Tested with KUnit:
- (a) Plain ARCH=um (./tools/testing/kunit/kunit.py run --kunitconfig=drivers/spi):
  11/11 passed (spi_ti_qspi not enabled).
- (b) ARCH=um with the --kconfig_add options, patch 2 only:
  11 passed, 1 failed (ti_qspi_test fails on all three checks).
- (c) ARCH=um with the --kconfig_add options, both patches:
  12/12 passed.
- (d) x86_64 with the --kconfig_add options: 11 passed, 1 skipped
  (ti_qspi_test skipped with reason); plain x86_64: 11/11 passed.
- W=1 builds of drivers/spi/ on ARCH=um and x86_64: 0 warnings.
- Not tested on hardware.

Changes in v3:
- Rebased on spi/for-7.5 now that the SPI core series is applied there.
- Patch 1: fixed the commit message to state that the old code returns
  -EINVAL directly rather than ret.
- Patch 2: dropped the drivers/spi/Makefile change (already includes
  tests/) and left drivers/spi/.kunitconfig unmodified because enabling
  CONFIG_COMPILE_TEST=y in it would alter many unrelated options for
  every SPI KUnit run (pass the three options via --kconfig_add); moved
  logic_iomem checks out of Kconfig depends and skipped via kunit_skip()
  when !INDIRECT_IOMEM || HAVE_CLK; removed the stale
  pm_runtime_get_noresume() calls (ti_qspi_remove() no longer calls
  pm_runtime_put_sync() after commit 8b8678d3e894); reduced the test to
  one fast KUNIT_CASE checking spi_sync() == -ETIMEDOUT, !msg.optimized,
  and QSPI_INVAL (removed the async, recovery, and tautological m->status
  checks and the optional second MEM resource).

Changes in v2:
- Split out of the v1 14-patch series, as David suggested.
- Patch 2: trimmed the comments in the test.
- Moved the AI assistance note from an Assisted-by tag into the commit
  message.

v2: https://lore.kernel.org/linux-spi/20261103225116.3624270-1-jctchan@gmail.com/
v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

Please consider this patch series for the next merge window.

Thanks,
Joseph

Joseph CT Chan (2):
  spi: spi-ti-qspi: finalize message on transfer error
  spi: spi-ti-qspi: add a KUnit test for transfer error finalization

 drivers/spi/Kconfig                   |  12 ++
 drivers/spi/spi-ti-qspi.c             |   4 +-
 drivers/spi/tests/Makefile            |   1 +
 drivers/spi/tests/spi-ti-qspi-kunit.c | 172 ++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100644 drivers/spi/tests/spi-ti-qspi-kunit.c


base-commit: 0877b0b54a4c186ea9acca25ae79efd8516176ba
-- 
2.56.0.679.gc527c65306-goog
