Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4A383993
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716398; cv=pass; b=jeWInDE2I3ALUcXmsOWuy//397eSLBLfgEHVANQoIUHc1oddjYXxggtW29Ifr6ByLx0prGPFtxKkRA7wAiDMST6a79cnqZAY6Ew6vqPRzVdeZ1jH/VsN0azi5N0MDFPrwG4aMc//+95Tr7qfyr3qxZS8MxQzH9qGQSiJbiGGQPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716398; c=relaxed/simple;
	bh=NjcoxtPxAXPyy+r6qEG8tR6sVU2Znv7M+7Rf2K1IM6s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/e4Q3cwb+y5mavlqvcIHshu3+MRiruYEcrfPTfXNm1lT7CgbjvASH+eujuuXKkMawFFhUmYyer+6d0xLLGAQ0Q9Pew4X2Bedb7W3SAfqk8AS6Jq16l1xNeKtaagE7Zyg18nrLzheY32GPkyroWaeCD69u9M1tKvy1vtD6Rk7l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Hxkft0Kv; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Hxkft0Kv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so1669418266b.2
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 06:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779716393; cv=none;
        d=google.com; s=arc-20240605;
        b=EgcYpgxmEE/OxyuqtIEf9TP7mzEYNaRudmFdWd6zyx5mr2vDiQpFUE8cV6vP5dczGP
         z2fEqnwz9Dr0zjSCcy4Yd3ob/3OWrw0auFOhSc2UodfTkJGixgwHDO0DZ9wx3jiQ09do
         +YXu2vb8qd2JSzTGT8Rh3jgySPmWA2bBE1Fyj114LFanyemFTd87nQ7j0P4MbKI8jdOT
         w3sEioPlByqOXrPzGS1z6j6PvitUGX15g8sMukNRwIhqRhAm3A/MfrhAoaH98VFTHfMA
         dEHpIrkbZVKG6MqXjUQ/q3KysAxhfqrO6kDnTS4NTLMV0HezchaeYuyG42uRJA6vTAcR
         ECIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        fh=ZcMSHPXd3U/pnVDduSAtKHATP0UmOO7JPpKpiaiMRZ8=;
        b=VfXL4SoaRKP6Pl7KpTB3ne1jqLLL470SFZZEq8vXmTuB98JbF1SM8lj0Hu64hpQUMw
         i0PO53qokhxQ6lT6BtlijD9eWAM3K/Oc9rUmbhUAWav6q8GIIw+5CnXEuGsjbY+XVpIP
         uV9EWcmVPzpSjxZoEU6YRlBYgvuTNnLM0+aZUkNTfTK9WIPiQ5ecMCq99Y+07VuChe/k
         f9PBc6c9DrJ+qfdUCjGij6xN/VJMwI1fA1HTmCFnTCGWCcfrXGi7gygNMLBdNsdUimEv
         q1LNVANNUmD+toqp1o5pRpxxopOdpZfgpbOtHvqYitkSMUVFy5GHsMuwiHty5TOvucyW
         6CXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779716393; x=1780321193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        b=Hxkft0KvERMTMzXxBOlEr+W32q8Kan57nvrkaB+PJ8ITksriR6rgI0qC9VTOSLr1Bf
         kogt7MG/kMnTrMgaaI3TmrgX9yoY1/liPHUCu0rbHgQ637XtxKyacCov0miYljweQEFm
         xCcMHhiDlI50D1uVioaqqE3YXcpbQYqj0p8WwUOWSdkTWgGCUImac9TUUIraBxRCS710
         Gk7b4a6+XukROM3clvflFf5cjBUvjjQWdpJ2GrDfDeAuEEd8RH/GhxpoNBda+QqzobWl
         Wz1AJW5PLxq3DG2SIGRkqqMLIL+mc31Uxb9qV+CSI9bcbd0nX5iPZPWAclklz/8OwkuT
         +mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716393; x=1780321193;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        b=REeCouaYV7FhckgbEKpKdXBmQvW4nmavHBL1oY3agCXuzi3lOIbU2aXzi9X9kFSQIr
         PzR7cs4ob090hTbI2aUuEAZbNekSd/gQHwCrzzsaoPXDvjBAKvI8DEq28VQXurw0Kb2f
         1DqD+0ddSBeGJhBUN7x3utD2PVdUGAI2RRtLoMx5FXmzSWkPxIJWttfgnZTLPkFJ5yYl
         NVaKXyKUil39i2RA8+XHDeYn+tlVWU0JRHDWIpucmkPvRtsO1vpZGo9xpIEvZLvbzWre
         g0Jx2Xoa9vlWvaQ5tpvRCvZCUJLPv2IAnutm14Zub4xaaKmbJwzcD570C9WOR7IrvRXy
         iWxg==
X-Forwarded-Encrypted: i=1; AFNElJ9+w3JMfJl7fcQTG1QY7o2s9NBzFU98IxaXS0hZ3TDLoURqy3cHg7YMBxmpCuxGfvBYnxu/cqmO1LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYez5HyC1US98djqqrkOAiXvKU/UTf+Y5CrYVs2c6I/3FI8SIZ
	Yzf76TsR7Pl/AtbvRsuwba/mVy9rCiVFTLMcPzrOXilsPzNMyRwxM+HySrpl/HOGVZWXaqhO6jN
	UOJdmF48EEWDb9Zmby9rPu3OFtwL36phKLbG1G2mwWw==
X-Gm-Gg: Acq92OGbrsmRKb/A6WcMl/1CT/6qDXQkuJegEL0Oa5nsvKSFqa98MAa9geyd6Ip/W7N
	ULVjI/OWS/ku8u0OOwvahpXyTEPnWLM+rmD8XTGr1AtV0u5jt9OQ034rVqLVgKUFqacu/e3Jy7D
	axrPOiN/BnvaSCftWJ2Ar46ktgqesyo4zM8h94q6RLXhHkjEDfkBY6Rt6e8NZTzKE1J9NSxvTf+
	2pe9KIeuR/OntGKz6rMsmiKJD7mvL26QGml510YB7L9yCbf4WJ/x7xfHxQfMvjRSRlwLZK6YPjh
	iHJ8ow4Vz0W4/YtlZnfkCPXSgCmO1I8nowtV
X-Received: by 2002:a17:907:3c8a:b0:bcf:9dd2:f79e with SMTP id
 a640c23a62f3a-bdd26cd265bmr861792166b.29.1779716393446; Mon, 25 May 2026
 06:39:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 06:39:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 06:39:52 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com> <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Date: Mon, 25 May 2026 06:39:52 -0700
X-Gm-Features: AVHnY4LbckeKGYKU7CghJurgC1FodfGLzJmAolw5gCW0YFJ46Zr4ueny_XzVmqs
Message-ID: <CALSJ-wBfn9vkZYM8AfB3SvCH-AkuYEW9ccQ-p3N+GWR11da5dQ@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg and all,

so i posted a patch this morning to have edma driver back working.
If approved, i can proceed testing this RFC (adjusting it as needed)
with edma and dspi driver.

Regards,
angelo

On Sun, May 24, 2026 at 04:34:03PM -0500, Angelo Dureghello wrote:
> On Sun, May 24, 2026 at 02:17:07PM -0700, Angelo Dureghello wrote:
> > Hi All,
> >
> > On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> > > Hi,
> > >
> > > On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > > > Hi Arnd,
> > > >
> > > > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > > > >
> > > > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > > > >
> > >
> > > About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> > > i probably lost some dma config option.
> > >
> >
> > so i worked on this open issue above:
> >
> > - moved to master and rebased,
> > - crated a wip/edma branch,
> > - bisected and found the offending commit, before this, mcf-edma driver
> >   and connected spi-fsl-dspi (using edma) was both working correctly.
> >
> > 7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
> > commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu Oct 12 09:52:27 2023 +0200
> >
> >     m68k: don't provide arch_dma_alloc for nommu/coldfire
> >
> >     Coldfire cores configured with a data cache can't provide coherent
> >     DMA allocations at all.
> >
> >     Instead of returning non-coherent kernel memory in this case,
> >     return NULL and fail the allocation.
> >
> >     The only driver that used to rely on the previous behavior (fec) has
> >     been switched to use non-coherent allocations for this case recently.
> >
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> >     Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
> >     Tested-by: Greg Ungerer <gerg@linux-m68k.org>
> >
> >  arch/m68k/Kconfig      |  1 -
> >  arch/m68k/kernel/dma.c | 23 -----------------------
> >  2 files changed, 24 deletions(-)
> >
> > So i can try next week a patch for edma looking what has been done
> > in fec, and since i am probably the only with mcf54415, will test it
> > here.
> >
>
> Looking into this better, looks like the above commit was meant for the
> majority on non-mmu ColdFire. I think mcf5441x and some other with mmu
> enabled can flag pages as "page cache disabled".
>
> So i would re-enabled that code only for such mmu families.
>
> Please let me know if i am correct.
> Thanks.
>
> > > > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > > > >
> > > > > > About how it works:
> > > > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > > > >
> > > > > The twist here is that with the way that readl() is defined on
> > > > > coldfire as a non-swapping operation, and the generic
> > > > > definition assuming the opposite in
> > > > >
> > > > > static inline u32 ioread32be(const void __iomem *addr)
> > > > > {
> > > > >         return swab32(readl(addr));
> > > > > }
> > > > >
> > > > > the function called ioread32be() actually tries to access
> > > > > the registers as little-endian. I can see two possible ways
> > > > > we got here, but don't know which one is currect:
> > > > >
> > > > > a) the device actually has little-endian registers (like it
> > > > >    does on i.MX, but unlike all other coldfire devices), and
> > > > >    you just never noticed because using ioread32be() worked
> > > > >    as you expected.
> > > > >
> > > > > b) you tested the driver using an ioread32be() definition that
> > > > >    did not have a byteswap and it correctly accessed big-endian
> > > > >    registers at the time, but the version in mainline today does
> > > > >    not.
> > > >
> > > > Ok. The ioread32be now works properly since i had applied Greg patches.
> > > > I generated an error in _probe on edma channel 2, reading status reg.
> > > > looks consistent:
> > > >
> > > > 	iowrite16(2121, regs->erqh);
> > > > 	iowrite8(0x77, regs->serq);
> > > > 	iowrite8(0x12, regs->ssrt);
> > > > 	
> > > > 	u32 status = ioread32be(regs->es);
> > > > 	printk("%s() status: %04x\n", __func__, status);
> > > >
> > > > [    0.140000] mcf_edma_probe() entering
> > > > [    0.140000] mcf_edma_probe(): allocating data
> > > > [    0.140000] mcf_edma_probe() status: 800012f8
> > > >
> > > > If i am not loosing myself in this r/w labyrinth, the path should be:
> > > >
> > > > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > > > 2) So the ioread32be swaps the standard LE read giving BE.
> > > >
> > > > Am i correct ?
> > > >
> > > >
> > > > >
> > > > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > > > remember, anyway in little endian, independently from the cpu core
> > > > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > > > used for tcd area accesses, so the IP module was built.
> > > > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > > > >
> > > > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > > > that is used for normal register access, so from what I can tell,
> > > > > they always use the same endianess here.
> > > > >
> > > >
> > > > If edma_readl was using
> > > >
> > > >         if (edma->big_endian)
> > > >                 val = ioread32be(addr);
> > > >
> > > > and never changed, without Greg patch, it was likely returning little
> > > > endian for coldfire and correct LE for other arch ? :)
> > > >
> > > > I remember something about tcd area was coded LE, but will investigate
> > > > better, now i am over midnight.
> > > >
> > > > Regards,
> > > > angelo
> > > >
> > > > >       Arnd
> > >
> > > Regards,
> > > angelo
> >
> > Regards,
> > angelo
>
> Regards,
> angelo
