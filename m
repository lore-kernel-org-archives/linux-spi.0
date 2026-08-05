Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8D46D554;
	Wed,  5 Aug 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942935; cv=none; b=lWs2DW2Eeh4SvYyJP4nRHZU31WjZ91sydBBuftel7tpzGSYeBBUDlRrGPShH+1wCoTaCfx3qg9Az/XufqJo8KAfepqwVBCz8QJVAMpE/6ce9EScKr1IifXzYqmEfOgGZdTnP9oTPGn8xVM/KmTuO9YI6pwHe8w1l8tnMLC1YBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942935; c=relaxed/simple;
	bh=lBqh7Q7tCR32zdoJbq4nH7WQoUNmx4LJ7FiBHZcSctI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4FMxNkxwqGw6AK3RvpjMm5qIGKWEc66qdUOSQ6QpDNkTKUMGvVGM/DAfCdUUpUxT5WczcxQwCg9uiXC0qbDAwW9vTLC5ZuMU4yCzVaLHZi7QyyxxTitl5XZ0G3HxlM3WNxPNTcDyv9Iw5h+sS+KEuRqrundcBrL/9CFNidLUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bU1hwoGI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bU1hwoGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A/
	eL8vaJLROkUGuFGpEkzqGVSCkE3NlsX8c5nRfPXfw=; b=bU1hwoGIO0MBB+fSaz
	94gvQefnyXbppk506w3DgZd45ErWV4FqjdwFv0kJb+obHGIavw2/ttkrSciVZvv2
	Ar12YOk3ZulKuwUlxBv6G8uJPCxdZo9lgU82DwLel9T9oWHZ7NCVe9R5cd0i0AH5
	GLoZXN/UXvdjeKpP6hqjOxTDU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H31xU3Nq02g5AA--.30422S2;
	Wed, 05 Aug 2026 23:14:59 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: broonie@kernel.org
Cc: andy@kernel.org,
	andriy.shevchenko@linux.intel.com,
	fancer.lancer@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH 0/2] spi: Fix DMA mapping ownership on partial map failure
Date: Wed,  5 Aug 2026 23:14:54 +0800
Message-ID: <20260805151456.756579-1-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H31xU3Nq02g5AA--.30422S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW8tFyUArW8uw4UWFWkCrg_yoW8AFy5pF
	Z8tFWYkr4DXFyay3ZxA3yj9F13Gr93GryYyr13KwnrZFyqgFyYyFW0ka4UXay7GFn7Ja1j
	yrZYkr1DGryjka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC9RNoqGpzU3M4RQAA3i

__spi_map_msg() can fail after mapping only part of a message.  The
normal cleanup path may then act on stale mapped flags using a NULL or
stale DMA device, causing a NULL dereference or an extra unmap.

The core DMA mapping path is used by 28 in-tree SPI controllers.  The
bug remains reachable until a controller completes its first DMA-mapped
message, since cur_{tx,rx}_dma_dev are only set on success.  can_dma()
length checks may postpone that point well beyond probe.  A two-transfer
message with a mapped command followed by an unmappable static payload
reproduces the failure without memory pressure.

Patch 1 publishes the mapping devices before mapping starts and uses a
common unwind path for all failures.  Patch 2 adds KUnit coverage for
partial TX and RX mapping failures, successful map/unmap, and messages
which require no mapping.

Tested on v7.2-rc6 under x86_64 QEMU with KASAN.  All three cases that
previously oopsed complete cleanly after the fix, and the RX-only case
no longer issues an empty unmap.  DMA map/unmap counts changed from
3/4, 2/3 and 5/6 to 3/3, 2/2 and 5/5.

Two of the four KUnit cases fail without patch 1; all four pass with it.
Patch 1 also builds independently with x86_64_defconfig plus SPI.

Honghui Jiang (2):
  spi: Fix DMA mapping ownership on partial map failure
  spi: Add KUnit coverage for DMA mapping error paths

 drivers/spi/.kunitconfig      |   4 +
 drivers/spi/Kconfig           |  11 ++
 drivers/spi/spi.c             |  37 +++--
 drivers/spi/tests/spi_kunit.c | 301 ++++++++++++++++++++++++++++++++++
 4 files changed, 338 insertions(+), 15 deletions(-)
 create mode 100644 drivers/spi/.kunitconfig
 create mode 100644 drivers/spi/tests/spi_kunit.c


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0

