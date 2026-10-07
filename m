Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78B3D3314
	for <linux-spi@vger.kernel.org>; Wed,  7 Oct 2026 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353495; cv=none; b=HHG8nmos0QDRBwKXp8bysaVWYB4xFzgQcSxmEH1qZQvaF/N6igfUkKAWYr8JmI0bLddNDCXDRdvRnTssgY3Dr07cxCzvly2CqTRfjDN8kTHFeWe+K7tlf1jAhFAbyfSbCLC11ykcTOs7VI0QKpAxbhpbxqiu3YYhNDG/Dc9+HJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353495; c=relaxed/simple;
	bh=vCVqv3zqss70uKOdyCuiJtU+zwuXKOXJXwtTH7wskzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aadhWcvy0d8yOIWuZCZTxXObYcimwXb0rhbhtIEpRV8v9k3l77yiVottTVQefrw5aUzft5FJoeoQ2qVrxS4kXvT7QXUfXXvGSWOBeKliXrHqb04JqAktouibZy74ltiy6rZPxQH8KIHsmrN+TU7KGZNHF18rzViVzVJBYUmJSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fErPtDiW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fErPtDiW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so41045445e9.0
        for <linux-spi@vger.kernel.org>; Tue, 06 Oct 2026 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791353492; x=1791958292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vCVqv3zqss70uKOdyCuiJtU+zwuXKOXJXwtTH7wskzU=;
        b=fErPtDiWpoyuJ45GoUWZYVBpMXCvTmuHzH6duF6yzhsI6dvPIhrQTqSUzZCIs/1Lhg
         U+sf9R3VUlp6O1iFqDWljOPFUlLV3niIFuFxOhptBPxTqInivD5expZN6fRKnNAlpPd0
         wedcf4chkj/twBMa8SqI8IyqVvfYdu17SQuWsx3E3Hk2eJUIz02TVMcz79Airy2w6nS3
         /38P0cFgNPjkE7p2MH/dxUbkHUIkey7Le+GNyuMGOZxED71T1PBvVBCdEL2x981o7G2S
         929q/wy4YC47y+EHBksSrxOnKqJYdf6gfw8aMzMhyJit4j6uK6mJLQMYR7+WMJXFjemt
         1Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791353492; x=1791958292;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCVqv3zqss70uKOdyCuiJtU+zwuXKOXJXwtTH7wskzU=;
        b=AK1F0V4wrCvTYYkpBbktZmhwRLnVSCL/dBPvYaW8AVDcttguoj3KrylmHnazN+zJrB
         gEyXhuonxtkR7Ll1XWF6pw+DOLrybRVT3r6EkMSKxCjYi/+uxvYoSZqsvY5nsrP6dyWB
         D44/ZWRJ1R4Q6xj6CnOpBtQw0znLHURl1ySXM+LOjbQIVMV6iv2l9AfmsMo4E/NPmVkL
         uura6kfLqz/7GMBiNbF48VzFkshug0Dp5/4TZLrOVUGOxRCny922Kcft+6XXvrH0L5SH
         RSwAHuDSHd7BsusELtp01j8/PpuUNSOtRTq1WK3vw0iWxIEZupB///m0QQCv1ZcxAu3C
         p+Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzxphtal9E6iLvMV8BPzOHsa6MxfAuxq+jc7hVtkZ4vuEa+oiZ/ePrlz52crwBXcpHO1v14tgPwzXo=@vger.kernel.org
X-Gm-Message-State: AFuF++nZEtUP6w6zO1llAiZANwOxsSE7yAeDsdI9mnVvN1ruZ0Z49eFN
	eekUKTeTNJLnLi+jsk6x/K5fqFJQ91vhvQHgqE5Qea7K0TV/ieIPdm/JY+k3Lw==
X-Gm-Gg: AYBFou2XgI/80vls0b7k5OcHjMqRYKt4ttIIJtowogZqPm0Nx4Noh0OSTffP50k6zRa
	d0Ja8Itlh/1r3zRS3ikw1XRzWnsRd9vQO5elwLa2JN9gHd8txNAZXDFRN5NQJ+bEzp+iQ1bK7IN
	x4q5vNshHMAoEqKCgZ6+FaX1RTB24w1ytq/tXcfy/9meHAEq4ogBTdF/WAoVjJX5tf0m7uyb8fx
	SZ+SnqvM2eKUcA3PyQgZtjl3EyMSxnznpbvNkBx/LTDrQDdPoi2RCA/9bvrmgm8/IibtvESg9nv
	Sp5hMtKRRHIpW6Aqc/1+Lyk2M5KpmKs8yORqWfHb5iLOocUACnCHiINC+iyNKDR4LPLNkkhFat4
	o7FKtmyLtX66//afSUWYmDeBkNJ7vdGMV8VpzQD+NO/6WNfGM7z9/9AgaNYsoRYsCD0nEGJIZeM
	uMQr5kBqHKloZ7f+oa1wUDuSHEIBIW4+uH9SLnsGEhzUqujMg23+kBfLVVRRvXA6qSAA1wOBjmC
	fLynv3ccTUCai7ZnFK+FO/LhU/TIaHkxh8SudBLThSov9FYuF93Z9D1J9OSGLh47WiP2g==
X-Received: by 2002:a05:600c:609a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18031130emr15222165e9.12.1791353491497;
        Tue, 06 Oct 2026 23:11:31 -0700 (PDT)
Received: from [192.168.1.67] (225.217.137.78.rev.vodafone.pt. [78.137.217.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178a17ac9sm123244485e9.1.2026.10.06.23.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:11:31 -0700 (PDT)
Message-ID: <dde19ed4315a58bb7f109486a05277f40c2a2842.camel@gmail.com>
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for
 NAND and NOR
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Fei Xie <fei.xie@horizon.auto>, Mark Brown	
 <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org
Date: Wed, 07 Oct 2026 07:12:57 +0100
In-Reply-To: <asXPFxphyuGXxsfH@xhacker>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	 <arOwdePAmoghlakj@nsa> <20260928055005.3987624-1-fei.xie@horizon.auto>
	 <arp-E1MDFLfV1ASq@nsa> <87bj99lef4.fsf@bootlin.com>
	 <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
	 <asXPFxphyuGXxsfH@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-10-07 at 12:48 +0800, Jisheng Zhang wrote:
> On Tue, Oct 06, 2026 at 07:50:44AM +0100, Nuno S=C3=A1 wrote:
> > On Sun, 2026-10-04 at 16:37 +0200, Miquel Raynal wrote:
> > > Hello,
> > >=20
> > > On 28/09/2026 at 16:02:27 +01, Nuno S=C3=A1 <nuno.sa@analog.com> wrot=
e:
> > >=20
> > > > On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
> > > >=20
> > > > Hi Fei,
> > > >=20
> > > > > Hi Nuno, Miquel,
> > > > >=20
> > > > > Thanks for asking for benchmarks. I backported the 32/64-bit STIG=
 SDMA
> > > > > transfer changes from the patch Nuno pointed to [1] to our vendor=
 6.1
> > > > > kernel, and compared that STIG path against the ACMD SPI NAND pat=
h from
> > > > > this RFC. I have not applied Nuno's separate ACMD read implementa=
tion;
> > > > > the figures below are for the implementation in this RFC.
> > > > >=20
> > > > > The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB erasebl=
ocks)
> > > > > on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both =
paths
> > > > > used the same board PHY configuration. STIG needed one additional=
 dummy
> > > > > clock for the EBh read-cache command on this board to return corr=
ect
> > > > > data at 80 MHz. This is a local test adjustment, not part of the =
posted
> > > > > RFC or [1]; I excluded the incorrect STIG reads from the comparis=
on.
> > > > >=20
> > > > > I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. =
The
> > > > > numbers below are the arithmetic means, in KiB/s:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ACMD PIO
> > > > > =C2=A0 eraseblock write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3685=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3555
> > > > > =C2=A0 eraseblock read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12468=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14222
> > > > > =C2=A0 page write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3671=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 3510
> > > > > =C2=A0 page read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 11931=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 13716
> > > > > =C2=A0 erase speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40000=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 37647
> > > >=20
> > > > So this goes along with my expectations. I think we can all agree t=
hat
> > > > PROGRAM + ERASE is not worth the trouble? We even loose performance=
...
> > >=20
> > > Yeah.
> > >=20
> > > > > For a separate sequential-read test, I erased and programmed the =
first
> > > > > 64 MiB with known random data, then checked that each mode read b=
ack
> > > > > the complete area byte-for-byte. Both SHA-256 hashes matched the =
source;
> > > > > the reported ECC failure counts were zero. I then ran:
> > > >=20
> > > > What do you mean by sequential read? Does your flash supports conti=
nuous
> > > > rads (or buffered mode I think). If so, I would expect much better
> > > > number for the ACMD case. But that can be the issue of having both =
the
> > > > controller and the chip trying to walk pages.
> > >=20
> > > Sequential, continuous and buffered should mean the same in the NAND
> > > context.
> > >=20
> > > > > =C2=A0 /var/busybox/time -f 'real=3D%e user=3D%U sys=3D%S cpu=3D%=
P' \
> > > > > =C2=A0=C2=A0=C2=A0 dd if=3D/dev/mtd18 of=3D/dev/null bs=3D1M coun=
t=3D64
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ACMD PIO
> > > > > =C2=A0 elapsed (three runs)=C2=A0=C2=A0=C2=A0 5.30/5.28/5.26 s=C2=
=A0 4.66/4.65/4.65 s
> > > > > =C2=A0 mean throughput=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 12.12 MiB/s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.75 MiB/s
> > > > > =C2=A0 mean system time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3.55 s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
.06 s
> > > > > =C2=A0 process CPU usage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 67%=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 22%
> > > > >=20
> > > > > On this NAND, ACMD improves the 64 MiB read throughput by about 1=
3.5%
> > > > > and reduces the reading process's CPU usage by 45 percentage poin=
ts.
> > > > > The flash_speed results show a similar gain for reads, including
> > > > > single-page reads.
> > >=20
> > > FYI, if you pull a recent version of mtd-utils, flash_speed can
> > > benchmark continuous read improvements with the -C option.
> > >=20
> > > > > I do not see a program or erase throughput benefit:
> > > > > ACMD is slightly slower for both in this setup. These are SPI NAN=
D
> > > > > results only; I have not benchmarked the NOR path on this board.
> > > >=20
> > > > So CPU results are the bing thing here. I guess we need to decide i=
f
> > > > it's worth the amount of complexity it requires for the whole thing=
 to
> > > > work. As I mentioned, if the chip has continuous mode and we try to
> > > > read anything bigger than page size we should let the nand chip to
> > > > walk the pages and that means the behavior we have today (IMHO of
> > > > course):
> > > >=20
> > > > 0x13 (STIG) + wait + read from cache (ACMD)
> > > >=20
> > > > If we're only reading a single page then the logic in this series w=
ould
> > > > payoff (slight performance gain + significant drop in cpu load). On=
e simple
> > > > way for doing this as a starting point would be:
> > > >=20
> > > > * Nand has cont mode -> xspi controller does nothing special
> > > > * Nand has no cont mode -> Aggregate the xfers together.
> > >=20
> > > I'm fine with static decisions like that, but my understanding of the
> > > above is that ACMD mode is useful for all reads. so I don't get why y=
ou
> > > would no use it for all. Maybe because it would break continuous read=
s?
> > > (sorry I lost a bit of the context already).
> >=20
> > Exactly. In ACMD, is also capable of "walking pages" for reads bigger t=
han page
> > size
> > (hence the need to know the flash geometry) and IIRC, that does not rea=
lly work
> > well
> > when the flash is also doing it.
> >=20
> > >=20
> > > For writes and erases however, it seems like we could keep the STIG p=
ath.
> > >=20
> > > > Doing something dynamic would be much more complex I guess. With th=
e
> > > > above reasoning, having some mem_info() kind of spi_mem callback to=
 tell
> > > > us things like geometry, continuous mode support, etc would be enou=
gh to
> > > > handle the above I think. The reasoning is that reading a nand page=
 is
> > > > always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
> > > > spinand_read_from_cache_op() so we could probably aggregate everyth=
ing
> > > > in the last call on the controller side without complicating the na=
nd core
> > > > logic.
> > >=20
> > > In general, drivers making assumptions has been a disaster in the raw
> > > NAND world. This was the main reason for the ->exec_op() introduction
> > > there: giving the whole operation to the controller so it can decide
> > > what to do without guessing. But we thinking at the operation boundar=
y,
> > > not at the "set of operations" level. Since ->exec_op() in the SPI NA=
ND
> > > subsystem has been written following the same philosophy, I fear we'r=
e
> > > going to try make rounds fit inside squares. One of the possible
> >=20
> > Fair enough! Agreed
> >=20
> > > approach would be to mimic what we've done for the some limited
> > > controllers: pack everything in one single op (see the _monolithic
> > > suffix in drivers/mtd/nand/raw/). That's just one idea.
> > >=20
> >=20
> > I can take a look mostly for curiosity as my intention is not to "steal=
" this
> > work
> > from Fei. If everyone agrees (specially Fei), what I can do is to send =
my simpler
> > patches that just support ACMD (without any special distinction between=
 Nand and
> > Nor)
> > For Nands, I have a mix of STIG and ACMD, where big gains come from Nan=
ds with
> > cont
> > mode.
> >=20
> > Then we can build on top of it in order to improve Nand support (mostly=
 on CPU
> > load).
>=20
> I'm also interested in this driver's performance. A bit off the subject
> but related question: Usually, the Soc may connect the xspi to dma
> engine, I'm curious what would be the benefit of adding dma engine
> support instead of ACMD? Is dma engine support simpler and
> is the gain(performance + cpu load) more?
>=20

I'm not familiar with that approach tbh. But I would assume performance to =
be pretty
much similar to what I have given that ACMD uses the IP internal DMA engine=
. But not
using ACMD means not having the cpu gains at least for the smaller transfer=
s as we
would not be able to aggregate transfers. FWIW, given that you might not ha=
ve looked
at the whole thread, this is what I have:

https://github.com/analogdevicesinc/linux/pull/3478/changes/477e60955085465=
52071b825a66522cf697c27c2

- Nuno S=C3=A1

> Regards
