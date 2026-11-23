Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443243;
	b=gktc9i5/6VjHfuL7G7BNTuugsLOi/Dfc9lcKu1QnXwpsAQ0VBHYX2oE94fKWyeloMXNV
	 C++RlERPyFrIi4b+0STvR/VUDQwTp19U0mAFY4JCKaniCYxjPbluPVgBRcguxZglcUBra
	 N6c3mXdGIgpVryRODBFT5gu3lRJtUhPJq2dEWeWtuCpg6RtqtJ6IrRB8Yrf+5XMrZTaRz
	 +MxlB4ViXHAAV5L09cuTtq3e/ekNxMvyGWpxmsi5LXPrq1LdYH6kbDd3kbYXvBWcc5oNq
	 2bGDrkdRr+lnOEgryi6lTjfu6JNZ1fHyO+b6lDTxVv5FZNXiSuBdzMUl7cr/1Jr/umg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443243;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=nsdKbIq36FccgQPqfh448GwbaW+3f8OpmGVjFlQ7f0g=;
	b=Ja/a0BFoZUbybdCkQExG4bL7xwdYu2yyIAQQEri4YVKXws4QcA/ODx9JMQOLYhNYYGzy
	 XMd4Ar2YsaASFgOLdLjXgvI+XDb8+Qf7LfuLpGN91CvbvF3jJfenveZbK/A+bsE9xkhRj
	 Mfm00i5laHjY76Ts28mOa6jGYNqkM3gs5+QnxjiCUwAQUwFz8Cmwj4Vn/Mb8fuqGOMfc2
	 9KoD93SfKSGNGOg7AF4rasuVxhgGdzeZb3z2+xNvCCbC2db0vyJZGnUlgEqH+Ksv+1qT7
	 j9vUCiJgTsIQgkAsjABAHmvYTSDzqMe+sep9WX0WKZ/lSyuRjnjyjmFQ9lOxibv8x3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XnhYjMjT;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE3606A31E
	for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 14:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28EE3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XnhYjMjT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 313E2C69149;
	Mon, 23 Nov 2026 14:14:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D33A601E1;
	Mon, 23 Nov 2026 14:14:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0DED11E6A4C1;
	Mon, 23 Nov 2026 15:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795443234; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nsdKbIq36FccgQPqfh448GwbaW+3f8OpmGVjFlQ7f0g=;
	b=XnhYjMjTclObhst0aAEM0y3bJQXQR6cpMOqc6MhJ3wSz/AlktiY1ml+VnUwWOMiOCUl/Dq
	OUYl5eOOhsyZNKYGbmumLIbXQV6QwCfpXQ45y7DHeBAIlya9J+WnIvcs9xP4vq3XZybDZG
	2/c0Jer2kVEydpLrpjkpMtTx0NYGlqtfkdyIrw9FVX8eSVx96mYCG3WvOAuH7HJRTzc4h8
	59Y50GvwIW+XmJP+JxfwzbtnrC1xrQkL4foNpEy1W+zJkK5dsy3KmqP3DVOFHhLsKO5T75
	aANYJSXHsZ8qedaAwFOPQbo3gwJ35/zobcxZFj9hCKw//+KuX8fk/wW3E0GkTQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Mark Brown <broonie@kernel.org>,  Kees Cook
 <kees@kernel.org>,  Tony Luck <tony.luck@intel.com>,  "Guilherme G .
 Piccoli" <gpiccoli@igalia.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-spi@vger.kernel.org,  Bharat Bhushan
 <bbhushan2@marvell.com>,  Sunil Kovvuri Goutham <sgoutham@marvell.com>,
  Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH v4 2/7] mtd: spi-nor: Wait for NOR ready with
 poll_timeout_us()
In-Reply-To: <20261016102917.171095-3-paul.cercueil@bootlin.com> (Paul
	Cercueil's message of "Fri, 16 Oct 2026 12:29:12 +0200")
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
	<20261016102917.171095-3-paul.cercueil@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 23 Nov 2026 15:13:49 +0100
Message-ID: <874id7vdnm.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 16/10/2026 at 12:29:12 +02, Paul Cercueil <paul.cercueil@bootlin.com> wrote:

> From: Tanmay Jagdale <tanmay@marvell.com>
>
> Instead of polling for the spi_nor_ready() with a custom loop, use
> poll_timeout_us(). The sleep period between two polls is set to 100 us
> which I think should be fine.
>
> This will make it simpler to support waiting for the SPI NOR in atomic
> context later.
>
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
