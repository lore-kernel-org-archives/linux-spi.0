From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] spi: sprd: Replace of_hwspin_lock_get_id() with
 of_hwspin_lock_get_id_byname()
Date: Mon, 25 Jun 2018 13:47:46 +0100
Message-ID: <20180625124746.GM9413@sirena.org.uk>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <c08a834989a8ffa841c457129d13b7a11361ec51.1529654288.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Cc: ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c08a834989a8ffa841c457129d13b7a11361ec51.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2018 at 04:09:04PM +0800, Baolin Wang wrote:
> Now the hwlock core has supplied new function to get a specific hwlock id
> by one hwlock name, which is more clear for users. So change to use
> of_hwspin_lock_get_id_byname().

Acked-by: Mark Brown <broonie@kernel.org>

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw5HIACgkQJNaLcl1U
h9D32wf/WJzH7SS7t6UorY3hEadoLBgmENS8DYT+wpi5gJpMbC3plZULUD++pNKw
g9wtWOqfkIqvzwLQtpJIlNDtuC53AJOYQqf5+7IhsmJg5S9rI9twV5XoS2fS4eUE
IX7PJTQHg8eWwwnLyqKbLJO2K58s25RAerFZjVsiU9X+DerAc19lXCqV0COhxprr
gbyETR6F1pKf01DPrkh4HXLDSa5ZVrCJWLPbqML1d+5o/P4PQ9Muh7fFp/4cqtG1
zRQR9vdTZ2KDsfw/uSz6KEb+SYHxDbXVwBqMc4xxY82rAchfitpH9Degep26GnWg
OpaRcuwJEUPg//UNzFKQhSpsJugOsg==
=Xdrq
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
