Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FD1CAA6D
	for <linux-spi@vger.kernel.org>; Sun,  4 Oct 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124689; cv=none; b=ZULghajXXJJky2qQ12e7IvTEIPRV9H8ax2WT7KVQUwcFsWyILa+NYzneH/ICInphmebK5qJYNJ/m6WsQ7iNpEklJHaur/9DX9expV/J085QAa+7ZG8KHYNYUWGNolJJ6V4jiUBnkOwIk+OblwGy+RZaj8rBe32hlomfXfdqZrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124689; c=relaxed/simple;
	bh=gWrLRD7rS/BYWAF/ov3E2y05f2PSszqoyhfJCicIzhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/d+c6mKPUltH1vZFVpv+LYAXiPLglOkLa/me0rQjqm/VdHWsu5uM7cCu+XZdoY9VVmXVJ0Da4XUL82Z/1GkLHeDmVatvgdMCyfAIhnwxdfpRrgtTHzziB0T0IJIiTFo7hvoqRWz/B3WyHp0lzDwwpHWCpWRH/No/+86N0hoCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JZM+rjRO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JZM+rjRO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ED87C1A1129;
	Sun,  4 Oct 2026 14:38:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5402604FE;
	Sun,  4 Oct 2026 14:38:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75E021032817F;
	Sun,  4 Oct 2026 16:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791124682; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gWGKeo6pOGt3hazUh/+qK3zmUNIFITs6zZqKEmgF+vs=;
	b=JZM+rjRORI2FonbVaYOerFxqQdonnI4TilW1UDgsMyXlJTdsWlo+zk8EtBh3XJoG0AsAnc
	qauYLkikuHLcViv6wkNKbhCaQmuaofS1otivvEyVhnY6JZhGJyj3x10IYZuVoWYsOpA9ar
	r7ZOiApzlb/UKD9uQsILyw7NPDVu8K7GoemztqvEKc3IMlUNws6t6YqW09TAh4TZW3APgy
	3d5hbwPbtJHrDx0vPb5FqYpkRhMM3ikMdACbFIjbW6tVnPVyQodgFtaXEQuP3lec8uhEXD
	ZWyx9wLV0VelXS5jagudm2t3EBH+eOL+UwONv+8QFRII/nDJJzKm8nqn8zXz7w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>
Cc: Fei Xie <fei.xie@horizon.auto>,  Mark Brown <broonie@kernel.org>,
  linux-spi@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for
 NAND and NOR
In-Reply-To: <arp-E1MDFLfV1ASq@nsa> ("Nuno =?utf-8?Q?S=C3=A1=22's?= message
 of "Mon, 28 Sep 2026
	16:02:27 +0100")
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	<arOwdePAmoghlakj@nsa> <20260928055005.3987624-1-fei.xie@horizon.auto>
	<arp-E1MDFLfV1ASq@nsa>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 04 Oct 2026 16:37:51 +0200
Message-ID: <87bj99lef4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 28/09/2026 at 16:02:27 +01, Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
>
> Hi Fei,
>
>> Hi Nuno, Miquel,
>>=20
>> Thanks for asking for benchmarks. I backported the 32/64-bit STIG SDMA
>> transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
>> kernel, and compared that STIG path against the ACMD SPI NAND path from
>> this RFC. I have not applied Nuno's separate ACMD read implementation;
>> the figures below are for the implementation in this RFC.
>>=20
>> The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB eraseblocks)
>> on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both paths
>> used the same board PHY configuration. STIG needed one additional dummy
>> clock for the EBh read-cache command on this board to return correct
>> data at 80 MHz. This is a local test adjustment, not part of the posted
>> RFC or [1]; I excluded the incorrect STIG reads from the comparison.
>>=20
>> I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
>> numbers below are the arithmetic means, in KiB/s:
>>=20
>>                                STIG      ACMD PIO
>>   eraseblock write speed      3685          3555
>>   eraseblock read speed      12468         14222
>>   page write speed            3671          3510
>>   page read speed            11931         13716
>>   erase speed                40000         37647
>
> So this goes along with my expectations. I think we can all agree that
> PROGRAM + ERASE is not worth the trouble? We even loose performance...

Yeah.

>> For a separate sequential-read test, I erased and programmed the first
>> 64 MiB with known random data, then checked that each mode read back
>> the complete area byte-for-byte. Both SHA-256 hashes matched the source;
>> the reported ECC failure counts were zero. I then ran:
>
> What do you mean by sequential read? Does your flash supports continuous
> rads (or buffered mode I think). If so, I would expect much better
> number for the ACMD case. But that can be the issue of having both the
> controller and the chip trying to walk pages.

Sequential, continuous and buffered should mean the same in the NAND
context.

>>   /var/busybox/time -f 'real=3D%e user=3D%U sys=3D%S cpu=3D%P' \
>>     dd if=3D/dev/mtd18 of=3D/dev/null bs=3D1M count=3D64
>>=20
>>                           STIG              ACMD PIO
>>   elapsed (three runs)    5.30/5.28/5.26 s  4.66/4.65/4.65 s
>>   mean throughput         12.12 MiB/s       13.75 MiB/s
>>   mean system time        3.55 s            1.06 s
>>   process CPU usage       67%               22%
>>=20
>> On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
>> and reduces the reading process's CPU usage by 45 percentage points.
>> The flash_speed results show a similar gain for reads, including
>> single-page reads.

FYI, if you pull a recent version of mtd-utils, flash_speed can
benchmark continuous read improvements with the -C option.

>> I do not see a program or erase throughput benefit:
>> ACMD is slightly slower for both in this setup. These are SPI NAND
>> results only; I have not benchmarked the NOR path on this board.
>
> So CPU results are the bing thing here. I guess we need to decide if
> it's worth the amount of complexity it requires for the whole thing to
> work. As I mentioned, if the chip has continuous mode and we try to
> read anything bigger than page size we should let the nand chip to
> walk the pages and that means the behavior we have today (IMHO of
> course):
>
> 0x13 (STIG) + wait + read from cache (ACMD)
>
> If we're only reading a single page then the logic in this series would
> payoff (slight performance gain + significant drop in cpu load). One simp=
le
> way for doing this as a starting point would be:
>
> * Nand has cont mode -> xspi controller does nothing special
> * Nand has no cont mode -> Aggregate the xfers together.

I'm fine with static decisions like that, but my understanding of the
above is that ACMD mode is useful for all reads. so I don't get why you
would no use it for all. Maybe because it would break continuous reads?
(sorry I lost a bit of the context already).

For writes and erases however, it seems like we could keep the STIG path.

> Doing something dynamic would be much more complex I guess. With the
> above reasoning, having some mem_info() kind of spi_mem callback to tell
> us things like geometry, continuous mode support, etc would be enough to
> handle the above I think. The reasoning is that reading a nand page is
> always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
> spinand_read_from_cache_op() so we could probably aggregate everything
> in the last call on the controller side without complicating the nand core
> logic.

In general, drivers making assumptions has been a disaster in the raw
NAND world. This was the main reason for the ->exec_op() introduction
there: giving the whole operation to the controller so it can decide
what to do without guessing. But we thinking at the operation boundary,
not at the "set of operations" level. Since ->exec_op() in the SPI NAND
subsystem has been written following the same philosophy, I fear we're
going to try make rounds fit inside squares. One of the possible
approach would be to mimic what we've done for the some limited
controllers: pack everything in one single op (see the _monolithic
suffix in drivers/mtd/nand/raw/). That's just one idea.

Thanks,
Miqu=C3=A8l
