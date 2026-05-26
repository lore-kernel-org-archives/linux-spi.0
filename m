Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9A331214;
	Tue, 26 May 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795229; cv=none; b=eB8A2Ws+W/jzW/XG7ejlw/CC1irJflecDLvzhfunZ00ET5j4MjYNh87OEdkO2NSqTN51ppo1RBPkkyLPKgSYMaVBzZmzhcJ9V781ZqsD1WWyLoYcYMg6gLgKZgOqHSxMMgV6ua0RRgqsk/mDRPZNxkIHK8jegVXm9xWlK3yFwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795229; c=relaxed/simple;
	bh=PPCK9akiy6fH5UxzPtV/3xckKmAmimhOfe413SkkRf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSqx94upMbYcBvoroMx7iPHPmYJqBt/kgjsw4e2MFmoQED+Pu2Ao/AZFsfPsKHl/+dA6BxvQoHl/Nse7g337BgWLWgfJuh785kEbiMIE9V4d7G/0iVzCB0cbqslOBZB6B2ImRuOhorMbDSghAcSXOAYAltosj0SQq6BiGaFO99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUDWcnUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUDWcnUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1751F000E9;
	Tue, 26 May 2026 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795228;
	bh=lExycXup3Kth53PS6pY9jKXk3+KgKe19U45fFLAJd1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUDWcnUkQiNkpbbx4ukm7S0i33GqMtgrdzDEbs4qJRqZh9ztuAiTUwY4sCYt85bXB
	 vITI3SLUTyhg/UWiiplgUwiPCSfjkCiMctXw7WRXa7qBhdx1uT6UTz8M+KapvhhBrI
	 q25AOd8XxvVZZPl5ZdWniq/OB6Li2VeTA81U6QFBuNJCS7yS6ngtytkEgnJSd+Os81
	 rkKqD0tf5EEbzmlXGlLtSYpqjZtyAZHENHEyrz4++kx6jmfHjnAn4xyEWZ7hcitbNm
	 l8nR5Lx8p99NPQIzvUOIPvms/mhII4n+EGap5MQkCGYBXvO7H7XN2udCU3Pm/IAl3Z
	 1V5NT63S+uMTQ==
Date: Tue, 26 May 2026 12:33:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Yang, Peng" <pyangyyd@amazon.com>
Cc: Peng Yang <pyangyyd@gmail.com>, Serge Semin <fancer.lansen@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: fix race between transfer IRQ handler and
 timeout handler
Message-ID: <a18639a1-9d67-4418-a495-8dd218e0d47d@sirena.org.uk>
References: <20260522095727.18307-1-pyangyyd@amazon.com>
 <d08e1763-1130-48ef-9804-22e708c6e8f2@sirena.org.uk>
 <TYRP286MB5365F4E370E3F4862A598B56A60B2@TYRP286MB5365.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bNZdUP9LnAAoohC9"
Content-Disposition: inline
In-Reply-To: <TYRP286MB5365F4E370E3F4862A598B56A60B2@TYRP286MB5365.JPNP286.PROD.OUTLOOK.COM>
X-Cookie: You are fairminded, just and loving.


--bNZdUP9LnAAoohC9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 02:18:39AM +0000, Yang, Peng wrote:

> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> The race I'm fixing is specifically about the local variable =E2=80=9Cmax=
=E2=80=9D in
> dw_reader()/dw_writer(). These functions snapshot the FIFO level into
> a local =E2=80=9Cmax" via dw_spi_rx_max()/dw_spi_tx_max(), then iterate

That doesn't mean that's the only possible thing that could race.

> Regarding irq_status being read before the lock: this is intentional.
> irq_status only gates which code path is taken (read vs write). The
> actual safety comes from the FIFO level check inside
> dw_spi_rx_max()/dw_spi_tx_max() being protected by the lock together
> with the DR access.

What happens if between checking the interrupt status and handling the
FIFOs we call dw_spi_handle_err()?  The next transfer could be started,
updating the buffer pointers and lengths in dw_spi_transfer_one() but
that doesn't exclude the interrupt handler.  That's also already an
issue, but it's complicated by the thin locking windows.

--bNZdUP9LnAAoohC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoVhRgACgkQJNaLcl1U
h9BztQf9GMbk3oUZ7OdvqbLGHKKr6ghiKD9NmByC0DqYHHyvALmIhPng5/rNEN9O
YI9GRH/HSyaoTMYXWRcD0M91lEpv3MWdCFubwiPjOfk1/gMymbwxe6klPAawbjsr
XVe2JBCQNSWePrX5PsNjM9piUkr14jGZCJGQfw5PP9+j8IjNiwmt9ti6CVgjiaTt
t6GEhQ7gcRa8IO6qxoS69v3tMi0n5MZotCXoY6osGT2AY7ndZOUsKh/K22JV4b0c
DSUGAsUkdeBAiDJkaBqbFX61ZVc+azmfHBOAEKBtKY3ZBP3t8E5o0l4fJkhXMHvX
FOLDTacNfqkLlV2UAhW6M0y59nWASw==
=zRDp
-----END PGP SIGNATURE-----

--bNZdUP9LnAAoohC9--
