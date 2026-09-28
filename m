Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A113E3178
	for <linux-spi@vger.kernel.org>; Mon, 28 Sep 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574686; cv=none; b=Y4NeCcipvbOEQD9wkKpaxgDvFCFmWaehYAb65Qg2S+IYjGbaFH0W6RbiFRsVOvl0Kby9XIFKL81ZZN9j2JD7tmFZKQALHALTDrqdcplFhoSiG06pbBwmOyUdTmlGHKwRlhnHqpw7KYmWE/RirmZR4VNtsAb/w5Q8VgX/Kon5cuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574686; c=relaxed/simple;
	bh=hRlz6w3/VqfPNmsmwuYQe/GUMBab926L4DYFAD8ftGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6sgQSuPRq2/3z5NbSKT2B0NpyxfkPBgdknvMHgctc03RQg9WQxdWfDjbzhbxB+7dS4KoQWXafvMA9npaDevKaBArU6bNfE3aTbVWbU0JqkNIXZao0Nym9H7/ZbeFzDq05wQhpfrAKfzkaUHFyZDqzUmZtdSuagTkYGZ8v2dgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=maD3LBli; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="maD3LBli"
Received: from spam01.horizon.auto ([10.9.15.211])
	by spam01.horizon.auto with ESMTPS id 68S5oAf0090129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Mon, 28 Sep 2026 13:50:10 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by robotics002.hobot.cc
 (10.9.15.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Mon, 28 Sep
 2026 13:50:10 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: Fei Xie <fei.xie@horizon.auto>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND and NOR
Date: Mon, 28 Sep 2026 13:50:05 +0800
Message-ID: <20260928055005.3987624-1-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arOwdePAmoghlakj@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto> <arOwdePAmoghlakj@nsa>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To robotics002.hobot.cc
 (10.9.15.211)
X-DKIM-Results: [10.9.15.211]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 68S5oAf0090129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1790574614;
	bh=5Hoqqmkb0npLMGhnM+q6H7DxLsjwFU5C3AZVJPESqsk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=maD3LBlizP14NBSrWGWQr49QsMF7TzOayZW3CuQvoQoPJIXX6aJOJaQCfhuIDDexG
	 VpEPCAWFCaODxySYaohdtgCo/zGjD2db2gUp8CeBoFdZmGrwhuqh0ph2m0FgpVSkiM
	 Xjm/zJwqgBD3spfzjUsn8b2KC+9vWvs0+2G5vgKxTZwHSNknteSXEWu3OLnHUUZRzk
	 9xCvI4qZ+PoZgJRUuD3Mw73ZY9GbMfZndeLPgI/ot3GHYJYI7OWElhBe1PUyXeviMH
	 I6BzpmVKDhaxXGC2Ej3apvknmV1idV8tQFtZkjhGq0iD1xW0vdI4VqTPjGCXCj5sqQ
	 CqgFgcANhhaDQ==

Hi Nuno, Miquel,

Thanks for asking for benchmarks. I backported the 32/64-bit STIG SDMA
transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
kernel, and compared that STIG path against the ACMD SPI NAND path from
this RFC. I have not applied Nuno's separate ACMD read implementation;
the figures below are for the implementation in this RFC.

The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB eraseblocks)
on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both paths
used the same board PHY configuration. STIG needed one additional dummy
clock for the EBh read-cache command on this board to return correct
data at 80 MHz. This is a local test adjustment, not part of the posted
RFC or [1]; I excluded the incorrect STIG reads from the comparison.

I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
numbers below are the arithmetic means, in KiB/s:

                               STIG      ACMD PIO
  eraseblock write speed      3685          3555
  eraseblock read speed      12468         14222
  page write speed            3671          3510
  page read speed            11931         13716
  erase speed                40000         37647

For a separate sequential-read test, I erased and programmed the first
64 MiB with known random data, then checked that each mode read back
the complete area byte-for-byte. Both SHA-256 hashes matched the source;
the reported ECC failure counts were zero. I then ran:

  /var/busybox/time -f 'real=%e user=%U sys=%S cpu=%P' \
    dd if=/dev/mtd18 of=/dev/null bs=1M count=64

                          STIG              ACMD PIO
  elapsed (three runs)    5.30/5.28/5.26 s  4.66/4.65/4.65 s
  mean throughput         12.12 MiB/s       13.75 MiB/s
  mean system time        3.55 s            1.06 s
  process CPU usage       67%               22%

On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
and reduces the reading process's CPU usage by 45 percentage points.
The flash_speed results show a similar gain for reads, including
single-page reads. I do not see a program or erase throughput benefit:
ACMD is slightly slower for both in this setup. These are SPI NAND
results only; I have not benchmarked the NOR path on this board.

This is hardware validation of a 6.1 backport, not a claim that the RFC
was tested on a current upstream kernel. I agree the read and CPU gains
need to be weighed against the controller/MTD layering concerns raised
in review.

Thanks,
Fei

[1] https://lore.kernel.org/linux-spi/178056886874.53724.4850286391745939707.b4-ty@b4/
