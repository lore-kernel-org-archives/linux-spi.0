Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193319;
	b=5jdxo8EDbRsnA+IY3hORa5hq4jBuOPqoYeCZS1uk6DPha7IyZlkkMbEAO6OLXcizxWve
	 1ddj3tSfCorx+zYeo866ZjQPgT9BQbL5WYTfWkI38057xbcnRQEGxRvYgIv7az2jDRkjB
	 KCITGKgvnmFjv0xRdRWgSlvYvnGlf5Y43weMznsGpUnTJHjeb1JqYxI8MNdO05R5xUUKy
	 NTc3eDrP7l34x+iEWQmIkkE/7bC1QiuRZJhnFk1HY+OXEuYV6RToJk+p4ybGaKImqq7WT
	 vH9/wqXFQPIvGxWbTmooAtq/LSyYwFu6g6mFlZaCd6Zydt9ISmeJzQ6CIu5zOdmEMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193319;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=X9Btf5XhOqdmeGG64jS4Slgjum0vmoxQYvsMqkyuAm0=;
	b=q1818qW6jlT1UJiQFJsI7stZiKC5jAm7j7psW2L3gUHRle8YLnM8wGb1hBeRNDcpU8Uf
	 hQNb7KPKjWyd7btZDjquuBXkX2pW9A1x0JHXMVbPgBi6rWg7rl1bCTGPbcDE5SD7fDDUu
	 KYF6goi0MASl7Qca1FFlS4b1Z2hlaBjt5CapKECq2UL71GSi4FAEKsOICTXXRMUGPyRBL
	 yGsGuaxRTZJRzEMuMWzYstqXT7n9Sx6wwqc7is5Ay8XIk74Z9om7JGCOGr4aoSPHwynVs
	 8kAheKtChiHS5w9B6mjHqCeFe87CaJNcNgWWaEdjZMtsl2jiUrpz3NRwNeb/98RvORQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HXMPqtaF;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AB606A31E
	for <linux-spi@vger.kernel.org>; Wed, 28 Oct 2026 13:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HXMPqtaF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4EB1CC4FED3;
	Wed, 28 Oct 2026 13:16:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5765360769;
	Wed, 28 Oct 2026 13:15:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60B931032904F;
	Wed, 28 Oct 2026 14:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793193309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X9Btf5XhOqdmeGG64jS4Slgjum0vmoxQYvsMqkyuAm0=;
	b=HXMPqtaFe6tOTgCdgNq63gOjGLoD81XTo0eU2xSORaqhJYxwUFPh1DuTFkrKOTl/bDr90D
	sZslTZoFozi9koBKKQ5/LjyLJrpC8KNB5hc055TsS/ZHXQG/GpyUEtqdOZCRmGdPS6mhZk
	xpKAka+Nkx1+rdLCmeIQzx71XcRzp08jpTgyLfoiY1a0MhBhU4V7ICiD0A8Re4mkUjyhgA
	NS2LFXXIFHaiYE2WIBYiiv2f2R0MC945QYx//nwxVgN5tqq2TTt74Aw1xBAkavdSYarpd+
	Hz1miIjW61CvLfUIaEdOaI4A4cbE9RDUkutMfmpqjj1jsm22qwHxi/0bOMotlg==
Message-ID: <cf96edf1cba37b775817d4df5f759b10e71c73da.camel@bootlin.com>
Subject: Re: [PATCH v4 0/7] spi: Add support for panic mem writes
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Kees Cook	 <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G . Piccoli"	 <gpiccoli@igalia.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
Date: Wed, 28 Oct 2026 14:15:00 +0100
In-Reply-To: <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
	 <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
	 <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Le mercredi 28 octobre 2026 =C3=A0 12:59 +0000, Mark Brown a =C3=A9crit=C2=
=A0:
> On Wed, Oct 28, 2026 at 11:42:33AM +0100, Paul Cercueil wrote:
> >=20
> > I have a second patchset for spi-cadence-xspi pending (unrelated to thi=
s
> > one)
> > that happens to have some Fixes: tags, and those fixes conflict slightl=
y
> > with
> > the changes here.
>=20
> > I'm thinking that in order to make it easier to backport those fixes to
> > older
> > kernels, my other patchset should be merged first. So I guess I'll v5 t=
his
> > one
> > with a rebase once the other one is in.
>=20
> I have no idea what that other patch set is, sorry.

Because I haven't sent the other one yet. I'm just saying that since it has
fixes it should probably go first to make it easier to backport those. Basi=
cally
I'm just saying "don't pick this one quite yet".

> > @Mark, do you want me to wait for -rc1 to send it to you?
>=20
> Please resend any new feature work after -rc1.=C2=A0 Please also do not
> misspell my name.

Your name is not Mark? Or where did I misspell it?

Cheers,
-Paul
