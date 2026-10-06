Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CB22425B
	for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2026 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269358; cv=none; b=eVDNz4s6Zn+IV+2eUnRm/6MYosSLxpTGb4OYCWQ8yb0lAl2r4uj5u9YwW1RxKwVk8KLxuh2c9G657PMKwB2C4CgmZ/emWxddpgLozTfCC+6f3Lri/bOO2nX2YF7+d79h3ikQ2xh0jgaLmSz/ICY/0bNXioHGFesZMkK6fmvQFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269358; c=relaxed/simple;
	bh=dQqu7u1PnHAzJlGyGfMmZKvvCDRPUclc9gbsVzDpIrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovmfsIc5VFLs/IMSIAy+gUZhxYuqlI89GvAAW1O08z4KwDZSGmjvb9O0hg9dsRKfruLWHM+ecqQIx1wk7auAih0sEod9L/ozeVTDFGv+/i3guSb7zwFFm5pQ0HPozR9meVi6eZWIgEdrRxCPfd1IkNDueByGiPIDFvElfU7JieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/4FrGGY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/4FrGGY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1998186f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 05 Oct 2026 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269355; x=1791874155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dQqu7u1PnHAzJlGyGfMmZKvvCDRPUclc9gbsVzDpIrw=;
        b=X/4FrGGYehkCtAru98UOYEuB+GLpP+HeZFRwuUVYYgU+xLKk8lVdimRftRUMrU6LiH
         zXtY2cQMt9tnX+DbJfnPrjdlWlOFbryK2ioKJHapYosD4EhJL+WF1vhrjq0y9TBd7nl5
         yx0H7zOB6T86QyDwsXS6P0MABsXooU6hSsIFMDWppbo1pPDobwE2UihghiZGV8BOsIKk
         1fk7bfFRpsgAjWXuW5HrYYfmWODgCI7Ncg+au5VefLyCflgnhShGjvNjqo7kLGebVW/z
         ksu3WHFXwNMEytzYvVWdR9rJoVsyZHDUl1+8aeeq8oP7yVHgO3tbtCGMwe0Mz7VWaEzQ
         jsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269355; x=1791874155;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQqu7u1PnHAzJlGyGfMmZKvvCDRPUclc9gbsVzDpIrw=;
        b=LGue6A7Uk5mvPvlzK0ri+gbfRJjzx9sDf0ndGPldyTowKVfBbx3zyncEz8cUBmbGBf
         yizWT2H5dJkohRB6Ir6AMhs48UO0Uc8DbOlGFIVMMPqm6+fk4wgWwJ7MuMQPxYm8lmso
         AGqxkMYHCjl2HoFg9WT49sTxZsiRr76wfBsyIJziIVgo4IrpeuLyM4CGgOibdbGt3iEn
         uY4oyFLFNVoBBC7q089nsuRtcLuCazGeCaQYYTkX/iYbTpay9pYK4FcxO7kiz9LUsx/I
         80NQisZ0qi8fXBOierR8Mlue3+P8+WObHVBBfWOOnl0MPKm9Wp/JRYOk2CF0l/9+8Jxt
         +09g==
X-Forwarded-Encrypted: i=1; AKwUvByCZvQcH5NWIXR/vizKYBftfDPLGbVSId4njBcjvUehIba9JHaz3UAt3Ew/L4nNOQAITt7EQsn1C0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkcM2WCC93/ijuCVlHsbSQjmo8eaq3WWKo2i6qgDRjilOLxNCw
	GlIHIR1DOLeYMCoNpYAPujADVLDA/FAVW6Of4qLNlEFBiRAMvY04WNsD
X-Gm-Gg: AYBFou3//R3ifx/1dYigr5k+iu6kdQwPHAuYodmB0nW2sDgvG5F1EKIBVV01TFndP+j
	v/nkDDaprs5EwZ9kDCXQ7D3z88GZSL+W6B8ZFm79ygmO9UDZYMffgcEjJXXOES641i3O63t4OLl
	13vpCX106pW5TJzkFcsfXs0y63QK3JJEM+BhjNVkSkdmalCGNX834uXir731fuMPASKPvHyaBLa
	izWvoMrg8afkwzbsnTIh5BG7S/hHzQ7EuzhGWZo+0YPrLWJfNb/A8FH2kt0RaGgeHZrDtURV8CA
	KLs7iMRN0IuktzQEYW+jdDYs7aAjomqWuv4+d0E3Ay134mMCyl8DTLpZmowedrGFcV05jNZZGi6
	6eTLccIsPEKToFfrjJv/kAXFuRkPU2w4zGh1GkhgtuQd/4QjkxCnKFw7Po4WsPIBWs7KH2Pe73y
	UDVYr0ti2wEHjn5L1iKudhN4LPyVQCfLq1lDqjRtAtSXsszcrlwsEFHI1Q31I6MpSo3zzrL5i+a
	28yRICz58Os+53wGXOp6OkeB9597yXM2IzA57tjcq9IOk/6C4DDyQVKqCYuM0kywdFScfIqUyOG
	r7fITn3VSsx5JFKm
X-Received: by 2002:a05:6000:22c6:b0:488:83b1:16a1 with SMTP id ffacd0b85a97d-48c6d0f47a2mr789373f8f.7.1791269354706;
        Mon, 05 Oct 2026 23:49:14 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6cd717f8sm1302935f8f.48.2026.10.05.23.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:49:14 -0700 (PDT)
Message-ID: <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for
 NAND and NOR
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Fei Xie <fei.xie@horizon.auto>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Date: Tue, 06 Oct 2026 07:50:44 +0100
In-Reply-To: <87bj99lef4.fsf@bootlin.com>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
		<arOwdePAmoghlakj@nsa> <20260928055005.3987624-1-fei.xie@horizon.auto>
		<arp-E1MDFLfV1ASq@nsa> <87bj99lef4.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-10-04 at 16:37 +0200, Miquel Raynal wrote:
> Hello,
>=20
> On 28/09/2026 at 16:02:27 +01, Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > On Mon, Sep 28, 2026 at 01:50:05PM +0800, Fei Xie wrote:
> >=20
> > Hi Fei,
> >=20
> > > Hi Nuno, Miquel,
> > >=20
> > > Thanks for asking for benchmarks. I backported the 32/64-bit STIG SDM=
A
> > > transfer changes from the patch Nuno pointed to [1] to our vendor 6.1
> > > kernel, and compared that STIG path against the ACMD SPI NAND path fr=
om
> > > this RFC. I have not applied Nuno's separate ACMD read implementation=
;
> > > the figures below are for the implementation in this RFC.
> > >=20
> > > The device is a GD5F4GM8RE SPI NAND (2 KiB pages, 128 KiB eraseblocks=
)
> > > on a Horizon J6B board, running at 80 MHz in quad SDR mode. Both path=
s
> > > used the same board PHY configuration. STIG needed one additional dum=
my
> > > clock for the EBh read-cache command on this board to return correct
> > > data at 80 MHz. This is a local test adjustment, not part of the post=
ed
> > > RFC or [1]; I excluded the incorrect STIG reads from the comparison.
> > >=20
> > > I ran flash_speed -c 5 -d /dev/mtd18 three times with each mode. The
> > > numbers below are the arithmetic means, in KiB/s:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACM=
D PIO
> > > =C2=A0 eraseblock write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3685=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3555
> > > =C2=A0 eraseblock read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12468=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14222
> > > =C2=A0 page write speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 3671=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3510
> > > =C2=A0 page read speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 11931=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 13716
> > > =C2=A0 erase speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 37647
> >=20
> > So this goes along with my expectations. I think we can all agree that
> > PROGRAM + ERASE is not worth the trouble? We even loose performance...
>=20
> Yeah.
>=20
> > > For a separate sequential-read test, I erased and programmed the firs=
t
> > > 64 MiB with known random data, then checked that each mode read back
> > > the complete area byte-for-byte. Both SHA-256 hashes matched the sour=
ce;
> > > the reported ECC failure counts were zero. I then ran:
> >=20
> > What do you mean by sequential read? Does your flash supports continuou=
s
> > rads (or buffered mode I think). If so, I would expect much better
> > number for the ACMD case. But that can be the issue of having both the
> > controller and the chip trying to walk pages.
>=20
> Sequential, continuous and buffered should mean the same in the NAND
> context.
>=20
> > > =C2=A0 /var/busybox/time -f 'real=3D%e user=3D%U sys=3D%S cpu=3D%P' \
> > > =C2=A0=C2=A0=C2=A0 dd if=3D/dev/mtd18 of=3D/dev/null bs=3D1M count=3D=
64
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 STIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ACMD PIO
> > > =C2=A0 elapsed (three runs)=C2=A0=C2=A0=C2=A0 5.30/5.28/5.26 s=C2=A0 =
4.66/4.65/4.65 s
> > > =C2=A0 mean throughput=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 12.12 MiB/s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.75 MiB/s
> > > =C2=A0 mean system time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.5=
5 s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.06 =
s
> > > =C2=A0 process CPU usage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 67%=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 22%
> > >=20
> > > On this NAND, ACMD improves the 64 MiB read throughput by about 13.5%
> > > and reduces the reading process's CPU usage by 45 percentage points.
> > > The flash_speed results show a similar gain for reads, including
> > > single-page reads.
>=20
> FYI, if you pull a recent version of mtd-utils, flash_speed can
> benchmark continuous read improvements with the -C option.
>=20
> > > I do not see a program or erase throughput benefit:
> > > ACMD is slightly slower for both in this setup. These are SPI NAND
> > > results only; I have not benchmarked the NOR path on this board.
> >=20
> > So CPU results are the bing thing here. I guess we need to decide if
> > it's worth the amount of complexity it requires for the whole thing to
> > work. As I mentioned, if the chip has continuous mode and we try to
> > read anything bigger than page size we should let the nand chip to
> > walk the pages and that means the behavior we have today (IMHO of
> > course):
> >=20
> > 0x13 (STIG) + wait + read from cache (ACMD)
> >=20
> > If we're only reading a single page then the logic in this series would
> > payoff (slight performance gain + significant drop in cpu load). One si=
mple
> > way for doing this as a starting point would be:
> >=20
> > * Nand has cont mode -> xspi controller does nothing special
> > * Nand has no cont mode -> Aggregate the xfers together.
>=20
> I'm fine with static decisions like that, but my understanding of the
> above is that ACMD mode is useful for all reads. so I don't get why you
> would no use it for all. Maybe because it would break continuous reads?
> (sorry I lost a bit of the context already).

Exactly. In ACMD, is also capable of "walking pages" for reads bigger than =
page size
(hence the need to know the flash geometry) and IIRC, that does not really =
work well
when the flash is also doing it.

>=20
> For writes and erases however, it seems like we could keep the STIG path.
>=20
> > Doing something dynamic would be much more complex I guess. With the
> > above reasoning, having some mem_info() kind of spi_mem callback to tel=
l
> > us things like geometry, continuous mode support, etc would be enough t=
o
> > handle the above I think. The reasoning is that reading a nand page is
> > always like spinand_load_page_op() (opcode 0x13) + spinand_wait() +
> > spinand_read_from_cache_op() so we could probably aggregate everything
> > in the last call on the controller side without complicating the nand c=
ore
> > logic.
>=20
> In general, drivers making assumptions has been a disaster in the raw
> NAND world. This was the main reason for the ->exec_op() introduction
> there: giving the whole operation to the controller so it can decide
> what to do without guessing. But we thinking at the operation boundary,
> not at the "set of operations" level. Since ->exec_op() in the SPI NAND
> subsystem has been written following the same philosophy, I fear we're
> going to try make rounds fit inside squares. One of the possible

Fair enough! Agreed

> approach would be to mimic what we've done for the some limited
> controllers: pack everything in one single op (see the _monolithic
> suffix in drivers/mtd/nand/raw/). That's just one idea.
>=20

I can take a look mostly for curiosity as my intention is not to "steal" th=
is work
from Fei. If everyone agrees (specially Fei), what I can do is to send my s=
impler
patches that just support ACMD (without any special distinction between Nan=
d and Nor)
For Nands, I have a mix of STIG and ACMD, where big gains come from Nands w=
ith cont
mode.

Then we can build on top of it in order to improve Nand support (mostly on =
CPU load).

- Nuno S=C3=A1
