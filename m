From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller
 documentation
Date: Thu, 7 Sep 2017 12:44:01 +0100
Message-ID: <20170907114401.kz2rfss2bkslybtq@sirena.co.uk>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906145900.yesyfyruv5wd3wxj@sirena.co.uk>
 <CAMz4ku+hKaemHQdVtNEbCf0J_9CjqKouSygAaQsqf+hBzGd-mg@mail.gmail.com>
 <20170907095435.5yhybxz6oootp37h@sirena.co.uk>
 <CAMz4kuLGTCgppki=je9pE5SidRnYWJA-nJd1=RD7qdN1ZRww3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vguk34mvr5spuvig"
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuLGTCgppki=je9pE5SidRnYWJA-nJd1=RD7qdN1ZRww3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vguk34mvr5spuvig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2017 at 07:03:18PM +0800, Baolin Wang wrote:
> On 7 September 2017 at 17:54, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Sep 07, 2017 at 11:29:05AM +0800, Baolin Wang wrote:

> >> The hwspinlock name should be "adi", and I will make it clear in next version.

> > So there's other drivers that might also be accessing this IP block?

> Yes. Other drivers (like regulator, RTC or charger ... ) can access
> analog chip (like PMIC) by ADI controller. But the hardware spinlock
> is used to synchronize between the multiple subsystems, since we only
> have one ADI controller.

If it were other drivers then the kernel should already be doing that
but...

> > So does this driver control all the channels or are there other drivers
> > (or hardware components) that control some of the other channels?

> The ADI driver only controls 2 software channels (read/write), and
> other hardware channels can be controlled by hardware components if we
> set the hardware config.

...if it can be configured to allow other things to use it independently
then this is fine, just needs a bit more documentation so someone can
understand how the bindings and hardware match up.

--vguk34mvr5spuvig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmxMQAACgkQJNaLcl1U
h9BsMwf8CG0Ejhc4sKcJgClOTN/XPVwI52R/pobIErQ50ERLnh1/r/mZEbI1EyPH
IqWqzB45nVrU5ZKpUy+bw+TgM8Cv6eakcfmUNsltV9eQgPXAFSiH6JIOEN0STXB7
wBYCfRJ2wyhHcOMmy7/9nbVQcH1h34xuKJN8ERPE+Q23f3UauE/Lu4yWjgMHmPtW
mai+0fzwJswUVq9wf9KIuBDlXRwIkGI7wJDrSzh5sqLHKBV0WMTszwf70bcq6/pk
THI4OYU8dvksoEBiv3gzN9VIKwQLqwTeOPGwmUFMbldonZyta7qRx/+7GcnUsIJf
P0SsklPOhwzmJ4Zej24LiIT5fKI8gA==
=wXNB
-----END PGP SIGNATURE-----

--vguk34mvr5spuvig--
