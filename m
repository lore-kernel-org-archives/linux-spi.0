Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7D434E21;
	Thu, 16 Jul 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220962; cv=none; b=e5UB2ExoCgmg/3BEIdcZW9ORRRgEf3YN0BR1xqbpibFnHDACdvU/sJr1M/nVihA6K9xkVHZWCXN99r/bpH4iQHN3p8ZhiLnkMe8SgBcwwXWH0QyVd0BWLVPQ6BkAJc7eh+x+7kvfGdL3KUm1l1V8XiDhJxkXkJpu0DTx9CZLWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220962; c=relaxed/simple;
	bh=opvgDRN70NNA4iw2JF8st6vi3mTuUaewq26i5x6B9Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZF+r+ZHqS9EkrIqPKgnvbPPnyQgIAdgMwXBp6qLyBodlVObhWv08nayd0Bwnc8yRsq3SWpRk78Dm3bWeA1CxgWOL3PhBqYbTw+kEy6Em7kfqp0r17JvsxC4XVMe4J1drBy/iuk6pVIgeFFpMnFc4MSCOextt/o3vnTk3Afrxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVC1bWAO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVC1bWAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3BD1F000E9;
	Thu, 16 Jul 2026 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220949;
	bh=Ereeer9CQWWQTY7p9qgEJR9IK6/slyEr0O3Qf6kZyz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PVC1bWAO4dg51B66wESDnUtqLkpxWy64EVf3AJlJ9w46wOyClGeBzvc+57xi17vwX
	 5zIXACKqQAQ3RtUiPhTeHXL1/Iv3FV5jVQYqG5GjUGtaeBkZd7Ta/2lswyr8nouT/m
	 I6+sad2FNKu56CPijdtftoIFk05jdxnsWS7d/97ZbjFZ0fD2kJIJpF4Npj0qwGQfsf
	 19PDtWchPIUBiZqZ9YbP3YdLu3BbUvH6nIfG67GZw19wmc9KcI26c2jiKYsZYZrV4X
	 rOw+jjqNAqZQk2gnTI/mxL3xIVLjxFk81wO8peCXAckta6aZzapaHJFiV1WpAvUNCo
	 Ep6y1PgZAcR/w==
Date: Thu, 16 Jul 2026 17:55:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-spi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: orion: use devm_clk_get_optional_enabled for axi
 clock
Message-ID: <00c4d9fb-9672-4a48-9e31-8f54167375e0@sirena.org.uk>
References: <20260715221343.474130-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ix1issenAsei+bSO"
Content-Disposition: inline
In-Reply-To: <20260715221343.474130-1-rosenp@gmail.com>
X-Cookie: The more the merrier.


--Ix1issenAsei+bSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 03:13:43PM -0700, Rosen Penev wrote:
> Replace the open-coded optional axi clock get/prepare/enable and the
> manual cleanup in probe/remove/runtime_resume with the managed helper
> devm_clk_get_optional_enabled(). This removes the now-unused
> out_rel_axi_clk error path and simplifies the clock lifecycle.

> @@ -804,7 +796,6 @@ static void orion_spi_remove(struct platform_device *=
pdev)
>  	spi_unregister_controller(host);
> =20
>  	pm_runtime_get_sync(&pdev->dev);
> -	clk_disable_unprepare(spi->axi_clk);
> =20
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);

This breaks the build since it removes the only use of 'spi' in the
function.

--Ix1issenAsei+bSO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpZDREACgkQJNaLcl1U
h9CL/gf+KUsYZPrmkE56rnp4xpA43aKu3YSiFv8BVolsrhYLaABH20+duF4/uQGn
IpEFd3/qAzfb04dKWhqpHaJxRzNgveMUHJVyu7GcXziQxAFpRMQ8dG3WY3iRVNOQ
iXSq1ejjuhPNHvu22DSl+xFi6O5d9H0ToUV5irxTH1bxM9CJ41pYl4Q97TtP/MTz
w3PbBXCr/PmIYMPX6CDoHu1K7QaDagSRTl8H1uJRyLTwRf5ze2J5WOvR72HhD2rZ
Lkyb2/537RSLapkVEIVIXnUcwzrExBeFPHkGsviioKA2P+5dT48X9DrqF0HeD2ZD
6Tx0C/F9MTAu+N8Lt8SHRmN9jZ/Oww==
=hPzx
-----END PGP SIGNATURE-----

--Ix1issenAsei+bSO--
