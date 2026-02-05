Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A1242D62
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312938; cv=none; b=nXzXYGvJ5LlRk2/51QUyGZXcshNdwp3Q2S0gxGCHdestvhWh5PLsMq5FluaP6FbJJfRbZMmNeSw3c6tY5JX4lqWeQGbJbWMn8Hnx6H9UcDLuDe3KS7W5Fi1+wPd6e3+o4GrNmzYtC+G4YybhKyxaLfpTUZ246trTaArQEy2E1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312938; c=relaxed/simple;
	bh=tV/ZLocVZdBi7hgAdczYvyRfc5thw1DladriRmwpiZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GahvEoDgNGsyFWc3HdgKAAqHq38+jV0btTlNUyWOV8DeyLHS16nZSc/95HAf4XGbgs0R9H1vsK/fPtfiXLRid9Yev4I6WnE2EvJYVzU3ermd1nL2RmyRkV/q2qR7eatfPoxnE9yYgLeBry8kNQ7PXpuS0LAJrvTRGWx3v1gzb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cxbb8ktH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cxbb8ktH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6039EC243B0;
	Thu,  5 Feb 2026 17:35:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 324B86074D;
	Thu,  5 Feb 2026 17:35:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24EF6102F1B6D;
	Thu,  5 Feb 2026 18:35:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770312936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tV/ZLocVZdBi7hgAdczYvyRfc5thw1DladriRmwpiZY=;
	b=Cxbb8ktHo2yBQiTArWp/lYhUfxUNbY8ZX2qFF7G9B8VjboTXDRIfVru1OveyU/lvL5LDeM
	ZWXiFBI4h+vF9KM+jHRvi/c4fyQXoiigy6paI4Ab4dMRPsz17xTFsASRiixzewVNtWZ1u/
	L76AB4t3hNaNVUV088iGe1D3jafpCLkYMs6OqzdccpOWwPyfau9gtISd2z1enY6cdHlxff
	GjkU/fzlnm9YrS3wjLDsWGFt5mY4mWwzeLGfYIeHSoqMZoTqx8VELBKSDWKZve3W6uVovo
	p/JABkwcTism9riHOl5XbIEf4Fpx3LxoG5Ew/zTY5YFO0VmTbGvpO6Af2lerlg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 06/12] spi: cadence-quadspi: move
 cqspi_readdata_capture earlier
In-Reply-To: <20260113141617.1905039-7-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 13 Jan 2026 19:46:11 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-7-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 05 Feb 2026 18:35:33 +0100
Message-ID: <87pl6jgkka.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 13/01/2026 at 19:46:11 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Move cqspi_readdata_capture() function earlier in the file. This is
> preparatory refactoring for upcoming PHY tuning support for read and
> write operations.
>
> No functional changes.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
