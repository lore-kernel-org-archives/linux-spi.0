From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Wed, 23 Jan 2019 17:56:09 +0000
Message-ID: <20190123175609.GG7503@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
 <20190118191202.GG6260@sirena.org.uk>
 <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 20, 2019 at 12:24:23PM +0100, kernel@martin.sperl.org wrote:

> These kind of changes it requires are consuming a bit more time than
> I was hoping for.

Thanks for trying.

> So maybe at this very moment the best is reverting the patch.

Yes, I'm just going to do that for now.

> As for the root cause of the regression: my guess is that spi-mem is
> just not triggering a shutdown any more because of how message_pump works.

I'm fairly sure that's what's going on but not been able to get my head
around things enough to figure out what's going wrong yet.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIqrgACgkQJNaLcl1U
h9Bo+Qf/R2oUsHmOVhx2IGtp1A69vFPJrwFZJXXjknp2y8JDfLjNHRs47+iFmpfJ
82jx8AMcTpYf4r4p3oAixX+huXXWP9sVD3jIx9jg4Wh7Nzjg/hqUhZlv0kPl2C0/
gdFt6vn5gW02ebILvzT8aHQAovButhjV5KObxCKfVJjLC7MSjrrZ66Nu1rIh7HEP
943ED4O4MSfCrkvbICr8QFEe+dNmlqnh/g1sfo8VMMuVQvizAi7axq7nm2keOMH5
owQCS7DkgQGa3q9ra8eYwVGwUCDSAt/gA9ccZ31zXmyX1U4FGkqzndh7t1aC0Ij+
qSH6CmkqaFC5X/Vl2ft/5RTPYJnOVA==
=qwRN
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
