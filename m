Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222417B50F
	for <linux-spi@vger.kernel.org>; Thu,  8 Oct 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468929; cv=none; b=UzS71XctsW5Obn+qplyVcMaL4gGXNMSWd2qtSnvQpMagASoyGmoaI1Sq6UOnsGNbXXJEk501wI7gSH3lpagCaDL+00W4jo7K09ush8hJNSLcg5Z95EJDQ6GUqbCHqeBbo89gSKqhSWtoC6dnkQzjY4g5OEocd1HahhnY+jlvWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468929; c=relaxed/simple;
	bh=QVyNV4WOcjg/olM/Wk2BR/0cymsBuF61r00W2QE+p40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTT3yaQ2ziZWcz/HGSCIuD0JoCT/9aR8mEPzaj9wX8Pcd84CJNMFm/fvaNZSooDDTxRBn2PyVHyDyMerTCGye4r1J5bxcXuTbiTz/JmJvmYJsJfI2/DS9oaqK4Q8PDN7Ej3xLG0qw0v2SxFPd8CV5Mf/ZoulnjApHUbo6fnuXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9oz5yhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9oz5yhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993711F000FF;
	Thu,  8 Oct 2026 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468928;
	bh=8XJt5C3RPzkVfzrMpjlMPHBznNL0WRY+1WpPfBNC7lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9oz5yhmYDipgCqmIDCLFg109FItC3XHs1e+34ocTlnjyYNSkpOspCfVcNMcCsl3S
	 FEkeEhjBvCbb8I4ZpmJrD81cKuDpCam9vGCqdiFqUfWKxiEwkCahg3scEBA5OCa8JJ
	 HT+z75kDNbwOYy4wW5BzBl7TDDI9/fGhX1dvOn0nZiTVUp8Il2jE21vvMBICobcmjY
	 qkvWElVw9GaBnJ8gGzaYj6+ktG8k9PWtmcX17KNfL1FZXcRdL4NiYbCmKLnpuhBL2E
	 ijE1utH96dthG6UBp6wK17txC6PmyOB1lpz+36xNPGhk95pR/2E/Dn+dZ3+p7/CkmW
	 ZEziy3qpHrpWw==
Date: Thu, 8 Oct 2026 21:55:27 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND
 and NOR
Message-ID: <asegz79z-SNqphVs@xhacker>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <arOwdePAmoghlakj@nsa>
 <20260928055005.3987624-1-fei.xie@horizon.auto>
 <arp-E1MDFLfV1ASq@nsa>
 <87bj99lef4.fsf@bootlin.com>
 <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
 <asXPFxphyuGXxsfH@xhacker>
 <dde19ed4315a58bb7f109486a05277f40c2a2842.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dde19ed4315a58bb7f109486a05277f40c2a2842.camel@gmail.com>

On Wed, Oct 07, 2026 at 07:12:57AM +0100, Nuno Sá wrote:
> On Wed, 2026-10-07 at 12:48 +0800, Jisheng Zhang wrote:
> > On Tue, Oct 06, 2026 at 07:50:44AM +0100, Nuno Sá wrote:
> > > On Sun, 2026-10-04 at 16:37 +0200, Miquel Raynal wrote:
> > > > Hello,
> > > > 
> > > > On 28/09/2026 at 16:02:27 +01, Nuno Sá <nuno.sa@analog.com> wrote:
> > > > 
> > > > > On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
> > > > > 
> > > > > Hi Fei,
> > > > > 
> > > > > > Hi Nuno, Miquel,
> > > > > > 
> > > > > > Thanks for asking for benchmarks. I backported the 32/64-bit STIG SDMA
> > > > > > transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
> > > > > > kernel, and compared that STIG path against the ACMD SPI NAND path from
> > > > > > this RFC. I have not applied Nuno's separate ACMD read implementation;
> > > > > > the figures below are for the implementation in this RFC.
> > > > > > 
> > > > > > The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB eraseblocks)
> > > > > > on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both paths
> > > > > > used the same board PHY configuration. STIG needed one additional dummy
> > > > > > clock for the EBh read-cache command on this board to return correct
> > > > > > data at 80 MHz. This is a local test adjustment, not part of the posted
> > > > > > RFC or [1]; I excluded the incorrect STIG reads from the comparison.
> > > > > > 
> > > > > > I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
> > > > > > numbers below are the arithmetic means, in KiB/s:
> > > > > > 
> > > > > >                                STIG      ACMD PIO
> > > > > >   eraseblock write speed      3685          3555
> > > > > >   eraseblock read speed      12468         14222
> > > > > >   page write speed            3671          3510
> > > > > >   page read speed            11931         13716
> > > > > >   erase speed                40000         37647
> > > > > 
> > > > > So this goes along with my expectations. I think we can all agree that
> > > > > PROGRAM + ERASE is not worth the trouble? We even loose performance...
> > > > 
> > > > Yeah.
> > > > 
> > > > > > For a separate sequential-read test, I erased and programmed the first
> > > > > > 64 MiB with known random data, then checked that each mode read back
> > > > > > the complete area byte-for-byte. Both SHA-256 hashes matched the source;
> > > > > > the reported ECC failure counts were zero. I then ran:
> > > > > 
> > > > > What do you mean by sequential read? Does your flash supports continuous
> > > > > rads (or buffered mode I think). If so, I would expect much better
> > > > > number for the ACMD case. But that can be the issue of having both the
> > > > > controller and the chip trying to walk pages.
> > > > 
> > > > Sequential, continuous and buffered should mean the same in the NAND
> > > > context.
> > > > 
> > > > > >   /var/busybox/time -f 'real=%e user=%U sys=%S cpu=%P' \
> > > > > >     dd if=/dev/mtd18 of=/dev/null bs=1M count=64
> > > > > > 
> > > > > >                           STIG              ACMD PIO
> > > > > >   elapsed (three runs)    5.30/5.28/5.26 s  4.66/4.65/4.65 s
> > > > > >   mean throughput         12.12 MiB/s       13.75 MiB/s
> > > > > >   mean system time        3.55 s            1.06 s
> > > > > >   process CPU usage       67%               22%
> > > > > > 
> > > > > > On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
> > > > > > and reduces the reading process's CPU usage by 45 percentage points.
> > > > > > The flash_speed results show a similar gain for reads, including
> > > > > > single-page reads.
> > > > 
> > > > FYI, if you pull a recent version of mtd-utils, flash_speed can
> > > > benchmark continuous read improvements with the -C option.
> > > > 
> > > > > > I do not see a program or erase throughput benefit:
> > > > > > ACMD is slightly slower for both in this setup. These are SPI NAND
> > > > > > results only; I have not benchmarked the NOR path on this board.
> > > > > 
> > > > > So CPU results are the bing thing here. I guess we need to decide if
> > > > > it's worth the amount of complexity it requires for the whole thing to
> > > > > work. As I mentioned, if the chip has continuous mode and we try to
> > > > > read anything bigger than page size we should let the nand chip to
> > > > > walk the pages and that means the behavior we have today (IMHO of
> > > > > course):
> > > > > 
> > > > > 0x13 (STIG) + wait + read from cache (ACMD)
> > > > > 
> > > > > If we're only reading a single page then the logic in this series would
> > > > > payoff (slight performance gain + significant drop in cpu load). One simple
> > > > > way for doing this as a starting point would be:
> > > > > 
> > > > > * Nand has cont mode -> xspi controller does nothing special
> > > > > * Nand has no cont mode -> Aggregate the xfers together.
> > > > 
> > > > I'm fine with static decisions like that, but my understanding of the
> > > > above is that ACMD mode is useful for all reads. so I don't get why you
> > > > would no use it for all. Maybe because it would break continuous reads?
> > > > (sorry I lost a bit of the context already).
> > > 
> > > Exactly. In ACMD, is also capable of "walking pages" for reads bigger than page
> > > size
> > > (hence the need to know the flash geometry) and IIRC, that does not really work
> > > well
> > > when the flash is also doing it.
> > > 
> > > > 
> > > > For writes and erases however, it seems like we could keep the STIG path.
> > > > 
> > > > > Doing something dynamic would be much more complex I guess. With the
> > > > > above reasoning, having some mem_info() kind of spi_mem callback to tell
> > > > > us things like geometry, continuous mode support, etc would be enough to
> > > > > handle the above I think. The reasoning is that reading a nand page is
> > > > > always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
> > > > > spinand_read_from_cache_op() so we could probably aggregate everything
> > > > > in the last call on the controller side without complicating the nand core
> > > > > logic.
> > > > 
> > > > In general, drivers making assumptions has been a disaster in the raw
> > > > NAND world. This was the main reason for the ->exec_op() introduction
> > > > there: giving the whole operation to the controller so it can decide
> > > > what to do without guessing. But we thinking at the operation boundary,
> > > > not at the "set of operations" level. Since ->exec_op() in the SPI NAND
> > > > subsystem has been written following the same philosophy, I fear we're
> > > > going to try make rounds fit inside squares. One of the possible
> > > 
> > > Fair enough! Agreed
> > > 
> > > > approach would be to mimic what we've done for the some limited
> > > > controllers: pack everything in one single op (see the _monolithic
> > > > suffix in drivers/mtd/nand/raw/). That's just one idea.
> > > > 
> > > 
> > > I can take a look mostly for curiosity as my intention is not to "steal" this
> > > work
> > > from Fei. If everyone agrees (specially Fei), what I can do is to send my simpler
> > > patches that just support ACMD (without any special distinction between Nand and
> > > Nor)
> > > For Nands, I have a mix of STIG and ACMD, where big gains come from Nands with
> > > cont
> > > mode.
> > > 
> > > Then we can build on top of it in order to improve Nand support (mostly on CPU
> > > load).
> > 
> > I'm also interested in this driver's performance. A bit off the subject
> > but related question: Usually, the Soc may connect the xspi to dma
> > engine, I'm curious what would be the benefit of adding dma engine
> > support instead of ACMD? Is dma engine support simpler and
> > is the gain(performance + cpu load) more?
> > 
> 
> I'm not familiar with that approach tbh. But I would assume performance to be pretty
> much similar to what I have given that ACMD uses the IP internal DMA engine. But not
> using ACMD means not having the cpu gains at least for the smaller transfers as we
> would not be able to aggregate transfers. FWIW, given that you might not have looked

Hmm, my platforms connect two dmaengine channels to the xspi controller,
but I haven't added the dma-engine support to the driver yet. If the
ACMD is enough, why HW connects dma-engine then? Just curious, there
must be performance gain I guess. But I'm not sure and I don't have
performance numbers.

> at the whole thread, this is what I have:
> 
> https://github.com/analogdevicesinc/linux/pull/3478/changes/477e6095508546552071b825a66522cf697c27c2
> 
> - Nuno Sá
> 
> > Regards
