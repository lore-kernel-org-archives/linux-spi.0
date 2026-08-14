Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68335B653;
	Fri, 14 Aug 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677323; cv=none; b=YBB0e9yMnERunkxFqrYphd3V5RjoBWMIxE1Py3J+gLbhhUp0kjfW0PzqnYg9Kof6K/oRpCkACJtr+nxHn6oZGU3hMCWXTkldRkGN6QuoD3PICXzbp7QbOvBNJjnQdJSOePQqucMqzuZ0HrRELXCwIvGRsBUAa0jaR1rxZ0XyIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677323; c=relaxed/simple;
	bh=gWThIDBVyEYfI9BDRKgyc4jsvTmKZn0rdRcSWGY4hjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVogE3vnU/Em7LtD7l5HihxSrksAHB13MzA+LT7sB3y59pEaytQ93hzwFRDb+K3XhQYl662VrDqbm+zIwO4FHgy/18MxAquDG2DeTLyBswaqAG6FqsH9V21XAQHYFbRiv5l6Q+qITl33tIR/ftA110QlyOIitG7addiH1Tpf4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=icnOeDOv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="icnOeDOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=g9
	2iRPm4t4H3lR1nmjMTqTGtYWJQLd8q7qJQRvtvLM0=; b=icnOeDOv6LR6BaabEd
	E0EX0ajqHQU+WYuzU1+kIlU1ZNozhIMMGfFOxUf6SJ8up7NtwWioZ2nDOZ5IHMld
	Agd5FjL1X8e88bmWcIn0ilFZ6zT67jtSJG9ZliKGHUNMg5u8tLQ+H5yeL+6GvU8l
	YlY7+rxpiM0bRKSZz3izFzt3g=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXHwwLiH5qPvvhMw--.15918S2;
	Fri, 14 Aug 2026 11:14:19 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH v2 0/4] spi: Fix DMA mapping ownership on partial map failure
Date: Fri, 14 Aug 2026 11:14:14 +0800
Message-ID: <20260814031419.43378-1-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXHwwLiH5qPvvhMw--.15918S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr43CFWUZrW8KF18CFWrGrg_yoW5tw4xpF
	ZYqFyYkanrWFW2yw4xu3yj9r1fCrZ3GrW5Ary7t3sFvr4DuFyYyFW0ya4UXFW3GFs5Ja40
	vrWF9F1kWw1jkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE5l1JUUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC1A5fn2p+iA7StgAA3s

A partial DMA mapping failure can leave per-transfer mapping flags set
while cur_{tx,rx}_dma_dev are NULL or still refer to the devices used
for an earlier message. The subsequent cleanup may then unmap a
transfer with a NULL or stale device.

Before commit e289df82344f ("spi: Rework per message DMA mapped flag to
be per transfer"), partial-failure handling was already incomplete, but
__spi_unmap_msg() was gated by cur_msg_mapped, which was set only after
the whole message mapped successfully. Earlier mappings could leak, but
cleanup could not unmap them with an unpublished device. The
per-transfer conversion removed that gate: mapping flags can now remain
set while cur_{tx,rx}_dma_dev are still unpublished, turning the leak
into a NULL- or stale-device unmap regression.

Patch 1 publishes the mapping devices before the loop and unwinds every
failure through __spi_unmap_msg(). It keeps the forward declaration so
it is independently buildable and straightforward to backport. Patch 2
then removes the declaration by moving __spi_unmap_msg() above
__spi_map_msg(). Patch 3 clears the current DMA device pointers once the
message has been unmapped, while leaving them intact during partial-map
unwind and DMA-to-PIO fallback. Patch 4 adds the DMA mapping KUnit suite
as a separate translation unit.

Only patch 1 is a stable candidate; patches 2 through 4 are follow-up
cleanup and test changes for mainline.

Testing:

- Patch 1 builds independently with the x86_64 reproducer configuration.
- The spi_dma KUnit suite passes all four cases on x86_64 and UML.
  Moving the DMA device assignments back after the mapping loop makes
  both failure-path cases fail.
- The default and all-tests KUnit configurations both select the suite.
- All four reproducer cases complete without an oops when run as the
  first message, and map/unmap counts are balanced after a successful
  first message.
- After message cleanup, cur_{tx,rx}_dma_dev are NULL.

Changes in v2:

- Explain why e289df82344f changed the partial-failure mode.
- Use plain if (ret) checks in the mapping loop.
- Add separate follow-up patches for the helper relocation and clearing
  stale DMA device pointers.
- Build the KUnit tests as a separate translation unit through the local
  internal header and <kunit/visibility.h>.
- Rename the Kconfig symbol and suite namespace for the DMA subsuite,
  and rename the test file to spi-dma-kunit.c.
- Enable SPI in the default and all-tests KUnit configurations.

v1: https://lore.kernel.org/r/20260805151456.756579-1-jiang_hh2019@163.com

Honghui Jiang (4):
  spi: Fix DMA mapping ownership on partial map failure
  spi: Move __spi_unmap_msg() before __spi_map_msg()
  spi: Clear current DMA devices when unmapping a message
  spi: Add KUnit coverage for DMA mapping error paths

 drivers/spi/.kunitconfig                     |   4 +
 drivers/spi/Kconfig                          |  13 +
 drivers/spi/Makefile                         |   1 +
 drivers/spi/internals.h                      |   9 +-
 drivers/spi/spi.c                            |  91 ++++---
 drivers/spi/tests/Makefile                   |   3 +
 drivers/spi/tests/spi-dma-kunit.c            | 259 +++++++++++++++++++
 tools/testing/kunit/configs/all_tests.config |   1 +
 tools/testing/kunit/configs/default.config   |   1 +
 9 files changed, 340 insertions(+), 42 deletions(-)
 create mode 100644 drivers/spi/.kunitconfig
 create mode 100644 drivers/spi/tests/Makefile
 create mode 100644 drivers/spi/tests/spi-dma-kunit.c


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0


