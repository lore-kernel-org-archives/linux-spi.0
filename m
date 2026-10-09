Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FC42AFBB
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526570; cv=none; b=oSlOqdEgvPtJFgDcM+tjkPZqS/SDLLxVBWyOghhiffWo+IK0pC+v4cVEPH2lC4OFK8J7GDsPeHgCXAyQNbizGUxdockawbqpHve/v0Ib99AjR0Gg6/pABTZyy6vvYx7SxMJ6qK5pD5Aaw3ZKLmgHdhT3+X/O9HMpGJzLsuTK9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526570; c=relaxed/simple;
	bh=3xlU7dwzpG7tdePdYTg0baHlaNyyPoEVVV4me98McRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvyzJ6KnZh664rvpm9Impo1q+dGvrk5zfDL00GAoi8ohmN+spXVwOT5bxH/v1nAO8sx4lDjHO91h6zLWJYYJcI+see4rXdmJp99ylcWRIgPwDK0zcxKdk49QiWGQgWDJTtr52VH1TO3WxUW84eSr1eP15313dv3thP7faFm9SMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo4bwmgr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo4bwmgr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so51517485e9.3
        for <linux-spi@vger.kernel.org>; Thu, 08 Oct 2026 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791526566; x=1792131366; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3xlU7dwzpG7tdePdYTg0baHlaNyyPoEVVV4me98McRQ=;
        b=eo4bwmgrNX6Sb2bOcNcCFDCJwn4J6hYLUUE6biOsDhOBHuIaHbYDyGRIGNaKVjj4UO
         PHdO0tDyYhzQwAgkywl6cp+GMg9N88C+gDSv9RobU9/i2S9/YSiG3EXNcn71xJHVIAjk
         iMVqeS8RxtT0lUWoddCEKL4O1hvunhNE93AaNXk/yi1y1SbbJ7uDto/e0SgtZ6QrdDOf
         3uhZQh6gRHtuxzbUnBoBsKkwNBhil8c+Qp/FmkUkmr77JroWZdzCchH65QOuDrbCuouJ
         M8AVjkyHbWL80mzHyQhzgh2daJS3ECWb46zpb1ZW7nJxLfZU5PAR+6rZihF1hqk8WzDf
         MaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791526566; x=1792131366;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xlU7dwzpG7tdePdYTg0baHlaNyyPoEVVV4me98McRQ=;
        b=EylNMIAlJMx0jHt7/hWrE+XJoAVuTGpROZ87urgkKThX8memhoO5mk6r60m9W6fnhP
         8fOH4yRkuIlPiC7EClk+pyns8qHy9/bi/pxhO6kMNKzIZXAHBqwta5CoJ7md4sqPrBY/
         SnRqejZk3BykOy0Grx/FeCJT01x9RjPLF+YXCEomtA9Kxo5c83SPJMqjZ0BJnAvbvyE/
         Bq3BD3d0MtCgLtB6JxZXXYkGsTt8oyuvQZw9JDva2FqRfy/uT3UOIR9j3DrwPCyvUWhb
         U3tXA/75lW5+D3Ye6BBK00mki/br+Wwunq84CHSqyg0VUabCKVW41UYoxqsm1hJHfY2+
         d98A==
X-Forwarded-Encrypted: i=1; AKwUvBzlWY5fKNzjwNfB+KS+DTflhYvZDmQ511nmmcBhgAK9F/+EmK4t7eDAp/EVD9yy41LPZ5Fn28FBmO8=@vger.kernel.org
X-Gm-Message-State: AFuF++nv/pqkPIxnzIFbKG0JM/eXh2aRiogLavlqjxHvU0e/vOr+30Ol
	y7z2IY/jqhzkh5UXNEk4o+34pbSerAECI57ufi8u10w0psT8DZ8KLWCZHu1zIA==
X-Gm-Gg: AYBFou3WJAeXeY8BcvjxdACFpfTy+YKBq5hMB9LUKjHUs3WwL9skzQddemfa6asI77T
	saqvG9FGsqTc6AaF/jxOEVFHdHITks21XbUKImNthUquPK780BCr5twZpviUhMGhIkN13VfXpKi
	UO7l7VFCI4iPZgydV8gInRKT6GnA5fbJD5nMaPp39wP5F7jFGjbb5MXmdHC0zFtPaJjWdQVXCBm
	1iRjvvQExv2juIP7spWE9OmfdaeLt+5FzMI9iJ7r7Lkkx1qOUAHrArKJmRM4psTymCF7jYymFs3
	L+4wyj0ra758rxsvTrpPrKxVVkHYdy6S5Hvyot9hLW2xsKUORoou5wbKy0mQZaDkXL7y+MdRIDX
	bccSqDvGYI0vEXQ9lXU42JevtYSv6SWBubx8ENhPuhKncG9hJyFTfHfbq9mQrM3M6oIon1CeoRZ
	jb7SZbLA1fowvZnp30PLDjDaxMLriepi5Qzib5pDtk326cSbCHaXTh86JBMBvkU096fC8i4g2wp
	H+auKmRnMDG2m3jWUR8o9l5gN8Z7N94eiuAeQ3nPZCKJTthF7QF8D43VN7244eJrh2VYAB/Pg5d
	Cv2z0g==
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-4a18e4f2221mr11371675e9.32.1791526566229;
        Thu, 08 Oct 2026 23:16:06 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac94c6sm2145153f8f.42.2026.10.08.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:16:05 -0700 (PDT)
Message-ID: <c747a7e7b0c0ed8157fed2443a40b9ef896d1b1d.camel@gmail.com>
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for
 NAND and NOR
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Fei Xie <fei.xie@horizon.auto>, Mark Brown	
 <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org
Date: Fri, 09 Oct 2026 07:17:35 +0100
In-Reply-To: <asht8pnVDV80zNXw@xhacker>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	 <arOwdePAmoghlakj@nsa> <20260928055005.3987624-1-fei.xie@horizon.auto>
	 <arp-E1MDFLfV1ASq@nsa> <87bj99lef4.fsf@bootlin.com>
	 <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
	 <asXPFxphyuGXxsfH@xhacker>
	 <dde19ed4315a58bb7f109486a05277f40c2a2842.camel@gmail.com>
	 <asegz79z-SNqphVs@xhacker> <asht8pnVDV80zNXw@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 12:30 +0800, Jisheng Zhang wrote:
> On Thu, Oct 08, 2026 at 09:55:27PM +0800, Jisheng Zhang wrote:
> > On Wed, Oct 07, 2026 at 07:12:57AM +0100, Nuno S=C3=A1 wrote:
> > > On Wed, 2026-10-07 at 12:48 +0800, Jisheng Zhang wrote:
> > > > On Tue, Oct 06, 2026 at 07:50:44AM +0100, Nuno S=C3=A1 wrote:
> > > > > On Sun, 2026-10-04 at 16:37 +0200, Miquel Raynal wrote:
> > > > > > Hello,
> > > > > >=20
> > > > > > On 28/09/2026 at 16:02:27 +01, Nuno S=C3=A1 <nuno.sa@analog.com=
> wrote:
> > > > > >=20
> > > > > > > On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
> > > > > > >=20
> > > > > > > Hi Fei,
> > > > > > >=20
> > > > > > > > Hi Nuno, Miquel,
> > > > > > > >=20
> > > > > > > > Thanks for asking for benchmarks. I backported the 32/64-bi=
t STIG
> > > > > > > > SDMA
> > > > > > > > transfer changes from the patch Nuno pointed to [1] to our =
vendor 6.1
> > > > > > > > kernel, and compared that STIG path against the ACMD SPI NA=
ND path
> > > > > > > > from
> > > > > > > > this RFC. I have not applied Nuno's separate ACMD read
> > > > > > > > implementation;
> > > > > > > > the figures below are for the implementation in this RFC.
> > > > > > > >=20
> > > > > > > > The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB
> > > > > > > > eraseblocks)
> > > > > > > > on a Horizon J6B board, running at 80 MHz in quad SDR mode.=
 Both
> > > > > > > > paths
> > > > > > > > used the same board PHY configuration. STIG needed one addi=
tional
> > > > > > > > dummy
> > > > > > > > clock for the EBh read-cache command on this board to retur=
n correct
> > > > > > > > data at 80 MHz. This is a local test adjustment, not part o=
f the
> > > > > > > > posted
> > > > > > > > RFC or [1]; I excluded the incorrect STIG reads from the co=
mparison.
> > > > > > > >=20
> > > > > > > > I ran flash_speed -c 5 -d /dev/mtd18 three times with each =
mode. The
> > > > > > > > numbers below are the arithmetic means, in KiB/s:
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ACMD PIO
> > > > > > > > =C2=A0 eraseblock write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3685=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3555
> > > > > > > > =C2=A0 eraseblock read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
12468=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14222
> > > > > > > > =C2=A0 page write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3671=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3510
> > > > > > > > =C2=A0 page read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11931=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 13716
> > > > > > > > =C2=A0 erase speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40000=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 37647
> > > > > > >=20
> > > > > > > So this goes along with my expectations. I think we can all a=
gree that
> > > > > > > PROGRAM + ERASE is not worth the trouble? We even loose perfo=
rmance...
> > > > > >=20
> > > > > > Yeah.
> > > > > >=20
> > > > > > > > For a separate sequential-read test, I erased and programme=
d the
> > > > > > > > first
> > > > > > > > 64 MiB with known random data, then checked that each mode =
read back
> > > > > > > > the complete area byte-for-byte. Both SHA-256 hashes matche=
d the
> > > > > > > > source;
> > > > > > > > the reported ECC failure counts were zero. I then ran:
> > > > > > >=20
> > > > > > > What do you mean by sequential read? Does your flash supports
> > > > > > > continuous
> > > > > > > rads (or buffered mode I think). If so, I would expect much b=
etter
> > > > > > > number for the ACMD case. But that can be the issue of having=
 both the
> > > > > > > controller and the chip trying to walk pages.
> > > > > >=20
> > > > > > Sequential, continuous and buffered should mean the same in the=
 NAND
> > > > > > context.
> > > > > >=20
> > > > > > > > =C2=A0 /var/busybox/time -f 'real=3D%e user=3D%U sys=3D%S c=
pu=3D%P' \
> > > > > > > > =C2=A0=C2=A0=C2=A0 dd if=3D/dev/mtd18 of=3D/dev/null bs=3D1=
M count=3D64
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACMD PIO
> > > > > > > > =C2=A0 elapsed (three runs)=C2=A0=C2=A0=C2=A0 5.30/5.28/5.2=
6 s=C2=A0 4.66/4.65/4.65 s
> > > > > > > > =C2=A0 mean throughput=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 12.12 MiB/s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.75 MiB/s
> > > > > > > > =C2=A0 mean system time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3.55 s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1.06 s
> > > > > > > > =C2=A0 process CPU usage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 67%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 22%
> > > > > > > >=20
> > > > > > > > On this NAND, ACMD improves the 64 MiB read throughput by a=
bout 13.5%
> > > > > > > > and reduces the reading process's CPU usage by 45 percentag=
e points.
> > > > > > > > The flash_speed results show a similar gain for reads, incl=
uding
> > > > > > > > single-page reads.
> > > > > >=20
> > > > > > FYI, if you pull a recent version of mtd-utils, flash_speed can
> > > > > > benchmark continuous read improvements with the -C option.
> > > > > >=20
> > > > > > > > I do not see a program or erase throughput benefit:
> > > > > > > > ACMD is slightly slower for both in this setup. These are S=
PI NAND
> > > > > > > > results only; I have not benchmarked the NOR path on this b=
oard.
> > > > > > >=20
> > > > > > > So CPU results are the bing thing here. I guess we need to de=
cide if
> > > > > > > it's worth the amount of complexity it requires for the whole=
 thing to
> > > > > > > work. As I mentioned, if the chip has continuous mode and we =
try to
> > > > > > > read anything bigger than page size we should let the nand ch=
ip to
> > > > > > > walk the pages and that means the behavior we have today (IMH=
O of
> > > > > > > course):
> > > > > > >=20
> > > > > > > 0x13 (STIG) + wait + read from cache (ACMD)
> > > > > > >=20
> > > > > > > If we're only reading a single page then the logic in this se=
ries would
> > > > > > > payoff (slight performance gain + significant drop in cpu loa=
d). One
> > > > > > > simple
> > > > > > > way for doing this as a starting point would be:
> > > > > > >=20
> > > > > > > * Nand has cont mode -> xspi controller does nothing special
> > > > > > > * Nand has no cont mode -> Aggregate the xfers together.
> > > > > >=20
> > > > > > I'm fine with static decisions like that, but my understanding =
of the
> > > > > > above is that ACMD mode is useful for all reads. so I don't get=
 why you
> > > > > > would no use it for all. Maybe because it would break continuou=
s reads?
> > > > > > (sorry I lost a bit of the context already).
> > > > >=20
> > > > > Exactly. In ACMD, is also capable of "walking pages" for reads bi=
gger than
> > > > > page
> > > > > size
> > > > > (hence the need to know the flash geometry) and IIRC, that does n=
ot really
> > > > > work
> > > > > well
> > > > > when the flash is also doing it.
> > > > >=20
> > > > > >=20
> > > > > > For writes and erases however, it seems like we could keep the =
STIG path.
> > > > > >=20
> > > > > > > Doing something dynamic would be much more complex I guess. W=
ith the
> > > > > > > above reasoning, having some mem_info() kind of spi_mem callb=
ack to
> > > > > > > tell
> > > > > > > us things like geometry, continuous mode support, etc would b=
e enough
> > > > > > > to
> > > > > > > handle the above I think. The reasoning is that reading a nan=
d page is
> > > > > > > always like spinand_load_page_op() (opcode 0x13) + spinand_wa=
it() +
> > > > > > > spinand_read_from_cache_op() so we could probably aggregate e=
verything
> > > > > > > in the last call on the controller side without complicating =
the nand
> > > > > > > core
> > > > > > > logic.
> > > > > >=20
> > > > > > In general, drivers making assumptions has been a disaster in t=
he raw
> > > > > > NAND world. This was the main reason for the ->exec_op() introd=
uction
> > > > > > there: giving the whole operation to the controller so it can d=
ecide
> > > > > > what to do without guessing. But we thinking at the operation b=
oundary,
> > > > > > not at the "set of operations" level. Since ->exec_op() in the =
SPI NAND
> > > > > > subsystem has been written following the same philosophy, I fea=
r we're
> > > > > > going to try make rounds fit inside squares. One of the possibl=
e
> > > > >=20
> > > > > Fair enough! Agreed
> > > > >=20
> > > > > > approach would be to mimic what we've done for the some limited
> > > > > > controllers: pack everything in one single op (see the _monolit=
hic
> > > > > > suffix in drivers/mtd/nand/raw/). That's just one idea.
> > > > > >=20
> > > > >=20
> > > > > I can take a look mostly for curiosity as my intention is not to =
"steal"
> > > > > this
> > > > > work
> > > > > from Fei. If everyone agrees (specially Fei), what I can do is to=
 send my
> > > > > simpler
> > > > > patches that just support ACMD (without any special distinction b=
etween
> > > > > Nand and
> > > > > Nor)
> > > > > For Nands, I have a mix of STIG and ACMD, where big gains come fr=
om Nands
> > > > > with
> > > > > cont
> > > > > mode.
> > > > >=20
> > > > > Then we can build on top of it in order to improve Nand support (=
mostly on
> > > > > CPU
> > > > > load).
> > > >=20
> > > > I'm also interested in this driver's performance. A bit off the sub=
ject
> > > > but related question: Usually, the Soc may connect the xspi to dma
> > > > engine, I'm curious what would be the benefit of adding dma engine
> > > > support instead of ACMD? Is dma engine support simpler and
> > > > is the gain(performance + cpu load) more?
> > > >=20
> > >=20
> > > I'm not familiar with that approach tbh. But I would assume performan=
ce to be
> > > pretty
> > > much similar to what I have given that ACMD uses the IP internal DMA =
engine.
> > > But not
> > > using ACMD means not having the cpu gains at least for the smaller tr=
ansfers as
> > > we
> > > would not be able to aggregate transfers. FWIW, given that you might =
not have
> > > looked
> >=20
> > Hmm, my platforms connect two dmaengine channels to the xspi controller=
,
> > but I haven't added the dma-engine support to the driver yet. If the
> > ACMD is enough, why HW connects dma-engine then? Just curious, there
> > must be performance gain I guess. But I'm not sure and I don't have
> > performance numbers.
>=20

SO the IP has an internal DMA engine capable of acting as controller and dr=
iving the
bus AFAIU. So we do not really need any external dma_chan. Just need to use=
 the dma
mapping API,

> Aha, my platforms don't enable the ACMD support, instead, connect the
> xspi with dmac.
>=20
> So when upstreaming ACMD support, the driver needs to detect the ACMD
> support either dynamically or via. DT. Unfortunately, I didn't find
> any register can export the ACMD availability. DT is the only way?
> Or issue a simple ACMD and check SDMA error?

I'm really not sure on your usecase. ACMD starts to payoff really when the =
transfers
start to be big enough. For example for my usecase, Im only using ACMD for =
reads
bigger than > 2KiB. That number is fixed but I suspect it's not that simple=
 given
that It might depend on number of lanes and clock speeds.

If I'm not missing anything, the easiest way to handle things would be to d=
etect
dma_chan from DT and if available use it instead of ACMD.


- Nuno S=C3=A1

> >=20
> > > at the whole thread, this is what I have:
> > >=20
> > > https://github.com/analogdevicesinc/linux/pull/3478/changes/477e60955=
08546552071b825a66522cf697c27c2
> > >=20
> > > - Nuno S=C3=A1
> > >=20
> > > > Regards
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
