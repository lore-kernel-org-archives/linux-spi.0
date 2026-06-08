Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329633DED9;
	Mon,  8 Jun 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924251; cv=none; b=gMdCS4uWoE3ZmplUvuBisrxDCvUlmKIE4tUKi/MF2j9d5k9BllbBHqsJPUVYUddOo6P3JoBuxPF5Ct8iFBJ+Og1Wnx0jZnJ0LEd9KPRrl7nzAleDagCiW+SwLMSIGdKlrueDK23t0v7PsgulezBMi6NnBS8Pstn7Md4AuKn1kgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924251; c=relaxed/simple;
	bh=VogCyLdvDW5H8sltNmAsH+uauN1WjwiuuQJATMB0N0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGodkz2KAxh3teK6e7ffW+rhN5bOD34yixFIg5/cyn2UR5gAKDmkq+t02I2RmSCHg4q20fvFsji8uNOYgOf6TtOy0crTo2AvDxNxbv6KB5/h6RKcD23+WWhfb63Y3ta0SGuZA8tYDT8uFaA197b6nnHVQnQ9OaoJSwvM9FSO/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7dnG+dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7dnG+dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45F51F00893;
	Mon,  8 Jun 2026 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924250;
	bh=VogCyLdvDW5H8sltNmAsH+uauN1WjwiuuQJATMB0N0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W7dnG+dPIKxos3JbC37N+Y2SgC+z8B8lrrNzNXFBljVXxAi+6EnKiCyCa2RqlqdfW
	 LekFyuyB1pT8GjTJpmHT/YFfVCLAMSXWMFH3bCsn9oESeHwbTUqQtu+ERzxdoC82QP
	 PNVIpU/FAe5bh0OHQK2IxOgCK6HEQmXBmselcON0eaVnh6VFb+eJdfbw8P5Hl2Hyz1
	 zgVoqVkGxsY17g9ARrQSIzOxfaxfS8yb1gi8A4BUtcdGdQms7nTuDw/8pog2gczuAH
	 6UKrzh5tJZsehuyBncJC9WfA3l9vvutZ23m7S4+84899jphNuFWz5dDhzK+xr3cRpf
	 nyfogbc6Sj3XA==
Date: Mon, 8 Jun 2026 14:10:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Peng Yang <pyangyyd@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Jonathan Chocron <jonnyc@amazon.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, pyangyyd@amazon.com
Subject: Re: [PATCH v2] spi: dw: fix race between IRQ handler and error
 handler on SMP
Message-ID: <7f21d199-bddd-45ae-9617-6a56f05d8b6d@sirena.org.uk>
References: <20260522095727.18307-1-pyangyyd@amazon.com>
 <20260608095849.3446-1-pyangyyd@amazon.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4+VOCXcdD029A0d"
Content-Disposition: inline
In-Reply-To: <20260608095849.3446-1-pyangyyd@amazon.com>
X-Cookie: We've upped our standards, so up yours!


--c4+VOCXcdD029A0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 05:58:49PM +0800, Peng Yang wrote:
> On SMP systems, dw_spi_handle_err() can be called from the SPI core
> kthread while the IRQ handler is still accessing the FIFO on another
> CPU. Resetting the chip via dw_spi_reset_chip() during an active FIFO
> read/write causes a bus error.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--c4+VOCXcdD029A0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmomv1UACgkQJNaLcl1U
h9CjGQf/eYs/L3ywRdpV1VXYqmshtwhAy6P1OdIM9LCdcY9pOTWBvXK1sHk2aBY8
rRejTP2eDt8uhwCmKqIpXDxTCNmc+dzXis9jjYMQXhabsMPjSRcGyV4s830IajHO
jHzQp6L+DwnaAADx6J28gzcXHEwqUCM0tkbuS0dNXMSy/TBjP1kf5efutFmXt7+5
JKP2xEbddU481RFx4FlN829GmnGAGmC+urM/LblQ09qDgCyXy9vF08d/4WTjtT8z
/ADduQAH8qYy5x3ld7RZ9OF+giwfkUaDY4CQ4bLasgVoaTbfoRZSxs2clAGE85wa
Ju7oi5U25mP7IL5vyv/8J5mSgGbMgg==
=ALDP
-----END PGP SIGNATURE-----

--c4+VOCXcdD029A0d--
