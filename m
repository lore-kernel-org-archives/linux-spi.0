Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C747044C;
	Mon, 21 Sep 2026 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986503; cv=none; b=CcQNLvsP1RRVall/i2F5+sYeykwzj1kRNZZkSTuq0B8e0x4FFOZnrkincBeu+hZ5p8ZWAZfjKWegXGPMuwFsg7ediPs4MgsoWqNO/Q40zs4YbMLqYyiyX4DpDMwxiT2cFu/7wkmT+gE+LU3CAgURp6ux+pRl+c0bTkS3YJC1f0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986503; c=relaxed/simple;
	bh=x3k+pzaCNsieQ673T7+7STlat7Yf8FLqkUE3cXkzw3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXYpMgT8UN1FHGx7gAcbvN7ZK3yQW8r/iSR6FUXUfbrwZf+wJPlYWaK4EDa8sFpkjuI4AZAmBcgAdOWE1jHcerstHHg1hO8W3vOBlDvTaFhyfsQm8qpJUfQOXGslU3v8/nJPPtJn5zbeUDRVIigW5YZPmTLi9DOdbG+Gtf3PQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=fail (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=e0z544Mg reason="signature verification failed"; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="e0z544Mg"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 68L9csOS069413;
	Mon, 21 Sep 2026 17:38:54 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto (exchange003.hobot.cc [10.69.1.10])
	by spam01.horizon.auto with ESMTPS id 68L9c0VA068799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Mon, 21 Sep 2026 17:38:00 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange003.hobot.cc
 (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Mon, 21 Sep 2026
 17:37:59 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "fei.xie"
	<fei.xie@horizon.auto>
Subject: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND and NOR
Date: Mon, 21 Sep 2026 17:36:57 +0800
Message-ID: <20260921093701.1341766-1-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange003.hobot.cc
 (10.69.1.10)
X-DKIM-Results: exchange003.hobot.cc; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 68L9csOS069413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1789983483;
	bh=39e/HaE+D1BgE7Sx1CzFyI167JKdJLF6ONVfYDIzyB0=;
	h=From:To:CC:Subject:Date;
	b=e0z544Mguqjn1CSH378BSFBllK//9QHBMTtJ6WjzgzaKF661dmxW055UnoS60SvvS
	 BBiCUW89R0U0z4FuwcbEtF/DKfEw4O6hTD6QqVlGJGzKvx/o8FuZNUTeMhq+EKM7G0
	 VhtAsjBwOwM1p2dxRvdtrBcQ2JpV/Ml6E7DM0u+mcytOqJJd+9P5c8ymuEvD71MLBq
	 yzN6uh0ehuZIth8wAcJIDeWEdmF35l8j/o3B/qmNJ5e8iJrixyf2JQVJJMkb/UEIVf
	 Amq8wFK4DurjPGOk98sENEIRAi2wVRINflENWFePzzYCp0SQrs+HP6WteKnxHplxq/
	 G571W9F855GzQ==

From: "fei.xie" <fei.xie@horizon.auto>

The Cadence XSPI controller provides an automatic command (ACMD) engine.
It can execute complete flash transactions, including command sequences,
device-ready polling and master-DMA data transfers.  Software submits a PIO
command containing the flash address, DMA address and transfer length.

For SPI NAND, for example, a read transaction combines PAGE READ, status
polling and READ CACHE in hardware.  Program and erase transactions also
combine write enable, data or erase commands, and status polling.  This
avoids submitting each command separately through STIG mode.

This RFC contains a working controller-local implementation for both SPI
NAND and SPI NOR.  Unsupported operations continue to use STIG mode.

There is an important layering issue in this implementation.  In order to
program the hardware sequences, the controller driver obtains upper-layer
driver data and directly uses struct spinand_device or struct spi_nor.  It
also keeps state across individual spi_mem_exec_op() calls in order to
recognize a complete NAND transaction.  We do not consider either property
desirable for a final implementation.

The hardware nevertheless needs information which is not available in one
spi_mem_op.  A NAND read is represented by separate PAGE READ, status-poll
and READ CACHE operations, while the ACMD engine needs all three before the
transaction is started.  NAND geometry is also needed to translate row and
column addresses for the ACMD address space.

We would appreciate guidance on the preferred interface boundary:

  1. Is a controller-local implementation acceptable because these command
     sequences are specific to the Cadence ACMD engine?

  2. Should SPI mem instead provide an interface for submitting an ordered
     group of operations, including status-poll semantics, with SPI NAND
     and SPI NOR constructing the group and the controller translating it
     into hardware sequences?

  3. If the latter is preferred, should NAND geometry be supplied through
     the sequence interface, or should it be exposed to controllers
     separately?

We have prototyped the second approach locally by adding sequence callbacks
to drivers/spi/spi-mem.c and constructing the NAND transactions in
drivers/mtd/nand/spi/core.c.  It removes the controller dependency on MTD
private structures, but the initial version duplicated page/OOB preparation
and made the generic sequence interface carry NAND-specific geometry.  That
prototype is therefore not included here; we would first like agreement on
the interface.

Performance
===========

The SPI NAND path was tested on a Horizon Robotics J6B platform with a
GigaDevice GD5F4GM8RE device.  A vendor Linux 6.1 backport of the same ACMD
implementation was used for the hardware tests.

Under the same 80 MHz transfer configuration, the sequential-read results
are:

  STIG using readq:  8.24 MB/s (7.86 MiB/s)
  ACMD PIO + MDMA:  10.08 MB/s (9.61 MiB/s), about 22% higher
  STIG read CPU:    59.74% / 40.87%
  ACMD read CPU:    approximately 16%

Using the lower STIG CPU figure for a conservative comparison, ACMD reduced
read CPU usage by 24.87 percentage points, or approximately 61% relative.

The CPU reduction comes from moving device-ready polling and command
sequencing into the controller.  Software no longer needs to submit and
wait for each STIG command while a page is being transferred.

The ACMD program path averaged 2.94 MiB/s over ten 128 KiB writes,
excluding erase time.  A 128 KiB random-data erase/program/read test
produced identical SHA-256 hashes and byte-for-byte comparison.  Read,
program and erase were also traced to confirm that the ACMD path was used.

The mainline series has been compile-tested for arm64.  The SPI NAND
hardware tests were performed with the Linux 6.1 backport because the test
platform currently runs the vendor 6.1 kernel.  SPI NOR has been
compile-tested but has not yet been tested on hardware.

This series is intended to start the API and layering discussion rather
than to propose the current upper-layer coupling as the final design.

fei.xie (4):
  dt-bindings: spi: cdns,xspi: add SPI NAND compatible
  spi: cadence-xspi: add ACMD support for SPI NAND
  spi: cadence-xspi: factor out reusable ACMD helpers
  spi: cadence-xspi: add ACMD support for SPI NOR

 .../devicetree/bindings/spi/cdns,xspi.yaml    |    3 +-
 drivers/spi/spi-cadence-xspi.c                | 1259 ++++++++++++++++-
 2 files changed, 1260 insertions(+), 2 deletions(-)

-- 
2.34.1
