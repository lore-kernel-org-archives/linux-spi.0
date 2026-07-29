Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872F40A926;
	Wed, 29 Jul 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320045; cv=none; b=f27+L3/zk6RgRN3+YBTawsQxppVdWMOrzgt8WuOlM/TD1QQr3JaltJ4l29lGSS+anManGIQ3qxrFyfN3yOVayos5ws9Cp/6EOKR1MF1AL+5eJ32PrEMHzHOrg/l4xupVrlwaUJP1gf/TOnBgZiGN3/f/UTfet7pS/umy76aXD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320045; c=relaxed/simple;
	bh=WYpGmaQk/hYXpy2pbpM0H+TWIPstNv3tL0UdDJGTLQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxoyMgy+52DBCO0/Oba/W/qEijH58VHuIhGFbljnDob/8Daz2SVdlaGpjIMMmoTWz3eFjGYHy5j4dn+I/jtpwH9IA/Qf2ydQI/Wy3U4Drur/uw9fCN3ZuDmm3ScPw3jf//Ow9wxoIohyIuaQxvUkLt75jzXE3EbL7tQ4R0b6al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0HyzjLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0HyzjLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171961F000E9;
	Wed, 29 Jul 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320044;
	bh=WYpGmaQk/hYXpy2pbpM0H+TWIPstNv3tL0UdDJGTLQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f0HyzjLjt0UoKnM2OuuyRhkX81MjzHc1QKe7RNSpc/qvvg0JvnZYuKz15kmmIWCtt
	 yH10R/3so9zTBxIlJngcAkG8FbMuBvdM6nraq+d2KaASb2KJWKQvOn0rMn2mC4aUUs
	 j4VRATASc/bkWmqDJUhZbfErlieJWx7DxpMj6jZkq+BGVg1pVxepbumkxzB83lcx8T
	 xqpe/W5sqcTlNA6cYoiRCJngvreZxqVP7NjzItDBlgul4UUq8UjzllfEiFjyutAmzQ
	 bBNsD+i7eKhXLv0XEuXLjT1LD42Co0KeJeKYdi1U8oF/UepshRRDvcbNVTYmoZS5Za
	 iil4LbDqzwHjQ==
Date: Wed, 29 Jul 2026 11:14:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
Message-ID: <4deace04-fbbd-4b45-ae9b-683a1ea891d8@sirena.org.uk>
References: <20260725042944.1204409-1-abe@maticrobots.com>
 <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
 <20260728025503.162543-1-abe@maticrobots.com>
 <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com>
 <20260728200316.1363536-1-abe@maticrobots.com>
 <0513a557-762e-4390-b5f3-84ac26a38de4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cde329U7yPqeTeFs"
Content-Disposition: inline
In-Reply-To: <0513a557-762e-4390-b5f3-84ac26a38de4@nvidia.com>
X-Cookie: Captain's Log, star date 21:34.5...


--Cde329U7yPqeTeFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2026 at 10:09:43PM +0100, Jon Hunter wrote:
> On 28/07/2026 21:03, Abraham Zukor wrote:

> > I think that defaulting to active-low is correct. The Tegra234 SPI
> > controller hardware defaults to active-low (all bits in CS_POL_INACTIVE
> > are set) so an active-high device is already asserted before this driver
> > initializes. I checked the controller drivers under drivers/spi/; they
> > either default to active-low or preserve the hardware default.

> I am a bit reluctant to make this change after 10+ years of this driver
> being around.

Yeah, I'd not be surprised to run into existing systems that somehow
manage to rely on the current behaviour.

--Cde329U7yPqeTeFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpp0mcACgkQJNaLcl1U
h9Dnvwf+I/lKyRrYbNSnmb1kNGVIVtI91/wWdmNRaO896sp6sPB7jB7C0KlELyiL
S7lDuyAGhgRiUjXDLmXGsFNfTkt1lYWFlAiNGHBv8DmUh2jnrSmmdbnIke2GDWVw
nwFOS/+WalRPr5BbhTYjNQpPbxOvElbzoVM+b7eh4WhQQdu/kJ8pPjf5g84/AQey
jfQy1PWqHdDCkKXkCR3EbrMaMaFMO9p9wo+5l5XgomBXZv0qFiKfusr9ZFvBtnXK
+JT+klHSk3IyEm11/yQ4Lr5G0knV3NMprLHCRv1qDXAFZF427wsBpitNdqxOzZZ+
eo5egEx4r5D6NNCtY7bYM6tVxlK5zQ==
=qVl/
-----END PGP SIGNATURE-----

--Cde329U7yPqeTeFs--
