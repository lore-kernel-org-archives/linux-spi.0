From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Thu, 26 Feb 2015 11:33:17 +0900
Message-ID: <20150226023317.GE6236@finisterre.sirena.org.uk>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
 <20150224135622.GH6236@finisterre.sirena.org.uk>
 <54ECA216.306@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LuH5Zozo3bmn6wjd"
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54ECA216.306@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LuH5Zozo3bmn6wjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 06:08:54PM +0200, Stanimir Varbanov wrote:

> yes, there is a potential race between atomic_inc and dma callback. I
> reordered these calls to save few checks, and now it returns to me.

> I imagine few options here:

>  - reorder the dmaengine calls and atomic operations, i.e.
> call atomic_inc for rx and tx channels before corresponding
> dmaengine_submit and dmaengine_issue_pending.

>  - have two different dma callbacks and two completions and waiting for
> the two.

>  - manage to receive only one dma callback, i.e. the last transfer in
> case of presence of the rx_buf and tx_buf at the same time.

>  - let me see for better solution.

Any solution which doesn't make use of atomics is likely to be better,
as I said they are enormously error prone.  A more common approach is a
single completion triggering on the RX (for RX only or bidirectional
transfers) or TX if that's the only thing active.  For most hardware you
can just use the RX to manage completion since it must of necessity
complete at the same time as or later than the transmit side, transmit
often completes early since the DMA completes when the FIFO is full not
when the data is on the wire.

--LuH5Zozo3bmn6wjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oXsAAoJECTWi3JdVIfQ6dEH/i01U4dPHFLAyECWxZgarSWL
6/8J05YeGghSPz6NRFt5yjegy/vuTyyEptgrKzyy+hd23Iq6bl7RMa28YbEuAd8m
9gsa/azVnI7RIPoh8qkyjTSceF6kEe4OJ0C46V6gvBjS4mwHyUWH8nJOYX9AL45q
izl6VvwhTOZXZtZaCm9mSw48Q8bhL7r0/NJL6ysa3Di3oYQNZ0cfIlhuzmy73NqT
zr9e+2LEJzQm4oXS30GxJD0Eu4eH2Pq5k9yJZm9DoAfmQVY9+VIZmQ4C9IhP/VYB
Cc4APLjLaEQZb92RwdcHa4rbTNlwhnBSkY+SnMigDN4q0n1TamEslat1tcctXcI=
=x3K5
-----END PGP SIGNATURE-----

--LuH5Zozo3bmn6wjd--
