From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 22:56:23 +0900
Message-ID: <20150224135622.GH6236@finisterre.sirena.org.uk>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K5rlT6r/WqkiQKGB"
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--K5rlT6r/WqkiQKGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 03:00:03PM +0200, Stanimir Varbanov wrote:

> +static void spi_qup_dma_done(void *data)
> +{
> +	struct spi_qup *qup = data;
> +
> +	if (atomic_dec_and_test(&qup->dma_outstanding))
> +		complete(&qup->done);
> +}

I'm finding it hard to be thrilled about the use of atomics for
synchronization (they're just generally hard to work with) and...

> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret)
> +		return ret;

> +	atomic_inc(&qup->dma_outstanding);

..don't we have two potential races here: one if somehow the DMA manages
to complete prior to the atomic_inc() (unlikely but that's what race
conditions are all about really) and one if we are issuing multiple DMAs
and the early ones complete before the later ones are issued?

--K5rlT6r/WqkiQKGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7IMGAAoJECTWi3JdVIfQu/cH/1fG6dAPVLBUQg0T80p8/VQd
pt4mPNUOjdBaV+TJArpDC++jEHj5USYzbhk+KmDiZ8Yg4G6q26htfL4x6gNeC8d/
pLoW5dtZa/0Z+OVBmtDhtLvaSqNU+u6VfViR9DAH1UYU+OhaSFyW1GSpwEkxGZEt
p1R2EPr0IYK1NOt7KQjbv9gF/EdUc3unYPlX9eT4jY97Rq9H/ZJlJGeO2CfuC8L6
rtaVRkRyuk6/BNfmuDHKLx9N0L0AJDKbpgKYjs4vsB1DYw+sbhs0ud8fZtJMktPk
z3FhKTYZvmvAZvV1u9ERiFun+S4s1NcAFYoiObs18jJHfRHvcX2MJu+mZR19lgs=
=9BCd
-----END PGP SIGNATURE-----

--K5rlT6r/WqkiQKGB--
