From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Wed, 16 Jan 2019 11:01:37 +0000
Message-ID: <b6d6585b-86ce-5eae-842e-83561beefa61@nvidia.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115212539.GK5522@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 15/01/2019 21:25, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 09:58:55PM +0100, Martin Sperl wrote:
>=20
>> Maybe a bigger change to the reduce the complexity of
>> the state machine would solve that problem and also
>> reduce code complexity...=20
>=20
> Yeah, that's where I was getting to with that test patch I posted.
>=20
>> I may find some time over the weekend if no solution
>> has been found until then.
>=20
> Thanks for volunteering :)
>=20
>> The way I would envision it it would have a =E2=80=9Cstate=E2=80=9D
>> as a level (0=3Dshutdown, 1=3Dhw enabled, 2=3Din pump,=20
>> 3=3Din transfer, 4=3Din hw-mode,...) and a complete
>> to allow waking the shutdown thread (and by this
>> avoiding the busy wait loop we have now).
>> This would replace those idling, busy, and running flags.
>=20
> That's a good idea, yes - a single enum much more reflects what we can
> actually do in terms of transitions.
>=20
>> Drawback: it is invasive, but let us see what it
>> really looks like...
>=20
> I think we need to either drop your change (which would be bad since it
> is a big performance improvement, I'd punted it for later when I did the
> original refactoring to push the work into the caller threads then never
> got around to it) or have a invasive changes to make the new situation
> clearer.  Right now things are just far too complex to reason about
> which isn't helping anyone.

What I am seeing on Tegra is that the SPI controller is no longer
runtime-pm suspended and so while this may improve performance, I think
that this change is going to have a negative impact on idle power.

I would be surprised if this problem is specific to Tegra because I
don't see how the controller's busy state can ever be cleared :-(

Cheers
Jon

--=20
nvpublic
